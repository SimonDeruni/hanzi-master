"""Codemod: fade in the `data:` branch of every `AsyncValue.when(...)`.

Why: `docs/UI_UX_STANDARDS.md` § Loading States requires *"Fade result content in.
Wrap content that replaces a loader in `ZenFadeIn` so it eases in rather than
snapping."* Measured on 2026-09-25: 26 `.when(` sites, only 10 `ZenFadeIn` uses,
and 20 files that replace a `ZenLoader` with content in a single frame.

Guarded and conservative:
  * only the plain `data: (params) { ... }` block shape is handled
  * the block must contain **exactly one** top-level `return`
  * the branch must sit inside a `when(` call, so a `data:` map key is never touched
  * files containing a triple-quoted string are skipped wholesale (the literal
    blanker does not model them), as are files that already use `ZenFadeIn`
  * candidates are processed in reverse offset order, so an edit can never
    invalidate an earlier position or re-wrap the same branch
  * the file's existing line endings are preserved
  * the import is added only when a rewrite happened
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path("lib")
IMPORT_LINE = "import 'package:hanzi_master/shared/widgets/zen_loader.dart';"

DATA_RE = re.compile(r"data\s*:\s*\(")


def blank_literals(src: str) -> str:
    """Blank comment and string *contents* so brackets can be scanned safely."""
    out = list(src)
    i, n = 0, len(src)
    while i < n:
        c = src[i]
        if c == "/" and i + 1 < n and src[i + 1] == "/":
            while i < n and src[i] != "\n":
                out[i] = " "
                i += 1
        elif c == "/" and i + 1 < n and src[i + 1] == "*":
            out[i] = out[i + 1] = " "
            i += 2
            while i + 1 < n and not (src[i] == "*" and src[i + 1] == "/"):
                out[i] = " "
                i += 1
            if i + 1 < n:
                out[i] = out[i + 1] = " "
                i += 2
        elif c in "'\"":
            quote = c
            out[i] = " "
            i += 1
            while i < n and src[i] != quote:
                if src[i] == "\\":
                    out[i] = " "
                    i += 1
                if i < n:
                    out[i] = " "
                    i += 1
            if i < n:
                out[i] = " "
                i += 1
        else:
            i += 1
    return "".join(out)


def match_bracket(blanked: str, open_index: int) -> int:
    """Index of the closer matching the opener at [open_index], or -1."""
    closer = {"(": ")", "{": "}", "[": "]"}[blanked[open_index]]
    depth = 0
    i = open_index
    while i < len(blanked):
        c = blanked[i]
        if c == blanked[open_index]:
            depth += 1
        elif c == closer:
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


def inside_when(blanked: str, index: int) -> bool:
    """True when the token at [index] sits inside a plain (non-spread) `when(`."""
    window = blanked[max(0, index - 400):index]
    cut = max(window.rfind("when("), window.rfind("when ("))
    if cut == -1:
        return False
    # A `;` between the `when(` and here means we have left the call.
    if ";" in window[cut:]:
        return False
    # A spread call (`...async.when(...)`) is merged into a children list, so its
    # branches return List<Widget> - which is not a widget and cannot be wrapped.
    return not window[:cut].rstrip().endswith("...")


def wrap_branch(source: str, blanked: str, at: int):
    """(start, end) of the branch's single top-level return expression."""
    paren = blanked.index("(", at)
    params_end = match_bracket(blanked, paren)
    if params_end == -1:
        return None, "unbalanced params"

    tail = blanked[params_end + 1:]
    stripped = tail.lstrip()
    lead = len(tail) - len(stripped)

    # Arrow form: `data: (x) => Widget(...)` - wrap the whole expression.
    if stripped.startswith("=>"):
        expr_start = params_end + 1 + lead + 2
        while expr_start < len(blanked) and blanked[expr_start] in " \n\r":
            expr_start += 1
        depth, end = 0, expr_start
        while end < len(blanked):
            c = blanked[end]
            if c in "({[":
                depth += 1
            elif c in ")}]":
                if depth == 0:
                    break  # the `)` closing `when(`: end of the argument list
                depth -= 1
            elif c == "," and depth == 0:
                break
            end += 1
        if blanked[expr_start] == "[":
            return None, "returns a list of slivers, not a widget"
        return (expr_start, end), None

    if not stripped.startswith("{"):
        return None, "data branch is not a block"
    brace = params_end + 1 + (len(tail) - len(stripped))
    block_end = match_bracket(blanked, brace)
    if block_end == -1:
        return None, "unbalanced block"

    body = blanked[brace + 1:block_end]
    returns = []
    depth = 0
    for token_match in re.finditer(r"[(){}\[\]]|\breturn\b", body):
        token = token_match.group(0)
        if token in "([{":
            depth += 1
        elif token in ")]}":
            depth -= 1
        elif depth == 0:
            returns.append(token_match)
    if len(returns) != 1:
        return None, f"{len(returns)} top-level return(s)"

    start = brace + 1 + returns[0].end()
    while start < block_end and blanked[start] in " \n\r":
        start += 1

    depth, end = 0, start
    while end < block_end:
        c = blanked[end]
        if c in "({[":
            depth += 1
        elif c in ")}]":
            depth -= 1
        elif c == ";" and depth == 0:
            break
        end += 1
    if end >= block_end:
        return None, "no closing semicolon"
    if blanked[start] == "[":
        # `data:` branches that build a sliver list (e.g. `return [#0, ...]`)
        # cannot be wrapped: a `List<Widget>` is not a widget. Escaping this cost
        # one real parse error and three type errors on the first run.
        return None, "returns a list of slivers, not a widget"
    return (start, end), None


def main() -> None:
    apply = "--apply" in sys.argv
    converted: list[str] = []
    skipped: list[str] = []

    for path in sorted(ROOT.rglob("*.dart")):
        source = path.read_text(encoding="utf-8")
        if "when(" not in source or "ZenFadeIn" in source:
            continue
        if "'''" in source or '"""' in source:
            skipped.append(f"{path.relative_to(ROOT)}  triple-quoted string")
            continue

        blanked = blank_literals(source)
        candidates = [m.start() for m in DATA_RE.finditer(blanked)
                      if inside_when(blanked, m.start())]
        if not candidates:
            continue

        newline = "\r\n" if "\r\n" in source else "\n"
        output = source
        rewrites = 0

        # Reverse order: an edit at a higher offset never shifts a lower one, so
        # every span computed from the original text stays valid, and the same
        # branch can never be wrapped twice.
        for at in reversed(candidates):
            span, reason = wrap_branch(source, blanked, at)
            if span is None:
                skipped.append(f"{path.relative_to(ROOT)}  {reason}")
                continue
            start, end = span
            output = (output[:start] + "ZenFadeIn(child: "
                      + output[start:end] + ")" + output[end:])
            rewrites += 1

        if not rewrites:
            continue

        if IMPORT_LINE not in output:
            lines = output.split(newline)
            last_import = max(index for index, line in enumerate(lines)
                              if line.startswith("import "))
            lines.insert(last_import + 1, IMPORT_LINE)
            output = newline.join(lines)

        converted.append(f"{path.relative_to(ROOT)}  ({rewrites})")
        if apply:
            path.write_text(output, encoding="utf-8", newline="")

    print(f"=== CONVERTED ({len(converted)} files) ===")
    for row in converted:
        print("  " + row)
    print(f"\n=== SKIPPED ({len(skipped)}) ===")
    for row in skipped:
        print("  " + row)
    print(f"\nmode: {'APPLIED' if apply else 'DRY RUN'}")


if __name__ == "__main__":
    main()

