import sys, re
sys.stdout.reconfigure(encoding='utf-8')

with open('app_localizations_en.dart', 'r', encoding='utf-8') as f:
    en = f.read()
with open('app_localizations_fr.dart', 'r', encoding='utf-8') as f:
    fr = f.read()

# Build dict of key->value for single-line getters
en_d = {}
fr_d = {}
for line in en.split('\n'):
    m = re.match(r'String get (\w+)\s*=>\s*(.+);', line)
    if m:
        val = m.group(2).strip()
        if val.startswith("'") and val.endswith("'"):
            en_d[m.group(1)] = val[1:-1]
for line in fr.split('\n'):
    m = re.match(r'String get (\w+)\s*=>\s*(.+);', line)
    if m:
        val = m.group(2).strip()
        if val.startswith("'") and val.endswith("'"):
            fr_d[m.group(1)] = val[1:-1]

common = sorted(set(en_d.keys()) & set(fr_d.keys()))
print(f'Single-line getters: en={len(en_d)}, fr={len(fr_d)}, common={len(common)}')
eng_starters = ['Please', 'Review', 'Open', 'What ', 'How ', 'This ', 'Feature', 'Error ', 'Failed', 'No ', 'Point ',
                'Practice', 'Preferences', 'Preparing', 'Remove', 'Saving', 'Search', 'Select', 'Simple', 'Statistics',
                'Table ', 'Shadowing', 'To Be', 'Traditional', 'Translation', 'Type ', 'Unable', 'Speak',
                'Are you', 'Added', 'Add to', 'Build', 'Calligraphy', 'Cancel', 'Chapters', 'Chinese', 'Contact',
                'Created', 'Custom', 'Display', 'Do you', 'Elementary', 'Etymology', 'Explain', 'Extract', 'Figure',
                'Font ', 'Generate', 'Grammar', 'Handwriting', 'Hearing', 'Hide', 'History', 'Home', 'Identify',
                'Import ', 'Integrations', 'Intermediate', 'Introduction', 'Japanese', 'Join', 'Journal', 'Just now',
                'Kanji', 'Language', 'Last ', 'Later', 'Launch', 'Learn', "Let's", 'Listening', 'Load',
                'Loading', 'Local', 'Log ', 'Look ', 'Make', 'Manage', 'Matching', 'Master', 'Media', 'Member',
                'Memo', 'Menu', 'Merge', 'Message', 'Microphone', 'Mobile', 'Model', 'Monday', 'Month',
                'More', 'Move', 'Movie', "My ", 'Name', 'Native', 'Navigate', 'Need', 'Network', 'Never',
                'New ', 'News', 'Next ', 'Night', 'No thanks', 'Normal', 'Note', 'Nothing', 'Notice',
                'Notification', 'Now', 'Number', 'OCR', 'OK', 'Once', 'Only', 'Open', 'Option',
                'Optional', 'Order', 'Other', 'Outline', 'Overview', 'Page', 'Paid', 'Paper',
                'Paraphrase', 'Paraphrasing', 'Part', 'Particular', 'Password', 'Paste', 'Path', 'Pause',
                'Pending', 'Perfect', 'Phone', 'Phonetic', 'Pinyin', 'Plan', 'Play', 'Playback', 'Please',
                'Pocket', 'Poetry', 'Polish', 'Pop-up', 'Portuguese', 'Practice', 'Premium', 'Preparing',
                'Press ', 'Preview', 'Previous', 'Privacy', 'Pro', 'Processing', 'Proficiency', 'Progress',
                'Pronunciation', 'Propose', 'Publish', 'Purchase', 'Quick', 'Quiz', 'Radical', 'Random',
                'Rate', 'Read', 'Reading', 'Ready', 'Recent', 'Recolor', 'Recover', 'Redo', 'Refine',
                'Reload', 'Remaining', 'Remind', 'Remove', 'Rename', 'Repeat', 'Replace', 'Report', 'Request',
                'Reset', 'Restore', 'Result', 'Resume', 'Retry', 'Review', 'Romanization', 'Russian',
                'Saturday', 'Save', 'Scholar', 'Score', 'Screenshot', 'Search', 'See', 'Select',
                'Send', 'Sentence', 'Setup', 'Shadowing', 'Shake', 'Share', 'Show', 'Shuffle', 'Sign',
                'Simple', 'Simplified', 'Skip', 'Slow', 'Smart', 'Smooth', 'Sort', 'Source', 'Spanish',
                'Speak', 'Speaking', 'Speech', 'Speed', 'Spelling', 'Spoken', 'Standard', 'Start',
                'Statistics', 'Stats', 'Status', 'Step', 'Stop', 'Storage', 'Store', 'Story', 'Streak',
                'Street', 'Strict', 'Stroke', 'Strong', 'Structure', 'Student', 'Study', 'Subject',
                'Subscription', 'Subtitle', 'Success', 'Suggestion', 'Summary', 'Sunday', 'Support',
                'Switch', 'Syllable', 'System', 'Table', 'Tag', 'Tap', 'Target', 'Text',
                'Theme', 'Then', 'There', 'This', 'Thursday', 'Time', 'Tip', 'Title', 'Today',
                'Toggle', 'Tone', 'Topic', 'Total', 'Trace', 'Traditional', 'Traffic', 'Train',
                'Transcribe', 'Transfer', 'Translate', 'Translation', 'Translator', 'Travel', 'Trial',
                'Trouble', 'True', 'Trust', 'Try', 'Tuesday', 'Turkish', 'Tutorial', 'Type',
                'Unable', 'Undo', 'Unfamiliar', 'Unlimited', 'Unlock', 'Update', 'Upgrade', 'Use',
                'Useful', 'User', 'Verb', 'Version', 'Video', 'Vietnamese', 'View', 'Vocabulary',
                'Voice', 'Volume', 'Wait', 'Warning', 'Wednesday', 'Welcome', 'What ', 'Where',
                'Which', 'Whisper', 'Why', 'Window', 'Word', 'Work', 'Write', 'Wrong',
                'Yearly', 'Yes', 'You', 'Your', "Couldn't", "Don't", "Won't", "It's", "I'm"]

issues = []
for k in common:
    en_v = en_d[k]
    fr_v = fr_d[k]
    has_accent = lambda s: sum(1 for c in s if c in 'éèêëàâùûôîçäëïüö')

    if any(fr_v.startswith(w) for w in eng_starters):
        if len(fr_v) > 5 and not has_accent(fr_v) > 0:
            whitelist = ['Wikipedia', 'Open Source', 'Premium', 'Mandarin', 'Mandarin Blueprint',
                        'Pocket SRS', 'Scholar Verdict', "Scholar's Verdict", 'SinoSpark Premium',
                        'Shadowing', 'Kanji Damage', 'Kanji', 'Hiragana', 'Katakana']
            if fr_v not in whitelist and not any(fr_v.startswith(x) for x in ['HSK ', 'HSK\n']):
                issues.append(f'{k}: ANGLAIS? "{fr_v[:80]}" <- "{en_v[:80]}"')

    fr_lower = fr_v.lower()
    if 's\xfbr le' in fr_lower:
        issues.append(f'{k}: "s\xfbr"->"sur": "{fr_v[:80]}"')
    if 'par\xf4le' in fr_lower:
        issues.append(f'{k}: "par\xf4le"->"parole": "{fr_v[:80]}"')
    if '\xe0 v\xf4tre' in fr_lower or 'de v\xf4tre' in fr_lower:
        issues.append(f'{k}: "v\xf4tre"->"votre": "{fr_v[:80]}"')
    if 'vous parl\xe9z' in fr_lower:
        issues.append(f'{k}: "parl\xe9z"->"parlez": "{fr_v[:80]}"')
    if 'selection' in fr_v and 's\xe9lection' not in fr_v:
        issues.append(f'{k}: "selection"->"s\xe9lection": "{fr_v[:80]}"')
    if 'se termin\xe9 ' in fr_lower or 'se termin\xe9!' in fr_lower:
        issues.append(f'{k}: "se termin\xe9"->"se termine": "{fr_v[:80]}"')
    if 'planifie' in fr_v:
        issues.append(f'{k}: "planifie" -> v\xe9rifier: "{fr_v[:80]}"')

print(f'\nIssues found: {len(issues)}')
for i in issues:
    print(i)