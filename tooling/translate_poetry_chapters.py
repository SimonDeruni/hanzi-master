#!/usr/bin/env python3
"""Translate every poem's title into the app's content locales.

    python tooling/translate_poetry_chapters.py [seconds] [--only LOCALE]

The store grew from the curated 100 poems to a whole collection per poet, but
`assets/data/l10n/poetry_<locale>.json` still only carries the original 100.
A chapter with no translated title falls back to its Chinese one
(`localizedValue`), so nothing is broken - this fills the gap so a reader in any
of the 13 locales sees the poem's name in their own language.

Only a missing or blank title is ever sent, so the hand-checked translations of
the curated 100 are never overwritten. Batches of 50 titles per request, saved
after every batch, so the run is resumable and a timeout loses nothing.
"""
import json
import os
import re
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_poet_bios import L10N_DIR, LANGS, ask, load_key, parse_array  # noqa: E402

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STORE = os.path.join("assets", "data", "famous_chinese_poetry.json")
PREFIX = "poetry_"
HAN = re.compile(r"[\u3400-\u9fff\uf900-\ufaff]")
# 50 answers in one array overran the model's output limit for token-heavy
# scripts (Arabic truncated mid-string), and a truncated array used to cost the
# whole locale. Smaller batches fail more gracefully; `salvage` recovers the rest.
BATCH = 25


def salvage(text, limit):
    """The complete strings of a truncated JSON array, in order.

    A reply cut off by the output limit is still mostly usable: every element
    before the cut parsed fine, and the missing tail is simply asked for again.
    """
    if not text:
        return []
    values = []
    for match in re.finditer(r'"((?:[^"\\]|\\.)*)"', text):
        if len(values) >= limit:
            break
        raw = match.group(1)
        try:
            values.append(json.loads('"%s"' % raw))
        except Exception:  # noqa: BLE001
            continue
    return values


def repair(key, only, budget):
    """Re-translate titles that came back still containing Chinese.

    A translation that keeps a Chinese proper noun is not a translation of that
    title: the reader picked German and is shown `谢朓楼`, or picked Thai and is
    shown `念奴娇` with nothing else. It is a quiet failure - non-blank, in the
    right file, so every completeness check passes - which is why it is measured
    rather than assumed. Japanese is excluded on purpose: kanji *is* Japanese, so
    a Han character there is correct, not a defect.
    """
    deadline = time.time() + budget
    total = 0
    store = json.load(open(STORE, encoding="utf-8-sig"))
    chinese = {str(e.get("link") or e.get("id")): str(e.get("title") or "")
               for e in store}
    order = [str(e.get("link") or e.get("id")) for e in store]

    for locale, language in [p for p in LANGS if only is None or p[0] == only]:
        if locale == "ja":
            print("%s: skipped, kanji is Japanese" % locale)
            continue
        path = os.path.join(L10N_DIR, PREFIX + locale + ".json")
        if not os.path.exists(path):
            # English has no file on purpose: the base locale reads the store's
            # own `title_en` rather than a catalogue.
            print("%s: no file, skipped" % locale)
            continue
        data = json.load(open(path, encoding="utf-8"))
        bad = [poem_id for poem_id in order
               if HAN.search(str((data.get(poem_id) or {}).get("title") or ""))]
        if not bad:
            print("%s: nothing to repair" % locale)
            continue
        print("%s: %d title(s) still contain Chinese" % (locale, len(bad)))

        cursor = 0
        stalls = 0
        while cursor < len(bad):
            if time.time() > deadline:
                print("%s: budget reached, %d left" % (locale, len(bad) - cursor))
                break
            chunk = bad[cursor:cursor + BATCH]
            numbered = "\n".join("%d. %s" % (i + 1, chinese.get(poem_id, ""))
                                 for i, poem_id in enumerate(chunk))
            prompt = (
                "Translate each of these %d classical Chinese poem titles into %s "
                "for a reading app. Return ONLY a JSON array of %d strings in the "
                "same order, with no commentary.\n"
                "Write the WHOLE title in %s script. If a title names a person, a "
                "place, a tune or a mountain, render that name in %s letters or "
                "characters as %s speakers normally write it - do not leave any "
                "Chinese character in the answer. A single Chinese character is a "
                "failed answer.\n\n%s"
                % (len(chunk), language, len(chunk), language, language, language,
                   numbered))
            text = ask(key, prompt)
            values = parse_array(text, len(chunk), "repair@%s@%d"
                                 % (locale, cursor))
            if values is None:
                values = salvage(text, len(chunk))
            if not values:
                stalls += 1
                if stalls >= 2:
                    print("%s: batch at %d failed twice, resumable - rerun to "
                          "continue" % (locale, cursor))
                    break
                continue
            stalls = 0
            for poem_id, value in zip(chunk, values):
                value = (value or "").strip()
                if not value or HAN.search(value):
                    continue
                entry = data.get(poem_id)
                if isinstance(entry, dict):
                    entry["title"] = value
                else:
                    data[poem_id] = {"title": value}
                total += 1
            cursor += len(values)
            ordered = {poem_id: data[poem_id] for poem_id in order
                       if poem_id in data}
            for poem_id, entry in data.items():
                ordered.setdefault(poem_id, entry)
            with open(path, "w", encoding="utf-8", newline="\n") as handle:
                json.dump(ordered, handle, ensure_ascii=False, indent=2)
                handle.write("\n")
            left = len([p for p in bad
                        if HAN.search(str((data.get(p) or {}).get("title") or ""))])
            print("%s: %d/%d repaired, %d still Chinese"
                  % (locale, cursor, len(bad), left))

    print("repaired this run: %d" % total)
    return 0


def main():
    argv = list(sys.argv[1:])
    only = None
    if "--only" in argv:
        index = argv.index("--only")
        only = argv[index + 1]
        del argv[index:index + 2]
    repair_mode = "--repair" in argv
    if repair_mode:
        argv.remove("--repair")
    budget = float(argv[0]) if argv else 900.0

    if repair_mode:
        return repair(load_key(), only, budget)

    deadline = time.time() + budget

    store = json.load(open(STORE, encoding="utf-8-sig"))
    order = [(e["link"] if e.get("link") else e["id"], e["title"]) for e in store]
    print("store: %d poems across %d locales to fill"
          % (len(order), len([p for p in LANGS if only is None or p[0] == only])))

    key = load_key()
    done = 0
    for locale, language in [p for p in LANGS if only is None or p[0] == only]:
        path = os.path.join(L10N_DIR, PREFIX + locale + ".json")
        if not os.path.exists(path):
            print("%s: no file, skipped" % locale)
            continue
        data = json.load(open(path, encoding="utf-8"))
        pending = [(poem_id, title) for poem_id, title in order
                   if not str((data.get(poem_id) or {}).get("title") or "").strip()]
        if not pending:
            print("%s: already complete" % locale)
            continue

        cursor = 0
        stalls = 0
        while cursor < len(pending):
            if time.time() > deadline:
                print("%s: budget reached, %d left" % (locale, len(pending) - cursor))
                break
            chunk = pending[cursor:cursor + BATCH]
            numbered = "\n".join("%d. %s" % (i + 1, title)
                                 for i, (_id, title) in enumerate(chunk))
            prompt = (
                "These are the titles of %d classical Chinese poems. Translate each "
                "one into %s for a poetry reading app. Return ONLY a JSON array of "
                "%d strings in the same order, no commentary. Give the title's "
                "meaning as a poem title in %s - not a phonetic transcription - and "
                "keep them short. Do not add punctuation the Chinese does not have."
                "\n\n%s" % (len(chunk), language, len(chunk), language, numbered))
            text = ask(key, prompt)
            values = parse_array(text, len(chunk), "%s@%d" % (locale, cursor))
            if values is None:
                values = salvage(text, len(chunk))
                if values:
                    print("%s: recovered %d of %d from a truncated reply"
                          % (locale, len(values), len(chunk)))
            if not values:
                stalls += 1
                if stalls >= 2:
                    print("%s: batch at %d failed twice, resumable - rerun to "
                          "continue" % (locale, cursor))
                    break
                continue
            stalls = 0
            for (poem_id, _title), value in zip(chunk, values):
                value = (value or "").strip()
                # A blank answer must not land: the reader falls back to the
                # Chinese title, which beats an empty one, and a blank entry
                # fails the title-localization ratchet.
                if not value:
                    continue
                entry = data.get(poem_id)
                if isinstance(entry, dict):
                    entry["title"] = value
                else:
                    data[poem_id] = {"title": value}
                done += 1
            # Only the answers we actually received are consumed, so a truncated
            # reply loses nothing: the rest of the batch comes round again.
            cursor += len(values)
            ordered = {poem_id: data[poem_id] for poem_id, _ in order
                       if poem_id in data}
            for poem_id, entry in data.items():
                ordered.setdefault(poem_id, entry)
            # The l10n catalogues carry no BOM and use LF, so match them.
            with open(path, "w", encoding="utf-8", newline="\n") as handle:
                json.dump(ordered, handle, ensure_ascii=False, indent=2)
                handle.write("\n")
            print("%s: %d/%d titles translated"
                  % (locale, cursor, len(pending)))

    print("translated this run: %d" % done)
    return 0



if __name__ == "__main__":
    sys.exit(main())
