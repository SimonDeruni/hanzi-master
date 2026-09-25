#!/usr/bin/env python3
"""Give every REACHABLE static screen/sheet a content entrance.

`ZenFadeIn` (fade + 6px lift, `ZenMotion.quick`, no-op under reduce motion) is the
project's own primitive for "content eases in instead of snapping" - it existed
but had zero call sites.

Two rules, both depth-aware:
  A. Wrap a `Scaffold`'s own `body:` argument  ->  Scaffold(body: ZenFadeIn(child: X))
  B. Fallback for sheets/dialogs with no Scaffold: wrap the build method's single
     top-level `return <expr>;`

A file is skipped (and reported) if the shape is ambiguous, so nothing is wrapped
by accident. Run with --dry-run first.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ZEN_LOADER_IMPORT = "package:hanzi_master/shared/widgets/zen_loader.dart"

TARGETS = [
    "lib/features/auth/presentation/screens/auth_screen.dart",
    "lib/features/auth/presentation/screens/delete_account_screen.dart",
    "lib/features/course/presentation/screens/tome_manager_screen.dart",
    "lib/features/course/presentation/widgets/radical_detail_sheet.dart",
    "lib/features/echo_hall/presentation/screens/scenario_selection_screen.dart",
    "lib/features/echo_hall/presentation/widgets/live_call_summary_screen.dart",
    "lib/features/echo_hall/presentation/widgets/pronunciation_report_sheet.dart",
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
    "lib/features/flashcards/presentation/widgets/deck_selection_sheet.dart",
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


def skip_span(src: str, index: int) -> int:
    """Index just past a string literal starting at `index`."""
    quote = src[index]
    if src.startswith(quote * 3, index):
        end = src.find(quote * 3, index + 3)
        return len(src) if end < 0 else end + 3
    i = index + 1
    while i < len(src) and src[i] != quote:
        i += 2 if src[i] == "\\" else 1
    return i + 1


def advance(src: str, index: int) -> int:
    """Next index after skipping a comment or string literal at `index`.

    The previous version treated every quote as a string opener, so an
    apostrophe inside a `//` comment (e.g. "// don't") desynchronised the
    scanner and it ran to end-of-file. Comments are checked first, then strings.
    """
    if src.startswith("//", index):
        newline = src.find("\n", index)
        return len(src) if newline < 0 else newline
    if src.startswith("/*", index):
        end = src.find("*/", index)
        return len(src) if end < 0 else end + 2
    if src[index] in "\"'":
        return skip_span(src, index)
    return index


def spans(src: str, anchor: str) -> list[tuple[int, int]]:
    found: list[tuple[int, int]] = []
    for match in re.finditer(re.escape(anchor) + r"(?:<[^()<>]*>)?\s*\(", src):
        open_paren = src.rindex("(", match.start(), match.end())
        depth, i = 0, open_paren
        while i < len(src):
            nxt = advance(src, i)
            if nxt != i:
                i = nxt
                continue
            char = src[i]
            if char == "(":
                depth += 1
            elif char == ")":
                depth -= 1
                if depth == 0:
                    found.append((open_paren, i + 1))
                    break
            i += 1
    return found


def depth_at(body: str, index: int) -> int:
    depth, i = 0, 0
    while i < index:
        nxt = advance(body, i)
        if nxt != i:
            i = nxt
            continue
        if body[i] == "(":
            depth += 1
        elif body[i] == ")":
            depth -= 1
        i += 1
    return depth


def scan_value(src: str, start: int) -> int:
    """End of an expression: stops at a top-level `,` or the closing `)`."""
    depth, i = start, 0
    while i < len(src):
        nxt = advance(src, i)
        if nxt != i:
            i = nxt
            continue
        char = src[i]
        if char in "([{":
            depth += 1
        elif char in ")]}":
            if depth == 0:
                return i
            depth -= 1
        elif char == "," and depth == 0:
            return i
        i += 1
    return len(src)


def rule_a(src: str) -> tuple[str, str] | None:
    """Wrap the unique Scaffold's own `body:` argument."""
    placements = spans(src, "Scaffold")
    if len(placements) != 1:
        return None
    open_paren, close = placements[0]
    body = src[open_paren:close]
    for match in re.finditer(r"\bbody:\s*", body):
        if depth_at(body, match.start()) != 1:
            continue
        start = open_paren + match.end()
        end = scan_value(src, start)
        inner = src[start:end]
        if "ZenFadeIn(" in inner or not inner.strip():
            return None
        return src[:start] + f"ZenFadeIn(child: {inner})" + src[end:], inner
    return None


def rule_b(src: str) -> tuple[str, str] | None:
    """Wrap the single top-level `return` of the first build method."""
    match = re.search(r"Widget\s+build\(BuildContext\s+\w+\)\s*\{", src)
    if not match:
        return None
    start = match.end()
    depth, i, returns = 1, start, []
    while i < len(src) and depth:
        nxt = advance(src, i)
        if nxt != i:
            i = nxt
            continue
        char = src[i]
        if char == "{":
            depth += 1
        elif char == "}":
            depth -= 1
            if depth == 0:
                break
        elif depth == 1 and src.startswith("return", i) and not src[i - 1].isalnum():
            target = i + len("return")
            while target < len(src) and src[target] in " \n\r\t":
                target += 1
            end, nested = target, 0
            while end < len(src):
                step = advance(src, end)
                if step != end:
                    end = step
                    continue
                ch = src[end]
                if ch in "([{":
                    nested += 1
                elif ch in ")]}":
                    if nested == 0:
                        break
                    nested -= 1
                elif ch == ";" and nested == 0:
                    break
                end += 1
            returns.append((target, end))
        i += 1
    if len(returns) != 1:
        return None
    target, end = returns[0]
    inner = src[target:end]
    if "ZenFadeIn(" in inner or not inner.strip():
        return None
    return src[:target] + f"ZenFadeIn(child: {inner})" + src[end:], inner


def ensure_import(src: str) -> tuple[str, bool]:
    if ZEN_LOADER_IMPORT in src:
        return src, False
    lines = src.split("\n")
    last = max(
        (i for i, l in enumerate(lines) if l.lstrip("\ufeff").startswith("import ")),
        default=None,
    )
    if last is None:
        return src, False
    lines.insert(last + 1, f"import '{ZEN_LOADER_IMPORT}';")
    return "\n".join(lines), True


def main() -> int:
    dry_run = "--dry-run" in sys.argv
    limit = next(
        (int(a.split("=", 1)[1]) for a in sys.argv if a.startswith("--limit=")),
        None,
    )
    targets = TARGETS[:limit] if limit else TARGETS
    wrapped = skipped = 0
    for rel in targets:
        path = Path(rel)
        original = path.read_text(encoding="utf-8")
        result, rule = rule_a(original), "Scaffold.body"
        if result is None:
            result, rule = rule_b(original), "build.return"
        if result is None:
            print(f"SKIP           {rel}  (ambiguous shape - needs a hand edit)")
            skipped += 1
            continue
        updated, inner = result
        updated, _ = ensure_import(updated)
        print(f"{rule:14} {rel}")
        print(f"               wraps: {' '.join(inner.split())[:68]}...")
        if not dry_run:
            path.write_text(updated, encoding="utf-8")
        wrapped += 1
    mode = "DRY RUN - nothing written" if dry_run else "APPLIED"
    print("-" * 70)
    print(f"{mode}  wrapped={wrapped}  skipped={skipped}  of {len(TARGETS)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

