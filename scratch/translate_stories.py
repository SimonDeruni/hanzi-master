#!/usr/bin/env python
"""Translates the micro-read titles and summaries in place, locale by locale.

    python scratch/translate_stories.py [seconds]

Why this exists
---------------
`assets/data/l10n/mandarin_bean_stories_<locale>.json` holds 150 stories per
locale, but in most locales the `title` and `summary` values are still the
English ones (measured 2026-09-26: Arabic ~134/150 translated, de ~30, pt ~26,
everything else ~21). Hand-writing 150 stories x 12 languages is not practical,
and the project already takes this route: `scratch/translate_json.dart` calls
the same public `translate.googleapis.com` endpoint the app itself uses for
on-device content translation, and the Arabic file was produced that way.

How it behaves
--------------
* Source language is auto-detected, so it is safe on the English text that is
  there now.
* A value that is already non-ASCII counts as translated and is left alone, so
  the script never degrades existing work and can be re-run freely.
* Each locale's file is rewritten after every small batch, so progress survives
  a timeout.
* It runs for the given number of seconds (default 20) and prints what is left,
  which keeps it inside a short shell budget: run it repeatedly until it says
  nothing remains.

Quality
-------
This is machine translation. It is far better than shipping English, and it is
not a substitute for a human pass on the stories that matter most.
"""
import json
import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from urllib.parse import quote
from urllib.request import Request, urlopen

LANGS = ["ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi"]
PREFIX = "mandarin_bean_stories_"
ASSET_DIR = os.path.join("assets", "data", "l10n")
CHUNK = 24
WORKERS = 6


def is_translated(text):
    """True when the value is no longer plain ASCII, i.e. already localized."""
    if not text:
        return False
    try:
        text.encode("ascii")
        return False
    except UnicodeEncodeError:
        return True


def translate(text, lang, tries=3):
    """Returns the translation, or None to leave the existing value alone."""
    if not text or not text.strip():
        return None
    url = (
        "https://translate.googleapis.com/translate_a/single"
        "?client=gtx&sl=auto&tl=%s&dt=t&q=%s" % (lang, quote(text))
    )
    for attempt in range(tries):
        try:
            request = Request(url, headers={"User-Agent": "Mozilla/5.0"})
            with urlopen(request, timeout=20) as response:
                payload = json.loads(response.read().decode("utf-8"))
            parts = payload[0] or []
            result = "".join(part[0] for part in parts if part and part[0])
            if result.strip():
                return result
        except Exception:
            time.sleep(1.0 + attempt)
    return None


def main():
    budget = float(sys.argv[1]) if len(sys.argv) > 1 else 20.0
    deadline = time.time() + budget
    translated = 0
    failed = 0
    left_over = 0

    for lang in LANGS:
        path = os.path.join(ASSET_DIR, PREFIX + lang + ".json")
        if not os.path.exists(path):
            continue
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)

        pending = []
        for key, entry in data.items():
            if not isinstance(entry, dict):
                continue
            for field in ("title", "summary"):
                value = entry.get(field)
                if value and not is_translated(value):
                    pending.append((key, field, value))

        if not pending:
            continue

        for start in range(0, len(pending), CHUNK):
            if time.time() > deadline:
                left_over += len(pending) - start
                break
            batch = pending[start:start + CHUNK]
            with ThreadPoolExecutor(max_workers=WORKERS) as pool:
                results = list(
                    pool.map(lambda item: translate(item[2], lang), batch)
                )
            for (key, field, original), result in zip(batch, results):
                if result:
                    data[key][field] = result
                    translated += 1
                else:
                    failed += 1
            with open(path, "w", encoding="utf-8") as handle:
                json.dump(data, handle, ensure_ascii=False, indent=2)
                handle.write("\n")

    print("translated: %d   failed: %d   still pending after the time budget: %d"
          % (translated, failed, left_over))


if __name__ == "__main__":
    main()
