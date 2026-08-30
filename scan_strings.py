import os, re, json

root = r'C:\Users\simon\Documents\hanzi_master\lib'
skip_dirs = {'l10n'}
skip_files = {'firebase_options.dart'}
output_path = r'C:\Users\simon\Documents\hanzi_master\lib\l10n\all_hardcoded_strings.json'

# Only capture strings that DIRECTLY appear in UI-displaying widgets
# This avoids capturing data map keys, JSON keys, etc.
# We look for specific patterns that indicate a string is being used as visible text:

# Pattern 1: Text('...') or Text("...") at the start of a widget child
# Pattern 2: Named parameters that display text: hintText:, label:, tooltip:, etc.
# Pattern 3: title/subtitle/message/content as named params in dialogs, etc.
# Pattern 4: Button text as child of TextButton/ElevatedButton/etc.

# Core UI patterns - these definitively indicate a string is displayed
UI_PATTERN_TERMS = [
    # Direct Text widget usage
    r'Text\s*\(\s*[\'"]',           # Text('...' or Text("...")
    # Named parameters for displayed text
    r'hintText\s*:\s*[\'"]',
    r'labelText\s*:\s*[\'"]',
    r'helperText\s*:\s*[\'"]',
    r'errorText\s*:\s*[\'"]',
    r'tooltip\s*:\s*[\'"]',
    r'semanticLabel\s*:\s*[\'"]',
    # Dialog/Sheet properties
    r"['\"]title['\"]\s*:\s*['\"]",
    r"['\"]message['\"]\s*:\s*['\"]",
    # SnackBar content
    r"SnackBar\s*\(\s*content\s*:\s*Text\s*\(\s*['\"]",
]

# Combined pattern
ui_pattern = re.compile('|'.join(UI_PATTERN_TERMS), re.IGNORECASE)

# Also scan for hardcoded strings in widget-building code without UI context markers
# but ensure they look like actual UI text
def looks_like_ui_text(text):
    """Heuristic: UI text usually has spaces, is longer, or has Chinese chars"""
    if len(text) < 2:
        return False
    # Pure identifiers (no spaces, all ASCII) shorter than 5 chars are likely variable names
    if re.match(r'^[a-zA-Z_][a-zA-Z0-9_]*$', text) and len(text) < 5:
        return False
    # Single English word identifiers
    if re.match(r'^[a-z][a-z0-9]*$', text) and len(text) < 8:
        return False
    # Has space or Chinese characters = UI text
    if ' ' in text or re.search(r'[\u4e00-\u9fff\u3400-\u4dbf]', text):
        return True
    # Longer text = likely UI
    if len(text) > 20:
        return True
    # Has punctuation typical of sentences
    if re.search(r'[.!?，。！？、]', text):
        return True
    return False

results = []

for dirpath, dirnames, filenames in os.walk(root):
    dirnames[:] = [d for d in dirnames if d not in skip_dirs]
    for f in sorted(filenames):
        if f.endswith('.g.dart') or f in skip_files:
            continue
        full = os.path.join(dirpath, f)
        rel = os.path.relpath(full, root).replace('\\', '/')
        rel_full = 'lib/' + rel

        try:
            with open(full, 'r', encoding='utf-8', errors='replace') as fh:
                content = fh.read()
        except Exception as e:
            print(f"Error reading {full}: {e}")
            continue

        lines = content.split('\n')
        file_strings = []

        for ln_idx, line in enumerate(lines):
            line_num = ln_idx + 1
            stripped = line.strip()

            if stripped.startswith('//') or stripped.startswith('*') or stripped.startswith('/*'):
                continue
            if stripped.startswith('import ') or stripped.startswith('export '):
                continue
            if 'AppLocalizations.of' in line or '.tr(' in line:
                continue
            if re.search(r'\b(debugPrint|print|logger\.|log\.)\(', line, re.IGNORECASE):
                continue

            has_ui = bool(ui_pattern.search(line))
            if not has_ui:
                # Check if line looks like it's in a UI context with string
                if not re.search(r'(child|children|title|subtitle|label|content):\s*[\'"]', line):
                    continue

            # Extract single-quoted strings
            for m in re.finditer(r"'([^'\\]*(?:\\.[^'\\]*)*)'", line):
                text = m.group(1)
                text = text.replace("\\'", "'").replace('\\"', '"').replace('\\\\', '\\')
                if not text or not text.strip():
                    continue
                if re.match(r'^\d+(\.\d+)?$', text):
                    continue
                if text.startswith('http') or text.startswith('package:') or text.startswith('assets/'):
                    continue
                # Apply heuristic
                if not has_ui and not looks_like_ui_text(text):
                    continue
                file_strings.append({'line': line_num, 'text': text})

            # Extract double-quoted strings
            for m in re.finditer(r'"([^"\\]*(?:\\.[^"\\]*)*)"', line):
                text = m.group(1)
                text = text.replace("\\'", "'").replace('\\"', '"').replace('\\\\', '\\')
                if not text or not text.strip():
                    continue
                if re.match(r'^\d+(\.\d+)?$', text):
                    continue
                if text.startswith('http') or text.startswith('package:') or text.startswith('assets/'):
                    continue
                if not has_ui and not looks_like_ui_text(text):
                    continue
                file_strings.append({'line': line_num, 'text': text})

        if file_strings:
            results.append({'path': rel_full, 'strings': file_strings})

output = {'files': results}
with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(output, f, ensure_ascii=False, indent=2)

total_strings = sum(len(r['strings']) for r in results)
print(f'Total files with hardcoded strings: {len(results)}')
print(f'Total string entries: {total_strings}')
print(f'Output written to: {output_path}')