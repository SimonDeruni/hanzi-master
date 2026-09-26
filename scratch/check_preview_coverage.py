"""Reports how many of the deck preview words the bundled dictionary covers.

Run from the repository root (after the deck word files exist):
    python scratch/check_preview_coverage.py

The library previews should read a word's meaning from dictionary.db in the
user's language rather than from hardcoded English, so this checks that the
store really covers the words the previews show, per language.

Output is deliberately ASCII so it survives a Windows console.
"""
import json
import sqlite3

LANGS = [
    "fr", "de", "es", "ru", "it", "pt", "ja", "ko", "vi", "id", "ar", "hi", "th",
]

conn = sqlite3.connect("assets/data/dictionary.db")
words = [row[0] for row in conn.execute("select simplified from words")]

by_simplified = {}
for row in conn.execute(
    "select simplified, traditional, definition, " +
    ", ".join("definition_%s" % lang for lang in LANGS) +
    " from words"
):
    by_simplified[row[0]] = row
    if row[1]:
        by_simplified.setdefault(row[1], row)

preview = list(json.load(open("assets/data/l10n/deck_words_en.json",
                              encoding="utf-8")).keys())

found = [h for h in preview if h in by_simplified]
print("dictionary rows: %d" % len(words))
print("preview words:   %d" % len(preview))
print("found in store:  %d (%.1f%%)" % (len(found), 100.0 * len(found) / len(preview)))

missing = [h for h in preview if h not in by_simplified]
if missing:
    print("missing:         %s" % " ".join(missing[:20]))

print("\nnon-empty definitions per language (of the found words):")
for index, lang in enumerate(LANGS, start=3):
    count = sum(1 for h in found if by_simplified[h][index])
    print("  %-3s %5d  (%.1f%%)" % (lang, count, 100.0 * count / max(1, len(found))))

english = sum(1 for h in found if by_simplified[h][2])
print("  en  %5d  (%.1f%%)" % (english, 100.0 * english / max(1, len(found))))
