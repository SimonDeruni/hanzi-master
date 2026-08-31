#!/usr/bin/env python3
"""Get detailed status of all keys that still need translation."""
import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"

with open(os.path.join(BASE, "app_en.arb"), "r", encoding="utf-8") as f:
    en = json.load(f)

# All keys mentioned by user that exist
keys = {
    # Screen-level words
    'calligraphy': 'Calligraphy',
    'reading': 'Reading',
    'recall': 'Recall', 
    'speaking': 'Speaking',
    'listening1': 'Listening',
    'today': 'Today',
    'emailLabel': 'Email',
    # Settings
    'audioAndHaptics': 'Audio And Haptics',
    'displayAndContent': 'Display And Content',
    'appLanguage': 'App Language',
    'translationLanguage': 'Translation Language',
    'french': 'French',
    'animationSpeed': 'Animation Speed',
    'notifications': 'Notifications',
    'notification_settings': 'Notification Settings',
    'dangerZone': 'Danger Zone',
    'resetAllData': 'Reset All Data',
    'resetDataDesc': 'Reset Data Desc',
    # Voice names
    'kore': 'Kore',
    'koreKoreFemaleWarm': "Kore', 'Kore', 'Female, warm",
    'aoede': 'Aoede',
    'aoedeAoedeFemaleCheerful': "Aoede', 'Aoede', 'Female, cheerful",
    'fenrir': 'Fenrir',
    'fenrirFenrirMaleUpbeat': "Fenrir', 'Fenrir', 'Male, upbeat",
    'charon': 'Charon',
    'charonCharonMaleNewsstyle': "Charon', 'Charon', 'Male, news-style",
    'puck': 'Puck',
    'puckPuckMaleSporty': "Puck', 'Puck', 'Male, sporty",
    'localOndevice': "Local', 'On-device",
    'localOndeviceTts': 'Local on-device TTS',
    'koreFenrirCharonAoedePuckOrLocal': "Kore', 'Fenrir', 'Charon', 'Aoede', 'Puck', or 'local",
}

langs = ['de', 'es', 'fr', 'it', 'pt', 'ru', 'ar', 'hi', 'id', 'ja', 'ko', 'vi']

outpath = os.path.join(BASE, "all_remaining.txt")
with open(outpath, "w", encoding="utf-8") as out:
    for lang in langs:
        d = json.load(open(os.path.join(BASE, f"app_{lang}.arb"), "r", encoding="utf-8"))
        out.write(f"\n=== {lang.upper()} ===\n")
        for key, en_val in keys.items():
            if key in d:
                if d[key] == en_val:
                    out.write(f"  STILL_EN: {key} = {en_val[:50]}\n")
            else:
                out.write(f"  MISSING: {key}\n")
    out.write(f"\nDone checking {len(langs)} languages for {len(keys)} keys\n")

print(f"Written to {outpath}")