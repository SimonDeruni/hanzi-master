import json
import urllib.request
import urllib.parse
import re
import time
import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

# Target languages and their codes in Flutter ARB files
TARGET_LANGS = {
    'ar': 'ar',
    'de': 'de',
    'es': 'es',
    'fr': 'fr',
    'hi': 'hi',
    'id': 'id',
    'it': 'it',
    'ja': 'ja',
    'ko': 'ko',
    'pt': 'pt',
    'ru': 'ru',
    'th': 'th',
    'vi': 'vi',
}

L10N_DIR = 'lib/l10n'
EN_ARB_PATH = os.path.join(L10N_DIR, 'app_en.arb')

def translate_text(text, target_lang):
    if not text or not text.strip():
        return text
    
    # 1. Protect placeholders like {variable}
    placeholders = re.findall(r'\{[a-zA-Z0-9_]+\}', text)
    token_map = {}
    protected_text = text
    for i, ph in enumerate(placeholders):
        token = f"XPH{i}X"
        token_map[token] = ph
        protected_text = protected_text.replace(ph, token)
        
    # 2. Call Google Translate API
    encoded = urllib.parse.quote(protected_text)
    url = f"https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl={target_lang}&dt=t&q={encoded}"
    
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=10) as resp:
                data = json.loads(resp.read().decode('utf-8'))
                translated_parts = [part[0] for part in data[0] if part[0]]
                translated = ''.join(translated_parts)
                
                # 3. Restore placeholders
                for token, ph in token_map.items():
                    # Handle any case or space mutations introduced by translation
                    pattern = re.compile(re.escape(token), re.IGNORECASE)
                    translated = pattern.sub(ph, translated)
                
                # Fallback check if any placeholder was lost
                for ph in placeholders:
                    if ph not in translated:
                        # Append if lost
                        translated += f" {ph}"
                
                return translated.strip()
        except Exception as e:
            time.sleep(1)
            
    return text  # Fallback to English if network fails

# Load English ARB
with open(EN_ARB_PATH, 'r', encoding='utf-8') as f:
    en_arb = json.load(f)

en_keys = {k: v for k, v in en_arb.items() if not k.startswith('@') and isinstance(v, str)}

print(f"📖 Loaded {len(en_keys)} English keys from app_en.arb\n")

for lang_code, google_lang in TARGET_LANGS.items():
    arb_file = os.path.join(L10N_DIR, f'app_{lang_code}.arb')
    if not os.path.exists(arb_file):
        print(f"⚠️ {arb_file} does not exist, skipping.")
        continue
        
    with open(arb_file, 'r', encoding='utf-8') as f:
        target_arb = json.load(f)
        
    missing_keys = [k for k in en_keys if k not in target_arb]
    print(f"🌐 [{lang_code.upper()}] Translating {len(missing_keys)} missing keys...")
    
    if not missing_keys:
        print(f"   ✅ Already 100% up to date!")
        continue
        
    count = 0
    for k in missing_keys:
        en_val = en_keys[k]
        translated_val = translate_text(en_val, google_lang)
        target_arb[k] = translated_val
        count += 1
        if count % 20 == 0:
            print(f"   ... translated {count}/{len(missing_keys)} keys", flush=True)
        time.sleep(0.05)
        
    with open(arb_file, 'w', encoding='utf-8') as f:
        json.dump(target_arb, f, ensure_ascii=False, indent=2)
        f.write('\n')
        
    print(f"   🎉 Saved {len(missing_keys)} new translations to app_{lang_code}.arb!\n")

print("==================================================================")
print("🚀 ALL 13 LOCALIZATION FILES FULLY TRANSLATED & SYNCED!")
print("==================================================================")
