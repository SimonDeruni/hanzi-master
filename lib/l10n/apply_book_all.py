import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"
en = json.load(open(os.path.join(BASE, "app_en.arb"), "r", encoding="utf-8"))

def apply_batch(batch_file, lang_keys):
    batch = json.load(open(os.path.join(BASE, batch_file), "r", encoding="utf-8"))
    for lang in lang_keys:
        if lang not in batch:
            print(f"  {lang} not in batch file, skipping")
            continue
        path = os.path.join(BASE, f"app_{lang}.arb")
        d = json.load(open(path, "r", encoding="utf-8"))
        c = 0
        for k, v in batch[lang].items():
            if k not in d:
                d[k] = v
                c += 1
            elif d[k] == en.get(k, ""):
                d[k] = v
                c += 1
        with open(path, "w", encoding="utf-8") as f:
            json.dump(d, f, ensure_ascii=False, indent=2)
            f.write("\n")
        print(f"  {lang}: {c} updates")

# Apply FR, IT, PT
print("Batch fr_it_pt:")
apply_batch("batch_book_fr_it_pt.json", ["fr", "it", "pt"])

# Apply RU, AR
print("Batch ru_ar:")
apply_batch("batch_book_ru_ar.json", ["ru", "ar"])

# Apply HI, ID
print("Batch hi_id:")
apply_batch("batch_book_hi_id.json", ["hi", "id"])

# Apply JA, KO, VI
print("Batch ja_ko_vi:")
apply_batch("batch_book_ja_ko_vi.json", ["ja", "ko", "vi"])

print("\nAll batches applied!")