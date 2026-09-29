#!/usr/bin/env python3
"""Choose which 100 poets the app publishes as collections.

    python tooling/select_poetry_poets.py [--target=100] [--min-poems=12] [--write]

Why a selection step exists at all: the eight anthology files hold 741 poems
spread over **170** poets, so a hundred books taken from them alone would end with
poets holding a single poem each - exactly the complaint the collection model was
built to fix. Ranking by presence in the canonical anthologies tells us who is
famous; the full corpora tell us who actually has a collection to publish. A poet
needs both.

The rule, in order:

1. **Keep every poet already published.** They are the curated set the app ships
   today; re-running must never drop a book a reader already has.
2. **Rank the rest by presence in `唐诗三百首`, `宋词三百首`, `花间集` and 南唐词.**
   Those anthologies *are* the fame signal - a poet is in them because editors
   chose their best work - so no hand-made list of favourites is needed.
3. **Drop names that are not people.** `张` is a truncation, `不详` and 无名氏 mean
   *unknown*, and a 元曲 author such as `高明《蔡伯喈琵琶记》` is a play, not a poet.
4. **Require enough poems to fill a book.** Anything below `--min-poems` in the
   full corpora is skipped rather than published as a two-poem shelf item.

Names go through the same pinned OpenCC map the fetch uses, because `唐诗三百首`
is 繁体: without it 王維 and 王维 are two poets and the store's simplified 王维
gains a traditional twin. The deep corpora are read through the fetch's own cache,
so running this before the fetch costs nothing twice.
"""
import argparse
import collections
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fetch_poetry_collections import (  # noqa: E402
    DEEP_SOURCES,
    MIN_LINES,
    SOURCES,
    STORE,
    cached_fetch,
    load_opencc_map,
    simplify,
    source_paths,
)

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SELECTION = os.path.join("tooling", "poetry_poet_selection.txt")

# `张` is a truncated name and 不详/无名氏 mean the author is unknown; a 元曲
# "author" holding 《》 is a play title. None of them can be a person's book.
NOT_A_PERSON = re.compile(r"不详|无名氏|佚名|《|》|^.$")


def norm(text):
    return re.sub(r"\s+", "", str(text or ""))


def count_by_poet(sources, mapping):
    """Poet -> how many of their usable poems the given sources hold.

    Only the author field is read, so 80,000 poems are counted without building
    80,000 records.
    """
    counts = collections.Counter()
    for source in sources:
        for path in source_paths(source):
            entries = json.loads(cached_fetch(path))
            for entry in entries:
                if not isinstance(entry, dict):
                    continue
                lines = entry.get(source["text"]) or []
                if isinstance(lines, str):
                    lines = [lines]
                if len([x for x in lines if str(x).strip()]) < MIN_LINES:
                    continue
                author = source.get("author") or \
                    str(entry.get("author") or "").strip()
                if not author:
                    continue
                if source.get("traditional"):
                    author = simplify(author, mapping)
                counts[norm(author)] += 1
    return counts


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument("--target", type=int, default=100,
                        help="how many poets to publish")
    parser.add_argument("--min-poems", type=int, default=12,
                        help="a poet below this many poems in the full corpora is "
                             "not worth a collection")
    parser.add_argument("--write", action="store_true",
                        help="write the selection file")
    parser.add_argument("--out", default=SELECTION)
    args = parser.parse_args()

    mapping = load_opencc_map()
    with open(STORE, encoding="utf-8-sig") as handle:
        store = json.load(handle)
    published = collections.Counter(
        str(e.get("sourceName") or "").strip() for e in store)

    print("published today       : %d poets, %d poems"
          % (len(published), len(store)))
    print("reading the anthology fame signal...")
    fame = count_by_poet(SOURCES, mapping)
    print("  %d distinct poets in the anthologies" % len(fame))
    print("reading the full corpora for availability...")
    deep = count_by_poet(DEEP_SOURCES, mapping)
    print("  %d distinct poets across 全唐诗 and 宋词" % len(deep))

    # 1. Keep what is already published, in a stable order.
    kept = sorted(published)
    # 2/3/4. Rank the rest by fame, then require a real collection.
    ranked = sorted(fame.items(), key=lambda pair: (-pair[1], pair[0]))
    chosen = []
    thin = []
    non_person = []
    for poet, presence in ranked:
        if poet in published:
            continue
        if NOT_A_PERSON.search(poet):
            non_person.append(poet)
            continue
        available = deep.get(poet, 0)
        if available < args.min_poems:
            thin.append((poet, available))
            continue
        chosen.append((poet, presence, available))
        if len(kept) + len(chosen) >= args.target:
            break

    selection = (kept + [poet for poet, _p, _a in chosen])[:args.target]

    print()
    print("kept from what we publish : %d" % len(kept))
    print("new poets selected        : %d" % (len(selection) - len(kept)))
    print("rejected as not a person  : %d (%s)"
          % (len(non_person), ", ".join(non_person[:6])))
    print("rejected as too thin      : %d (e.g. %s)"
          % (len(thin), ", ".join("%s=%d" % pair for pair in thin[:6])))
    print("total                     : %d" % len(selection))
    print()
    print("the new poets, with the poems available in the full corpora:")
    for poet, presence, available in chosen:
        print("   %-10s anthology %2d   corpus %4d"
              % (poet, presence, available))

    if not args.write:
        print()
        print("dry run: pass --write to save %s" % args.out)
        return 0

    with open(args.out, "w", encoding="utf-8", newline="\n") as handle:
        for poet in selection:
            handle.write(poet + "\n")
    print()
    print("wrote %s (%d names)" % (args.out, len(selection)))
    return 0


if __name__ == "__main__":
    sys.exit(main())

