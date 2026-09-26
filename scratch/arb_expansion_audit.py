"""Audit ARB translations for label expansion (width risk in fixed-size buttons).

Usage:  python scratch/arb_expansion_audit.py [--out PATH]
Reads lib/l10n/app_*.arb and reports, per locale, how much longer translated
label strings get compared to English.

`--out` writes the report somewhere other than the default
`scratch/arb_expansion_report.txt`, so CI can keep it as a build artifact.
"""
import json
import pathlib
import re
import sys

L10N = pathlib.Path(__file__).resolve().parent.parent / "lib" / "l10n"


def load(path):
    """Load an ARB preserving key case and reporting true duplicate keys."""
    def hook(pairs):
        seen, out, dups = set(), {}, []
        for k, v in pairs:
            if k in seen:
                dups.append(k)
            seen.add(k)
            out[k] = v
        if dups:
            print(f"  !! duplicate keys in {path.name}: {dups}")
        return out

    return json.loads(path.read_text(encoding="utf-8"), object_pairs_hook=hook)


def entries(d):
    return {k: v for k, v in d.items() if not k.startswith("@") and isinstance(v, str)}


PLACEHOLDER = re.compile(r"\{[^}]*\}")


def main():
    out = []

    def emit(line=""):
        out.append(line)

    en = entries(load(L10N / "app_en.arb"))
    emit(f"English keys: {len(en)}")
    emit()
    emit(f"{'locale':<8}{'keys':>6}{'ident':>7}{'mean':>7}{'p95':>7}{'max':>7}   worst short-label expansions")
    emit("-" * 118)

    for path in sorted(L10N.glob("app_*.arb")):
        if path.name == "app_en.arb":
            continue
        loc = entries(load(path))

        ratios, worst = [], []
        identical = 0
        for key, en_text in en.items():
            if key not in loc:
                continue
            loc_text = loc[key]
            if loc_text == en_text:
                identical += 1
            # Strip ICU placeholders: they do not consume layout width in the ARB.
            base = PLACEHOLDER.sub("", en_text).strip()
            if len(base) < 4:
                continue
            ratio = len(loc_text) / len(base)
            ratios.append(ratio)
            if len(base) <= 22 and not PLACEHOLDER.search(en_text):
                worst.append((ratio, key, base, loc_text))

        if not ratios:
            continue

        ratios.sort()
        p95 = ratios[int(len(ratios) * 0.95)]
        top = sorted(worst, reverse=True)[:3]
        sample = " | ".join(f"{r:.1f}x {k}" for r, k, _, _ in top)

        emit(
            f"{path.stem.replace('app_', ''):<8}{len(ratios):>6}{identical:>7}"
            f"{sum(ratios) / len(ratios):>7.2f}{p95:>7.2f}{ratios[-1]:>7.2f}   {sample}"
        )
        for r, k, base, loc_text in top:
            emit(f"          {k}: \"{base}\" -> \"{loc_text}\"  ({r:.1f}x)")
        emit()

    report = pathlib.Path(__file__).resolve().parent / "arb_expansion_report.txt"
    if "--out" in sys.argv:
        index = sys.argv.index("--out")
        if index + 1 < len(sys.argv):
            report = pathlib.Path(sys.argv[index + 1]).resolve()
    report.parent.mkdir(parents=True, exist_ok=True)
    report.write_text("\n".join(out), encoding="utf-8")
    print(f"Report written to {report} ({len(out)} lines)")


if __name__ == "__main__":
    main()
