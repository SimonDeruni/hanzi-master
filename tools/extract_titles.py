import re, json

with open(r'lib\features\media\data\repositories\shows_data.dart', encoding='utf-8') as f:
    text = f.read()

lines = text.split('\n')
titles = []
for i, line in enumerate(lines):
    if "'id': 'PL" in line:
        m = re.search(r"'title': '(.+)'", lines[i + 1])
        if m:
            titles.append(m.group(1))

print(f"Found {len(titles)} show titles")
with open('show_titles.txt', 'w', encoding='utf-8') as f:
    for i, t in enumerate(titles, 1):
        f.write(f"{i:03d}. {t}\n")
print("Written to show_titles.txt")