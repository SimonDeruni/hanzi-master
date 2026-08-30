import json, re, os

BASE_DIR = r'C:\Users\simon\Documents\hanzi_master\lib\l10n'

# Load data
with open(os.path.join(BASE_DIR, 'hardcoded_strings.json'), 'r', encoding='utf-8-sig') as f:
    raw = json.load(f)

with open(os.path.join(BASE_DIR, 'app_en.arb'), 'r', encoding='utf-8') as f:
    arb_en = json.load(f)

with open(os.path.join(BASE_DIR, 'known_keys.json'), 'r', encoding='utf-8') as f:
    known_keys = json.load(f)

# Collect all unique hardcoded strings
hc_strings = []
for file_entry in raw.get('files', []):
    for s in file_entry.get('strings', []):
        text = s.get('text', '').strip()
        if text:
            hc_strings.append(text)

hc_unique = []
seen = set()
for t in hc_strings:
    tl = t.lower().strip()
    if tl not in seen:
        seen.add(tl)
        hc_unique.append(t.strip())

print(f'Total unique hardcoded strings: {len(hc_unique)}')

# Existing ARB values
arb_values = {}
arb_key_for_value = {}
for k, v in arb_en.items():
    if not k.startswith('@') and isinstance(v, str):
        vs = v.strip()
        arb_values[vs.lower()] = vs
        arb_key_for_value[vs] = k

existing_keys = set(k for k in arb_en.keys() if not k.startswith('@'))

def should_filter(text):
    if re.match(r'^Error:\s*\$', text): return True
    if re.match(r'^Analysis Failed:\s*\$', text): return True
    if re.match(r'^Simplify Failed:\s*\$', text): return True
    if re.match(r'^Translation Failed:\s*\$', text): return True
    if re.match(r'^Extraction Failed:', text): return True
    if re.match(r'^Error creating scenario:', text): return True
    if re.match(r'^Failed to load context:', text): return True
    if re.match(r'^Error loading chapters:', text): return True
    if re.match(r'^Error loading decks', text): return True
    if re.match(r'^\$', text): return True
    if re.match(r'^\$\{', text): return True
    if '${' in text: return True
    if '$_' in text: return True
    if text in ['...', '-', '?', '\u00b7', ':', '(', ')', '}', '"', '\"', '\"]']: return True
    if text.startswith('tone_v4:') or text.startswith('}:'): return True
    if text in {'en','zh','es','fr','de','ja','ko','pt','it','ar','hi','id','vi','tr','ru'}: return True
    if text.startswith('http://') or text.startswith('https://'): return True
    if re.match(r'^[\u4e00-\u9fff\u3400-\u4dbf\uf900-\ufaff]+$', text): return True
    if text in {'info', 'mnemonic', 'details', 'meaning', 'title', 'char', 'words', 'x', 'phoneme'}: return True
    if re.match(r'^\d+\s*cards$', text): return True
    if '\ufffd' in text: return True
    if text in ['æ°µ', 'æŸ¥çœ‹ä¸']: return True
    if 'ð' in text: return True
    if text.startswith('\\"') or text == '\\"': return True
    if text.endswith('\\"') and text.startswith('\\"'): return True
    return False

# Find untranslated strings
untranslated = []
for text in hc_unique:
    if should_filter(text):
        continue
    norm = text.lower()
    if norm in arb_values:
        continue
    # Check similar matches
    found = False
    for av_norm, av_actual in arb_values.items():
        if av_norm == norm:
            found = True
            break
        if len(text) >= 8 and len(av_actual) >= 8:
            if norm in av_norm or av_norm in norm:
                found = True
                break
    if found:
        continue
    if text in arb_key_for_value:
        continue
    untranslated.append(text)

# Deduplicate
final_ut = []
seen_final = set()
for t in untranslated:
    tl = t.lower()
    if tl not in seen_final:
        seen_final.add(tl)
        final_ut.append(t)

print(f'Untranslated strings (deduplicated): {len(final_ut)}')
for i, s in enumerate(final_ut):
    print(f'{i+1}. {repr(s)}')

# Generate keys for remaining strings
def auto_generate_key(text):
    s = text.strip()
    # Remove leading/trailing punctuation
    s = s.strip('...?!.,;: \t')
    # Replace & with and
    s = s.replace('&', 'and')
    # Remove special characters
    s = re.sub(r'[^a-zA-Z0-9\s]', '', s)
    words = s.split()
    if not words:
        return None
    result = words[0].lower()
    for w in words[1:]:
        if w:
            result += w[0].upper() + w[1:].lower()
    if len(result) > 50:
        result = result[:50]
    return result

key_mapping = {}
for text in final_ut:
    if text in known_keys:
        key_mapping[text] = known_keys[text]
    else:
        key = auto_generate_key(text)
        if key is None or key in existing_keys or key in key_mapping.values():
            # Add suffix to make unique
            base = key or 'unknown'
            counter = 1
            while (key in existing_keys or key in key_mapping.values()) if key else True:
                key = base + str(counter)
                counter += 1
        key_mapping[text] = key

print(f'\nGenerated {len(key_mapping)} total key mappings')
print('\nSample mappings:')
for i, (text, key) in enumerate(list(key_mapping.items())[:15]):
    print(f'  {repr(text)} -> {key}')

# Save mapping
with open(os.path.join(BASE_DIR, 'key_mapping.json'), 'w', encoding='utf-8') as f:
    json.dump(key_mapping, f, ensure_ascii=False, indent=2)
print('\nKey mapping saved to key_mapping.json')
