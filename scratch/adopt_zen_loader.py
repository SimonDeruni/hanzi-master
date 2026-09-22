"""Adopt ZenLoader for full-section loading spinners.

Only converts a spinner that sits directly inside a `Center(child: ...)`, which
is the app's "this section is loading" pattern. Spinners used as tiny in-button
icons are left alone (LoadingSwap covers those).

Every argument is validated against what ZenLoader accepts, so anything unusual
is skipped and reported instead of producing broken code.

Usage:
    python scratch/adopt_zen_loader.py            # dry run, reports changes
    python scratch/adopt_zen_loader.py --apply    # writes the changes
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
LIB = ROOT / "lib"
IMPORT_LINE = "import 'package:hanzi_master/shared/widgets/zen_loader.dart';"

# ZenLoader forwards these; anything else means we leave the site untouched.
ALLOWED_ARGS = {"color", "backgroundColor", "value", "strokeWidth", "label",
                "semanticsLabel"}
CENTER_BEFORE = re.compile(r"Center\(\s*child:\s*(?:const\s+)?$")
TARGET = "CircularProgressIndicator("


def balanced_args(src, open_paren):
    """Return (args_text, close_index) for the call whose '(' is at open_paren."""
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


def top_level_args(args):
    """Split an argument list on depth-0 commas, respecting string literals."""
    parts, current, depth, quote = [], [], 0, None
    i = 0
    while i < len(args):
        c = args[i]
        if quote:
            if c == "\\":
                current.append(args[i:i + 2]); i += 2; continue
            if c == quote:
                quote = None
        elif c in "'\"":
            quote = c
        elif c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
        elif c == "," and depth == 0:
            parts.append("".join(current)); current = []; i += 1; continue
        current.append(c)
        i += 1
    parts.append("".join(current))
    return [p.strip() for p in parts if p.strip()]


def unsupported(args):
    """Return the first argument name ZenLoader cannot forward, if any."""
    for piece in top_level_args(args):
        if ":" not in piece:
            return piece[:40]  # positional argument
        name = piece.split(":", 1)[0].strip()
        if name not in ALLOWED_ARGS:
            return name
    return None


def main():
    apply = "--apply" in sys.argv
    converted = skipped = 0
    touched_files = []

    for path in sorted(LIB.rglob("*.dart")):
        # Never rewrite the widget's own spinner (that would self-wrap forever).
        if path.name == "zen_loader.dart":
            continue
        source = path.read_text(encoding="utf-8")
        if TARGET not in source:
            continue

        fixed, index, file_hits = source, 0, 0
        while True:
            found = fixed.find(TARGET, index)
            if found == -1:
                break

            # Is this spinner the direct child of a Center?
            window = fixed[max(0, found - 90):found]
            if not CENTER_BEFORE.search(window):
                index = found + len(TARGET)
                continue

            args, _ = balanced_args(fixed, found + len(TARGET) - 1)
            bad = unsupported(args)
            if bad:
                print(f"  SKIP {path.relative_to(ROOT)}: uses '{bad}'")
                skipped += 1
                index = found + len(TARGET)
                continue

            fixed = fixed[:found] + "ZenLoader(" + fixed[found + len(TARGET):]
            index = found + len("ZenLoader(")
            file_hits += 1
            converted += 1

        if not file_hits:
            continue

        # Add the import only when the file now needs it.
        if IMPORT_LINE not in fixed:
            last = max(
                (m.start() for m in re.finditer(r"^import .*;$", fixed, re.M)),
                default=None,
            )
            if last is None:
                print(f"  SKIP {path.relative_to(ROOT)}: no import block found")
                continue
            end = fixed.index("\n", last) + 1
            fixed = fixed[:end] + IMPORT_LINE + "\n" + fixed[end:]

        touched_files.append((path.relative_to(ROOT), file_hits))
        if apply:
            path.write_text(fixed, encoding="utf-8")

    for rel, hits in touched_files:
        print(f"  {rel}  ({hits} spinner{'s' if hits != 1 else ''})")
    print(f"\n{'Converted' if apply else 'Would convert'} {converted} spinner(s) "
          f"in {len(touched_files)} file(s); skipped {skipped}.")
    if not apply:
        print("Dry run - re-run with --apply to write.")


if __name__ == "__main__":
    main()
