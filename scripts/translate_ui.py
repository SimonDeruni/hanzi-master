import json
import os
import time
from googletrans import Translator

L10N_DIR = '../lib/l10n'
EN_FILE = 'app_en.arb'
TARGET_LANGUAGES = ['es', 'fr', 'ar', 'de', 'it', 'vi', 'ko', 'ja', 'ru', 'id', 'hi', 'pt']

translator = Translator()

def translate_ui_keys():
    en_filepath = os.path.join(L10N_DIR, EN_FILE)
    if not os.path.exists(en_filepath):
        print("Could not find app_en.arb")
        return

    with open(en_filepath, 'r', encoding='utf-8') as f:
        en_data = json.load(f)

    # We only translate the values of normal keys (ignoring @@locale and @keys)
    keys_to_translate = {k: v for k, v in en_data.items() if not k.startswith('@')}

    for lang in TARGET_LANGUAGES:
        target_file = f'app_{lang}.arb'
        target_filepath = os.path.join(L10N_DIR, target_file)
        
        # Load existing translations
        if os.path.exists(target_filepath):
            with open(target_filepath, 'r', encoding='utf-8') as f:
                target_data = json.load(f)
        else:
            target_data = {"@@locale": lang}

        updates_made = False

        for key, english_text in keys_to_translate.items():
            if key not in target_data:
                # Key is missing, we need to translate it
                print(f"[{lang}] Translating new key: '{key}'")
                try:
                    translation = translator.translate(english_text, dest=lang, src='en')
                    target_data[key] = translation.text
                    updates_made = True
                    time.sleep(0.5) # Anti-ban delay
                except Exception as e:
                    print(f"Error translating '{key}' to {lang}: {e}")

        if updates_made:
            with open(target_filepath, 'w', encoding='utf-8') as f:
                json.dump(target_data, f, ensure_ascii=False, indent=2)
            print(f"Updated {target_file}")
        else:
            print(f"[{lang}] Up to date.")

if __name__ == "__main__":
    print("Starting UI Auto-Translator...")
    translate_ui_keys()
    print("Done!")
