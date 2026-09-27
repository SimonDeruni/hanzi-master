#!/usr/bin/env python
"""Translates and repairs the per-locale content catalogs.

    python scratch/catalog_factory.py --survey
    python scratch/catalog_factory.py --family chapter_titles --locale th
    python scratch/catalog_factory.py --family chapter_titles --locale all
    python scratch/catalog_factory.py --family shows --locale th
    python scratch/catalog_factory.py --family channels --locale th

Where the English source lives
------------------------------
`LocalizedCatalogService` reads `assets/data/l10n/<family>_<locale>.json` and
takes English from the Dart call site as `fallbackEn` - **there is no `_en`
file**. So the source for each family has to be found, not assumed:

* `shows_*`           keyed by the English show title; the synopsis source is the
                      generated `const Map<String, String> showSummaries` in
                      `lib/features/media/data/repositories/show_summaries.dart`
                      (128 shows). **Every locale file covers only ~60 of them**,
                      so ~50 synopses per locale were never translated and the
                      reader fell back to English - a gap audit 37 missed because
                      it scored each file only on the keys the file happened to
                      contain.
* `chapter_titles_*`  keyed by the English chapter title -> source is the KEY.
                      A translated row keeps the English text after the chapter
                      number verbatim, which is the "English tail" audit 37 found
                      in twelve locales; repair translates only that tail so the
                      file's own prefix convention (`Kapitel 12:`) is preserved.
* `channels_*`        keyed by the channel handle, values are bullet lists ->
                      source is `ChannelsData` in `lib/features/media/data/
                      channels_data.dart`.

A Thai run needs no special case: the family simply has no `th` file yet, so
every key is pending. The runner keeps one worker per family and the credential
pool is shared with `summaries_factory.py`, so the quota is pooled rather than
fought over.
"""
import argparse
import json
import os
import re
import sys
import time
from concurrent.futures import ThreadPoolExecutor

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from translation_pool import (  # noqa: E402
    load_channels, log, translate_batch, write_json_atomic)

L10N = os.path.join("assets", "data", "l10n")
CHANNELS_DART = os.path.join("lib", "features", "media", "data", "channels_data.dart")
SHOW_SUMMARIES_DART = os.path.join("lib", "features", "media", "data",
                                   "repositories", "show_summaries.dart")
LOCALES = ["ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi"]
LANGUAGE_NAMES = {
    "ar": "Arabic", "de": "German", "es": "Spanish", "fr": "French", "hi": "Hindi",
    "id": "Indonesian", "it": "Italian", "ja": "Japanese", "ko": "Korean",
    "pt": "Portuguese", "ru": "Russian", "th": "Thai", "vi": "Vietnamese",
}
FAMILIES = ["shows", "channels", "chapter_titles"]

# Mirrors `LocalizedCatalogService._localizeChapterPrefix`, so the factory can
# recognise a chapter prefix the same way the app renders one. Used to *detect* a
# corrupted row: a value carrying the prefix twice (`Kapitel 10Kapitel 1: ...`)
# is the fingerprint of a repair that replaced an English tail with a whole title.
CHAPTER_PREFIX = {
    "ar": "الفصل", "de": "Kapitel", "es": "Capítulo", "fr": "Chapitre",
    "hi": "अध्याय", "id": "Bab", "it": "Capitolo", "ja": "第", "ko": "제",
    "pt": "Capítulo", "ru": "Глава", "th": "บทที่", "vi": "Chương",
}

# Show synopses are four sentences (~600 characters) where a chapter title is a
# line, so one batch size cannot serve both: 25 synopses would overrun the reply
# limit and come back truncated, while 8 chapter titles would waste quota.
BATCH_BY_FAMILY = {"shows": 8, "chapter_titles": 25, "channels": 12}


def read_json(path):
    with open(path, encoding="utf-8") as handle:
        return json.load(handle)


def family_path(family, locale):
    return os.path.join(L10N, "%s_%s.json" % (family, locale))


QUOTED = re.compile(r"'((?:[^'\\]|\\.)*)'")


def dart_string_map(path):
    """Reads a generated `const Map<String, String>` out of a Dart file.

    Same shape as the instrument in `scratch/content_l10n_audit.py`, so the
    factory and the audit agree on what the English source is.
    """
    if not os.path.exists(path):
        return {}
    body = open(path, encoding="utf-8").read().split("= {", 1)[-1]
    out = {}
    for match in re.finditer(r"'((?:[^'\\]|\\.)*)'\s*:\s*\n?\s*'((?:[^'\\]|\\.)*)'", body):
        key = match.group(1).replace("\\'", "'").replace("\\\\", "\\")
        value = match.group(2).replace("\\'", "'").replace("\\\\", "\\")
        out[key] = value
    return out


def english_channel_points():
    """Parses `ChannelsData.entries` for each handle's English bullets.

    The channel descriptions are not in any asset file - they are Dart string
    literals beside each `handle:`, which is why `channels_*` is the one family
    whose source cannot be read off the key.
    """
    text = open(CHANNELS_DART, encoding="utf-8").read()
    points = {}
    for block in re.split(r"ChannelEntry\(", text)[1:]:
        handle = re.search(r"handle:\s*'([^']+)'", block)
        if not handle:
            continue
        listed = re.search(r"descriptionPoints:\s*\[(.*?)\]", block, re.S)
        if not listed:
            continue
        bullets = [match.replace("\\'", "'") for match in QUOTED.findall(listed.group(1))]
        points[handle.group(1)] = [bullet for bullet in bullets if bullet.strip()]
    return points


_LOADED = {}


def show_summaries():
    """The 128 English show synopses, loaded once per process."""
    if "shows" not in _LOADED:
        _LOADED["shows"] = dart_string_map(SHOW_SUMMARIES_DART)
    return _LOADED["shows"]


def channel_points():
    """The English channel bullets, loaded once per process."""
    if "channels" not in _LOADED:
        _LOADED["channels"] = english_channel_points()
    return _LOADED["channels"]


def reference_keys(family):
    """The canonical key set: the union across every locale file that exists.

    Not every locale carries the same keys (`shows_ar.json` has 61 where
    `shows_de.json` has 60), so a new locale must be built from the union or it
    would silently drop the rows only some languages translate.
    """
    keys = []
    for locale in LOCALES:
        path = family_path(family, locale)
        if not os.path.exists(path):
            continue
        for key in read_json(path):
            if key not in keys:
                keys.append(key)
    return keys


def chapter_tail(key):
    """Everything after the chapter number in an English chapter title.

    `Chapter 10: Asteroid 325: The King Who Rules Solitude` -> `: Asteroid 325:
    The King Who Rules Solitude`. Repair translates only this, so the file keeps
    its own prefix convention (`Kapitel 10:`) instead of being re-derived.
    """
    match = re.match(r"^Chapter\s+\d+\s*(.*)$", key)
    return match.group(1) if match else ""


def looks_english(text):
    """True when `text` still carries real English words rather than numerals."""
    return bool(re.search(r"[A-Za-z]{3,}", text))


def tail_is_english(text):
    """True when a chapter tail holds English rather than a shared word.

    `: Prologue` is correct French, `: Epilogue` correct German, and a single
    proper noun is often correct everywhere - so one word is never enough. The
    defect audit 37 reported is a whole English phrase left after the localized
    prefix (`: Asteroid 325: The King Who Rules Solitude`), which is several.
    """
    return len(re.findall(r"[A-Za-z]{3,}", text)) >= 2


def build_jobs(family, locale, channel_points):
    """Returns (data, jobs): the loaded file and the rows that still need work.

    A job is `(key, bullet_index_or_None, english_text_to_translate)`. A file that
    does not exist yet yields a job for every reference key, so the same code path
    creates Thai and repairs German.
    """
    path = family_path(family, locale)
    data = read_json(path) if os.path.exists(path) else {}
    jobs = []

    if family == "channels":
        # Keys come from the Dart registry plus whatever a file already holds
        # (some files carry a 'DEFAULT' fallback entry).
        keys = list(channel_points.keys())
        for key in data:
            if key not in keys:
                keys.append(key)
        for key in keys:
            english = channel_points.get(key)
            if not english:
                continue
            current = data.get(key) or []
            for index, text in enumerate(english):
                existing = current[index] if index < len(current) else ""
                if not str(existing).strip() or str(existing) == text:
                    jobs.append((key, index, text))
        return data, jobs

    if family == "shows":
        # The source is the generated English map, not the key: a locale file that
        # is *missing* a show is as much of a gap as one still holding English, and
        # only the English map can tell the two apart.
        for key, english in show_summaries().items():
            value = str(data.get(key, ""))
            if not value.strip() or value == english:
                jobs.append((key, None, english))
        return data, jobs

    prefix = CHAPTER_PREFIX.get(locale, "")
    for key in reference_keys("chapter_titles"):
        value = str(data.get(key, ""))
        tail = chapter_tail(key)
        if not value.strip() or value == key:
            jobs.append((key, None, key))
        elif tail_is_english(tail) and tail in value:
            jobs.append((key, None, key))
        elif prefix and value.count(prefix) > 1:
            # The fingerprint of a repair that swapped an English tail for a whole
            # title and left the old prefix in front of it. Re-translate the row.
            jobs.append((key, None, key))
    return data, jobs


def is_sane(family, locale, key, value):
    """False when writing `value` would corrupt or fail to improve the row.

    The repair that produced 99 rows reading `Kapitel 10Kapitel 1: ...` wrote
    whatever came back. This is the check that would have stopped it: a chapter
    title may not carry its prefix twice, nor still hold its English tail, and a
    show synopsis may not be the English string it replaced.
    """
    text = str(value).strip()
    if not text:
        return False
    if family == "chapter_titles":
        prefix = CHAPTER_PREFIX.get(locale, "")
        if prefix and text.count(prefix) > 1:
            return False
        tail = chapter_tail(key)
        if tail and tail_is_english(tail) and tail in text:
            return False
        return True
    if family == "shows":
        return text != show_summaries().get(key)
    return True


def style_hint(family, locale, data):
    """Three already-localized rows, so the model matches the file's convention.

    Without this the model invents its own chapter prefix (`Chapter 12:` instead
    of the file's `Kapitel 12:`), which is how a repaired row drifts from its 500
    neighbours.
    """
    if family != "chapter_titles":
        return ""
    prefix = CHAPTER_PREFIX.get(locale, "")
    examples = []
    for key, value in data.items():
        text = str(value)
        tail = chapter_tail(key)
        if not text.strip() or text == key:
            continue
        if tail and tail in text:
            continue
        if prefix and text.count(prefix) > 1:
            continue
        examples.append(text)
        if len(examples) >= 3:
            break
    if not examples:
        return ""
    return (" Match this file's existing style exactly, for example: %s."
            % " | ".join(examples))


INSTRUCTIONS = {
    "shows": "Translate these Chinese-drama show synopses into {lang} for a "
             "Chinese-learning app. They are plot summaries: write flowing, "
             "idiomatic {lang} prose, not a literal gloss.",
    "chapter_titles": "Translate these book chapter names into {lang} for a "
                      "Chinese-learning app. A chapter number may lead the line; "
                      "render it the natural way in {lang} (German 'Kapitel 12:', "
                      "French 'Chapitre 12:') and translate the descriptive part "
                      "that follows it.",
    "channels": "Translate these YouTube channel description bullet points into "
                "{lang} for a Chinese-learning app. Keep each bullet to a single "
                "sentence and leave channel handles unchanged.",
}


def order_keys(family, data, channel_points):
    """Re-serialises in a stable order so the diff shows only translated text."""
    if family == "channels":
        keys = list(channel_points.keys())
    elif family == "shows":
        keys = list(show_summaries().keys())
    else:
        keys = reference_keys(family)
    ordered = {}
    for key in keys:
        if key in data:
            ordered[key] = data[key]
    for key, value in data.items():
        if key not in ordered:
            ordered[key] = value
    return ordered


def run_family(family, locale, args, pool):
    """Translates whatever this family/locale pair still needs. Returns a count."""
    channel_points = english_channel_points() if family == "channels" else {}
    data, jobs = build_jobs(family, locale, channel_points)
    if not jobs:
        log("%-14s %-3s nothing pending" % (family, locale))
        return 0

    log("%-14s %-3s %d row(s) pending" % (family, locale, len(jobs)))
    instruction = (INSTRUCTIONS[family].format(lang=LANGUAGE_NAMES[locale])
                   + style_hint(family, locale, data))
    path = family_path(family, locale)
    deadline = time.time() + args.seconds
    written = 0

    batch = min(args.batch, BATCH_BY_FAMILY.get(family, args.batch))
    for start in range(0, len(jobs), batch):
        if time.time() > deadline:
            log("%-14s %-3s budget reached at %d/%d - rerun to continue"
                % (family, locale, start, len(jobs)))
            break
        chunk = jobs[start:start + batch]
        answers = translate_batch(pool, instruction, [job[2] for job in chunk])
        if not answers:
            log("%-14s %-3s batch at %d failed - rerun to retry"
                % (family, locale, start))
            break
        rejected = 0
        for index, value in answers.items():
            key, bullet, source = chunk[index]
            if bullet is None:
                if not is_sane(family, locale, key, value):
                    rejected += 1
                    continue
                # Assign outright. The job's source is the *whole* English title, so
                # there is no tail to splice back into a prefix - and splicing is
                # exactly what corrupted 99 rows when the model answered with a full
                # title instead of just the tail (2026-09-27).
                data[key] = value
            else:
                bullets = data.setdefault(key, [])
                while len(bullets) <= bullet:
                    bullets.append("")
                bullets[bullet] = value
            written += 1
        if rejected:
            log("    %s %s rejected %d unusable translation(s)"
                % (family, locale, rejected))
        write_json_atomic(path, order_keys(family, data, channel_points))
        log("%-14s %-3s %d/%d"
            % (family, locale, min(start + batch, len(jobs)), len(jobs)))
    return written


def survey():
    """Prints coverage and outstanding work per family, without translating."""
    points = channel_points()
    print("channel handles parsed from channels_data.dart: %d" % len(points))
    print("English show synopses parsed from show_summaries.dart: %d"
          % len(show_summaries()))
    for family in FAMILIES:
        present = [loc for loc in LOCALES if os.path.exists(family_path(family, loc))]
        print("\n=== %s: %d/%d locale files" % (family, len(present), len(LOCALES)))
        for locale in LOCALES:
            data, jobs = build_jobs(family, locale, points)
            mark = "" if os.path.exists(family_path(family, locale)) else " (absent)"
            print("   %-3s rows=%-4d pending=%-4d%s"
                  % (locale, len(data), len(jobs), mark))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--survey", action="store_true")
    parser.add_argument("--family", choices=FAMILIES + ["all"])
    parser.add_argument("--locale", help="a locale code, or 'all'")
    parser.add_argument("--batch", type=int, default=25)
    parser.add_argument("--rpm", type=int, default=6,
                        help="requests per minute per credential (channels are pooled)")
    parser.add_argument("--workers", type=int, default=3)
    parser.add_argument("--seconds", type=float, default=1500.0)
    args = parser.parse_args()

    if args.survey:
        survey()
        return
    if not args.family or not args.locale:
        parser.error("--family and --locale are required unless --survey")
    if args.locale != "all" and args.locale not in LOCALES:
        parser.error("unknown locale %r" % args.locale)

    families = FAMILIES if args.family == "all" else [args.family]
    locales = LOCALES if args.locale == "all" else [args.locale]
    tasks = [(family, locale) for family in families for locale in locales]

    pool = load_channels(args.rpm)
    log("catalog factory: %d task(s), batch %d, %d worker(s), %d rpm/channel, %.0fs"
        % (len(tasks), args.batch, args.workers, args.rpm, args.seconds))
    log("channels: %s" % ", ".join(channel.label for channel in pool.channels))
    total = 0
    with ThreadPoolExecutor(max_workers=args.workers) as executor:
        futures = [executor.submit(run_family, family, locale, args, pool)
                   for family, locale in tasks]
        for future in futures:
            total += future.result()
    log("total rows written this run: %d" % total)


if __name__ == "__main__":
    main()



