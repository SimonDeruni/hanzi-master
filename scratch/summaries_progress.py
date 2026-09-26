#!/usr/bin/env python
"""How far the micro-read summary translation has got, per locale.

    python scratch/summaries_progress.py

A summary counts as translated when it differs from the English source. That is
the honest measure: an older check looked for non-ASCII characters, which
wrongly flagged correct translations in Latin-script languages (Indonesian, or
German without umlauts) as missing.
"""
import json
import os

LANGS = ["ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi"]
BASE = os.path.join("assets", "data", "mandarin_bean_stories.json")
PREFIX = os.path.join("assets", "data", "l10n", "mandarin_bean_stories_")


def main():
    with open(BASE, encoding="utf-8") as handle:
        stories = [e for e in json.load(handle) if isinstance(e, dict)]
    english = {
        e["link"]: (e.get("summary_en") or e.get("summary") or "").strip()
        for e in stories
        if e.get("link")
    }
    total_done = 0
    print("%-4s %-11s %s" % ("loc", "translated", "of"))
    for lang in LANGS:
        try:
            with open(PREFIX + lang + ".json", encoding="utf-8") as handle:
                data = json.load(handle)
        except FileNotFoundError:
            print("%-4s %-11s %s" % (lang, "-", "no file"))
            continue
        done = sum(
            1
            for link, source in english.items()
            if (data.get(link, {}).get("summary") or "").strip() != source
        )
        total_done += done
        print("%-4s %-11d %d" % (lang, done, len(english)))
    print("total: %d of %d" % (total_done, len(LANGS) * len(english)))


if __name__ == "__main__":
    main()
