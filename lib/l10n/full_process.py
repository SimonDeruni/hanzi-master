#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Complete processor for all 13 language ARB files.
Reads new_arb_entries_en.json, merges entries into each app_{lang}.arb file,
and provides translations for non-English languages.

Run: python -X utf8 full_process.py
"""

import json
import os
import re

BASE = os.path.dirname(os.path.abspath(__file__))
LANGUAGES = ['en', 'ar', 'de', 'es', 'fr', 'hi', 'id', 'it', 'ja', 'ko', 'pt', 'ru', 'vi']

NEW_PATH = os.path.join(BASE, 'new_arb_entries_en.json')
with open(NEW_PATH, 'r', encoding='utf-8') as f:
    NEW = json.load(f)

# All data keys and metadata keys
DATA_KEYS = [k for k in NEW if not k.startswith('@')]
META_KEYS = [k for k in NEW if k.startswith('@')]
ALL_KEYS = list(NEW.keys())

print(f"Data keys: {len(DATA_KEYS)}, Meta keys: {len(META_KEYS)}")

def keep_as_is(text):
    """Check if text should be kept as-is (special terms, Chinese-only, etc.)"""
    special = {'Hanzi', 'Pinyin', 'HSK', 'SinoSpark', 'SRS', 'BBC 中文', 'BBC 中文', 'chéng'}
    if text.strip() in special:
        return True
    # Only Chinese/CJK characters and common punctuation
    if re.match(r'^[\u4e00-\u9fff\u3400-\u4dbf\u3000-\u303f\uff00-\uffef\s\.\,\!\?\(\)\d\-\:\;\/\@\#\&\'\"]+$', text):
        return True
    return False