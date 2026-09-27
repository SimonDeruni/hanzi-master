#!/usr/bin/env python
"""The micro-read summary factory: every pending locale, in big pooled batches.

    python scratch/summaries_factory.py --dry-run
    python scratch/summaries_factory.py [--locales pt,id,hi] [--batch 25]
                                        [--workers 4] [--rpm 6] [--seconds 1800]

Only a value that is still identical to the English source (or empty) is ever
sent, so a hand-written translation can never be overwritten. Beyond that it adds
one worker per locale, batches of 25, a split-and-retry parser (a truncated answer
costs a few summaries, not the locale), and a write after every batch.

Credentials come from `translation_pool`, which pools every key the tree offers and
rotates on 429. That pool is not decoration: the first single-key run of this
script **stalled outright** when `GEMINI_API_KEY` began answering 429, and the old
retry path logged nothing, so the stall had no visible cause.

Supersedes the sequential `scratch/translate_summaries_gemini.py` for bulk runs -
that one walks a single locale in batches of eight on one key, which is right for
a careful top-up and cannot finish six languages.
"""
import argparse
import json
import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from translation_pool import (  # noqa: E402
    load_channels, log, translate_batch, write_json_atomic)

BASE_FILE = os.path.join("assets", "data", "mandarin_bean_stories.json")
L10N_DIR = os.path.join("assets", "data", "l10n")
PREFIX = "mandarin_bean_stories_"

LANGS = [
    ("ar", "Arabic"), ("de", "German"), ("es", "Spanish"), ("fr", "French"),
    ("hi", "Hindi"), ("id", "Indonesian"), ("it", "Italian"), ("ja", "Japanese"),
    ("ko", "Korean"), ("pt", "Portuguese"), ("ru", "Russian"), ("th", "Thai"),
    ("vi", "Vietnamese"),
]


def read_json(path):
    with open(path, encoding="utf-8") as handle:
        return json.load(handle)


def run_locale(locale, language, english, order, pool, args, deadline, tally):
    """Translates whatever this locale still needs. Returns nothing; appends a tally."""
    path = os.path.join(L10N_DIR, PREFIX + locale + ".json")
    if not os.path.exists(path):
        log("%-3s no locale file, skipped" % locale)
        return
    data = read_json(path)

    pending = [link for link in order
               if link in data
               and (not (data[link].get("summary") or "").strip()
                    or (data[link].get("summary") or "").strip() == english[link].strip())]
    if not pending:
        log("%-3s complete, nothing pending" % locale)
        return

    log("%-3s %d summaries pending" % (locale, len(pending)))
    instruction = ("Translate these Chinese short story summaries into %s for a "
                   "Chinese-learning app aimed at adult beginners. They are "
                   "micro-reads of a few short paragraphs: write flowing, "
                   "idiomatic %s prose, not a word-for-word gloss."
                   % (language, language))
    written = 0
    for start in range(0, len(pending), args.batch):
        if time.time() > deadline:
            log("%-3s time budget reached, %d left for the next run"
                % (locale, len(pending) - start))
            break
        chunk = pending[start:start + args.batch]
        answers = translate_batch(pool, instruction, [english[link] for link in chunk])
        if not answers:
            log("%-3s batch at %d failed, rerun to retry" % (locale, start))
            break
        for index, value in answers.items():
            data[chunk[index]]["summary"] = value
            written += 1
        # Canonical order, so every locale file lines up and the diff stays small.
        ordered = {link: data[link] for link in order if link in data}
        for link, entry in data.items():
            if link not in ordered:
                ordered[link] = entry
        write_json_atomic(path, ordered)
        log("%-3s %d/%d translated"
            % (locale, min(start + args.batch, len(pending)), len(pending)))
    tally.append((locale, written, len(pending)))


def pending_for(locale, english, order):
    """The links this locale still holds in English, for the dry run."""
    path = os.path.join(L10N_DIR, PREFIX + locale + ".json")
    if not os.path.exists(path):
        return []
    data = read_json(path)
    return [link for link in order
            if link in data
            and (not (data[link].get("summary") or "").strip()
                 or (data[link].get("summary") or "").strip() == english[link].strip())]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--locales", help="comma-separated locale codes (default: all)")
    parser.add_argument("--batch", type=int, default=25)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--rpm", type=int, default=6,
                        help="requests per minute per credential (channels are pooled)")
    parser.add_argument("--seconds", type=float, default=1800.0)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    wanted = set(args.locales.split(",")) if args.locales else None
    locales = [pair for pair in LANGS if wanted is None or pair[0] in wanted]

    base = [entry for entry in read_json(BASE_FILE) if isinstance(entry, dict)]
    english = {entry["link"]: (entry.get("summary_en") or entry.get("summary") or "")
               for entry in base if entry.get("link")}
    order = [entry["link"] for entry in base if entry.get("link")]

    if args.dry_run:
        total = 0
        for locale, _language in locales:
            pending = pending_for(locale, english, order)
            total += len(pending)
            print("%-3s %3d pending -> %d request(s) at batch %d"
                  % (locale, len(pending), -(-len(pending) // args.batch), args.batch))
        print("total pending: %d summaries" % total)
        return

    pool = load_channels(args.rpm)
    deadline = time.time() + args.seconds
    tally = []
    log("summary factory: %d locale(s), batch %d, %d worker(s), %d rpm/channel, %.0fs"
        % (len(locales), args.batch, args.workers, args.rpm, args.seconds))
    log("channels: %s" % ", ".join(channel.label for channel in pool.channels))
    with ThreadPoolExecutor(max_workers=args.workers) as executor:
        futures = [executor.submit(run_locale, locale, language, english, order,
                                   pool, args, deadline, tally)
                   for locale, language in locales]
        for future in futures:
            future.result()

    log("--- run summary ---")
    for locale, written, pending in sorted(tally):
        log("%-3s %3d/%3d written" % (locale, written, pending))
    log("total written this run: %d" % sum(item[1] for item in tally))


if __name__ == "__main__":
    main()

