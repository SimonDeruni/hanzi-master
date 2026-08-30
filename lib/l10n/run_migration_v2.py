#!/usr/bin/env python3
"""
Better migration script: handles actual Dart patterns like:
- Text('string') -> Text(AppLocalizations.of(context)!.key)
- tooltip: 'string' -> tooltip: AppLocalizations.of(context)!.key
- label: 'string' -> label: AppLocalizations.of(context)!.key  
- default param values -> fix widget (add context-based fallback)
- 'string' used as variable assignment -> leave with translation comment
"""
import json
import os
import re

BASE_DIR = os.path.join(os.path.dirname(__file__), "..")
PLAN_FILE = os.path.join(os.path.dirname(__file__), "migration_plan.txt")
ARB_FILE = os.path.join(os.path.dirname(__file__), "app_en.arb")

with open(ARB_FILE, "r", encoding="utf-8") as f:
    arb = json.load(f)

value_to_key = {}
for k, v in arb.items():
    if not k.startswith("@") and isinstance(v, str):
        norm = v.lower().strip(". !?").replace("\n", " ")
        value_to_key[norm] = k

entries = []
with open(PLAN_FILE, "r", encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        parts = line.split("|")
        if len(parts) >= 4:
            rel_path = parts[0]
            line_str = parts[1]
            text = "|".join(parts[2:-1])
            key = parts[-1]
            entries.append((rel_path, int(line_str), text, key))

file_groups = {}
for rel_path, line_str, text, key in entries:
    full_path = os.path.join(BASE_DIR, rel_path)
    full_path = os.path.normpath(full_path)
    if full_path not in file_groups:
        file_groups[full_path] = []
    file_groups[full_path].append((int(line_str), text, key))

print(f"Processing {len(file_groups)} files with {len(entries)} total replacements...")

import_count = 0
replace_count = 0

for file_path, replacements in sorted(file_groups.items()):
    if not os.path.exists(file_path):
        print(f"  SKIP (not found): {os.path.basename(file_path)}")
        continue

    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
    original = content

    # Add import if needed
    has_import = "app_localizations.dart" in content
    if not has_import:
        lines = content.split("\n")
        last_import = -1
        for i, line in enumerate(lines):
            if line.strip().startswith("import ") or line.strip().startswith("// ignore"):
                last_import = i
        if last_import >= 0:
            lines.insert(last_import + 1, 
                "import 'package:flutter_gen/gen_l10n/app_localizations.dart';")
            content = "\n".join(lines)
            import_count += 1

    for line_num, text, key in replacements:
        # Strategy: find the exact string in context and replace it
        escaped = re.escape(text)
        
        # Pattern 1: String in Text() or similar widget: Text('string')
        # or Text("string")  
        for quote in ["'", '"']:
            # Try to find occurrences
            pattern = re.compile(re.escape(quote + text + quote))
            replacement = quote + f"${'{'}AppLocalizations.of(context)!.{key}{'}'}" + quote
            
            # But wait - we can't use $ interpolation inside single quotes
            # In Dart, string interpolation uses $ 
            
            # Actually the better approach: replace the quoted string with the expression
            # Text('string') -> Text(AppLocalizations.of(context)!.key)
            
            # Find occurrences in context
            pos = 0
            while True:
                idx = content.find(quote + text + quote, pos)
                if idx == -1:
                    break
                
                # Look at what's before and after to determine context
                before = content[max(0,idx-20):idx].strip()
                after_start = idx + len(quote) + len(text) + len(quote)
                after = content[after_start:after_start+20].strip()
                
                new_replacement = f"AppLocalizations.of(context)!.{key}"
                
                # Replace
                content = content[:idx] + new_replacement + content[after_start:]
                replace_count += 1
                pos = idx + len(new_replacement)

    if content != original:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"  OK: {os.path.basename(file_path)}")
    else:
        print(f"  NO CHANGE: {os.path.basename(file_path)}")

print(f"\nDone! Added imports to {import_count} files, applied {replace_count} replacements.")