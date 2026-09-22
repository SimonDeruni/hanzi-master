"""Which ARB values are still identical to English (i.e. not translated)?"""
import json
import pathlib
import re

L10N = pathlib.Path(__file__).resolve().parent.parent / "lib" / "l10n"


def load(path):
    def hook(pairs):
        return {k: v for k, v in pairs}
    return json.loads(path.read_text(encoding="utf-8"), object_pairs_hook=hook)


def entries(d):
    return {k: v for k, v in d.items() if not k.startswith("@") and isinstance(v, str)}


SENTENCE = re.compile(r"^[A-Za-z][A-Za-z'’,.\- ]{9,}$")

out = []
en = entries(load(L10N / "app_en.arb"))
for name in ("app_de.arb", "app_ru.arb", "app_fr.arb"):
    loc = entries(load(L10N / name))
    same = [k for k, v in en.items() if loc.get(k) == v]
    sentence_like = [k for k in same if SENTENCE.match(en[k]) and " " in en[k]]
    out.append(f"=== {name}: {len(same)}/{len(en)} values identical to English "
               f"({len(sentence_like)} look like real sentences)")
    for k in sentence_like[:12]:
        out.append(f"    {k}: \"{en[k]}\"")
    out.append("")

pathlib.Path(__file__).parent.joinpath("untranslated_report.txt").write_text(
    "\n".join(out), encoding="utf-8")
print("written")
