#!/usr/bin/env python3
"""Verify the reachability verdicts: for each unreachable screen class, list the
files that reference it and say whether any of them is reachable itself."""
from __future__ import annotations

import re
from collections import deque
from pathlib import Path

LIB = Path("lib")
ENTRY = LIB / "main.dart"
IMPORT_RE = re.compile(r"""^\s*import\s+['"]([^'"]+)['"]""", re.MULTILINE)
CLASS_RE = re.compile(r"^\s*(?:abstract\s+)?class\s+(\w+)" , re.MULTILINE)

REPORT = [
    "course/presentation/screens/course_screen.dart",
    "course/presentation/screens/course_selection_screen.dart",
    "course/presentation/screens/lesson_screen.dart",
    "course/presentation/widgets/mission_briefing_sheet.dart",
    "flashcards/presentation/screens/flashcard_form_screen.dart",
    "flashcards/presentation/widgets/word_detail_dialog.dart",
    "media/presentation/screens/show_catalog_screen.dart",
    "media/presentation/screens/show_detail_screen.dart",
    "media/presentation/screens/story_cultural_insight_screen.dart",
    "media/presentation/screens/story_library_screen.dart",
    "monetization/presentation/screens/paywall_screen.dart",
    "onboarding/presentation/screens/tutorial_lesson_screen.dart",
    "premium/presentation/screens/paywall_sheet.dart",
    "quiz/presentation/screens/quiz_screen.dart",
    "reading/presentation/screens/reading_room_screen.dart",
    "reading/presentation/widgets/custom_story_creator_sheet.dart",
]


def resolve(importer: Path, target: str) -> Path | None:
    if target.startswith("package:hanzi_master/"):
        candidate = LIB / target[len("package:hanzi_master/"):]
    elif target.startswith(("dart:", "package:")):
        return None
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


live = reachable()
sources = {p: p.read_text(encoding="utf-8") for p in LIB.rglob("*.dart")}

for rel in REPORT:
    path = LIB / "features" / rel
    if not path.exists():
        print(f"{rel}: MISSING")
        continue
    classes = set(CLASS_RE.findall(sources[path]))
    referrers = set()
    for other, text in sources.items():
        if other == path:
            continue
        for name in classes:
            if re.search(rf"\b{re.escape(name)}\b", text):
                referrers.add(other)
    live_referrers = sorted(p.as_posix() for p in referrers if p in live)
    print(f"{rel}")
    print(f"    classes={sorted(classes)}")
    print(f"    referrers={len(referrers)}  REACHABLE referrers={len(live_referrers)}")
    for ref in live_referrers:
        print(f"        LIVE -> {ref}")
