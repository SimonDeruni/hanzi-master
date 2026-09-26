"""Route every raw haptic, and the haptics_manager import, to its new home.

Two mechanical moves in one auditable pass:

1.  The manager moved from
    ``features/flashcards/presentation/utils/haptics_manager.dart`` to
    ``core/services/haptics_manager.dart``.  It is imported by ``core``,
    ``shared`` and ten features, so living inside one feature inverted the
    dependency direction.  All three import spellings (package, and the two
    relative forms) collapse to the package path.
2.  The 13 raw ``HapticFeedback.*`` calls in four files now go through the
    manager.  A raw call is invisible to the Settings toggle, so a user who
    turns haptics off still gets buzzed by the paywall and the shadowing studio.

Matching is by *content*, not by line number, so a concurrent edit that shifts
lines cannot silently mis-apply; the per-file counts are asserted instead.

Dry run by default.  Pass --apply to write.
"""

import sys
from pathlib import Path

ROOT = Path(r"C:\Users\simon\Documents\hanzi_master")
LIB = ROOT / "lib"

NEW_IMPORT = "import 'package:hanzi_master/core/services/haptics_manager.dart';"
OLD_IMPORTS = (
    "import 'package:hanzi_master/features/flashcards/"
    "presentation/utils/haptics_manager.dart';",
    "import '../../../flashcards/presentation/utils/haptics_manager.dart';",
    "import '../utils/haptics_manager.dart';",
)

CALL_MAP = (
    ("HapticFeedback.lightImpact();", "HapticsManager.light();"),
    ("HapticFeedback.mediumImpact();", "HapticsManager.medium();"),
    ("HapticFeedback.heavyImpact();", "HapticsManager.heavy();"),
    ("HapticFeedback.selectionClick();", "HapticsManager.selection();"),
)

# file (relative to lib/) -> exactly how many raw calls it must hold
CALL_FILES = {
    "core/presentation/widgets/hanzi_text_field.dart": 1,
    "core/presentation/widgets/zen_search_bar.dart": 1,
    "features/live_translate/presentation/screens/"
    "shadowing_studio_screen.dart": 5,
    "features/premium/presentation/screens/custom_paywall_screen.dart": 6,
}

IMPORT_AFTER = "import 'package:flutter/services.dart';"


def main() -> int:
    apply = "--apply" in sys.argv
    print("MODE:", "APPLY" if apply else "DRY RUN")
    failures = []

    # ---- 1. the import move ------------------------------------------------
    moved = 0
    touched = set()
    for path in sorted(LIB.rglob("*.dart")):
        if path.name == "haptics_manager.dart":
            continue
        text = path.read_text(encoding="utf-8")
        hit = [old for old in OLD_IMPORTS if old in text]
        if not hit:
            continue
        for old in hit:
            text = text.replace(old, NEW_IMPORT)
        rel = path.relative_to(LIB).as_posix()
        print("  import  %-70s %s" % (rel, " | ".join(h.split("/")[-1] for h in hit)))
        if apply:
            path.write_text(text, encoding="utf-8")
        moved += 1
        touched.add(path)
    print("imports updated: %d" % moved)
    if moved != 45:
        failures.append("expected 45 import sites, found %d" % moved)

    # ---- 2. the raw calls --------------------------------------------------
    routed = 0
    for rel, expected in CALL_FILES.items():
        path = LIB / rel
        text = path.read_text(encoding="utf-8")
        found = sum(text.count(old) for old, _ in CALL_MAP)
        if found != expected:
            failures.append("%s: expected %d raw calls, found %d" % (rel, expected, found))
            continue
        for old, new in CALL_MAP:
            text = text.replace(old, new)
        if NEW_IMPORT not in text:
            if IMPORT_AFTER in text:
                text = text.replace(IMPORT_AFTER, IMPORT_AFTER + "\n" + NEW_IMPORT, 1)
                print("  +import %s" % rel)
            else:
                failures.append("%s: no services.dart import to anchor on" % rel)
                continue
        print("  call    %-70s %d -> HapticsManager" % (rel, found))
        if apply:
            path.write_text(text, encoding="utf-8")
        routed += found
        touched.add(path)
    print("raw calls routed: %d" % routed)
    if routed != 13:
        failures.append("expected 13 raw calls, routed %d" % routed)

    print("files touched: %d" % len(touched))
    if failures:
        print("\nFAILED:")
        for f in failures:
            print("  - %s" % f)
        return 1
    print("\nOK" + ("" if apply else "  (dry run - re-run with --apply)"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
