import sys, re
sys.stdout.reconfigure(encoding='utf-8')

with open('app_localizations_en.dart', 'r', encoding='utf-8') as f:
    en_content = f.read()
with open('app_localizations_fr.dart', 'r', encoding='utf-8') as f:
    fr_content = f.read()

# Build simple key-to-value dict - for single-line getters only
def extract_simple(lines):
    gets = {}
    for line in lines:
        m = re.match(r"\s*String get (\w+)\s*=>\s*'(.+?)';\s*$", line)
        if m:
            gets[m.group(1)] = m.group(2)
    return gets

en_dict = extract_simple(en_content.split('\n'))
fr_dict = extract_simple(fr_content.split('\n'))

common = sorted(set(en_dict.keys()) & set(fr_dict.keys()))
print(f'Total single-line getters: EN={len(en_dict)}, FR={len(fr_dict)}, Common={len(common)}')

# Print them in batches of 20 for review
batch_size = 20
for start in range(0, len(common), batch_size):
    batch = common[start:start+batch_size]
    print(f'\n{"="*60}')
    print(f'BATCH {start//batch_size + 1} (lines {start+1}-{start+len(batch)})')
    print(f'{"="*60}')
    for k in batch:
        en_v = en_dict[k][:100].replace('\n', ' ')
        fr_v = fr_dict[k][:100].replace('\n', ' ')
        print(f'\n--- [{k}] ---')
        print(f'  EN: {en_v}')
        print(f'  FR: {fr_v}')
    print(f'\n--- End of batch {start//batch_size + 1} ---')