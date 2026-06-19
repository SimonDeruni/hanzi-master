import json
import os
import glob

# The correct mapping for the new keys added today
correct_english_strings = {
    "aiHubTitle": "AI Hub",
    "textChat": "Text Chat",
    "scholarlyPersonas": "Scholarly Personas",
    "shadowing": "Shadowing",
    "liveTranslation": "Live Translation",
    "scholarsLibrary": "The Scholar's Library",
    "generate": "Generate",
    "searchPinyinHanziEnglish": "Search Pinyin, Hanzi, or English...",
    "liveTranslate": "Live Translate",
    "poweredByGemini": "Powered by Gemini 3.5. Seamless real-time translation for any scenario.",
    "travelInterpreter": "Travel Interpreter",
    "realTimeSplitScreen": "Real-time split-screen conversation with a native speaker. Breaks down language barriers instantly.",
    "whisperEarpiece": "Whisper Earpiece",
    "listenToChineseAudio": "Listen to Chinese audio and get real-time English subtitles directly on your screen.",
    "dashboardTitle": "Dashboard",
    "yourMindIsClear": "Your mind is clear.",
    "noReviewsDueToday": "No reviews due today.",
    "done": "Done",
    "hskLevel1": "HSK Level 1",
    "hskLevel2": "HSK Level 2",
    "hskLevel3": "HSK Level 3",
    "hskLevel4": "HSK Level 4",
    "hskLevel5": "HSK Level 5",
    "hskLevel6": "HSK Level 6",
    "generalVocabulary": "General Vocabulary",
    "cardsRequireAttention": "cards require attention.",
    "begin": "Begin"
}

# 1. Update app_en.arb
with open('lib/l10n/app_en.arb', 'r', encoding='utf-8') as f:
    en_data = json.load(f)

for k, v in correct_english_strings.items():
    if k in en_data:
        en_data[k] = v

with open('lib/l10n/app_en.arb', 'w', encoding='utf-8') as f:
    json.dump(en_data, f, indent=2, ensure_ascii=False)

# 2. Delete these keys from other arb files so they get translated
other_arb_files = glob.glob('lib/l10n/app_*.arb')
for path in other_arb_files:
    if os.path.basename(path) == 'app_en.arb':
        continue
    
    with open(path, 'r', encoding='utf-8') as f:
        data = json.load(f)
        
    changed = False
    for k in correct_english_strings.keys():
        if k in data:
            del data[k]
            changed = True
            
    if changed:
        with open(path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)

print("Arb files fixed!")
