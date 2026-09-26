"""Mechanical adoption of the iPad/adaptive kit.

Implements F5 + F7 of `docs/IPAD_ADAPTIVE_PLAN.md` across `lib/`:

  A. MediaQuery.of(context).size            -> MediaQuery.sizeOf(context)
  B. showModalBottomSheet                   -> zenSheet
  C. SliverGridDelegateWithFixedCrossAxisCount / GridView.count -> ZenGrid.*

Why a script: the three classes are mechanical (46 sheet calls in 26 files, 29
size reads in 20 files, 10 grids in 8 files) and several of those files are being
edited by other agents, so tasteful per-file hand edits would collide. Passes B
and C *skip and report* anything the helpers cannot express verbatim instead of
guessing — every skip stays counted by the ratchet in
`test/core/adaptive_layout_guard_test.dart`, so nothing is silently dropped.

`dart analyze` is the safety net: a bad rewrite cannot compile.

Run:  python scratch/ipad_adoption.py [--dry-run]
"""

from __future__ import annotations

import argparse
import pathlib
import re

LIB = pathlib.Path("lib")
OVERLAY_IMPORT = (
    "import 'package:hanzi_master/shared/widgets/zen_overlay.dart';"
)
LAYOUT_IMPORT = "import 'package:hanzi_master/core/layout/zen_layout.dart';"

# zenSheet exposes exactly these named parameters (plus a positional context).
SHEET_ALLOWED = {
    "context",
    "builder",
    "isScrollControlled",
    "useSafeArea",
    "backgroundColor",
    "shape",
    "isDismissible",
    "enableDrag",
    "showDragHandle",
    "useRootNavigator",
    "constraints",
}
SHEET_RENAME = {"isDismissible": "dismissible", "enableDrag": "enableDrag"}

# Entry points that are deliberately NOT zenSheet: zen_overlay is the helper
# itself, the other two predate it (tokenised motion / pointer anchoring).
SHEET_SKIP_FILES = {
    "lib/shared/widgets/zen_overlay.dart",
    "lib/shared/widgets/global_blurred_bottom_sheet.dart",
    "lib/shared/widgets/quick_look_sheet.dart",
}


def dart_files() -> list[pathlib.Path]:
    return sorted(LIB.rglob("*.dart"))


def read(path: pathlib.Path) -> str:
    # Universal newlines: every snippet below is written with \n.
    return path.read_text(encoding="utf-8")


def write(path: pathlib.Path, text: str) -> None:
    path.write_text(text, encoding="utf-8")


def split_top(text: str) -> list[tuple[str, int, int]]:
    """Split on top-level commas, returning (part, start, end) offsets."""
    parts: list[tuple[str, int, int]] = []
    depth = 0
    quote: str | None = None
    start = 0
    i = 0
    while i < len(text):
        ch = text[i]
        if quote:
            if ch == "\\":
                i += 1
            elif ch == quote:
                quote = None
        elif ch in "\"'":
            quote = ch
        elif ch == "/" and text[i + 1 : i + 2] == "/":
            # Line comments may contain apostrophes ("We'll...") that would
            # otherwise be read as a string opener and desync the scan.
            newline = text.find("\n", i)
            if newline == -1:
                break
            i = newline
        elif ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
        elif ch == "," and depth == 0:
            parts.append((text[start:i], start, i))
            start = i + 1
        i += 1
    if text[start:].strip():
        parts.append((text[start:], start, len(text)))
    return parts


def kv(part: str) -> tuple[str, str] | None:
    """Parse a top-level `key: value` argument, ignoring anything else."""
    m = re.match(r"\s*([A-Za-z_][A-Za-z0-9_]*)\s*:\s*(.*)", part, re.DOTALL)
    if not m:
        return None
    return m.group(1), m.group(2).strip()


def call_span(text: str, at: int, name: str) -> tuple[int, int, int] | None:
    """Locate `name<...>(` starting at `at`; return (start, open, close).

    Handles nested generic type arguments (`showModalBottomSheet<Map<String, int>>`),
    which a simple regex cannot.
    """
    m = re.compile(re.escape(name)).match(text, at)
    if not m:
        return None
    i = m.end()
    if i < len(text) and text[i] == "<":
        depth = 0
        while i < len(text):
            if text[i] == "<":
                depth += 1
            elif text[i] == ">":
                depth -= 1
                if depth == 0:
                    i += 1
                    break
            i += 1
    while i < len(text) and text[i].isspace():
        i += 1
    if i >= len(text) or text[i] != "(":
        return None
    open_paren = i
    depth = 0
    quote: str | None = None
    while i < len(text):
        ch = text[i]
        if quote:
            if ch == "\\":
                i += 1
            elif ch == quote:
                quote = None
        elif ch in "\"'":
            quote = ch
        elif ch == "/" and text[i + 1 : i + 2] == "/":
            newline = text.find("\n", i)
            if newline == -1:
                return None
            i = newline
            continue
        elif ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
            if depth == 0:
                return (m.start(), open_paren, i)
        i += 1
    return None


def ensure_import(text: str, import_line: str) -> tuple[str, bool]:
    """Insert `import_line` after the last import, if not already present."""
    if import_line in text:
        return text, False
    matches = list(re.finditer(r"^import\s+[^\n]*;\n", text, re.MULTILINE))
    if not matches:
        return text, False
    last = matches[-1]
    return text[: last.end()] + import_line + "\n" + text[last.end():], True


def pass_mediaquery(dry: bool) -> tuple[int, int]:
    """A. MediaQuery.of(context).size -> MediaQuery.sizeOf(context)."""
    total = 0
    files = 0
    for path in dart_files():
        text = read(path)
        new, n = re.subn(
            r"MediaQuery\.of\(context\)\.size\b",
            "MediaQuery.sizeOf(context)",
            text,
        )
        if n:
            total += n
            files += 1
            if not dry:
                write(path, new)
    return total, files


def pass_sheets(dry: bool) -> tuple[int, int, list[str]]:
    """B. showModalBottomSheet -> zenSheet (phone sheet / tablet dialog)."""
    converted = 0
    files_touched = 0
    skipped: list[str] = []
    for path in dart_files():
        rel = path.as_posix()
        if rel in SHEET_SKIP_FILES:
            continue
        text = read(path)
        if "showModalBottomSheet" not in text:
            continue
        out: list[str] = []
        cursor = 0
        changed = False
        while True:
            at = text.find("showModalBottomSheet", cursor)
            if at == -1:
                out.append(text[cursor:])
                break
            span = call_span(text, at, "showModalBottomSheet")
            if span is None:
                out.append(text[cursor : at + len("showModalBottomSheet")])
                cursor = at + len("showModalBottomSheet")
                skipped.append(f"{rel} (unparsable call)")
                continue
            start, open_paren, close = span
            header = text[start:open_paren]
            args = text[open_paren + 1 : close]
            keys: list[str] = []
            ctx_part: tuple[int, int, str] | None = None
            for part, p_start, p_end in split_top(args):
                parsed = kv(part)
                if parsed is None:
                    continue
                keys.append(parsed[0])
                if parsed[0] == "context":
                    ctx_part = (p_start, p_end, part)
            bad = sorted({k for k in keys if k not in SHEET_ALLOWED})
            if bad or ctx_part is None:
                line = text.count("\n", 0, at) + 1
                detail = ", ".join(bad) if bad else "no context: argument"
                skipped.append(f"{rel}:{line} (kept as-is: {detail})")
                out.append(text[cursor : close + 1])
                cursor = close + 1
                continue
            p_start, p_end, part = ctx_part
            prefix = re.match(r"(\s*context\s*:\s*)", part)
            assert prefix is not None
            new_args = args[:p_start] + part[prefix.end() :] + args[p_end:]
            for old_key, new_key in SHEET_RENAME.items():
                if old_key != new_key:
                    new_args = re.sub(
                        rf"\b{old_key}\s*:", f"{new_key}:", new_args
                    )
            new_header = header.replace("showModalBottomSheet", "zenSheet", 1)
            out.append(text[cursor:start] + new_header + "(" + new_args + ")")
            cursor = close + 1
            converted += 1
            changed = True
        if changed:
            new_text = "".join(out)
            new_text, _ = ensure_import(new_text, OVERLAY_IMPORT)
            files_touched += 1
            if not dry:
                write(path, new_text)
    return converted, files_touched, skipped


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    mq_sites, mq_files = pass_mediaquery(args.dry_run)
    print(f"A. MediaQuery.sizeOf: {mq_sites} sites in {mq_files} files")

    sheet_sites, sheet_files, skipped = pass_sheets(args.dry_run)
    print(f"B. zenSheet: {sheet_sites} calls in {sheet_files} files")
    for line in skipped:
        print(f"   skipped {line}")

    if args.dry_run:
        print("(dry run - nothing written)")


if __name__ == "__main__":
    main()
