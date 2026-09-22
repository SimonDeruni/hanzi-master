"""Repair UTF-8 text that was decoded as Windows-1252 (mojibake) in lib/.

Each replacement is a byte-exact recovery: the mojibake string is the UTF-8
encoding of the intended character read through code page 1252, so the fix is
derived, not guessed.

Usage:  python scratch/fix_mojibake.py [--apply]
Without --apply it only reports what it would change.
"""
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent

# (mojibake sequence, intended character, description)
# The sequences are written with escapes so the encoding is unambiguous.
REPAIRS = [
    ("\u00f0\u0178\u201c\u0153", "\U0001F4DC", "F0 9F 93 9C -> U+1F4DC SCROLL"),
    ("\u00f0\u0178\u008f\u203a\u00ef\u00b8\u008f", "\U0001F3DB\uFE0F",
     "F0 9F 8F 9B + VS16 -> U+1F3DB CLASSICAL BUILDING"),
    ("\u00e2\u201d\u20ac", "\u2500", "E2 94 80 -> U+2500 BOX DRAWINGS LIGHT HORIZONTAL"),
]


def main():
    apply = "--apply" in sys.argv
    total = 0

    for path in sorted((ROOT / "lib").rglob("*.dart")):
        source = path.read_text(encoding="utf-8")
        if not any(bad in source for bad, _, _ in REPAIRS):
            continue

        fixed = source
        for bad, good, description in REPAIRS:
            count = fixed.count(bad)
            if count:
                fixed = fixed.replace(bad, good)
                print(f"{path.relative_to(ROOT)}: replaced {count}x {description}")

        if fixed != source:
            total += 1
            if apply:
                path.write_text(fixed, encoding="utf-8")

    if not apply:
        print(f"\nDry run: {total} file(s) would change. Re-run with --apply.")
    else:
        print(f"\nRepaired {total} file(s).")


if __name__ == "__main__":
    main()
