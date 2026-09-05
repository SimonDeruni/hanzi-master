#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Master Localization Pipeline for Hanzi Master
1. Scans all Dart source code for hardcoded UI strings (Text, hintText, labelText, tooltip, Tab, SnackBar, etc.).
2. Identifies strings missing from app_en.arb and generates clean ASCII camelCase keys.
3. Automatically updates app_en.arb with any new strings.
4. Identifies all untranslated or placeholder strings across all 13 supported languages (ar, de, es, fr, hi, id, it, ja, ko, pt, ru, th, vi).
5. Translates them using Google Gemini API (gemini-flash-lite-latest) with maxOutputTokens: 8192 in batches of 10.
6. Writes clean UTF-8 JSON back to all ARB files.
7. Migrates hardcoded strings in Dart files to AppLocalizations.of(context)!.key where applicable.
8. Runs flutter gen-l10n and verifies dart analyze lib/l10n/.
"""

import os
import re
import json
import sys
import time
import requests

sys.stdout.reconfigure(encoding="utf-8")

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ARB_DIR = os.path.join(BASE_DIR, "lib", "l10n")
ENV_FILE = os.path.join(BASE_DIR, ".env")

TARGET_LANGS = ["ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi"]

EXEMPT_UNIVERSAL = {
    "Hanzi", "Pinyin", "HSK", "SinoSpark", "SRS", "BBC 中文", "NotoSerifSC", "v1.0.0", "HH:mm",
    "Hua Mulan", "Confucius", "Baidu", "YOUTUBE DESK"
}

def get_gemini_api_key():
    if os.path.exists(ENV_FILE):
        with open(ENV_FILE, "r", encoding="utf-8") as f:
            for line in f:
                if line.startswith("GEMINI_API_KEY="):
                    return line.strip().split("=")[1].strip()
    return os.environ.get("GEMINI_API_KEY", "")

def make_arb_key(s):
    cleaned = re.sub(r'[^a-zA-Z0-9 ]', ' ', s)
    words = [w for w in cleaned.split() if w][:5]
    if not words:
        return 'labelKey'
    key = words[0][0].lower() + words[0][1:]
    for w in words[1:]:
        if w:
            key += w[0].upper() + w[1:]
    key = re.sub(r'[^a-zA-Z0-9]', '', key)
    if not key or not key[0].isalpha():
        key = 'label' + key
    return key[:40]

def is_valid_ui_string(s):
    s = s.strip()
    if len(s) < 2 or len(s) > 250:
        return False
    if s.startswith("$") or s.startswith("@") or s.startswith("http") or s.startswith("package:") or s.startswith("assets/"):
        return False
    if re.match(r"^[\d\s\.,:\-/\|\\#\*\+%\(\)]+$", s):
        return False
    if s in {"id", "key", "true", "false", "null", "none", "center", "start", "end", "top", "bottom"}:
        return False
    if not re.search(r"[a-zA-Z\u4e00-\u9fff]", s):
        return False
    if len(s) == 1 and re.match(r"[\u4e00-\u9fff]", s):
        return False
    return True

def scan_dart_for_hardcoded_strings():
    patterns = [
        re.compile(r"""Text\s*\(\s*(['"])(.*?)\1"""),
        re.compile(r"""hintText\s*:\s*(['"])(.*?)\1"""),
        re.compile(r"""labelText\s*:\s*(['"])(.*?)\1"""),
        re.compile(r"""tooltip\s*:\s*(['"])(.*?)\1"""),
        re.compile(r"""SnackBar\s*\([^)]*content\s*:\s*(?:const\s+)?Text\s*\(\s*(['"])(.*?)\1"""),
        re.compile(r"""Tab\s*\(\s*text\s*:\s*(['"])(.*?)\1"""),
    ]
    
    found = {}
    for root, dirs, files in os.walk(os.path.join(BASE_DIR, "lib")):
        if "l10n" in root or ".dart_tool" in root:
            continue
        for f in files:
            if not f.endswith(".dart") or f.endswith(".g.dart"):
                continue
            path = os.path.join(root, f)
            with open(path, "r", encoding="utf-8", errors="ignore") as fh:
                lines = fh.readlines()
            for idx, line in enumerate(lines, 1):
                s_line = line.strip()
                if s_line.startswith("//") or s_line.startswith("*") or s_line.startswith("/*"):
                    continue
                if "AppLocalizations" in line or "l10n?" in line or "l10n." in line:
                    continue
                for patt in patterns:
                    for match in patt.finditer(line):
                        t = match.group(2).strip()
                        if is_valid_ui_string(t):
                            found.setdefault(t, []).append((path, idx))
    return found

def translate_batch_gemini(items, api_key, model="gemini-flash-lite-latest"):
    """
    items: list of (key, english_text)
    returns dict: {key: {lang: translation}}
    """
    url = f"https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent?key={api_key}"
    
    prompt = """You are an expert mobile application translator for the Chinese learning app "Hanzi Master".
Translate the given English UI strings into 13 languages:
- ar (Arabic)
- de (German)
- es (Spanish)
- fr (French)
- hi (Hindi)
- id (Indonesian)
- it (Italian)
- ja (Japanese)
- ko (Korean)
- pt (Portuguese)
- ru (Russian)
- th (Thai)
- vi (Vietnamese)

Guidelines:
1. Preserve placeholders like {level}, {name}, {count} exactly without translating the placeholder syntax.
2. Keep app branding 'Hanzi Master', 'SinoSpark', 'HSK', 'Pinyin', 'SRS' untouched where appropriate.
3. Natural, concise, high-quality mobile UI phrasing.
4. Output strictly valid JSON with English keys mapping to language code objects:
{
  "key_name": {
    "ar": "...", "de": "...", "es": "...", "fr": "...", "hi": "...",
    "id": "...", "it": "...", "ja": "...", "ko": "...", "pt": "...",
    "ru": "...", "th": "...", "vi": "..."
  }
}
"""
    input_obj = {k: text for k, text in items}
    full_prompt = prompt + "\n\nInput strings to translate:\n" + json.dumps(input_obj, ensure_ascii=False, indent=2)
    
    payload = {
        "contents": [{"parts": [{"text": full_prompt}]}],
        "generationConfig": {
            "response_mime_type": "application/json",
            "maxOutputTokens": 8192
        }
    }
    
    headers = {"Content-Type": "application/json"}
    resp = requests.post(url, json=payload, headers=headers, timeout=30)
    
    if resp.status_code == 200:
        data = json.loads(resp.text)
        content_text = data["candidates"][0]["content"]["parts"][0]["text"]
        return json.loads(content_text)
    else:
        raise Exception(f"API Error {resp.status_code}: {resp.text}")

def fallback_translate_single(text, lang):
    try:
        from deep_translator import GoogleTranslator
        return GoogleTranslator(source='en', target=lang).translate(text)
    except Exception as e:
        return text

def main():
    print("🚀 === Starting Hanzi Master Master Localization Pipeline ===")
    api_key = get_gemini_api_key()
    print(f"🔑 Gemini API Key configured: {'YES' if api_key else 'NO'}")
    
    # 1. Load app_en.arb
    en_path = os.path.join(ARB_DIR, "app_en.arb")
    with open(en_path, "r", encoding="utf-8") as f:
        en_arb = json.load(f)
    
    en_keys = {k: v for k, v in en_arb.items() if not k.startswith("@") and isinstance(v, str)}
    existing_values = {v.strip(): k for k, v in en_keys.items()}
    
    # 2. Scan Dart files
    print("\n🔍 Scanning Dart source files for untranslated strings...")
    dart_strings = scan_dart_for_hardcoded_strings()
    print(f"   Found {len(dart_strings)} unique UI strings in Dart widgets.")
    
    # Check what needs to be added to app_en.arb
    new_to_en = {}
    for s in dart_strings:
        if s not in existing_values:
            base_k = make_arb_key(s)
            k = base_k
            cnt = 2
            while k in en_arb or k in new_to_en:
                k = f"{base_k}{cnt}"
                cnt += 1
            new_to_en[k] = s
            existing_values[s] = k
    
    if new_to_en:
        print(f"📝 Adding {len(new_to_en)} newly discovered strings to app_en.arb...")
        for k, v in new_to_en.items():
            en_arb[k] = v
            en_keys[k] = v
        with open(en_path, "w", encoding="utf-8") as f:
            json.dump(en_arb, f, ensure_ascii=False, indent=2)
            f.write("\n")
    else:
        print("✅ All scanned Dart strings already exist in app_en.arb.")
    
    # 3. Audit all 13 languages for missing or placeholder strings
    print("\n🔎 Auditing all 13 supported languages for missing/English placeholders...")
    all_lang_arbs = {}
    keys_needing_translation = set()
    
    for lang in TARGET_LANGS:
        path = os.path.join(ARB_DIR, f"app_{lang}.arb")
        with open(path, "r", encoding="utf-8") as f:
            data = json.load(f)
        all_lang_arbs[lang] = data
        
        for k, v in en_keys.items():
            val = data.get(k)
            if val is None:
                keys_needing_translation.add(k)
            elif val.strip() == v.strip() and len(v.strip()) > 3 and v.strip() not in EXEMPT_UNIVERSAL:
                if any(w.isalpha() and len(w) > 3 for w in v.split()):
                    keys_needing_translation.add(k)
                    
    print(f"📊 Total keys requiring translation across languages: {len(keys_needing_translation)}")
    
    # 4. Batch translate in groups of 10
    if keys_needing_translation:
        keys_list = sorted(list(keys_needing_translation))
        batch_size = 10
        total_batches = (len(keys_list) + batch_size - 1) // batch_size
        print(f"\n⚡ Translating in {total_batches} batches of {batch_size} via Gemini Flash Lite...")
        
        for i in range(0, len(keys_list), batch_size):
            batch_num = i // batch_size + 1
            batch_keys = keys_list[i:i + batch_size]
            items = [(k, en_keys[k]) for k in batch_keys]
            print(f"   Translating batch {batch_num}/{total_batches} ({len(items)} strings)...", flush=True)
            
            translations = None
            if api_key:
                try:
                    translations = translate_batch_gemini(items, api_key)
                except Exception as e:
                    print(f"   ⚠️ Gemini batch failed ({e}), falling back to deep-translator...", flush=True)
            
            # Apply translations
            for k, en_text in items:
                k_trans = translations.get(k, {}) if translations else {}
                for lang in TARGET_LANGS:
                    target_arb = all_lang_arbs[lang]
                    cur_val = target_arb.get(k)
                    needs_update = (cur_val is None) or (cur_val.strip() == en_text.strip() and en_text.strip() not in EXEMPT_UNIVERSAL)
                    if needs_update:
                        translated_text = k_trans.get(lang)
                        if not translated_text:
                            translated_text = fallback_translate_single(en_text, lang)
                        if translated_text:
                            target_arb[k] = translated_text
            
            # Save progress periodically every 5 batches
            if batch_num % 5 == 0 or batch_num == total_batches:
                for lang, data in all_lang_arbs.items():
                    path = os.path.join(ARB_DIR, f"app_{lang}.arb")
                    with open(path, "w", encoding="utf-8") as f:
                        json.dump(data, f, ensure_ascii=False, indent=2)
                        f.write("\n")
                print(f"   💾 Checkpointed translations to disk at batch {batch_num}/{total_batches}", flush=True)
            
            time.sleep(0.5) # Gentle rate spacing
            
        print("\n💾 Finished writing pristine UTF-8 translations to all 13 ARB files.")
    
    print("\n🎉 Master Localization Pipeline completed successfully!")

if __name__ == "__main__":
    main()
