#!/usr/bin/env python3
"""Give every fetched poem the English title the base locale reads.

    python tooling/build_poem_titles_en.py [seconds] [--dry-run]

The store grew from the curated 100 poems to a whole collection per poet, and the
new poems arrived from the anthology corpus with `title_en: ""`. That field is not
decoration: `book_repository.dart` builds the chapter's `titleEn` from it, and
`localizedTitle('en')` falls back to `titleEn` because English is the app's base
locale rather than one of the 13 content locales (`l10n/poetry_en.json` does not
exist and is not meant to). So an empty field renders as an **empty chapter title**
in the table of contents and the reader - `poem['title_en'] ?? 'Poem'` never fires,
because `""` is not null.

Titles are translated, never authored: a poem's name already exists, so the work is
the same faithful translation the 13 content locales received. A handful of poems
the anthology re-supplied under a 乐府 form label ("鼓吹曲辞 将进酒") are the same
poem the curated set already names, so those English titles are reused verbatim
rather than re-invented - see `reuse_titles`.

Output: `assets/data/famous_chinese_poetry.json`, updated in place. The store
carries a UTF-8 BOM and CRLF line endings and its key order is meaningful, all of
which are preserved so the diff stays content-only.
"""
import collections
import json
import os
import re
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_poet_bios import ask, load_key, parse_array  # noqa: E402

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STORE = os.path.join("assets", "data", "famous_chinese_poetry.json")
BATCH = 40
HAN = re.compile(r"[\u3400-\u9fff\uf900-\ufaff]")
# "鼓吹曲辞 将进酒" -> "将进酒": a form label the anthology prefixes the poem's
# actual name with.
FORM_LABEL = re.compile(r"^[\u4e00-\u9fff]{2,6}(?:曲辞|歌辞|曲|辞|歌)\s+")


def reuse_titles(store):
    """Poem id -> English title already known from the curated set.

    Matching is exact on the title first, then on the title with its 乐府 form
    label stripped, because the anthology stores the same poem under both
    ("将进酒" and "鼓吹曲辞 将进酒").
    """
    known = {}
    for entry in store:
        title_en = str(entry.get("title_en") or "").strip()
        if title_en:
            known.setdefault(str(entry.get("title") or "").strip(), title_en)
    reused = {}
    for entry in store:
        if str(entry.get("title_en") or "").strip():
            continue
        title = str(entry.get("title") or "").strip()
        body = FORM_LABEL.sub("", title).strip()
        for candidate in (title, body):
            if candidate in known:
                reused[id(entry)] = known[candidate]
                break
    return reused


def compose_prompt(chunk):
    numbered = "\n".join(
        "%d. %s - %s" % (i + 1, poet, title)
        for i, (poet, (_entry, title)) in enumerate(chunk))
    return (
        "These are the titles of %d classical Chinese poems. Each line is the poet "
        "and then the poem's title. Translate each title into short, natural "
        "English suitable for a table of contents - the meaning of the title as a "
        "poem title, never a phonetic transcription, and keep it brief (about 2 to "
        "5 words). The poet's name is context only; do not include it in the "
        "answer.\n"
        "If a title begins with a musical or verse-form label (曲辞, 歌辞, 乐府 and "
        "the like), carry it over as a natural English qualifier rather than "
        "dropping it or translating it word for word.\n"
        "Return ONLY a JSON array of %d strings in the same order, with no "
        "commentary and no Chinese characters in the answers.\n\n%s"
        % (len(chunk), len(chunk), numbered))


def salvage(text, limit):
    """The complete strings of a truncated JSON array, in order.

    A reply cut off by the model's output limit is still mostly usable, and for
    3,565 titles a single truncated batch must not end the run.
    """
    if not text:
        return []
    values = []
    for match in re.finditer(r'"((?:[^"\\]|\\.)*)"', text):
        if len(values) >= limit:
            break
        try:
            values.append(json.loads('"%s"' % match.group(1)))
        except Exception:  # noqa: BLE001
            continue
    return values


def valid(value, title, limit=60):
    """Rejects anything that would read wrong in the table of contents."""
    value = (value or "").strip()
    if not value:
        return False
    if HAN.search(value):
        # The model echoed Chinese back: English is what this locale needs.
        return False
    if value == title.strip():
        return False
    return len(value) <= limit


def save(store):
    """Writes the store back with its BOM, CRLF endings and key order intact."""
    with open(STORE, "w", encoding="utf-8", newline="\r\n") as handle:
        handle.write("\ufeff")
        json.dump(store, handle, ensure_ascii=False, indent=2)
        handle.write("\n")


def compose_strict_prompt(poet, title):
    """A single-title retry that forbids leaving any Chinese character behind.

    The batch prompt asks in the general case and mostly gets it right; the
    exceptions are 词 tune names, where the model tends to romanise half the name
    and keep the rest ("Remembering Qin娥"). Spelling that out fixes it without
    weakening the check, which is what caught the answer in the first place.
    """
    return (
        "Give the English title of this classical Chinese poem on one line, for a "
        "table of contents. Reply with the title ONLY - no quotes, no explanation, "
        "no full stop.\n"
        "Write every part of it in Latin letters: if a name or tune title is "
        "involved, transliterate it in pinyin (for example 秦娥 becomes \"Qin E\"). "
        "A single remaining Chinese character is a failed answer.\n"
        "Poem: %s - %s" % (poet, title))


def fix_stragglers(key, store, tries=3):
    """Retries the titles the batch prompt could not satisfy, one at a time.

    The length limit is relaxed here on purpose. A batch answer should be a short
    table-of-contents line, but some classical titles are a sentence in themselves
    (神龙初废逐南荒途出郴口北望苏耽山), and their honest English is longer than the
    batch limit - better a long title than a blank one.
    """
    fixed = 0
    for entry in store:
        if str(entry.get("title_en") or "").strip():
            continue
        poet = str(entry.get("sourceName") or "")
        title = str(entry.get("title") or "")
        for attempt in range(tries):
            text = ask(key, compose_strict_prompt(poet, title))
            value = (text or "").strip().splitlines()[0].strip() if text else ""
            if valid(value, title, limit=95):
                entry["title_en"] = value
                fixed += 1
                print("  fixed %s -> %s" % (title, value))
                break
            print("  ! attempt %d rejected %r for %s"
                  % (attempt + 1, value, title))
        save(store)
    return fixed


def main():
    argv = list(sys.argv[1:])
    dry_run = "--dry-run" in argv
    if dry_run:
        argv.remove("--dry-run")
    budget = float(argv[0]) if argv else 900.0
    deadline = time.time() + budget

    with open(STORE, encoding="utf-8-sig") as handle:
        store = json.load(handle, object_pairs_hook=collections.OrderedDict)

    missing = [e for e in store if not str(e.get("title_en") or "").strip()]
    print("store: %d poems, %d without an English title" % (len(store), len(missing)))
    if not missing:
        print("nothing to do")
        return 0

    reused = reuse_titles(store)
    reuse_count = 0
    for entry in missing:
        if id(entry) in reused:
            entry["title_en"] = reused[id(entry)]
            reuse_count += 1
    print("reused %d curated English title(s) for poems the anthology re-supplied"
          % reuse_count)

    pending = [e for e in store if not str(e.get("title_en") or "").strip()]
    print("%d still need a translation" % len(pending))
    if dry_run:
        print("dry run: nothing written")
        return 0

    key = load_key()
    written = 0
    cursor = 0
    stalls = 0
    while cursor < len(pending):
        if time.time() > deadline:
            print("budget reached, %d left - rerun to continue"
                  % (len(pending) - cursor))
            break
        chunk = [(str(entry.get("sourceName") or ""), (entry, entry["title"]))
                 for entry in pending[cursor:cursor + BATCH]]
        text = ask(key, compose_prompt(chunk))
        values = parse_array(text, len(chunk), "titles@%d" % cursor)
        if values is None:
            values = salvage(text, len(chunk))
            if values:
                print("  recovered %d of %d from a truncated reply"
                      % (len(values), len(chunk)))
        if not values:
            stalls += 1
            if stalls >= 2:
                print("  batch at %d failed twice, resumable - rerun to continue"
                      % cursor)
                break
            continue
        stalls = 0
        for (poet, (entry, title)), value in zip(chunk, values):
            if valid(value, title):
                entry["title_en"] = value.strip()
                written += 1
            else:
                print("  ! rejected %r for %s (%s)" % (value, title, poet))
        # Only the answers received are consumed, so a truncated reply costs
        # nothing: the rest of the batch comes round on the next iteration.
        cursor += len(values)
        save(store)
        print("%d/%d English titles written" % (cursor, len(pending)))

    save(store)
    print("wrote %d title(s) this run" % written)
    left = sum(1 for e in store if not str(e.get("title_en") or "").strip())
    if left:
        print("retrying %d stubborn title(s) individually" % left)
        print("  fixed %d" % fix_stragglers(key, store))
    left = sum(1 for e in store if not str(e.get("title_en") or "").strip())
    print("poems still without an English title: %d" % left)
    return 0


if __name__ == "__main__":
    sys.exit(main())

