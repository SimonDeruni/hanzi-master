#!/usr/bin/env python3
"""Expand every poet's collection with more of their own poems.

A single Chinese poem averages ~85 characters, so one poem per book opened the
whole reader - table of contents, chapter counter, progress - for four lines of
verse. A book is now one poet's collection and a poem is a chapter of it; this
script gives those collections something to hold.

    python tooling/fetch_poetry_collections.py --per-author=50
    python tooling/fetch_poetry_collections.py --check      # validate only
    python tooling/fetch_poetry_collections.py --dry-run    # report, no write

Why the anthologies and not the full corpora: `全唐诗/poet.tang.[0-57000].json`
is 58 files of 1000 poems (~23 MB) plus another 255 for `poet.song.*`, with no
poem ids and no author index, whereas `唐诗三百首.json` alone already holds 51
李白 and 41 杜甫 poems. Eight small files cover every poet the store has.

Encoding: `唐诗三百首.json` is the **only** 繁体 source - the other seven are
already 简体 - so it is the only one run through the pinned OpenCC
traditional-to-simplified character map. A character map, not phrase rewriting:
繁 to 简 is many-to-one and therefore the safe direction, unlike the reverse
(which is why the corpus README warns that converted text may not fit context).

Determinism: ids are `poetry_<dynasty>_<8 hex>` over author+title+first line, and
the curated 100 keep their existing ids and their place at the head of each
collection, so re-running only ever appends.
"""

import argparse
import hashlib
import json
import os
import sys
import unicodedata
import urllib.parse
import urllib.request
from collections import OrderedDict, defaultdict

# The paths and poem titles in the progress log are Chinese; a Windows console
# defaults to a codepage that cannot encode them and would abort the run.
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REVISION = "b8594f8"
RAW = "https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/" + REVISION
OPENCC_TS_CHARACTERS = (
    "https://raw.githubusercontent.com/BYVoid/OpenCC/ver.1.1.6"
    "/data/dictionary/TSCharacters.txt"
)

STORE = os.path.join("assets", "data", "famous_chinese_poetry.json")

# `text` is the field holding the verse lines, `title` the field holding the
# poem's name, `author` a fixed name for the two files that carry none.
SOURCES = [
    dict(path="全唐诗/唐诗三百首.json", dynasty="Tang", slug="tang",
         text="paragraphs", title="title", traditional=True),
    dict(path="宋词/宋词三百首.json", dynasty="Song", slug="song",
         text="paragraphs", title="rhythmic", traditional=False),
    dict(path="诗经/shijing.json", dynasty="pre-Qin", slug="pre-qin",
         text="content", title="title", author="佚名", traditional=False),
    dict(path="元曲/yuanqu.json", dynasty="Yuan", slug="yuan",
         text="paragraphs", title="title", traditional=False),
    dict(path="纳兰性德/纳兰性德诗集.json", dynasty="Qing", slug="qing",
         text="para", title="title", traditional=False),
    dict(path="曹操诗集/caocao.json", dynasty="Han", slug="han",
         text="paragraphs", title="title", author="曹操", traditional=False),
    dict(path="五代诗词/nantang/poetrys.json", dynasty="Five Dynasties",
         slug="five_dynasties", text="paragraphs", title="title",
         traditional=False),
    dict(path="五代诗词/huajianji/huajianji-1-juan.json",
         dynasty="Five Dynasties", slug="five_dynasties", text="paragraphs",
         title="title", traditional=False),
]

# The full corpora, read only with `--deep`. The eight anthology files above hold
# 741 poems across 170 poets, so the 100th poet by anthology presence would get a
# collection of **one** poem - which is the complaint this whole feature exists to
# fix. These two add ~58,000 Tang poems and ~22,000 词 so every published poet can
# hold a real collection. They are 34 MB of downloads, hence the opt-in flag and
# the on-disk cache:
#   `poet.tang.*.json` is 繁体 (2783 traditional characters to 37 simplified in a
#   single file), `ci.song.*.json` is 简体 (0 to 4433) - the same split as the
#   anthology files, so the same pinned OpenCC map applies to the Tang side only.
CACHE = os.path.join(os.environ.get("TEMP", "."), "poetry_corpus")
DEEP_SOURCES = [
    dict(label="全唐诗/poet.tang.*.json (58 files)", dynasty="Tang", slug="tang",
         text="paragraphs", title="title", traditional=True,
         paths=["全唐诗/poet.tang.%d.json" % (1000 * i) for i in range(58)]),
    dict(label="宋词/ci.song.*.json (22 files)", dynasty="Song", slug="song",
         text="paragraphs", title="rhythmic", traditional=False,
         paths=["宋词/ci.song.%d.json" % (1000 * i) for i in range(22)]),
]


def source_paths(source):
    """Every corpus file a source reads, in order."""
    return list(source["paths"]) if "paths" in source else [source["path"]]


def cached_fetch(path):
    """`path` from the corpus, kept on disk: the deep corpora are 34 MB total."""
    cache_path = os.path.join(CACHE, path.replace("/", "_"))
    if os.path.exists(cache_path):
        return open(cache_path, encoding="utf-8").read()
    os.makedirs(CACHE, exist_ok=True)
    text = fetch(RAW + "/" + urllib.parse.quote(path))
    with open(cache_path, "w", encoding="utf-8") as handle:
        handle.write(text)
    return text


# Poems the app can never show honestly: one line, or no verse at all. A 元曲
# entry is often a stage direction ("(正旦做悲科)") rather than a poem.
MIN_LINES = 2


def fetch(url):
    """GET `url` as text, with a user agent GitHub does not rate-limit."""
    request = urllib.request.Request(
        url, headers={"User-Agent": "HanziMasterPoetryCollections/1.0"}
    )
    with urllib.request.urlopen(request, timeout=60) as response:
        return response.read().decode("utf-8")


def load_opencc_map():
    """`繁 -> 简` for single characters, from OpenCC's pinned TSCharacters.txt."""
    mapping = {}
    for line in fetch(OPENCC_TS_CHARACTERS).splitlines():
        parts = line.split()
        if len(parts) >= 2:
            # A line is `traditional simplified [further candidates]`; the first
            # simplified form is OpenCC's canonical choice.
            mapping[parts[0]] = parts[1]
    return mapping


def simplify(text, mapping):
    out = []
    for char in text:
        out.append(mapping.get(char, char))
    return "".join(out)


def slug_digest(*parts):
    """8 hex characters, the shape the existing `poetry_<dynasty>_<hex>` ids use."""
    joined = "\u0000".join(parts)
    return hashlib.sha1(joined.encode("utf-8")).hexdigest()[:8]


def normalise(text):
    """Compare poems on their characters alone: whitespace and punctuation vary."""
    stripped = unicodedata.normalize("NFKC", text)
    return "".join(ch for ch in stripped if ch.isalnum() or is_han(ch))


def is_han(char):
    return "\u4e00" <= char <= "\u9fff"


def source_records(source, mapping, paths):
    """Every usable poem across a source's files, in file order."""
    records = []
    for path in paths:
        entries = json.loads(cached_fetch(path))
        for entry in entries:
            if not isinstance(entry, dict):
                continue
            lines = entry.get(source["text"]) or []
            if isinstance(lines, str):
                lines = [lines]
            lines = [str(line).strip() for line in lines if str(line).strip()]
            # A 元曲 or 宋词 entry is often a stage direction or a fragment rather
            # than a poem; a one-line "poem" is not a chapter worth opening.
            if len(lines) < MIN_LINES:
                continue
            title = str(entry.get(source["title"]) or "").strip()
            if not title:
                continue
            author = source.get("author") or str(entry.get("author") or "").strip()
            if not author:
                continue
            if source["traditional"]:
                lines = [simplify(line, mapping) for line in lines]
                title = simplify(title, mapping)
                author = simplify(author, mapping)
            records.append(
                dict(author=author, title=title, lines=lines,
                     dynasty=source["dynasty"], slug=source["slug"],
                     source_path=path)
            )
    return records


def build_entry(record, author_en):
    """A store entry for a poem the app has never seen.

    `title_en`, `summary` and `themes` stay empty: they are generated content,
    and inventing them here would break the project's zero-hallucination rule.
    The chapter falls back to its Chinese title, and `hskLevel` 0 is ignored by
    the collection's median so an ungraded poem cannot skew the book's level.
    """
    first_line = record["lines"][0]
    poem_id = "poetry_%s_%s" % (
        record["slug"],
        slug_digest(record["author"], record["title"], first_line),
    )
    body = "\n".join(record["lines"])
    return OrderedDict([
        ("id", poem_id),
        ("link", poem_id),
        ("title", record["title"]),
        ("titleOriginal", record["title"]),
        ("title_en", ""),
        ("sourceName", record["author"]),
        ("author_en", author_en),
        ("dynasty", record["dynasty"]),
        ("form", ""),
        ("summary", ""),
        ("summary_en", ""),
        ("rawText", body),
        ("rawTextOriginal", body),
        ("rawText_en", ""),
        ("themes", []),
        ("keywords", [record["dynasty"], record["author"]]),
        ("category", "Chinese Poetry"),
        ("hskLevel", 0),
        ("source", "chinese-poetry/chinese-poetry"),
        ("sourcePath", record["source_path"]),
        ("sourceRevision", REVISION),
        ("sourceLicense", "MIT"),
        ("priority", 100),
    ])


def merge(store, records, per_author, publish=frozenset()):
    """Keep the curated poems first, then top each poet up to `per_author`."""
    existing_counts = defaultdict(int)
    english_names = {}
    seen = defaultdict(set)
    seen_titles = defaultdict(set)
    for entry in store:
        author = str(entry.get("sourceName") or "").strip()
        existing_counts[author] += 1
        english_names.setdefault(author, str(entry.get("author_en") or "").strip())
        seen[author].add(normalise(str(entry.get("rawText") or "")))
        seen_titles[author].add(str(entry.get("title") or "").strip())

    added = defaultdict(list)
    skipped_unknown_author = 0
    for record in records:
        author = record["author"]
        # Only poets the store already publishes, plus any named in
        # `--publish-file`: pulling all 170 anthology authors would invent
        # collections nobody curated, and most would hold a single poem.
        if author not in existing_counts and author not in publish:
            skipped_unknown_author += 1
            continue
        # The cap is the poet's *total*, curated poems included — counting only
        # the new ones would overshoot by however many are already published.
        if existing_counts[author] + len(added[author]) >= per_author:
            continue
        # The anthology's text of a poem we already curated often differs from
        # the curated edition, so a verse fingerprint alone lets it back in as a
        # near-duplicate. The title is the second guard.
        title = record["title"]
        if title in seen_titles[author]:
            continue
        fingerprint = normalise("".join(record["lines"]))
        if fingerprint in seen[author]:
            continue
        seen_titles[author].add(title)
        seen[author].add(fingerprint)
        added[author].append(build_entry(record, english_names.get(author, "")))

    merged = list(store)
    for _author, extra in added.items():
        merged.extend(extra)
    return merged, added, skipped_unknown_author


def summarise(store):
    counts = defaultdict(int)
    for entry in store:
        counts[str(entry.get("sourceName") or "").strip()] += 1
    return counts


def check(store):
    """Structural problems that would break the app, and non-fatal warnings."""
    problems = []
    warnings = []
    ids = set()
    for index, entry in enumerate(store):
        for field in ("id", "title", "rawText", "sourceName"):
            if not str(entry.get(field) or "").strip():
                problems.append("entry %d has no %s" % (index, field))
        poem_id = str(entry.get("id") or "")
        if poem_id in ids:
            problems.append("duplicate id %s" % poem_id)
        ids.add(poem_id)
        lines = [ln for ln in str(entry.get("rawText") or "").split("\n")
                 if ln.strip()]
        if len(lines) < MIN_LINES:
            warnings.append("%s has %d line(s)" % (poem_id, len(lines)))
    return problems, warnings


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument("--per-author", type=int, default=50,
                        help="maximum poems per poet (curated poems always kept)")
    parser.add_argument("--dry-run", action="store_true",
                        help="report without writing")
    parser.add_argument("--check", action="store_true",
                        help="validate the store and exit")
    parser.add_argument("--out", default=STORE, help="where to write the store")
    parser.add_argument("--deep", action="store_true",
                        help="also read the full 全唐诗 and 宋词 corpora "
                             "(58 + 22 files, 34 MB, cached after the first run)")
    parser.add_argument("--publish-file",
                        help="a file of poet names to start publishing, one per "
                             "line; without it only poets already in the store "
                             "are topped up")
    args = parser.parse_args()

    # The store carries a UTF-8 BOM and CRLF line endings; both are preserved on
    # write so regenerating it stays a content diff rather than a whole-file one.
    with open(STORE, encoding="utf-8-sig") as handle:
        store = json.load(handle, object_pairs_hook=OrderedDict)

    if args.check:
        problems, warnings = check(store)
        for problem in problems:
            print("  ! " + problem)
        for warning in warnings[:10]:
            print("  ~ " + warning)
        print("checked %d entries: %d problem(s), %d warning(s)"
              % (len(store), len(problems), len(warnings)))
        return 1 if problems else 0

    print("store: %d poems, %d poets" % (len(store), len(summarise(store))))
    mapping = load_opencc_map()
    print("opencc: %d traditional->simplified characters" % len(mapping))

    publish = set()
    if args.publish_file:
        with open(args.publish_file, encoding="utf-8") as handle:
            publish = {line.strip() for line in handle if line.strip()}
        print("publish list: %d poet(s) may start a collection" % len(publish))

    sources = list(SOURCES) + (DEEP_SOURCES if args.deep else [])
    records = []
    for source in sources:
        paths = source_paths(source)
        got = source_records(source, mapping, paths)
        records.extend(got)
        print("  %-44s %5d usable poems" % (source.get("label") or source["path"],
                                            len(got)))

    merged, added, skipped = merge(store, records, args.per_author, publish)
    total_added = sum(len(v) for v in added.values())
    print("")
    print("added %d poems across %d poets (%d records skipped: poet is not "
          "published yet)" % (total_added, len(added), skipped))

    before = summarise(store)
    after = summarise(merged)
    for author in sorted(after, key=lambda a: (-after[a], a))[:14]:
        print("  %-8s %2d -> %2d" % (author, before[author], after[author]))

    problems, warnings = check(merged)
    for problem in problems:
        print("  ! " + problem)
    if problems:
        print("refusing to write: %d structural problem(s)" % len(problems))
        return 1
    print("validation: 0 structural problems, %d short-poem warning(s)"
          % len(warnings))

    if args.dry_run:
        print("dry run: %d poems in memory, nothing written" % len(merged))
        return 0

    directory = os.path.dirname(args.out)
    if directory:
        os.makedirs(directory, exist_ok=True)
    with open(args.out, "w", encoding="utf-8", newline="\r\n") as handle:
        handle.write("\ufeff")
        json.dump(merged, handle, ensure_ascii=False, indent=2)
        handle.write("\n")
    print("wrote %d poems to %s" % (len(merged), args.out))
    return 0


if __name__ == "__main__":
    sys.exit(main())
