#!/usr/bin/env python3
"""Give every poet the Latin name the non-Chinese locales display.

    python tooling/build_poet_names_en.py [seconds] [--dry-run]

`poetryCollectionToBook` sets `titleEn`/`authorEn` from the first poem's
`author_en`, and falls back to `authorEn.isNotEmpty ? authorEn : collection.author`
- the **Chinese** name. So a poet published without it reads 王维 in all thirteen
content locales instead of "Wang Wei", and the fallback is silent: nothing is
blank, nothing fails, the shelf just renders Chinese to a reader who chose French.

The 37 poets curated from the original 100 poems already carry `author_en` from
the store. The poets added to reach 100 books do not, so this fills them in.

A name is transcribed, not translated: 王维 is "Wang Wei" in every language, the
same way 李白 is "Li Bai" in the 37 that already ship - which is why the app needs
no ARB key and no 13-file sweep for a collection's title at all.

Output: `assets/data/famous_chinese_poetry.json`, updated in place, preserving its
UTF-8 BOM, CRLF endings and key order so the diff stays content-only.
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
BATCH = 30
HAN = re.compile(r"[\u3400-\u9fff\uf900-\ufaff]")
LATIN_NAME = re.compile(r"^[A-Za-z][A-Za-z'’.\- ]*$")


def valid(value, poet):
    """A Latin proper name: no Han, no commentary, sensible length."""
    value = (value or "").strip().strip('"').strip()
    if not value or HAN.search(value):
        return False
    if not LATIN_NAME.match(value):
        return False
    if len(value) > 40 or len(value.split()) > 4:
        return False
    # A model that echoes the Chinese name or writes a sentence is not helping.
    return value.lower() != poet.lower()


def compose_prompt(poets):
    numbered = "\n".join("%d. %s" % (i + 1, poet)
                         for i, poet in enumerate(poets))
    return (
        "These are the names of %d classical Chinese poets, written in Chinese. "
        "Give the standard Latin (pinyin) form of each name as it is normally "
        "written in English - for example 李白 is \"Li Bai\" and 王维 is "
        "\"Wang Wei\".\n"
        "Return ONLY a JSON array of %d strings in the same order, containing the "
        "name and nothing else: no Chinese characters, no dates, no titles such "
        "as \"poet\", no commentary.\n\n%s" % (len(poets), len(poets), numbered))


def save(store):
    with open(STORE, "w", encoding="utf-8", newline="\r\n") as handle:
        handle.write("\ufeff")
        json.dump(store, handle, ensure_ascii=False, indent=2)
        handle.write("\n")


def main():
    argv = list(sys.argv[1:])
    dry_run = "--dry-run" in argv
    if dry_run:
        argv.remove("--dry-run")
    budget = float(argv[0]) if argv else 600.0
    deadline = time.time() + budget

    with open(STORE, encoding="utf-8-sig") as handle:
        store = json.load(handle, object_pairs_hook=collections.OrderedDict)

    # A poet is named once and every one of their poems carries it.
    poets = sorted({str(e.get("sourceName") or "").strip() for e in store
                    if not str(e.get("author_en") or "").strip()})
    poets = [poet for poet in poets if poet]
    print("store: %d poems, %d poet(s) without a Latin name" % (len(store),
                                                               len(poets)))
    if not poets:
        print("nothing to do")
        return 0
    print("  %s" % ", ".join(poets))
    if dry_run:
        print("dry run: nothing written")
        return 0

    key = load_key()
    names = {}
    for start in range(0, len(poets), BATCH):
        if time.time() > deadline:
            print("budget reached, %d poet(s) left - rerun to continue"
                  % (len(poets) - start))
            break
        chunk = poets[start:start + BATCH]
        values = parse_array(ask(key, compose_prompt(chunk)), len(chunk),
                             "names@%d" % start)
        if values is None:
            print("batch at %d failed, resumable - rerun to continue" % start)
            break
        for poet, value in zip(chunk, values):
            if valid(value, poet):
                names[poet] = value.strip()
                print("   %-10s -> %s" % (poet, value.strip()))
            else:
                print("   ! rejected %r for %s" % (value, poet))

    if not names:
        print("no names accepted")
        return 1

    written = 0
    for entry in store:
        poet = str(entry.get("sourceName") or "").strip()
        if poet in names:
            entry["author_en"] = names[poet]
            written += 1
    save(store)
    print()
    print("named %d poet(s) across %d poem(s)" % (len(names), written))
    print("poets still without a Latin name: %d"
          % len({str(e.get("sourceName") or "").strip() for e in store
                 if not str(e.get("author_en") or "").strip()}))
    return 0


if __name__ == "__main__":
    sys.exit(main())
