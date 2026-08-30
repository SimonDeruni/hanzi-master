import json, re, os

BASE_DIR = r'C:\Users\simon\Documents\hanzi_master\lib\l10n'

# Load the key mapping
with open(os.path.join(BASE_DIR, 'key_mapping.json'), 'r', encoding='utf-8') as f:
    key_mapping = json.load(f)

# Now let's identify the ones that still have issues and need better filtering or keys
# The problematic ones to fix:

issues = {
    '\u00e2\u20ac\u00a2': None,  # corrupted bullet - skip
    'Mastery': 'mastery',
    'Rescind': 'rescind',
    'Removed': 'removed',
    'Library': 'library',
    'Reviewing your tones...': 'reviewingYourTones',
    'CC': 'cc',
    'Speaker': 'speaker',
    'Play $pinyinWithTone': None,  # has variable, skip
    'Add to': 'addTo',
    'Create New Deck': 'createNewDeck',
    'Search characters...': 'searchCharactersHint',
    'You need to spend at least one second recording to submit your drawing': 'needOneSecondRecordingToSubmit',
    'Your path for': None,  # has Dart interpolation
    ').first})': None,  # code fragment
    'No results found for': None,  # has Dart interpolation
    'Added $char to Review Queue': None,  # has Dart interpolation
    'Etymology: $char': None,  # has Dart interpolation
    'HSK $hskLevel': None,  # has Dart interpolation
    'Added to your Library': 'addedToYourLibrary',
    'Ask about': 'askAbout',
    'Review in': 'reviewIn',
    'Bookmark removed': 'bookmarkRemoved',
    'Added:': 'added',  # fragment
    'Table of Contents \u00b7 \u76ee\u5f55 (': None,  # mixed Chinese/English fragment
    'Chapters)': None,  # continuation of above
    '": null': None,  # code
    '": null,': None,  # code
    '":"': None,  # code
    'https://www.bbc.com/zhongwen/simp': None,  # URL
    '"$_transcription"': None,  # variable
    '} ${comp.hanzi}...': None,  # code
    '} ${comp.hanzi}...\n                                    ': None,  # code
    'Saving ${wordsToAdd.length} words to ${deck.name}...': None,  # variables
    'Added ${cards.length} cards to "$_selectedDeckName".': None,  # variables
    'Ask about ${widget.hanzi}...': None,  # variables
    "\"Added '$hanzi' to your Library\"": None,  # has single quotes in double quotes, code
}

# Filter out None entries (should not be translated)
cleaned_mapping = {}
skipped = []
for text, key in key_mapping.items():
    if text in issues:
        if issues[text] is None:
            skipped.append(text)
            continue
        else:
            cleaned_mapping[text] = issues[text]
            continue
    # Check for text that got incorrectly included
    # Fragments
    if len(text) < 2:
        skipped.append(text)
        continue
    if text in {'\u00e2\u20ac\u00a2'}:
        skipped.append(text)
        continue
    # Mixed Chinese/English fragments
    if '\u76ee\u5f55' in text or '\u4e66\u7b7e' in text or '\u5df2\u6dfb\u52a0' in text:
        skipped.append(text)
        continue
    # Variable interpolation
    if '${' in text or '$_' in text or '$char' in text or '$hskLevel' in text:
        skipped.append(text)
        continue
    if text.startswith('\\"') or '\\"$' in text:
        skipped.append(text)
        continue
    # Code fragments
    if text in {'": null', '": null,', '":"', ').first})'}:
        skipped.append(text)
        continue
    cleaned_mapping[text] = key_mapping[text]

print(f'Original: {len(key_mapping)}')
print(f'Cleaned: {len(cleaned_mapping)}')
print(f'Skipped: {len(skipped)}')
print(f'Skipped items: {skipped}')

# Save cleaned mapping
with open(os.path.join(BASE_DIR, 'key_mapping_clean.json'), 'w', encoding='utf-8') as f:
    json.dump(cleaned_mapping, f, ensure_ascii=False, indent=2)

print(f'\nCleaned mapping saved with {len(cleaned_mapping)} entries')

# Print final list for verification
print('\n=== FINAL UNTRANSLATED STRINGS ===')
for i, (text, key) in enumerate(cleaned_mapping.items()):
    print(f'{i+1}. [{key}] {repr(text)}')
