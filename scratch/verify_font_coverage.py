"""Name exactly which requested characters the bundled subset lacks.

`build_font_subset.py` reports a *count*; this answers the question that actually
matters - whether any **taught** character (one in `hanzi_metadata.json`) falls
outside the bundled face and therefore renders silently in a second font.

Writes the full list to `scratch/font_coverage_report.txt` so the characters survive
a cp1252 console that cannot print them.

    python scratch/verify_font_coverage.py
"""

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import build_font_subset as builder  # noqa: E402

from fontTools.ttLib import TTFont  # noqa: E402

REPORT = Path(__file__).parent / "font_coverage_report.txt"


def main() -> int:
    found: set = set()
    builder._from_metadata(found)
    builder._from_dictionary(found)
    builder._from_books(found)
    requested = found | set(builder.EXTRA)

    metadata = json.loads(
        (builder.DATA / "hanzi_metadata.json").read_text(encoding="utf-8")
    )
    taught = set(builder.CJK.findall("".join(metadata.keys())))

    font = TTFont(builder.OUT / "NotoSerifSC-Regular.ttf")
    cmap = font.getBestCmap()
    missing = sorted(c for c in requested if ord(c) not in cmap)
    taught_missing = [c for c in missing if c in taught]
    hanzi_missing = [c for c in missing if builder.CJK.match(c)]
    other_missing = [c for c in missing if not builder.CJK.match(c)]

    report = REPORT
    report.write_text(
        "requested: %d\nmissing: %d\nhanzi missing: %d\ntaught missing: %d\n\n"
        "taught: %s\n\nhanzi: %s\n\nother: %s\n"
        % (
            len(requested),
            len(missing),
            len(hanzi_missing),
            len(taught_missing),
            "".join(taught_missing),
            "".join(hanzi_missing),
            "".join(other_missing),
        ),
        encoding="utf-8",
    )

    print("  requested %d | missing %d" % (len(requested), len(missing)))
    print(
        "  of the missing: hanzi %d, taught %d, other %d"
        % (len(hanzi_missing), len(taught_missing), len(other_missing))
    )
    print("  report -> %s" % report)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
