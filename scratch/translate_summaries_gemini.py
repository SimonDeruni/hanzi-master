#!/usr/bin/env python
"""Translates the micro-read summaries with Gemini (free tier).

    python scratch/translate_summaries_gemini.py [seconds]

Only a value that is still identical to the English source (or empty) is sent
for translation, so a hand-written translation is never overwritten. Batches of
eight summaries per request, one locale at a time, saved after every batch so
the run is resumable and a timeout loses nothing.

The key comes from `.env` (GEMINI_API_KEY) - the same credential the app itself
uses - and never leaves this script. No public web-translation endpoint is
involved.
"""
import json
import os
import re
import sys
import time
import urllib.error
import urllib.request

BASE_FILE = os.path.join("assets", "data", "mandarin_bean_stories.json")
L10N_DIR = os.path.join("assets", "data", "l10n")
PREFIX = "mandarin_bean_stories_"
MODEL = "gemini-3.6-flash"
BATCH = 8

LANGS = [
    ("ar", "Arabic"), ("de", "German"), ("es", "Spanish"), ("fr", "French"),
    ("hi", "Hindi"), ("id", "Indonesian"), ("it", "Italian"), ("ja", "Japanese"),
    ("ko", "Korean"), ("pt", "Portuguese"), ("ru", "Russian"), ("th", "Thai"),
    ("vi", "Vietnamese"),
]


def load_key():
    for line in open(".env", encoding="utf-8"):
        if line.strip().startswith("GEMINI_API_KEY="):
            return line.split("=", 1)[1].strip().strip('"')
    raise SystemExit("no GEMINI_API_KEY in .env")


def ask_gemini(key, prompt, tries=5):
    """Returns the model's text, or None after exhausting retries."""
    url = ("https://generativelanguage.googleapis.com/v1beta/models/%s:generateContent"
           % MODEL)
    body = json.dumps({"contents": [{"parts": [{"text": prompt}]}]}).encode("utf-8")
    for attempt in range(tries):
        request = urllib.request.Request(
            url, data=body,
            headers={"Content-Type": "application/json", "x-goog-api-key": key},
        )
        try:
            with urllib.request.urlopen(request, timeout=90) as response:
                payload = json.loads(response.read().decode("utf-8"))
            return payload["candidates"][0]["content"]["parts"][0]["text"]
        except urllib.error.HTTPError as error:
            if error.code in (429, 500, 503):
                time.sleep(8 * (attempt + 1))
                continue
            print("    HTTP %s %s" % (error.code, error.read().decode("utf-8", "replace")[:120]))
            return None
        except Exception as error:  # noqa: BLE001 - keep the batch alive
            print("    %s" % type(error).__name__)
            time.sleep(4)
    return None


def parse_list(text, expected):
    """Pulls a JSON array of strings out of the model's answer."""
    if not text:
        return None
    cleaned = re.sub(r"^```(?:json)?|```$", "", text.strip(), flags=re.MULTILINE).strip()
    start, end = cleaned.find("["), cleaned.rfind("]")
    if start == -1 or end == -1:
        return None
    try:
        values = json.loads(cleaned[start:end + 1])
    except Exception:  # noqa: BLE001
        return None
    if not isinstance(values, list) or len(values) != expected:
        return None
    return [str(v).strip() for v in values]


def main():
    argv = list(sys.argv[1:])
    only = None
    if "--only" in argv:
        index = argv.index("--only")
        only = argv[index + 1]
        del argv[index:index + 2]
    budget = float(argv[0]) if argv else 900.0
    deadline = time.time() + budget
    key = load_key()
    locales = [pair for pair in LANGS if only is None or pair[0] == only]

    with open(BASE_FILE, encoding="utf-8") as handle:
        base = [e for e in json.load(handle) if isinstance(e, dict)]
    english = {e["link"]: (e.get("summary_en") or e.get("summary") or "") for e in base
               if e.get("link")}
    order = [e["link"] for e in base if e.get("link")]

    done = 0
    for locale, language in locales:
        path = os.path.join(L10N_DIR, PREFIX + locale + ".json")
        if not os.path.exists(path):
            continue
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)

        pending = [link for link in order
                   if link in data
                   and (not (data[link].get("summary") or "").strip()
                        or (data[link].get("summary") or "").strip() == english[link].strip())]
        if not pending:
            continue

        for start in range(0, len(pending), BATCH):
            if time.time() > deadline:
                print("%s: time budget reached, %d left" % (locale, len(pending) - start))
                break
            chunk = pending[start:start + BATCH]
            numbered = "\n".join("%d. %s" % (i + 1, english[link]) for i, link in enumerate(chunk))
            prompt = (
                "Translate these %d short story summaries into %s for a Chinese-learning app. "
                "Return ONLY a JSON array of %d strings in the same order, no commentary. "
                "Keep proper names, numbers and any trailing ellipsis. Write naturally, not "
                "word for word.\n\n%s" % (len(chunk), language, len(chunk), numbered)
            )
            values = parse_list(ask_gemini(key, prompt), len(chunk))
            if values is None:
                print("%s: batch at %d failed, will retry next run" % (locale, start))
                break
            for link, value in zip(chunk, values):
                data[link]["summary"] = value
                done += 1
            ordered = {link: data[link] for link in order if link in data}
            for link, entry in data.items():
                if link not in ordered:
                    ordered[link] = entry
            with open(path, "w", encoding="utf-8") as handle:
                json.dump(ordered, handle, ensure_ascii=False, indent=2)
                handle.write("\n")
            print("%s: %d/%d summaries translated" % (locale, min(start + BATCH, len(pending)), len(pending)))

    print("translated this run: %d" % done)


if __name__ == "__main__":
    main()
