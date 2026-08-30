import json, re, os

BASE_DIR = r'C:\Users\simon\Documents\hanzi_master\lib\l10n'

with open(os.path.join(BASE_DIR, 'key_mapping_final.json'), 'r', encoding='utf-8') as f:
    mapping = json.load(f)

# Load existing ARB to check for duplicate keys
with open(os.path.join(BASE_DIR, 'app_en.arb'), 'r', encoding='utf-8') as f:
    arb_en = json.load(f)

existing_keys = set(k for k in arb_en.keys() if not k.startswith('@'))

# Build final entries for ARB - process each string
# Convert Dart interpolation ($var or ${var}) to ARB placeholders ({var})
# and identify strings that need @metadata

final_entries = {}
placeholder_entries = {}

for text, key in mapping.items():
    # Skip if key already exists
    if key in existing_keys:
        print(f'WARNING: Key {key} already exists! Skipping...')
        continue
    
    # Check for Dart variable interpolation and convert to ARB format
    arb_text = text
    
    # Convert ${variable} to {variable}
    # First handle ${variable.subfield} -> cannot use ARB, keep as is or skip
    has_complex_dollar = bool(re.search(r'\$\{[^}]*\.', text))
    has_simple_dollar = bool(re.search(r'\$\{(\w+)\}', text))
    has_dollar_var = bool(re.search(r'\$(\w+)', text))
    
    placeholders = {}
    
    if has_complex_dollar:
        print(f'WARNING: Complex interpolation in: {repr(text[:60])}')
        # Still add but with the text as-is for English, note that it needs manual fix
    
    # Convert ${var} to {var}
    if has_simple_dollar:
        matches = re.findall(r'\$\{(\w+)\}', text)
        for m in matches:
            arb_text = arb_text.replace('${' + m + '}', '{' + m + '}')
            placeholders[m] = {"type": "String"}
    
    # Convert $var to {var}  
    if has_dollar_var and not has_simple_dollar:
        matches = re.findall(r'\$(\w+)', text)
        for m in matches:
            # Only replace $word if it appears as a whole word
            arb_text = re.sub(r'\$' + m + r'\b', '{' + m + '}', arb_text)
            placeholders[m] = {"type": "String"}
    
    final_entries[key] = arb_text
    if placeholders:
        placeholder_entries[key] = placeholders

# Now also check for entries that already exist with the same key in ARB
# Manually handle the tricky ones
# "No results found for '$searchQuery'" -> needs special handling
# "Added '$hanzi' to your Library" -> needs special handling

# Fix specific entries
if 'noResultsFoundForSearchquery' in final_entries:
    text = final_entries['noResultsFoundForSearchquery']
    # Convert the single-quoted $searchQuery
    text = text.replace("'$searchQuery'", "'{searchQuery}'")
    final_entries['noResultsFoundForSearchquery'] = text
    placeholder_entries['noResultsFoundForSearchquery'] = {"searchQuery": {"type": "String"}}

if 'addedHanziToYourLibrary' in final_entries:
    text = final_entries['addedHanziToYourLibrary']
    # "Added '$hanzi' to your Library" -> "Added '{hanzi}' to your Library"
    text = text.replace("'$hanzi'", "'{hanzi}'")
    final_entries['addedHanziToYourLibrary'] = text
    placeholder_entries['addedHanziToYourLibrary'] = {"hanzi": {"type": "String"}}

# Fix remaining entries with $ in them
for key in list(final_entries.keys()):
    text = final_entries[key]
    if '$' in text:
        print(f'  Remaining $ in: {key}: {repr(text[:60])}')
        # Try to fix
        text_fixed = re.sub(r'\$(\w+)', r'{\1}', text)
        if text_fixed != text:
            print(f'    Fixed to: {repr(text_fixed[:60])}')
            final_entries[key] = text_fixed
            # Extract placeholders
            phs = re.findall(r'\{(\w+)\}', text_fixed)
            if phs and key not in placeholder_entries:
                placeholder_entries[key] = {p: {"type": "String"} for p in phs}

# Generate final output structure for English
output_entries = {}
for key in sorted(final_entries.keys()):
    output_entries[key] = final_entries[key]
    if key in placeholder_entries:
        output_entries['@' + key] = {"placeholders": placeholder_entries[key]}

with open(os.path.join(BASE_DIR, 'new_arb_entries_en.json'), 'w', encoding='utf-8') as f:
    json.dump(output_entries, f, ensure_ascii=False, indent=2)

print(f'\nTotal new English ARB entries: {len(output_entries)}')
print(f'Entries with placeholders: {len(placeholder_entries)}')
print('\nPreview:')
for i, (k, v) in enumerate(list(output_entries.items())[:30]):
    if k.startswith('@'):
        print(f'  {k}: {v}')
    else:
        print(f'  {k}: {repr(v[:60])}')
