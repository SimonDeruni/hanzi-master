import sys, re
sys.stdout.reconfigure(encoding='utf-8')

fr = open('app_localizations_fr.dart','r',encoding='utf-8').read()

# Extract all getter values
vals = {}
# Single line
for m in re.finditer(r"String get (\w+)\s*=>\s*'([^']+)'\s*;", fr):
    vals[m.group(1)] = m.group(2)

print(f'Single-line values: {len(vals)}')

# Check for English
eng_starts = ['Please', 'Open ', 'Are you', 'What ', 'How ', 'This ', 'Type ', 'Do you', 
              "Couldn", "Don't", "Won't", "It's", "I'm", "You're", 'Would you', "Let's"]
issues_en = [(k,v) for k,v in sorted(vals.items()) 
             if any(v.startswith(s) for s in eng_starts) and len(v) > 8]

# Accent checks
accent_words = ['selection', 'ecrit', 'etait']
issues_accent = [(k,v) for k,v in sorted(vals.items())
                 if any(w in v.lower() for w in accent_words)
                 and not any(c in v for c in 'éèêëàâùûôîç')]

print(f'\nRemaining English strings: {len(issues_en)}')
for k,v in issues_en:
    print(f'  {k}: "{v}"')

print(f'\nAccent issues: {len(issues_accent)}')
for k,v in issues_accent:
    print(f'  {k}: "{v}"')

if not issues_en and not issues_accent:
    print('\n*** CLEAN: No issues found! ***')
else:
    print(f'\nTotal issues remaining: {len(issues_en) + len(issues_accent)}')