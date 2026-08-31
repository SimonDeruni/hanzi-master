import json, os
BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"
with open(os.path.join(BASE, "all_translations.json"), "r", encoding="utf-8") as f:
    T = json.load(f)
for lang, trans in T.items():
    path = os.path.join(BASE, f"app_{lang}.arb")
    with open(path, "r", encoding="utf-8") as f:
        d = json.load(f)
    c = 0
    for k, v in trans.items():
        if k in d:
            if d[k] != v:
                d[k] = v; c += 1
        else:
            d[k] = v; c += 1
    with open(path, "w", encoding="utf-8") as f:
        json.dump(d, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"{lang}: {c} changes")
print("DONE")