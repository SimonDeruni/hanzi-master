import json
import glob

missing_keys = {
    "strokeAnalysis": "Stroke Analysis",
    "excellentWork": "Excellent work!",
    "keepPracticing": "Keep practicing!",
    "drawingSubmitted": "Drawing Submitted",
    "customPersonaHint": "Define a custom persona...",
    "stepOneOrigin": "STEP 1: THE ORIGIN",
    "stepTwoForge": "STEP 2: THE FORGE",
    "toForge": "To forge",
    "whatEssenceDoesNeed": "what essence does",
    "need": "need",
    "forged": "FORGED",
    "stepThreeHunt": "STEP 3: THE HUNT",
    "findCharactersWith": "Find characters with",
    "uninstallButton": "UNINSTALL"
}

for filepath in glob.glob("lib/l10n/app_*.arb"):
    with open(filepath, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    for k, v in missing_keys.items():
        if k not in data:
            data[k] = v
            # To avoid cluttering with descriptions for every language, we can just add the key
            
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
