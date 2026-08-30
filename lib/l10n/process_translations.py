#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Process all ARB files: merge new entries and provide translations.
Run: python -X utf8 process_translations.py
"""

import json
import os
import re
import sys

BASE = os.path.dirname(os.path.abspath(__file__))
NEW_ENTRIES_PATH = os.path.join(BASE, 'new_arb_entries_en.json')
LANGUAGES = ['en', 'ar', 'de', 'es', 'fr', 'hi', 'id', 'it', 'ja', 'ko', 'pt', 'ru', 'vi']


def load_json(path):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)


def save_json(path, data):
    with open(path, 'w', encoding='utf-8', newline='\n') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write('\n')


# Load new English entries
new_entries_en = load_json(NEW_ENTRIES_PATH)
print(f'Loaded {len(new_entries_en)} new entries')


def get_translation(key, english_text, lang):
    """Get translation using per-language JSON files (trans_{lang}.json)."""
    if lang == 'en':
        return english_text
    
    # If text is just special terms, keep as-is
    special_keep = {'Hanzi', 'Pinyin', 'HSK', 'SinoSpark', 'SRS', 'BBC 中文'}
    if english_text.strip() in special_keep:
        return english_text
    
    # If text is only Chinese characters (or common CJK punct), keep as-is
    if re.match(r'^[\u4e00-\u9fff\u3400-\u4dbf\u3000-\u303f\uff00-\uffef\s\.\,\!\?\(\)\d\-\:\;\/\@\#\&\'\"\u2018\u2019\u201c\u201d]+$', english_text):
        return english_text
    
    # Load translation data for this language
    tfile = os.path.join(BASE, f'trans_{lang}.json')
    if os.path.exists(tfile):
        trans_data = load_json(tfile)
        if key in trans_data:
            return trans_data[key]
        if english_text in trans_data:
            return trans_data[english_text]
    
    # Return English with a warning
    print(f'  WARNING: No translation for key={key} lang={lang}: {english_text[:50]}...', file=sys.stderr)
    return english_text


def process_language(lang):
    """Process one language file."""
    filepath = os.path.join(BASE, f'app_{lang}.arb')
    print(f'\nProcessing {lang} ({filepath})...')
    
    # Read existing file
    existing = load_json(filepath)
    existing_keys = set(k for k in existing if not k.startswith('@'))
    print(f'  Existing entries: {len(existing_keys)}')
    
    # Track what we add
    added = 0
    skipped = 0
    errors = []
    
    # Process new entries
    for key, value in new_entries_en.items():
        if key.startswith('@'):
            # Metadata key: add if the corresponding data key exists (or will exist)
            data_key = key[1:]
            if data_key in new_entries_en:
                if key not in existing:
                    existing[key] = value
                    added += 1
            continue
        
        # Data key
        if key in existing:
            skipped += 1
            continue
        
        # Translate or copy
        try:
            translated = get_translation(key, value, lang)
            existing[key] = translated
            added += 1
        except Exception as e:
            errors.append((key, str(e)))
    
    # Save
    save_json(filepath, existing)
    print(f'  Added: {added}, Skipped: {skipped}')
    if errors:
        print(f'  Errors: {len(errors)}')
        for k, e in errors[:5]:
            print(f'    {k}: {e}')
    
    return added, skipped


def main():
    total_added = 0
    total_skipped = 0
    
    for lang in LANGUAGES:
        a, s = process_language(lang)
        total_added += a
        total_skipped += s
    
    print(f'\n{"="*50}')
    print(f'Total: Added {total_added} entries across {len(LANGUAGES)} languages')
    print(f'Total: Skipped {total_skipped} existing entries')
    print('Done!')


if __name__ == '__main__':
    main()