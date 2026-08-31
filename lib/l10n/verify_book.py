import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"
en = json.load(open(os.path.join(BASE, "app_en.arb"), "r", encoding="utf-8"))

# Check which keys are still English placeholders in each language
keys_to_check = [
    "audio", "previous",
    "analyzingImage", "extractingChineseText", "lookingUpVocabulary",
    "dreamOfTheRedChamber", "journeyToTheWest", "romanceOfTheThreeKingdoms",
    "mingDynasty", "wuChengEn", "hundredChapters", "volume1",
    "bookmarksCount", "noBookmarksYet", "sinosparkIsNotResponding",
    "closeApp", "wait", "studioHdAllowance", "bookPercentRead",
    "chAbbreviation", "booksAndAudiobooks", "sentenceXOfY", "chapterXOfY",
    "chineseEpics",
]

langs = ["de","es","fr","it","pt","ru","ar","hi","id","ja","ko","vi"]

print(f"{'Lang':5} | Keys missing | Still English | OK")
print("-"*60)
all_ok = True
for lang in langs:
    d = json.load(open(os.path.join(BASE, f"app_{lang}.arb"), "r", encoding="utf-8"))
    missing = []
    still_en = []
    ok = 0
    skip = 0
    for k in keys_to_check:
        if k not in d:
            missing.append(k)
        else:
            en_val = en.get(k, "")
            if d[k] == en_val:
                # Check if it's a proper name that should stay the same
                still_en.append(f"{k}={d[k]}")
            else:
                ok += 1
    status = f"{lang:5} | {len(missing):3d} missing | {len(still_en):3d} same as EN | {ok} ok"
    print(status)
    if missing:
        print(f"       Missing: {missing}")
    if still_en and lang not in ["ja", "ko", "vi"]:
        # For CJKV some keys legitimately stay same as EN (names)
        pass
    if missing or still_en:
        all_ok = False

print(f"\nAll OK: {all_ok}")

# Print summary of any remaining issues
if not all_ok:
    print("\n--- Details of remaining issues ---")
    for lang in langs:
        d = json.load(open(os.path.join(BASE, f"app_{lang}.arb"), "r", encoding="utf-8"))
        for k in keys_to_check:
            if k not in d:
                print(f"  {lang}: MISSING KEY: {k}")
            elif d[k] == en.get(k, ""):
                print(f"  {lang}: STILL ENGLISH: {k}={d[k]}")