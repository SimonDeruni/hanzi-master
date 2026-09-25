#!/usr/bin/env python3
"""Which screens/sheets are actually reachable from the app's entry point?

`flutter analyze` reports zero issues, so there are no unused imports in `lib/`.
That makes a plain import-graph walk from `lib/main.dart` an exact answer: any
file that is not reachable is dead code, and any screen it defines is unreached.

Usage: python scratch/reachable_screens.py
"""
from __future__ import annotations

import re
from collections import deque
from pathlib import Path

LIB = Path("lib")
ENTRY = LIB / "main.dart"

IMPORT_RE = re.compile(r"""^\s*import\s+['"]([^'"]+)['"]""", re.MULTILINE)


def _without_comments(source: str) -> str:
    return "\n".join(
        line[: line.index("//")] if "//" in line else line
        for line in source.split("\n")
    )


def resolve(importer: Path, target: str) -> Path | None:
    """Maps an import URI onto a file inside lib/, or None if it is external."""
    if target.startswith("package:hanzi_master/"):
        candidate = LIB / target[len("package:hanzi_master/"):]
    elif target.startswith("dart:") or target.startswith("package:"):
        return None  # SDK or third-party package
    else:
        candidate = (importer.parent / target).resolve()
        try:
            candidate = candidate.relative_to(Path.cwd())
        except ValueError:
            return None
    return candidate if candidate.suffix == ".dart" else Path(f"{candidate}.dart")


def reachable() -> set[Path]:
    seen: set[Path] = set()
    queue: deque[Path] = deque([ENTRY])
    while queue:
        current = queue.popleft()
        if current in seen or not current.exists():
            continue
        seen.add(current)
        for target in IMPORT_RE.findall(current.read_text(encoding="utf-8")):
            resolved = resolve(current, target)
            if resolved is not None and resolved not in seen:
                queue.append(resolved)
    return seen


def main() -> int:
    live = reachable()
    all_files = {p for p in LIB.rglob("*.dart")}

    screens = sorted(
        p
        for p in all_files
        if "/presentation/" in p.as_posix()
        and re.search(r"(screen|sheet|dialog)\.dart$", p.name)
    )
    dead = [p for p in screens if p not in live]

    print(f"lib files                : {len(all_files)}")
    print(f"reachable from main.dart : {len(live)}")
    print(f"screen/sheet/dialog files: {len(screens)}")
    print(f"  -> REACHABLE           : {len(screens) - len(dead)}")
    print(f"  -> UNREACHABLE (dead)   : {len(dead)}")
    print("-" * 72)
    print("UNREACHABLE screen/sheet/dialog files:")
    for path in dead:
        print(f"  {path.as_posix()}")

    # Any lib file at all that nothing imports.
    orphan_files = sorted(p for p in all_files if p not in live)
    print("-" * 72)
    print(f"ALL unreachable lib files ({len(orphan_files)}):")

    # Targets: reachable screens/sheets/dialogs with no animation primitive.
    anim_re = re.compile(
        r"Animated[A-Za-z]+\(|AnimationController\(|TweenAnimationBuilder"
        r"|\.animate\(|ZenMotion|ZenFadeIn|Hero\("
    )
    targets = [
        p for p in screens
        if p in live
        and not anim_re.search(_without_comments(p.read_text(encoding="utf-8")))
    ]
    print("-" * 72)
    print(f"TARGETS: reachable screens/sheets with NO animation ({len(targets)}):")
    for path in targets:
        print(f"  {path.as_posix()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
