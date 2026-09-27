#!/usr/bin/env python
"""Independent language sanity check on the micro-read summaries.

    python scratch/_verify_summaries_quality.py

`summaries_progress.py` proves a summary *differs* from English, which is not the
same as proving it is in the target language - a half-translated or wrong-language
string still differs. This checks two things the differ-from-English test cannot:

* script coverage for the non-Latin locales (a Hindi summary with no Devanagari,
  a Japanese one with no kana/kanji, is a defect regardless of byte comparison);
* residual English function words for the Latin-script locales, which catch a
  summary the model only half-translated.

Also reports very short values, which usually mean a truncated answer.
"""
import json
import os
import re

BASE = os.path.join("assets", "data", "mandarin_bean_stories.json")
L10N = os.path.join("assets", "data", "l10n", "mandarin_bean_stories_")
LOCALES = ["ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi"]

SCRIPTS = {
    "ar": r"[\u0600-\u06ff]",
    "hi": r"[\u0900-\u097f]",
    "ja": r"[\u3040-\u30ff\u4e00-\u9fff]",
    "ko": r"[\uac00-\ud7af]",
    "ru": r"[\u0400-\u04ff]",
    "th": r"[\u0e00-\u0e7f]",
}

# Function words that survive a half-finished translation far more often than they
# appear legitimately in prose (they are checked as whole words, lowercased).
ENGLISH_WORDS = {"the", "and", "with", "from", "that", "this", "have", "were",
                 "which", "their", "about", "because", "there", "would"}


def load_base():
    with open(BASE, encoding="utf-8") as handle:
        entries = [e for e in json.load(handle) if isinstance(e, dict)]
    return {e["link"]: (e.get("summary_en") or e.get("summary") or "").strip()
            for e in entries if e.get("link")}


def main():
    english = load_base()
    problems = 0
    print("%-4s %-8s %-9s %-9s %s" % ("loc", "values", "badscript", "english", "shortest"))
    for locale in LOCALES:
        path = L10N + locale + ".json"
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
        if len(data) != len(english):
            print("%-4s KEY COUNT MISMATCH: %d vs %d" % (locale, len(data), len(english)))

        values = [(link, (data.get(link, {}).get("summary") or "").strip())
                  for link in english]
        bad_script = 0
        if locale in SCRIPTS:
            pattern = re.compile(SCRIPTS[locale])
            bad_script = sum(1 for _link, text in values
                             if text and not pattern.search(text))
        english_words = []
        for link, text in values:
            words = set(re.findall(r"[A-Za-z']+", text.lower()))
            hits = words & ENGLISH_WORDS
            if hits:
                english_words.append((link, sorted(hits)))
        shortest = min((text for _link, text in values if text), key=len, default="")
        problems += bad_script + len(english_words)
        print("%-4s %-8d %-9d %-9d %d chars" % (locale, len(values), bad_script,
                                                len(english_words), len(shortest)))
        for link, hits in english_words[:4]:
            print("      english words %s -> %s" % (hits, link))
    print("total script/english problems: %d" % problems)


if __name__ == "__main__":
    main()
