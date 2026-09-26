#!/usr/bin/env python
"""Which micro-read summaries are still literally the English source.

    python scratch/check_summaries.py          # every locale
    python scratch/check_summaries.py es de    # only these

`summaries_progress.py` counts a summary as translated once it differs from the
English source. This prints the story numbers behind the remaining count, so the
next batch can be addressed by 1-based index instead of by URL.
"""
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from story_i18n import load_base, locale_path  # noqa: E402

LANGS = ["ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi"]


def main():
    wanted = [arg for arg in sys.argv[1:] if not arg.startswith("-")] or LANGS
    stories = load_base()
    for locale in wanted:
        path = locale_path(locale)
        if not os.path.exists(path):
            print("%-4s no file" % locale)
            continue
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
        empty = []
        english = []
        for index, (link, _title, summary) in enumerate(stories, start=1):
            current = (data.get(link, {}).get("summary") or "").strip()
            if not current:
                empty.append(index)
            elif current == summary.strip():
                english.append(index)
        done = len(stories) - len(empty) - len(english)
        print("%-4s %3d / %d" % (locale, done, len(stories)))
        print("     no summary : %s" % (" ".join(str(i) for i in empty) or "-"))
        print("     still english: %s" % (" ".join(str(i) for i in english) or "-"))


if __name__ == "__main__":
    main()
