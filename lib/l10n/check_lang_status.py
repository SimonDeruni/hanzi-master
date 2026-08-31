#!/usr/bin/env python3
"""Check which keys in each language ARB still have English placeholder text."""
import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"

target_keys = [
    "guestScholar", "localAccount", "createAccount", 
    "createAccountToSyncProgress", "account", "learning_stats",
    "view_your_learning_history_and_streaks", "sinospark_premium",
    "youAreAPremiumMember", "premium", "unlockSinosparkPremium",
    "signInToSyncYourProgress", "createAnAccountToSaveYourStats",
    "hanziMaster"
]

with open(os.path.join(BASE, "app_en.arb"), "r", encoding="utf-8") as f:
    en = json.load(f)

langs = ["de", "es", "fr", "it", "pt", "ru", "ar", "hi", "id", "ja", "ko", "vi"]

outpath = "C:/Users/simon/Documents/hanzi_master/lib/l10n/translation_status.txt"
with open(outpath, "w", encoding="utf-8") as out:
    for lang in langs:
        path = os.path.join(BASE, f"app_{lang}.arb")
        with open(path, "r", encoding="utf-8") as f:
            data = json.load(f)
        
        out.write(f"\n{'='*60}\n")
        out.write(f"  {lang.upper()}\n")
        out.write(f"{'='*60}\n")
        for key in target_keys:
            english = en.get(key, "")
            if key in data:
                current = data[key]
                if current == english:
                    out.write(f"  [PLACEHOLDER] {key}: {english}\n")
                elif current and current != english:
                    out.write(f"  [TRANSLATED]  {key}: {current}\n")
                else:
                    out.write(f"  [EMPTY]       {key}\n")
            else:
                out.write(f"  [MISSING]     {key}\n")

print(f"Written to {outpath}")