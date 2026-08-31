import sys, re, os
sys.stdout.reconfigure(encoding='utf-8')
os.chdir(os.path.dirname(os.path.abspath(__file__)))

with open('app_localizations_en.dart', 'r', encoding='utf-8') as f:
    en_content = f.read()
with open('app_localizations_fr.dart', 'r', encoding='utf-8') as f:
    fr_content = f.read()

en_lines = en_content.split('\n')
fr_lines = fr_content.split('\n')

# Extract all getters with their keys and values from both files
def extract_gets(lines):
    gets = {}
    current_key = None
    current_val = []
    in_multi = False
    for line in lines:
        m = re.match(r"\s*String get (\w+)\s*=>\s*'(.*?)';?\s*$", line)
        if m:
            gets[m.group(1)] = m.group(2)
            current_key = None
            continue
        # Single-line with trailing comma
        m = re.match(r"\s*String get (\w+)\s*=>\s*'(.*?)';", line)
        if m:
            gets[m.group(1)] = m.group(2)
            current_key = None
            continue
        # Start of multi-line
        m = re.match(r"\s*String get (\w+)\s*=>$", line)
        if m:
            current_key = m.group(1)
            current_val = []
            in_multi = True
            continue
        m = re.match(r"\s*String get (\w+)\s*=>", line)
        if m:
            current_key = m.group(1)
            current_val = []
            in_multi = True
            continue
        if in_multi:
            m = re.match(r"\s*'(.*?)';\s*$", line.strip())
            if m:
                current_val.append(m.group(1))
                gets[current_key] = '\n'.join(current_val)
                current_key = None
                in_multi = False
            else:
                m2 = re.match(r"\s*'(.*?)'$", line.strip())
                if m2:
                    current_val.append(m2.group(1))
                elif line.strip() == '':
                    pass
    return gets

en_gets = extract_gets(en_lines)
fr_gets = extract_gets(fr_lines)
print(f'English strings: {len(en_gets)}')
print(f'French strings: {len(fr_gets)}')
en_keys = set(en_gets.keys())
fr_keys = set(fr_gets.keys())
print(f'Keys in en but not fr: {en_keys - fr_keys}')
print(f'Keys in fr but not en: {fr_keys - en_keys}')
common = en_keys & fr_keys
print(f'Common keys: {len(common)}')

# Save them side by side for review
with open('l10n_review.txt', 'w', encoding='utf-8') as out:
    keys_sorted = sorted(common)
    for k in keys_sorted:
        en_val = en_gets[k][:150]
        fr_val = fr_gets[k][:150]
        out.write(f'[{k}]\nEN: {en_val}\nFR: {fr_val}\n\n')
print('Saved l10n_review.txt')