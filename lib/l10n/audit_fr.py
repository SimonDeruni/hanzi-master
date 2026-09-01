import sys, re
sys.stdout.reconfigure(encoding='utf-8')

fr = open('app_localizations_fr.dart','r',encoding='utf-8').read()

# Find ALL getter values (single and multi-line)
vals = {}
# Single line
for m in re.finditer(r"String get (\w+)\s*=>\s*'([^']+)'\s*;", fr):
    vals[m.group(1)] = m.group(2)
# Simple multi-line (value on next line)
current_key = None
current_val_parts = []
for line in fr.split('\n'):
    m1 = re.match(r'\s+String get (\w+)\s*=>', line)
    if m1:
        current_key = m1.group(1)
        current_val_parts = []
        rest = line.split('=>')[1].strip() if '=>' in line else ''
        if rest.startswith("'") and not rest.endswith(';'):
            current_val_parts = [rest[1:]]
        elif rest.startswith("'"):
            # full value on same line - already caught above
            current_key = None
        continue
    if current_key:
        stripped = line.strip()
        if stripped.endswith(';'):
            if stripped.startswith("'"):
                current_val_parts.append(stripped[1:-2])
            elif stripped.endswith("';"):
                current_val_parts.append(stripped[:-2])
            full = ''.join(current_val_parts)
            vals[current_key] = full
            current_key = None
        elif stripped.startswith("'"):
            current_val_parts.append(stripped[1:-1] if stripped.endswith("'") else stripped[1:])
        else:
            current_val_parts.append(stripped)

print(f'Total values extracted: {len(vals)}')

# English patterns
eng_starts = ['Please', 'Open ', 'Are you', 'What ', 'How ', 'This ', 'Type ', 'Do you',
              "Couldn", "Don't", "Won't", "It's", "I'm", "You're", "Press ", "Your ",
              "Would you", "There ", "We'll", "Let's", "We'll"]
eng_found = []
for k, v in sorted(vals.items()):
    if any(v.startswith(s) for s in eng_starts) and len(v) > 8:
        en_keywords = ['the', 'your', 'my', 'you', 'are', 'this', 'what', 'how', 'please', 'will', 'would', 'could']
        if any(w in v.lower() for w in en_keywords):
            eng_found.append(f'{k} -> "{v}"')

if eng_found:
    print(f'\nPossible English strings ({len(eng_found)}):')
    for e in eng_found:
        print(f'  {e}')
else:
    print('\nNo English strings detected!')

# Check for selection/seleccionne without accent
accent_issues = []
for k, v in sorted(vals.items()):
    if 'selection' in v.lower() and 'sélection' not in v.lower():
        accent_issues.append(f'{k}: "selection" -> "sélection": "{v}"')

if accent_issues:
    print(f'\nAccent issues ({len(accent_issues)}):')
    for a in accent_issues:
        print(f'  {a}')
else:
    print('No accent issues detected!')

print('\nFinal audit complete.')