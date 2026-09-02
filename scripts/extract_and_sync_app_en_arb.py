import os
import re
import json
import sys

sys.stdout.reconfigure(encoding='utf-8')

ARB_PATH = 'lib/l10n/app_en.arb'

IGNORE_DIRS = {'l10n', 'generated', '.dart_tool', 'assets'}
IGNORE_FILES = {'app_localizations', '.g.dart', '_test.dart', 'firebase_options.dart', 'firebase_options_prod.dart', 'firebase_options_dev.dart'}

TECHNICAL_PATTERNS = [
    r'^[a-z]{2,3}-[A-Z]{2}',
    r'^[A-Z0-9_-]{15,}$',
    r'^[a-zA-Z0-9_\-\.\/]+\.[a-zA-Z0-9]{2,4}$',
    r'^(GET|POST|PUT|DELETE|OPTIONS|HEAD)$',
    r'^(true|false|null|undefined|void)$',
    r'^[A-Z][a-zA-Z0-9_]+Exception',
    r'^[A-Z][a-zA-Z0-9_]+Error',
    r'^[a-z]+[A-Z][a-zA-Z0-9]*$',
    r'^[A-Z][a-z0-9]+([A-Z][a-z0-9]+)+$',
    r'^[a-z0-9_]+$',
    r'^[A-Z0-9_]+$',
]

def is_clean_ui_string(s):
    s_clean = s.strip()
    if len(s_clean) < 3 or len(s_clean) > 300:
        return False
        
    # Skip technical terms
    if any(sig in s_clean for sig in [
        'http://', 'https://', 'package:', 'lib/', 'com.', 'AIza', 'Bearer ', 
        'application/', 'text/plain', 'SELECT ', 'INSERT INTO', 'PRAGMA ', 
        'CREATE TABLE', 'DROP TABLE', 'FIRAuth', 'Firebase', 'StoreKit',
        '0123456789', 'BEGIN PRIVATE KEY', 'END PRIVATE KEY', 'gzip', 'deflate',
        'Content-Type', 'User-Agent', 'Authorization', 'apiKey', 'projectId',
        'appId', 'messagingSenderId', 'measurementId', 'storageBucket',
        'authDomain', 'databaseURL', 'androidClientId', 'iosClientId',
        '\\', '=>', '==', '!=', '&&', '||', ';', 'void ', 'const ',
        '${', '{', '}', '[', ']', '<', '>', '(', ')'  # Avoid code interpolations & syntax
    ]):
        return False
        
    # Skip if contains '$' unless it's followed by digit ($9.99)
    if '$' in s_clean and not re.search(r'\$\d', s_clean):
        return False
        
    for tp in TECHNICAL_PATTERNS:
        if re.match(tp, s_clean):
            return False
            
    # Must have alphabetic words
    words = re.findall(r'[a-zA-Z]{2,}', s_clean)
    if not words:
        return False
        
    has_space = ' ' in s_clean
    has_punct = any(p in s_clean for p in ['!', '?', '.', ',', ':', '—', '–', '-', "'", '"', '…', '✨', '🚀', '⚡', '📚', '🎨', '🎯', '🎲', '❤️', '💡', '🌟', '🔔', '🔒', '👑', '🔥'])
    is_standalone_title = s_clean[0].isupper() and len(s_clean) >= 4 and not re.search(r'[A-Z][a-z]+[A-Z]', s_clean)
    
    return has_space or has_punct or is_standalone_title

def make_arb_key(s):
    cleaned = re.sub(r'[^a-zA-Z0-9 ]', ' ', s)
    words = [w for w in cleaned.split() if w][:5]
    if not words:
        return 'label'
    key = words[0][0].lower() + words[0][1:]
    for w in words[1:]:
        if w:
            key += w[0].upper() + w[1:]
    key = re.sub(r'[^a-zA-Z0-9]', '', key)
    if not key or not key[0].isalpha():
        key = 'label' + key
    return key[:40]

# 1. Read base clean ARB
with open(ARB_PATH, 'r', encoding='utf-8') as f:
    arb_data = json.load(f)

base_keys = {k: v for k, v in arb_data.items() if not k.startswith('@')}
existing_values = {v.strip() for v in base_keys.values() if isinstance(v, str)}
existing_keys = set(base_keys.keys())

STRING_PATTERN = re.compile(r'(?<!\\)(?:"""(.*?)"""|\'\'\'(.*?)\'\'\'|"((?:[^"\\]|\\.)*)"|\'((?:[^\'\\]|\\.)*)\')', re.DOTALL)

found_strings = {}

for root, dirs, files in os.walk('lib'):
    dirs[:] = [d for d in dirs if d not in IGNORE_DIRS]
    for fname in files:
        if not fname.endswith('.dart') or any(ign in fname for ign in IGNORE_FILES):
            continue
        fpath = os.path.join(root, fname)
        rel_path = fpath.replace('lib' + os.sep, '').replace('lib/', '')
        
        with open(fpath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
            
        lines = content.split('\n')
        for i, line in enumerate(lines, 1):
            stripped = line.strip()
            if stripped.startswith('//') or stripped.startswith('*') or stripped.startswith('/*'):
                continue
            if 'print(' in stripped or 'debugPrint(' in stripped or 'log(' in stripped:
                continue
                
            for match in STRING_PATTERN.finditer(line):
                raw_match = match.group(1) or match.group(2) or match.group(3) or match.group(4)
                if not raw_match:
                    continue
                cleaned = raw_match.replace('\\"', '"').replace("\\'", "'").replace('\\\\', '\\').strip()
                if is_clean_ui_string(cleaned):
                    if cleaned not in existing_values and cleaned not in found_strings:
                        found_strings[cleaned] = (rel_path, i, make_arb_key(cleaned))

print(f"🎯 Discovered {len(found_strings)} pure clean untranslated English UI Strings!\n")

to_inject = {}
for s, (f, ln, base_key) in found_strings.items():
    key = base_key
    counter = 2
    while key in existing_keys or key in to_inject:
        key = f"{base_key}{counter}"
        counter += 1
    to_inject[key] = s

print(f"💾 Adding {len(to_inject)} new UI strings into {ARB_PATH}...")
for k, v in to_inject.items():
    arb_data[k] = v

with open(ARB_PATH, 'w', encoding='utf-8') as f:
    json.dump(arb_data, f, ensure_ascii=False, indent=2)
    f.write('\n')

print(f"✅ Total keys in app_en.arb is now: {len(arb_data)}")
