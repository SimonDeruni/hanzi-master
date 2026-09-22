"""Precise, depth-aware audit of size-capped containers that wrap localized text.

Usage:  python scratch/fixed_width_text_audit.py

Only a container's OWN direct `width:` / `height:` / `constraints:` matters, so the
scanner splits each call's arguments at nesting depth 0 and ignores nested values
(border widths, inner spacers, drag handles).
"""
import pathlib
import re

LIB = pathlib.Path(__file__).resolve().parent.parent / "lib"

CONTAINERS = ("SizedBox", "Container", "ConstrainedBox")
BUTTON = re.compile(r"(?:Elevated|Outlined|Text|Filled|Cupertino)?Button(?:\.icon)?\s*\(")
LOCALIZED = re.compile(r"l10n\.|AppLocalizations\.of\(|localizations\.")
ANY_TEXT = re.compile(r"(?<![\w.])Text\(")
# Widths at or below this are too narrow to hold an expanded locale label.
NARROW = 130.0


def line_of(src, index):
    return src.count("\n", 0, index) + 1


def balanced_args(src, open_paren):
    """Return (argument_text, closing_index) for the call opening at open_paren."""
    depth, i = 0, open_paren
    while i < len(src):
        c = src[i]
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
            if depth == 0:
                return src[open_paren + 1:i], i
        i += 1
    return src[open_paren + 1:], len(src)


def split_top_level(args):
    """Split an argument string on depth-0 commas, respecting string literals."""
    parts, current, depth = [], [], 0
    quote = None
    i = 0
    while i < len(args):
        c = args[i]
        if quote:
            if c == "\\":
                current.append(args[i:i + 2])
                i += 2
                continue
            if c == quote:
                quote = None
        elif c in "'\"":
            quote = c
        elif c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
        elif c == "," and depth == 0:
            parts.append("".join(current))
            current = []
            i += 1
            continue
        current.append(c)
        i += 1
    parts.append("".join(current))
    return [p.strip() for p in parts if p.strip()]


def arg_value(top_args, name):
    """Raw text of a top-level named argument, or None."""
    prefix = name + ":"
    for a in top_args:
        if a.startswith(prefix):
            return a[len(prefix):].strip()
    return None


def plain_number(text):
    """Return the literal when the expression is a bare finite number."""
    if text is None:
        return None
    m = re.fullmatch(r"([\d.]+)", text)
    return float(m.group(1)) if m else None


def from_constraints(text, key):
    """Pull a bare numeric literal out of a BoxConstraints(...) expression."""
    if text is None:
        return None
    m = re.search(rf"(?<![\w.]){key}\s*:\s*([\d.]+)\s*[,)]", text)
    return float(m.group(1)) if m else None



def main():
    narrow, fixed_height, rows = [], [], []

    for path in sorted(LIB.rglob("*.dart")):
        src = path.read_text(encoding="utf-8", errors="replace")
        rel = path.relative_to(LIB.parent).as_posix()

        for name in CONTAINERS:
            for m in re.finditer(rf"(?<![\w.]){name}\(", src):
                args, _ = balanced_args(src, m.end() - 1)
                top = split_top_level(args)
                child = arg_value(top, "child")
                # Any Text counts: the localized label is often passed in as a
                # String parameter (e.g. SizedBox(width: 60, child: Text(label))).
                if not child or not ANY_TEXT.search(child):
                    continue
                inline_localized = bool(LOCALIZED.search(child))

                width = plain_number(arg_value(top, "width"))
                if width is None:
                    width = from_constraints(arg_value(top, "constraints"), "maxWidth")
                if width is not None and width <= NARROW:
                    narrow.append((rel, line_of(src, m.start()), name, width,
                                   " ".join(child.split())[:90]))

                height = plain_number(arg_value(top, "height"))
                if height is None:
                    height = from_constraints(arg_value(top, "constraints"), "maxHeight")
                if height is not None and height <= 48:
                    fixed_height.append((rel, line_of(src, m.start()), name, height,
                                         " ".join(child.split())[:90]))

        # Rows that hold a button with no flexible child anywhere inside.
        for m in BUTTON.finditer(src):
            row_idx = src[:m.start()].rfind("Row(")
            if row_idx == -1:
                continue
            args, close = balanced_args(src, row_idx + 3)
            if m.start() > close:
                continue  # that Row already closed before this button
            if "Expanded(" in args or "Flexible(" in args or "Wrap(" in args:
                continue
            rows.append((rel, line_of(src, row_idx), m.group(0)[:-1],
                         " ".join(args.split())[:110]))

    out = [
        "=" * 108,
        f"A. CONTAINER WIDTH <= {NARROW:.0f}px AROUND LOCALIZED TEXT  ({len(narrow)})",
        "   These CANNOT hold an expanded locale label.",
        "=" * 108,
    ]
    for rel, line, name, width, child in narrow:
        out.append(f"  {rel}:{line}  {name}(width: {width:g})  child: {child}")

    out += [
        "",
        "=" * 108,
        f"B. CONTAINER HEIGHT <= 48px AROUND LOCALIZED TEXT  ({len(fixed_height)})",
        "   Vertical clip risk for Devanagari / Thai / Arabic (taller line boxes).",
        "=" * 108,
    ]
    for rel, line, name, height, child in fixed_height:
        out.append(f"  {rel}:{line}  {name}(height: {height:g})  child: {child}")

    out += [
        "",
        "=" * 108,
        f"C. BUTTONS IN A Row WITH NO Expanded/Flexible/Wrap  ({len(rows)})",
        "   An expanded locale label makes the whole Row overflow horizontally.",
        "=" * 108,
    ]
    for rel, line, kind, args in rows:
        out.append(f"  {rel}:{line}  {kind}")
        out.append(f"        Row( {args}")

    pathlib.Path(__file__).parent.joinpath("fixed_width_report.txt").write_text(
        "\n".join(out), encoding="utf-8")
    print(f"narrow={len(narrow)} short_height={len(fixed_height)} button_rows={len(rows)}")


if __name__ == "__main__":
    main()
