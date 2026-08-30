import json, sys

sys.stdout.reconfigure(encoding='utf-8')

with open(r'C:\Users\simon\Documents\hanzi_master\lib\l10n\all_hardcoded_strings.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

print(f'Files: {len(data["files"])}')
print(f'Total strings: {sum(len(fi["strings"]) for fi in data["files"])}')

top = sorted(data['files'], key=lambda x: len(x['strings']), reverse=True)[:15]
print('\nTop 15 files by string count:')
for t in top:
    print(f'  {t["path"]}: {len(t["strings"])} strings')
    for s in t['strings'][:3]:
        print(f'    L{s["line"]}: {repr(s["text"][:120])}')
    print()