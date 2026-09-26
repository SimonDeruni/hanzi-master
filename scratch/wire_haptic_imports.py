"""Add the `HapticsManager` import to any file that calls it but forgets it.

The haptic sweep edits call sites in a dozen files, several of which had never
touched the manager before. Rather than hand-edit each import block (and guess at
each file's ordering), this finds the end of the first import run and inserts the
canonical package import there. Dart does not reorder imports and this repo has
no `directives_ordering` lint, so placement is only cosmetic.

Dry run by default.  Pass --apply to write.
"""

import sys
from pathlib import Path

ROOT = Path(r"C:\Users\simon\Documents\hanzi_master")
LIB = ROOT / "lib"

IMPORT = "import 'package:hanzi_master/core/services/haptics_manager.dart';"
NEEDLE = "HapticsManager."


def main() -> int:
    apply = "--apply" in sys.argv
    print("MODE:", "APPLY" if apply else "DRY RUN")

    changed = []
    skipped = []
    for path in sorted(LIB.rglob("*.dart")):
        if path.name == "haptics_manager.dart":
            continue
        text = path.read_text(encoding="utf-8")
        if NEEDLE not in text or IMPORT in text:
            continue

        lines = text.split("\n")
        idx = None
        for i, line in enumerate(lines[:80]):
            if line.startswith("import ") and line.rstrip().endswith(";"):
                idx = i
        if idx is None:
            skipped.append(str(path.relative_to(LIB)))
            continue

        lines.insert(idx + 1, IMPORT)
        print("  +import  %s" % path.relative_to(LIB))
        if apply:
            path.write_text("\n".join(lines), encoding="utf-8")
        changed.append(path)

    print("files updated: %d" % len(changed))
    if skipped:
        print("SKIPPED (no import block found): %s" % ", ".join(skipped))
    print("OK" + ("" if apply else "  (dry run - re-run with --apply)"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
