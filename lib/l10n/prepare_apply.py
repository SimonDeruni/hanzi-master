import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"
with open(os.path.join(BASE, "batch_trans.json"), "r", encoding="utf-8") as f:
    T = json.load(f)

# Now write and run the updater
script = r"""
import json, os
BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"
with open(os.path.join(BASE, "batch_trans.json"), "r", encoding="utf-8") as f:
    T = json.load(f)
for lang, trans in T.items():
    path = os.path.join(BASE, f"app_{lang}.arb")
    with open(path, "r", encoding="utf-8") as f:
        d = json.load(f)
    for k, v in trans.items():
        d[k] = v
    with open(path, "w", encoding="utf-8") as f:
        json.dump(d, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"{lang}: {len(trans)} keys updated")
"""
with open(os.path.join(BASE, "do_apply.py"), "w", encoding="utf-8") as f:
    f.write(script)
print("do_apply.py created")