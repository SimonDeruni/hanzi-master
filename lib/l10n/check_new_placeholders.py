#!/usr/bin/env python3
"""Check which of the newly listed keys are still English placeholders."""
import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"

with open(os.path.join(BASE, "app_en.arb"), "r", encoding="utf-8") as f:
    en = json.load(f)

keys_to_check = [
    'calligraphy', 'reading', 'recall', 'speaking', 'listening1', 'today',
    'audioAndHaptics', 'displayAndContent', 'appLanguage', 'translationLanguage',
    'french', 'animationSpeed', 'notifications', 'notification_settings',
    'dangerZone', 'resetAllData', 'resetDataDesc',
    'howCanWeHelpYou', 'do_you_keep_or_store_my',
    'speaking_pronunciation', 'how_is_my_pronunciation_scored',
    'what_is_shadowing_studio', 'whoAreTheVoicesSpeakingInTheApp',
    'readingVocabulary', 'howDoesTheWebExplorerWork', 'whatIsZenMode',
    'howDoesTheFlashcardSpacedrepetition',
    'iAgreeToTheTermsOfServiceAndPrivacy', 'sendMeOccasionalUpdatesTipsAndOffer'
]

# Also check for the long FAQ answers
faq_keys = []
for k, v in en.items():
    if isinstance(v, str) and len(v) > 50:
        faq_keys.append((k, v))

langs = ['de', 'es', 'fr', 'it', 'pt', 'ru', 'ar', 'hi', 'id', 'ja', 'ko', 'vi']

outpath = os.path.join(BASE, "placeholder_detail.txt")
with open(outpath, "w", encoding="utf-8") as out:
    for lang in langs:
        d = json.load(open(os.path.join(BASE, f"app_{lang}.arb"), "r", encoding="utf-8"))
        out.write(f"\n=== {lang.upper()} ===\n")
        placeholders = []
        for key in keys_to_check:
            if key in d:
                if d[key] == en.get(key, ''):
                    placeholders.append(key)
            else:
                placeholders.append(f"{key}[MISSING]")
        if placeholders:
            out.write(f"  {len(placeholders)} placeholders:\n")
            for k in placeholders:
                kv = k.replace('[MISSING]', '')
                en_val = en.get(kv.replace('[MISSING]', ''), '?')
                out.write(f"    {k}: {en_val[:60]}\n")
        else:
            out.write(f"  All translated!\n")

print(f"Written to {outpath}")
print("Keys checked:", len(keys_to_check))