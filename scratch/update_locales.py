import pathlib, re

base = pathlib.Path('lib/l10n')

for fname in sorted(base.glob('app_localizations_*.dart')):
    lang = fname.stem.split('_')[-1]
    content = fname.read_text(encoding='utf-8')
    
    # Find the current string for geminiFlashIsStructuring
    m = re.search(r"geminiFlashIsStructuring\s*=>\s*\n\s*'([^']*)'", content)
    if m:
        old = m.group(1)
        if 'Gemini Flash' in old:
            print(f'{lang}: "{old}"')
        else:
            print(f'{lang}: ALREADY OK - "{old}"')
    else:
        print(f'{lang}: PARSE FAILED')

print('Done - investigation')