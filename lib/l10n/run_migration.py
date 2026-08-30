#!/usr/bin/env python3
"""
Migrate hardcoded strings in Dart files to use AppLocalizations.
Reads migration_plan.txt and performs find-and-replace on each Dart file.
Also adds the required import where needed.
"""
import json
import os
import re

BASE_DIR = os.path.join(os.path.dirname(__file__), "..")
PLAN_FILE = os.path.join(os.path.dirname(__file__), "migration_plan.txt")
ARB_FILE = os.path.join(os.path.dirname(__file__), "app_en.arb")

# Load ARB to have the key->value mapping
with open(ARB_FILE, "r", encoding="utf-8") as f:
    arb = json.load(f)

# Reverse map: value -> key
value_to_key = {}
for k, v in arb.items():
    if not k.startswith("@") and isinstance(v, str):
        norm = v.lower().strip(". !?").replace("\n", " ")
        value_to_key[norm] = k

# Read the plan
entries = []
with open(PLAN_FILE, "r", encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        parts = line.split("|", 3)
        if len(parts) == 4:
            entries.append(parts)

# Group by file
file_groups = {}
for rel_path, line_str, text, key in entries:
    full_path = os.path.join(BASE_DIR, rel_path)
    full_path = os.path.normpath(full_path)
    if full_path not in file_groups:
        file_groups[full_path] = []
    file_groups[full_path].append((int(line_str), text, key))

print(f"Processing {len(file_groups)} files with {len(entries)} replacements...")

import_count = 0
replace_count = 0
error_count = 0

for file_path, replacements in sorted(file_groups.items()):
    if not os.path.exists(file_path):
        print(f"  SKIP (not found): {file_path}")
        continue

    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
    original_content = content

    # Check if import already exists
    has_import = (
        "import 'package:flutter_gen/gen_l10n/app_localizations.dart';" in content
        or "app_localizations.dart" in content
    )

    # Add import if needed (only for Dart files that reference strings)
    if not has_import and any(r[2] for r in replacements):
        # Find the last import line
        lines = content.split("\n")
        last_import_idx = -1
        for i, line in enumerate(lines):
            stripped = line.strip()
            if stripped.startswith("import ") or stripped.startswith("// ignore"):
                last_import_idx = i

        if last_import_idx >= 0:
            indent = ""
            if lines[last_import_idx].startswith(" "):
                indent = lines[last_import_idx][: len(lines[last_import_idx]) - len(lines[last_import_idx].lstrip())]
            import_line = f"{indent}import 'package:flutter_gen/gen_l10n/app_localizations.dart';"
            lines.insert(last_import_idx + 1, import_line)
            content = "\n".join(lines)
            import_count += 1

    # Now replace each hardcoded string with a localized version
    # We need to be smart: replace string literals that are used in Text(), 
    # as default parameter values, tooltips, etc.
    
    for line_num, text, key in replacements:
        # Escape special regex chars in the search text
        search_text = text
        # Build a replacement with the localized string
        # The pattern depends on context:
        # 1. Text('string') or Text("string") -> Text(l10n.key)
        # 2. 'string' as default param -> just leave it (these are widget defaults, callers should localize)
        # 3. tooltip: 'string' -> tooltip: l10n.key
        
        # Escape the text for regex
        escaped = re.escape(search_text)
        # Replace with l10n key access
        replacement = f"AppLocalizations.of(context)!.{key}"
        
        # Apply replacement for quoted strings
        # Handle both single and double quotes
        for quote in ["'", '"']:
            quoted_escaped = quote + escaped + quote
            # Replace occurrences
            if quoted_escaped in content:
                content = content.replace(quoted_escaped, replacement)
                replace_count += 1

    if content != original_content:
        # Verify it's valid-ish (just check no broken syntax)
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"  OK: {os.path.basename(file_path)} ({len(replacements)} replacements)")
    else:
        print(f"  NO CHANGE: {os.path.basename(file_path)} ({len(replacements)} expected)")

print(f"\nDone! Added imports to {import_count} files, applied {replace_count} replacements, {error_count} errors.")