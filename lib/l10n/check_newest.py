import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"

en = json.load(open(os.path.join(BASE, "app_en.arb"), "r", encoding="utf-8"))

strings = [
    "Align Chinese text within frame",
    "Analyzing image...",
    "Extracting Chinese text...",
    "Looking up vocabulary...",
    "Continue Reading",
    "Dream of the Red Chamber",
    "Ch. 2",
    "86 Books & Audiobooks",
    "Audiobook",
    "The Journey to the West",
    "Volume 1",
    "Journey to the West",
    "Audio",
    "Romance of the Three Kingdoms",
    "Audiobook Included",
    "Chinese Epics",
    "Ming Dynasty",
    "100 Chapters",
    "Start Reading",
    "Listen to Audiobook",
    "Wu Cheng'en",
    "Table of Contents",
    "Chapter 1", "Chapter 2", "Chapter 3", "Chapter 4", "Chapter 5", "Chapter 6",
    "Chapter 1 of 100",
    "Sentence 1 of 338",
    "Sentence 1", "Sentence 2", "Sentence 3",
    "Previous",
    "Bookmarks (0)",
    "No bookmarks yet. Tap the bookmark icon to save a passage.",
    "Also seen in",
    "Add to Deck",
    "Read",
    "Sentence 1 / 320",
    "Book 1%",
    "SinoSpark isn't responding",
    "Close app",
    "Wait",
    "Studio HD: 4.0h",
    "Sentence 1 of 320",
]

results = []
for s in strings:
    found = False
    for k, v in en.items():
        if isinstance(v, str) and v.strip() == s.strip():
            results.append(f"EXISTS: {k} = {v}")
            found = True
            break
    if not found:
        results.append(f"MISSING: {s}")

for r in results:
    print(r)

with open(os.path.join(BASE, "check_newest_keys.txt"), "w", encoding="utf-8") as f:
    f.write("\n".join(results))
print(f"\nWritten to check_newest_keys.txt")