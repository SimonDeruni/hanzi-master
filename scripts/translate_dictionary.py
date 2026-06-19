import json
import os
import time
from googletrans import Translator

# The languages we want to translate the definitions into
TARGET_LANGUAGES = ['es', 'fr', 'ar', 'de', 'it', 'vi', 'ko', 'ja', 'ru', 'id', 'hi', 'pt']

# The HSK files to translate
DATA_DIR = '../assets/data'
HSK_FILES = ['hsk1.json', 'hsk2_bundle.json', 'hsk3_bundle.json', 'hsk4_bundle.json', 'hsk5_bundle.json', 'hsk6_bundle.json']

translator = Translator()

def translate_file(filename):
    filepath = os.path.join(DATA_DIR, filename)
    if not os.path.exists(filepath):
        print(f"Skipping {filename}, not found.")
        return

    print(f"Loading {filename}...")
    with open(filepath, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # HSK 1 uses a raw list, HSK 2-6 uses a bundle format
    is_bundle = isinstance(data, dict) and "vocabulary" in data
    vocab_list = data["vocabulary"] if is_bundle else data

    for lang in TARGET_LANGUAGES:
        # Create a deep copy of the data structure for this language
        lang_data = json.loads(json.dumps(data))
        lang_vocab_list = lang_data["vocabulary"] if is_bundle else lang_data
        
        output_filename = filename.replace('.json', f'_{lang}.json')
        output_filepath = os.path.join(DATA_DIR, output_filename)
        
        # Skip if already exists to save time/API calls
        if os.path.exists(output_filepath):
            print(f"  {output_filename} already exists. Skipping.")
            continue

        print(f"  Translating {filename} to {lang}...")
        
        # Batch translation to avoid IP blocks and speed up process
        batch_size = 50
        for i in range(0, len(vocab_list), batch_size):
            batch = vocab_list[i:i+batch_size]
            definitions = [word.get("definition", "") for word in batch]
            
            try:
                translations = translator.translate(definitions, dest=lang, src='en')
                for j, translation in enumerate(translations):
                    lang_vocab_list[i+j]["definition"] = translation.text
                time.sleep(1) # Be polite to Google's free API
            except Exception as e:
                print(f"    Error on batch {i}: {e}")
                time.sleep(5)
                
        with open(output_filepath, 'w', encoding='utf-8') as f:
            json.dump(lang_data, f, ensure_ascii=False, indent=2)
            
        print(f"  Saved {output_filename}")

if __name__ == "__main__":
    print("Starting HSK Dictionary Translation Script...")
    for file in HSK_FILES:
        translate_file(file)
    print("Done!")
