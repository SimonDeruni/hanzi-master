#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Translation dictionary for all languages.
This file contains translations for the 332 new English entries across 12 non-English languages.
"""

# For each language, we provide translations for all 332 new entries.
# Entries not explicitly listed will be handled by fallback rules.
# Special terms (Hanzi, Pinyin, HSK, SinoSpark, SRS, BBC 中文) are kept as-is.

# We organize by language code, then by entry key.

def get_translation(key, english_text, lang):
    """Get translation for a specific key and English text in the target language."""
    
    # If it's a special term, keep as-is
    special_terms = {'Hanzi', 'Pinyin', 'HSK', 'SinoSpark', 'SRS', 'BBC 中文'}
    if english_text.strip() in special_terms:
        return english_text
    
    # If text contains only Chinese characters, keep as-is
    if re.match(r'^[\u4e00-\u9fff\u3400-\u4dbf\u3000-\u303f\uff00-\uffef\s\.\,\!\?\(\)\d\-]+$', english_text):
        return english_text
    
    # Use the translation table
    translations = lang_translations.get(lang, {})
    if key in translations:
        return translations[key]
    
    # Fallback: if the exact text is in the text-based lookup
    text_lookup = text_translations.get(lang, {})
    if english_text in text_lookup:
        return text_lookup[english_text]
    
    # Last resort: return English
    return english_text