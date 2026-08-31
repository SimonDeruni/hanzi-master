import json, os, sys

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"

# Read en to get keys list
with open(os.path.join(BASE, "app_en.arb"), "r", encoding="utf-8") as f:
    en = json.load(f)

# Translations data as compact dicts
# Format: {lang: {key: value}}
data = json.loads(sys.stdin.read())

for lang, trans in data.items():
    path = os.path.join(BASE, f"app_{lang}.arb")
    with open(path, "r", encoding="utf-8") as f:
        d = json.load(f)
    for k, v in trans.items():
        d[k] = v
    with open(path, "w", encoding="utf-8") as f:
        json.dump(d, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"{lang}: {len(trans)} keys updated")