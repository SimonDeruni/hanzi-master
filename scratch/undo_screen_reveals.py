#!/usr/bin/env python3
"""Undo add_screen_reveals.py exactly.

The faulty codemod made precisely two insertions per file:
  1. `ZenFadeIn(child: ` at the start of the body expression, and
  2. a stray `)` appended at EOF (its scanner ran to end-of-file because a quote
     inside a `//` comment defeated the string skipper - an apostrophe in a
     comment is not a string opener).
Plus it may have added the zen_loader import.

Removing those three things restores the original bytes, which `flutter analyze`
then confirms (the pre-codemod tree was clean).
"""
from __future__ import annotations

from pathlib import Path

MARKER = "ZenFadeIn(child: "
IMPORT_LINE = "import 'package:hanzi_master/shared/widgets/zen_loader.dart';"

FILES = [
    "lib/features/auth/presentation/screens/auth_screen.dart",
    "lib/features/auth/presentation/screens/delete_account_screen.dart",
    "lib/features/course/presentation/screens/tome_manager_screen.dart",
    "lib/features/course/presentation/widgets/radical_detail_sheet.dart",
    "lib/features/echo_hall/presentation/screens/scenario_selection_screen.dart",
    "lib/features/echo_hall/presentation/widgets/live_call_summary_screen.dart",
    "lib/features/echo_hall/presentation/widgets/tone_comparison_sheet.dart",
    "lib/features/flashcards/presentation/screens/daily_study_dashboard_screen.dart",
    "lib/features/flashcards/presentation/screens/deck_review_session_screen.dart",
    "lib/features/flashcards/presentation/screens/dictionary_screen.dart",
    "lib/features/flashcards/presentation/screens/profile_screen.dart",
    "lib/features/flashcards/presentation/screens/radical_detail_screen.dart",
    "lib/features/flashcards/presentation/screens/radical_library_screen.dart",
    "lib/features/flashcards/presentation/screens/session_summary_screen.dart",
    "lib/features/flashcards/presentation/screens/settings_screen.dart",
    "lib/features/flashcards/presentation/screens/stats_screen.dart",
    "lib/features/flashcards/presentation/widgets/deck_settings_sheet.dart",
    "lib/features/flashcards/presentation/widgets/flashcard_edit_dialog.dart",
    "lib/features/flashcards/presentation/widgets/study_mode_selection_sheet.dart",
    "lib/features/media/presentation/screens/media_hub_screen.dart",
    "lib/features/media/presentation/screens/simplified_article_reader_screen.dart",
    "lib/features/media/presentation/screens/story_summary_screen.dart",
    "lib/features/reading/presentation/screens/book_detail_screen.dart",
    "lib/features/settings/presentation/screens/ai_data_privacy_screen.dart",
    "lib/features/settings/presentation/screens/contact_screen.dart",
    "lib/features/settings/presentation/screens/qa_screen.dart",
]

for rel in FILES:
    path = Path(rel)
    original = path.read_text(encoding="utf-8")
    src = original

    if IMPORT_LINE in src and src.count("ZenFadeIn") == 1:
        lines = [l for l in src.split("\n") if l.strip() != IMPORT_LINE]
        src = "\n".join(lines)

    if MARKER in src:
        idx = src.index(MARKER)
        src = src[:idx] + src[idx + len(MARKER):]

    stripped = src.rstrip()
    if stripped.endswith(")") and stripped.count("(") == stripped.count(")") - 1:
        # Only strip when that stray paren is what unbalances the file.
        src = stripped[:-1].rstrip() + "\n"

    if src.count("(") != src.count(")"):
        print(f"UNBALANCED {rel}  open={src.count('(')} close={src.count(')')}")
    if src != original:
        path.write_text(src, encoding="utf-8")
        print(f"reverted {rel}")
