"""Point every non-literal serif at the family the app actually bundles.

Three spellings of the same intent existed:

  * `fontFamily: 'Serif'`                                  (24 sites)
  * `fontFamily: l10n.serif`                               ( 3 sites)
  * `fontFamily: AppLocalizations.of(context)!.notoserifsc` ( 3 sites)

`'Serif'` is a platform-generic name: it resolves on Android and falls back to
the *sans-serif* system face on iOS, so those 24 sites looked inconsistent
between platforms by construction. The other six routed a font family through
`l10n`, which means a translator editing a string could change the typography -
and it is not something that belongs in a translation file at all.

All 30 now name the bundled OFL family directly. The `serif` / `notoserifsc`
`.arb` keys become unused; they are left in place deliberately, because removing a
key across 15 locale files is churn with its own risk and buys nothing.

Dry run by default.  Pass --apply to write.
"""

import sys
from pathlib import Path

ROOT = Path(r"C:\Users\simon\Documents\hanzi_master")
LIB = ROOT / "lib"

FAMILY = "fontFamily: 'NotoSerifSC'"
REPLACEMENTS = (
    ("fontFamily: 'Serif'", FAMILY),
    ("fontFamily: 'serif'", FAMILY),
    ("fontFamily: l10n.serif", FAMILY),
    ("fontFamily: AppLocalizations.of(context)!.notoserifsc", FAMILY),
    ("fontFamily: 'NotoSansSC'", FAMILY),
)


def _remaining() -> dict:
    """Any spelling of the old intent still present, by file.

    The acceptance test is the **post-condition**, not a pre-count: concurrent
    agents edit these files, so how many sites exist when the sweep starts is a
    moving number (it moved from 24 to 19 between measuring and applying). What
    must be true is that none survive.
    """
    left = {}
    for old, _ in REPLACEMENTS:
        for path in sorted(LIB.rglob("*.dart")):
            hits = path.read_text(encoding="utf-8").count(old)
            if hits:
                left.setdefault(old, []).append("%s x%d" % (path.name, hits))
    return left


def main() -> int:
    apply = "--apply" in sys.argv
    print("MODE:", "APPLY" if apply else "DRY RUN")

    total = 0
    for old, new in REPLACEMENTS:
        found = 0
        for path in sorted(LIB.rglob("*.dart")):
            text = path.read_text(encoding="utf-8")
            hits = text.count(old)
            if not hits:
                continue
            found += hits
            if apply:
                path.write_text(text.replace(old, new), encoding="utf-8")
        print("  %-58s %2d" % (old, found))
        total += found

    print("sites rewritten: %d" % total)

    if apply:
        left = _remaining()
        if left:
            print("FAILED: these survive:")
            for old, files in left.items():
                print("  %s -> %s" % (old, ", ".join(files)))
            return 1
        print("post-condition: no non-literal serif family remains in lib/")
    print("OK" + ("" if apply else "  (dry run - re-run with --apply)"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
