import re

with open('lib/features/media/data/repositories/shows_data.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Find all entries (each is a map block between { and },)
entries = re.findall(r'\{\s*\n\s*\'id\':.*?\n\s*\},', content, re.DOTALL)

total_before = len(entries)
# Filter out entries with episodeCount of 0, 1, 2, or 3
filtered = [e for e in entries if not re.search(r"'episodeCount':\s*([0-3])\b", e)]

print(f'Before: {total_before} entries')
print(f'After: {len(filtered)} entries')
print(f'Removed: {total_before - len(filtered)} entries')

# Rebuild the file
# Find the header (everything before the first entry)
first_entry_start = content.find(entries[0])
header = content[:first_entry_start]

# Find the footer (everything after the last entry)
last_entry_end = content.find(entries[-1]) + len(entries[-1])
footer = content[last_entry_end:]

# Build new content
new_data = ',\n'.join(filtered)
new_content = header + new_data + footer

# Update the total count in the comment
new_content = re.sub(r'// Total: will be filled after generation', f'// Total: {len(filtered)} shows (filtered, episodeCount > 3)', new_content)

with open('lib/features/media/data/repositories/shows_data.dart', 'w', encoding='utf-8') as f:
    f.write(new_content)

print('File updated successfully.')