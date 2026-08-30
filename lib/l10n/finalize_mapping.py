import json, re, os

BASE_DIR = r'C:\Users\simon\Documents\hanzi_master\lib\l10n'

with open(os.path.join(BASE_DIR, 'key_mapping_clean.json'), 'r', encoding='utf-8') as f:
    mapping = json.load(f)

# More filtering
remove_keys = []
for text, key in mapping.items():
    # Remove garbage texts
    if 'æ°µ' in text or 'æŸ¥' in text:
        remove_keys.append(text)
    elif text == 'unknown7' or text == 'unknown8':
        remove_keys.append(text)
    elif text.startswith('")'):
        remove_keys.append(text)
    elif text in {'No results found for'}:
        remove_keys.append(text)

for k in remove_keys:
    del mapping[k]

# Shorten/improve some keys that are too long
key_fixes = {}
for text, key in mapping.items():
    if len(key) > 45:
        # Generate a shorter key
        words = re.sub(r'[^a-zA-Z0-9\s]', '', text.replace("'", "").replace("&", " and ")).split()
        if len(words) > 3:
            # Take first 2 words + last word
            new_key = words[0].lower()
            if len(words) > 1:
                new_key += words[1][0].upper() + words[1][1:].lower() if len(words) > 1 else ''
            if len(words) > 2:
                new_key += words[-1][0].upper() + words[-1][1:].lower()
            if len(new_key) > 45:
                new_key = new_key[:45]
            key_fixes[text] = (key, new_key)

print("Key fixes (shortening):")
for text, (old, new) in list(key_fixes.items())[:10]:
    print(f"  {repr(text[:60])}...")
    print(f"    {old} -> {new}")

# Apply fixes
for text, (old, new) in key_fixes.items():
    mapping[text] = new

with open(os.path.join(BASE_DIR, 'key_mapping_final.json'), 'w', encoding='utf-8') as f:
    json.dump(mapping, f, ensure_ascii=False, indent=2)

print(f"\nFinal mapping: {len(mapping)} entries")
print("\nAll final entries:")
for i, (text, key) in enumerate(mapping.items()):
    print(f'{i+1}. {key}: {repr(text[:80])}')
