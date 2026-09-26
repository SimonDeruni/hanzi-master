"""C. Fixed-column grids -> ZenGrid (F7 of `docs/IPAD_ADAPTIVE_PLAN.md`).

Two call shapes exist in the codebase:

    GridView.count(crossAxisCount: 2, ..., childAspectRatio: 1.2, children: ...)
    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: N, ...)

Both are rebuilt as `ZenGrid.tiles|covers`, keeping the original proportions
(`childAspectRatio` + spacings) so the phone look does not change — only the
column count becomes density-driven. `maxTileWidth` is the phone content width
(390dp screen minus padding) divided by the original column count, which keeps
the same number of columns on a phone and lets it grow on an iPad.

Run:  python scratch/ipad_grids.py [--dry-run]
"""

from __future__ import annotations

import argparse
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))

from ipad_adoption import (  # noqa: E402
    LAYOUT_IMPORT,
    call_span,
    dart_files,
    ensure_import,
    kv,
    read,
    split_top,
    write,
)

# file suffix -> (ZenGrid kind, max tile/cover width on a phone)
RULES: dict[str, tuple[str, int]] = {
    "lesson_steps/quiz_step.dart": ("tiles", 170),
    "radical_detail_sheet.dart": ("tiles", 170),
    "dictionary_screen.dart": ("tiles", 114),
    "radical_detail_screen.dart": ("tiles", 86),
    "radical_library_screen.dart": ("tiles", 114),
    "shadowing_studio_screen.dart": ("tiles", 170),
    "story_library_screen.dart": ("covers", 175),
    "book_catalog_screen.dart": ("covers", 179),
}

SPACING_KEYS = ("crossAxisSpacing", "mainAxisSpacing")
DROPPED_KEYS = ("crossAxisCount", "childAspectRatio", *SPACING_KEYS)


def rule_for(path: pathlib.Path) -> tuple[str, int] | None:
    posix = path.as_posix()
    for suffix, rule in RULES.items():
        if posix.endswith(suffix):
            return rule
    return None


def build(kind: str, width: int, values: dict[str, str]) -> str:
    extent = (
        f"maxTileWidth: {width}" if kind == "tiles" else f"maxCoverWidth: {width}"
    )
    params = [extent]
    if "childAspectRatio" in values:
        params.append(f"childAspectRatio: {values['childAspectRatio']}")
    if "crossAxisSpacing" in values:
        params.append(f"crossSpacing: {values['crossAxisSpacing']}")
    if "mainAxisSpacing" in values:
        params.append(f"mainSpacing: {values['mainAxisSpacing']}")
    return f"ZenGrid.{kind}({', '.join(params)})"


def parse_args(args_text: str) -> dict[str, str]:
    values: dict[str, str] = {}
    for part, _, _ in split_top(args_text):
        parsed = kv(part)
        if parsed:
            values[parsed[0]] = parsed[1]
    return values


def convert_delegates(text: str, kind: str, width: int) -> tuple[str, int]:
    """Rewrite every SliverGridDelegateWithFixedCrossAxisCount(...) call."""
    name = "SliverGridDelegateWithFixedCrossAxisCount"
    out: list[str] = []
    cursor = 0
    count = 0
    while True:
        at = text.find(name, cursor)
        if at == -1:
            out.append(text[cursor:])
            break
        span = call_span(text, at, name)
        if span is None:
            out.append(text[cursor : at + len(name)])
            cursor = at + len(name)
            continue
        start, open_paren, close = span
        values = parse_args(text[open_paren + 1 : close])
        if "crossAxisCount" not in values:
            out.append(text[cursor : close + 1])
            cursor = close + 1
            continue
        expr_start = start
        if text[max(0, start - len("const ")) : start] == "const ":
            expr_start = start - len("const ")
        out.append(text[cursor:expr_start] + build(kind, width, values))
        cursor = close + 1
        count += 1
    return "".join(out), count


def convert_gridview_count(text: str, kind: str, width: int) -> tuple[str, int]:
    """Rewrite GridView.count(...) as GridView(gridDelegate: ZenGrid...)."""
    name = "GridView.count"
    out: list[str] = []
    cursor = 0
    count = 0
    while True:
        at = text.find(name, cursor)
        if at == -1:
            out.append(text[cursor:])
            break
        span = call_span(text, at, name)
        if span is None:
            out.append(text[cursor : at + len(name)])
            cursor = at + len(name)
            continue
        start, open_paren, close = span
        inner = text[open_paren + 1 : close]
        if "crossAxisCount" not in inner or "//" in inner:
            # A comment inside the argument list would be swallowed when the
            # arguments are re-joined; leave those for a human.
            out.append(text[cursor : close + 1])
            cursor = close + 1
            continue
        values: dict[str, str] = {}
        kept: list[str] = []
        for part, _, _ in split_top(inner):
            parsed = kv(part)
            if parsed and parsed[0] in DROPPED_KEYS:
                values[parsed[0]] = parsed[1]
            elif part.strip():
                kept.append(part.strip())
        new_args = [f"gridDelegate: {build(kind, width, values)}", *kept]
        out.append(text[cursor:start] + "GridView(" + ", ".join(new_args) + ")")
        cursor = close + 1
        count += 1
    return "".join(out), count


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    total = 0
    for path in dart_files():
        rule = rule_for(path)
        if rule is None:
            continue
        text = read(path)
        if "crossAxisCount" not in text:
            continue
        kind, width = rule
        text, delegates = convert_delegates(text, kind, width)
        text, counted = convert_gridview_count(text, kind, width)
        if delegates + counted == 0:
            continue
        text, added = ensure_import(text, LAYOUT_IMPORT)
        total += delegates + counted
        print(
            f"{path.as_posix()}: {delegates} delegate(s) + {counted} "
            f"GridView.count -> ZenGrid (import {'added' if added else 'ok'})"
        )
        if not args.dry_run:
            write(path, text)

    print(f"C. ZenGrid: {total} grids converted")
    if args.dry_run:
        print("(dry run - nothing written)")


if __name__ == "__main__":
    main()
