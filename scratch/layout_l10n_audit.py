"""Audit Dart UI code for localization/layout fragility.

Usage:  python scratch/layout_l10n_audit.py
Detects the patterns that make text overflow when a locale is longer than English:
  1. Buttons constrained by a hard-coded numeric width
  2. Buttons placed in a Row without Expanded/Flexible
  3. Fixed-height boxes that wrap text
  4. Hard-coded (non-localized) user-visible strings
"""
import pathlib
import re

LIB = pathlib.Path(__file__).resolve().parent.parent / "lib"

BUTTONS = r"(?:Elevated|Outlined|Text|Filled|Cupertino)?Button(?:\.icon)?\s*\("
CONSTRAINED = re.compile(
    r"(?:SizedBox\(\s*width:\s*(?P<w1>\d+(?:\.\d+)?)"
    r"|width:\s*(?P<w2>\d+(?:\.\d+)?)"
    r"|ConstrainedBox\(|BoxConstraints\([^)]*maxWidth:\s*(?P<w3>\d+(?:\.\d+)?))"
)
# Text('...') / Text("...") with no AppLocalizations / l10n reference on the line
HARDCODED = re.compile(r"""Text\(\s*(['"])([A-Za-z][^'"\\\n]{3,})\1""")
L10N_REF = re.compile(r"l10n\.|AppLocalizations|localizations\.|_localized|\.tr\b|\btr\(")
FIXED_HEIGHT = re.compile(r"(?:height:\s*(\d+(?:\.\d+)?))")


def dart_files():
    return sorted(p for p in LIB.rglob("*.dart"))


def main():
    findings = {
        "constrained_button": [],
        "row_button": [],
        "hardcoded_string": [],
    }
    fixed_height_hits = 0

    for path in dart_files():
        text = path.read_text(encoding="utf-8", errors="replace")
        rel = path.relative_to(LIB.parent).as_posix()

        for m in re.finditer(BUTTONS, text):
            start = max(0, m.start() - 320)
            window = text[start:m.start()]
            cm = CONSTRAINED.search(window)
            if cm and (cm.group("w1") or cm.group("w2")):
                width = cm.group("w1") or cm.group("w2")
                if float(width) <= 260:  # ignore full-bleed image blocks
                    findings["constrained_button"].append(
                        (rel, text[:m.start()].count("\n") + 1, m.group(0)[:-1], width)
                    )
            # Row without Expanded/Flexible before the button
            row_idx = window.rfind("Row(")
            if row_idx != -1 and "Expanded(" not in window[row_idx:] \
                    and "Flexible(" not in window[row_idx:]:
                findings["row_button"].append(
                    (rel, text[:m.start()].count("\n") + 1, m.group(0)[:-1])
                )

        fixed_height_hits += len(FIXED_HEIGHT.findall(text))

        for m in HARDCODED.finditer(text):
            literal = m.group(2)
            line_start = text.rfind("\n", 0, m.start()) + 1
            line = text[line_start:text.find("\n", m.start())]
            if L10N_REF.search(line):
                continue
            if literal.lower() in ("true", "false") or "/" in literal and " " not in literal:
                continue
            findings["hardcoded_string"].append(
                (rel, text[:m.start()].count("\n") + 1, literal)
            )

    out = []
    out.append("=" * 100)
    out.append("1. BUTTONS WITH A HARD-CODED NUMERIC WIDTH  (these cannot grow with the locale)")
    out.append("=" * 100)
    for rel, line, kind, width in findings["constrained_button"]:
        out.append(f"  {rel}:{line}   {kind}  width~{width}")
    out.append(f"  total: {len(findings['constrained_button'])}")

    out.append("")
    out.append("=" * 100)
    out.append("2. BUTTONS IN A Row WITHOUT Expanded/Flexible  (overflow candidates)")
    out.append("=" * 100)
    seen = set()
    for rel, line, kind in findings["row_button"]:
        key = (rel, line)
        if key in seen:
            continue
        seen.add(key)
        out.append(f"  {rel}:{line}   {kind}")
    out.append(f"  total: {len(seen)}")

    out.append("")
    out.append("=" * 100)
    out.append("3. HARD-CODED USER-VISIBLE STRINGS  (never translated)")
    out.append("=" * 100)
    per_file = {}
    for rel, line, literal in findings["hardcoded_string"]:
        per_file.setdefault(rel, []).append((line, literal))
    for rel in sorted(per_file, key=lambda r: -len(per_file[r])):
        out.append(f"  {rel}  ({len(per_file[rel])})")
        for line, literal in per_file[rel][:6]:
            out.append(f"      L{line}: '{literal}'")
    out.append(f"  total: {len(findings['hardcoded_string'])} across {len(per_file)} files")

    out.append("")
    out.append("=" * 100)
    out.append(f"4. Fixed-height values found in lib/: {fixed_height_hits} (review those wrapping Text)")
    out.append("=" * 100)

    report = LIB.parent / "scratch" / "layout_l10n_report.txt"
    report.write_text("\n".join(out), encoding="utf-8")
    print(f"Report written to {report}")
    print(f"constrained buttons: {len(findings['constrained_button'])} | "
          f"row buttons: {len(seen)} | hardcoded strings: {len(findings['hardcoded_string'])} "
          f"in {len(per_file)} files")


if __name__ == "__main__":
    main()
