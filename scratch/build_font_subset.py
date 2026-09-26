"""Build the bundled Zen serif from Noto Serif SC (SIL OFL 1.1).

Why this exists
---------------
The app has always *asked* for `'NotoSerifSC'` - 60 declarations across ~30
files - without ever bundling it: the `fonts:` block in `pubspec.yaml` is
commented out and `assets/fonts/` did not exist. Flutter therefore fell back
silently at every one of those 60 sites, so the calligraphic identity never
shipped, Latin text rendered differently on iOS and Android, and the hanzi
themselves - the product - were drawn in whatever sans-serif CJK font the device
happened to have.

This turns the 24 MB upstream **variable** font into two small **static**
weights carrying exactly what the app draws:

  * every hanzi in `assets/data/hanzi_metadata.json` - the taught inventory
  * every hanzi in `assets/data/dictionary.db` - the 190 MB lookup corpus
  * every hanzi in `assets/data/books/*.json` - the reading room
  * pinyin tone vowels, so tone marks never fall back to a second face
  * ASCII, Latin-1 / Latin-Extended-A, CJK punctuation and the arrows and
    symbols the UI actually prints

Two static weights rather than one variable file is deliberate: Flutter maps
`fontWeight` onto declared static faces predictably, whereas a variable CJK face
needs `fontVariations` at every site to avoid synthetic weights.

The upstream file is **not kept in the repository** (24 MB). Fetch it first:

    curl -sL -o "assets/fonts/_full_NotoSerifSC[wght].ttf" ^
      "https://raw.githubusercontent.com/google/fonts/main/ofl/notoserifsc/NotoSerifSC%5Bwght%5D.ttf"

and the licence, if `assets/fonts/OFL.txt` is missing:

    curl -sL -o assets/fonts/OFL.txt ^
      "https://raw.githubusercontent.com/google/fonts/main/ofl/notoserifsc/OFL.txt"

Usage:
    python scratch/build_font_subset.py            # report only
    python scratch/build_font_subset.py --build    # write assets/fonts/
    python scratch/verify_font_coverage.py         # name any gaps
"""

import json
import re
import sqlite3
import sys
import tempfile
import time
from pathlib import Path

ROOT = Path(r"C:\Users\simon\Documents\hanzi_master")
DATA = ROOT / "assets" / "data"
OUT = ROOT / "assets" / "fonts"
SRC = OUT / "_full_NotoSerifSC[wght].ttf"

CJK = re.compile(r"[\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]")

# Everything that is not a hanzi but is still drawn in this face.
EXTRA = (
    "".join(chr(c) for c in range(0x20, 0x7F))          # ASCII printable
    + "".join(chr(c) for c in range(0xA0, 0x180))        # Latin-1 + Latin Ext-A
    + "".join(chr(c) for c in range(0x1EA0, 0x1F00))     # Vietnamese
    + "ƠơƯư"                                             # Vietnamese Ext-B letters
    + "āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜ"                        # pinyin tone vowels
    + "ĀÁǍÀĒÉĚÈĪÍǏÌŌÓǑÒŪÚǓÙǕǗǙǛ"
    + "üÜ·×÷°′″±≈≠≤≥$€¥£%&@#№"
    + "。、，：；？！「」『』《》〈〉（）【】〔〕…—～"
    + "→←↑↓•✓✗★☆♫♪⚠ℹ⏱⏸▶⏹"
)


def _from_metadata(found: set) -> int:
    path = DATA / "hanzi_metadata.json"
    if not path.exists():
        return 0
    data = json.loads(path.read_text(encoding="utf-8"))
    before = len(found)
    found.update(CJK.findall("".join(data.keys())))
    return len(found) - before


def _from_dictionary(found: set) -> int:
    path = DATA / "dictionary.db"
    if not path.exists():
        return 0
    before = len(found)
    conn = sqlite3.connect("file:%s?mode=ro" % path.as_posix(), uri=True)
    try:
        tables = [
            r[0]
            for r in conn.execute(
                "SELECT name FROM sqlite_master WHERE type='table'"
            )
        ]
        for table in tables:
            cols = [
                r[1]
                for r in conn.execute('PRAGMA table_info("%s")' % table)
                if (r[2] or "").upper().startswith(("TEXT", "VARCHAR", "CHAR"))
            ]
            for col in cols:
                try:
                    for (value,) in conn.execute(
                        'SELECT "%s" FROM "%s"' % (col, table)
                    ):
                        if isinstance(value, str):
                            found.update(CJK.findall(value))
                except sqlite3.Error:
                    continue
    finally:
        conn.close()
    return len(found) - before


def _from_books(found: set) -> int:
    before = len(found)
    for book in sorted((DATA / "books").glob("*.json")):
        with book.open(encoding="utf-8", errors="ignore") as handle:
            for line in handle:
                found.update(CJK.findall(line))
    return len(found) - before


def main() -> int:
    build = "--build" in sys.argv
    print("MODE:", "BUILD" if build else "REPORT ONLY")

    if not SRC.exists():
        print("missing upstream font: %s" % SRC)
        return 1

    found: set = set()
    started = time.time()
    print("  hanzi_metadata.json : +%d" % _from_metadata(found))
    print("  dictionary.db       : +%d" % _from_dictionary(found))
    print("  books/*.json        : +%d" % _from_books(found))
    print("  unique hanzi        : %d  (%.1fs)" % (len(found), time.time() - started))

    requested = found | set(EXTRA)
    print("  + ASCII/pinyin/punct: %d requested characters" % len(requested))

    if not build:
        print("OK  (report only - re-run with --build)")
        return 0

    from fontTools import subset
    from fontTools.ttLib import TTFont
    from fontTools.varLib import instancer

    with tempfile.NamedTemporaryFile(
        "w", encoding="utf-8", delete=False, suffix=".txt"
    ) as handle:
        handle.write("".join(sorted(requested)))
        chars_file = handle.name

    failures = []
    for weight, name in ((400, "Regular"), (700, "Bold")):
        target = OUT / ("NotoSerifSC-%s.ttf" % name)
        variable = TTFont(SRC)
        instancer.instantiateVariableFont(
            variable, {"wght": weight}, inplace=True, updateFontNames=True
        )
        with tempfile.NamedTemporaryFile(delete=False, suffix=".ttf") as handle:
            instance_path = handle.name
        variable.save(instance_path)
        variable.close()

        subset.main(
            [
                instance_path,
                "--text-file=%s" % chars_file,
                "--layout-features=*",
                "--output-file=%s" % target,
            ]
        )

        check = TTFont(target)
        cmap = check.getBestCmap()
        missing = [c for c in sorted(requested) if ord(c) not in cmap]
        print(
            "  %-8s -> %-26s %6d KB  (%d glyphs, %d of %d requested covered)"
            % (
                name,
                target.name,
                target.stat().st_size // 1024,
                len(cmap),
                len(requested) - len(missing),
                len(requested),
            )
        )
        if missing:
            failures.append((name, missing))
        check.close()

    for name, missing in failures:
        # Count only: this console cannot encode the characters themselves, and
        # `scratch/verify_font_coverage.py` writes the full list to a UTF-8 file.
        print("  NOTE %s lacks %d requested characters" % (name, len(missing)))
    print("OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
