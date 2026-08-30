#!/usr/bin/env python3
"""Identify the distinct shows from raw titles and prepare for bulk summary generation."""
import re, os

base = os.path.dirname(os.path.abspath(__file__))
shows_path = os.path.normpath(os.path.join(base, '..', 'lib', 'features', 'media', 'data', 'repositories', 'shows_data.dart'))
summary_path = os.path.normpath(os.path.join(base, '..', 'lib', 'features', 'media', 'data', 'repositories', 'show_summaries.dart'))

existing = set()
if os.path.exists(summary_path):
    with open(summary_path, encoding='utf-8') as f:
        for line in f:
            m = re.search(r"^  '([^']+)':", line)
            if m:
                existing.add(m.group(1))

with open(shows_path, encoding='utf-8') as f:
    text = f.read()
lines = text.split('\n')
raw_titles = []
i = 0
while i < len(lines):
    line = lines[i]
    if "'id': 'PL" in line:
        title_match = re.search(r"'title':\s*'([^']+)'", lines[i+1])
        title = title_match.group(1) if title_match else ''
        if title:
            raw_titles.append(title)
    i += 1

def canonical_name(t):
    t = t.replace('&#39;', "'").replace('&amp;', '&')
    prefixes = [
        r'^\[ENG\s*SUB\]\s*', r'^\[Get APP Now\]\s*', r'^ENGSUB\s*',
        r'^\[FULL\]\s*', r'^\[Full\]\s*', r'^\[Limited FULL\]\s*',
        r'^Members Premiere\s+',
    ]
    for p in prefixes:
        t = re.sub(p, '', t, flags=re.IGNORECASE)
    t = re.sub(r'\[.*?\]', '', t)
    t = re.sub(r'^[\u2600-\u27BF\uD800-\uDFFF\uFE00-\uFE0F\u200D\u2600-\u26FF\u2700-\u27BF]+', '', t)
    t = re.sub(r'^\W+', '', t)
    t = re.sub(r'\s*\|\s*Cast[^|]+$', '', t)
    t = re.sub(r'\s*\|\s*[A-Z][a-z]+ [A-Z][a-z]+.*$', '', t)
    t = re.sub(r'\s+\([^)]*Cast[^)]*\)\s*$', '', t, flags=re.IGNORECASE)
    t = re.sub(r'\s+Starring:.*$', '', t)
    t = re.sub(r'\s*\|\s*iQIYI.*$', '', t, flags=re.IGNORECASE)
    t = re.sub(r'\s*\|\s*YOUKU.*$', '', t, flags=re.IGNORECASE)
    t = re.sub(r'\s+Chinese Drama Full Episodes\s*$', '', t)
    t = re.sub(r'\s*/\s*EP\s+\d+[-–]\d+\s*/\s*Eng sub\s*$', '', t, flags=re.IGNORECASE)
    t = re.sub(r'\s+FULL\w*\s*$', '', t)
    t = re.sub(r'\s*In no particular order.*$', '', t)
    t = re.sub(r'\s*Join the Membership.*$', '', t)
    t = re.sub(r'\s*ENG\s*SUB\s*$', '', t, flags=re.IGNORECASE)
    t = re.sub(r'\s*ENGSUB\s*$', '', t, flags=re.IGNORECASE)
    t = t.strip()
    t = re.sub(r'[\s\u200b]+$', '', t)
    if len(t) > 80:
        m = re.match(r'^([\u4e00-\u9fff][\u4e00-\u9fff\w\s]+?)(?:\s{2,}|\s*\|\s*|\s*\(\s*)', t)
        if m:
            t = m.group(1).strip()
    return t.strip()

canonical_groups = {}
for rt in sorted(set(raw_titles)):
    c = canonical_name(rt)
    if c:
        canonical_groups.setdefault(c, []).append(rt)

covered = set()
missing_groups = {}
for c, titles in sorted(canonical_groups.items()):
    any_covered = any(t in existing for t in titles)
    if any_covered:
        covered.add(c)
    else:
        missing_groups[c] = titles

print(f"Distinct shows: {len(canonical_groups)}")
print(f"Already covered: {len(covered)}")
print(f"Still missing: {len(missing_groups)}")

out_path = os.path.join(os.path.dirname(__file__), 'missing_shows_clean.txt')
with open(out_path, 'w', encoding='utf-8') as f:
    for c in sorted(missing_groups.keys()):
        f.write(f"{c}\n")
        for rt in missing_groups[c]:
            f.write(f"  RAW: {rt}\n")
print(f"Wrote {out_path}")