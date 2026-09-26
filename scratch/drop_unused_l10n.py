"""Delete the `final l10n = ...` lines the typography sweep left unused.

Replacing `fontFamily: l10n.serif` with the bundled family removed the last use
of `l10n` in two build methods, so the analyzer reports `unused_local_variable`.
The same line appears three times in the file (one of which is still used), so
this targets by **line number with a content assertion** rather than by text,
and deletes from the bottom up so the earlier indices stay valid.

    python scratch/drop_unused_l10n.py            # report only
    python scratch/drop_unused_l10n.py --apply
"""

import sys
from pathlib import Path

TARGET = (
    Path(r"C:\Users\simon\Documents\hanzi_master")
    / "lib"
    / "features"
    / "media"
    / "presentation"
    / "screens"
    / "simplified_article_reader_screen.dart"
)

EXPECTED = "    final l10n = AppLocalizations.of(context)!;"
LINES = (150, 275)


def main() -> int:
    apply = "--apply" in sys.argv
    print("MODE:", "APPLY" if apply else "DRY RUN")

    lines = TARGET.read_text(encoding="utf-8").split("\n")
    print("  file: %s (%d lines)" % (TARGET.name, len(lines)))

    for number in sorted(LINES, reverse=True):
        actual = lines[number - 1]
        if actual != EXPECTED:
            print("  FAILED: line %d is not the expected declaration:" % number)
            print("    got: %r" % actual)
            return 1
        print("  delete line %d" % number)
        if apply:
            del lines[number - 1]

    if apply:
        TARGET.write_text("\n".join(lines), encoding="utf-8")
        left = TARGET.read_text(encoding="utf-8").count(EXPECTED)
        print("  remaining declarations: %d (1 is still in use)" % left)
    print("OK" + ("" if apply else "  (dry run - re-run with --apply)"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
