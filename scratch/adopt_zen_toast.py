"""Codemod: migrate Material `SnackBar` sites to the calligraphic `ZenToast`.

Why: per `docs/UI_UX_STANDARDS.md` § Motion and the existing convention
(`deck_selection_sheet`, `custom_scenario_dialog`, `book_reader_screen` are all
asserted SnackBar-free), a toast must live on the root overlay. A Material
`SnackBar` is pinned to the nearest `ScaffoldMessenger` and renders **behind**
the modal barrier, so from inside a sheet it arrives dimmed and half-covered.

The codemod only rewrites shapes it can prove are safe and reports the rest for a
human. Run without `--apply` first to read the plan.

Guarded, conservative rules:
  * skip any `SnackBar` that carries an `action:` (ZenToast has no action slot)
  * skip any `SnackBar` whose `content:` is not a plain `Text(...)`
  * skip anything the shape regex cannot match cleanly
  * preserve the file's existing line endings exactly (no whole-file churn)
  * add the `zen_toast.dart` import only when a rewrite happened
  * drop the now-unused `zen_motion.dart` import only when `ZenMotion` is gone
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path("lib")

TOAST_IMPORT = "import 'package:hanzi_master/shared/widgets/zen_toast.dart';"
MOTION_IMPORT = "import 'package:hanzi_master/core/theme/zen_motion.dart';"

CALL_RE = re.compile(
    r"ScaffoldMessenger\s*\.\s*of\(\s*(\w+)\s*\)\s*\.\.?\s*showSnackBar\(\s*SnackBar\((.*?)\)\s*,?\s*\)\s*,?\s*;",
    re.S,
)
CONTENT_RE = re.compile(r"content\s*:\s*(Text\((?:.|\n)*?\))\s*(?:,|$)", re.S)

# Explicit tone overrides, matched on the message text (most specific first).
# Anything not listed falls back to the keyword heuristic below.
TONE_OVERRIDES: list[tuple[str, str]] = [
    ("noNewWordsFound", "info"),
    ("noWordsSelected", "info"),
    ("noChineseCharactersFound", "info"),
    ("unlockCharactersToQuiz", "info"),
    ("addCardsFirst", "info"),
    ("Diving into", "info"),
    ("Scenario removed", "info"),
    ("removedFromDeck", "info"),
    ("storyBookmarkedInLibrary", "success"),
    ("articleSavedToMediaHub", "success"),
    ("storySavedToLibrary", "success"),
    ("your_path_for_is_ready", "success"),
    ("developerBackdoorUnlocked", "success"),
    ("lessonComplete", "success"),
]

ERROR_WORDS = (
    "fail",
    "error",
    "could not",
    "couldn't",
    "cannot",
    "unable",
    "invalid",
    "denied",
    "permission",
    "not found",
    "no active",
    "unavailable",
    "wrong",
    "not that one",
)
SUCCESS_WORDS = (
    "saved",
    "bookmarked",
    "added",
    "created",
    "complete",
    "success",
    "unlocked",
    "ready",
)


def tone_for(message: str) -> str:
    for needle, tone in TONE_OVERRIDES:
        if needle in message:
            return tone
    lowered = message.lower()
    if any(word in lowered for word in ERROR_WORDS):
        return "error"
    if any(word in lowered for word in SUCCESS_WORDS):
        return "success"
    return "info"


def line_of(source: str, offset: int) -> int:
    return source.count("\n", 0, offset) + 1


def strip_line_comments(source: str) -> str:
    return "\n".join(line.split("//")[0] for line in source.split("\n"))


def main() -> int:
    apply = "--apply" in sys.argv
    converted: list[str] = []
    skipped: list[str] = []
    untouched: list[str] = []

    for path in sorted(ROOT.rglob("*.dart")):
        source = path.read_text(encoding="utf-8")
        if "showSnackBar" not in source:
            continue

        newline = "\r\n" if "\r\n" in source else "\n"
        rewrites = 0

        def repl(match: re.Match[str]) -> str:
            nonlocal rewrites
            context, body = match.group(1), match.group(2)
            where = f"{path}:{line_of(source, match.start())}"

            if "SnackBarAction" in body:
                skipped.append(f"{where}  action: SnackBarAction (no ZenToast slot)")
                return match.group(0)
            if "showSnackBar" in body or "ScaffoldMessenger" in body:
                skipped.append(f"{where}  body spans another call site")
                return match.group(0)

            found = CONTENT_RE.search(body)
            if not found:
                skipped.append(
                    f"{where}  content is not a plain Text(...): {body.strip()[:60]}"
                )
                return match.group(0)

            text_expr = found.group(1)
            inner = text_expr[len("Text(") : -1].strip()
            tone = tone_for(inner)
            rewrites += 1
            converted.append(f"{where}  ZenToast.{tone}  {inner[:80]}")
            return f"ZenToast.{tone}({context}, {inner});"

        new_source = CALL_RE.sub(repl, source)

        if rewrites:
            if TOAST_IMPORT not in new_source:
                lines = new_source.split(newline)
                last_import = max(
                    index
                    for index, line in enumerate(lines)
                    if line.startswith("import ")
                )
                lines.insert(last_import + 1, TOAST_IMPORT)
                new_source = newline.join(lines)

            if "ZenMotion." not in strip_line_comments(new_source):
                new_source = new_source.replace(MOTION_IMPORT + newline, "")

            if apply:
                path.write_text(new_source, encoding="utf-8", newline="")

        for offset_match in re.finditer(r"showSnackBar", new_source):
            untouched.append(f"{path}:{line_of(new_source, offset_match.start())}")

    print(f"=== CONVERTED ({len(converted)}) ===")
    for row in converted:
        print("  " + row)
    print(f"\n=== SKIPPED ({len(skipped)}) ===")
    for row in skipped:
        print("  " + row)
    print(f"\n=== STILL PRESENT after rewrite ({len(untouched)}) ===")
    for row in untouched:
        print("  " + row)
    print(f"\nmode: {'APPLIED' if apply else 'DRY RUN'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
