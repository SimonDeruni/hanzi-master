#!/usr/bin/env python
"""The summary translation factory: every pending locale, in parallel, in big batches.

    python scratch/summaries_factory.py --dry-run
    python scratch/summaries_factory.py [--locales pt,id,hi] [--batch 25]
                                        [--workers 4] [--rpm 6] [--seconds 1800]

Supersedes `translate_summaries_gemini.py` for bulk runs: that one walks a single
locale in batches of eight, which is right for a careful top-up and far too slow
to finish six untouched languages. This runner keeps the same safety rule - only a
value that is still identical to the English source (or empty) is ever sent, so a
hand-written translation is never overwritten - and adds:

* one worker thread per locale, so six languages progress at once;
* batches of 25 summaries per request (~3x the old size);
* a process-wide requests-per-minute governor, so parallelism cannot trip the
  free tier's 429 (the budget is shared, not per thread);
* a split-and-retry parser: a malformed answer costs the failing summaries rather
  than the rest of the locale, and a truncated reply is retried in halves;
* a write after every batch, so a timeout or a kill loses at most one batch.

The key comes from `.env` (GEMINI_API_KEY) and never leaves this script.

Credentials are **pooled, not fixed**. The free tier 429s a single key after a
burst, which stalled the first run of this script outright. The app already solves
that with its "Scholar's Key Pool", so the factory does the same: it collects every
credential the tree offers (`GEMINI_API_KEY`, `GEMINI_API_KEY_LOCAL`, both
`OPENROUTER_API_KEY` entries), rotates on 429, cools the offending channel instead
of the whole run, and drops a channel that answers 401/403/404. Each channel gets
its own requests-per-minute clock. Secrets are read but never printed.
"""
import argparse
import collections
import json
import os
import re
import sys
import threading
import time
import urllib.error
import urllib.request
from concurrent.futures import ThreadPoolExecutor

BASE_FILE = os.path.join("assets", "data", "mandarin_bean_stories.json")
L10N_DIR = os.path.join("assets", "data", "l10n")
PREFIX = "mandarin_bean_stories_"
GEMINI_URL = ("https://generativelanguage.googleapis.com/v1beta/models/"
              "%s:generateContent")
GEMINI_MODEL = "gemini-3.6-flash"
OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions"
OPENROUTER_MODEL = "google/gemini-3.6-flash"

LANGS = [
    ("ar", "Arabic"), ("de", "German"), ("es", "Spanish"), ("fr", "French"),
    ("hi", "Hindi"), ("id", "Indonesian"), ("it", "Italian"), ("ja", "Japanese"),
    ("ko", "Korean"), ("pt", "Portuguese"), ("ru", "Russian"), ("th", "Thai"),
    ("vi", "Vietnamese"),
]

_print_lock = threading.Lock()


class RateLimited(Exception):
    """The channel answered 429, so it has a quota rather than a fault."""


class DeadChannel(Exception):
    """401/403/404: this credential or model will never work."""


def read_pairs(path):
    """Parses a dotenv file into a dict; missing files read as empty."""
    pairs = {}
    if not os.path.exists(path):
        return pairs
    for line in open(path, encoding="utf-8"):
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        name, value = line.split("=", 1)
        pairs[name.strip()] = value.strip().strip("'\"")
    return pairs


class Channel:
    """One credential on one provider, with its own cooldown and rate clock."""

    def __init__(self, label, kind, key, model, rpm):
        self.label = label
        self.kind = kind
        self.key = key
        self.model = model
        self.rpm = rpm
        self.cooldown_until = 0.0
        self.calls = collections.deque()
        self.rate_lock = threading.Lock()

    def available(self, now):
        return now >= self.cooldown_until

    def cool(self, seconds, reason):
        self.cooldown_until = time.time() + seconds
        log("    %s cooling %ds (%s)" % (self.label, seconds, reason))

    def _wait_for_slot(self):
        """Blocks until this channel is under its own per-minute budget."""
        while True:
            with self.rate_lock:
                now = time.time()
                while self.calls and now - self.calls[0] > 60:
                    self.calls.popleft()
                if len(self.calls) < self.rpm:
                    self.calls.append(now)
                    return
                sleep_for = 60 - (now - self.calls[0]) + 0.5
            time.sleep(max(sleep_for, 0.5))

    def call(self, prompt):
        if self.kind == "gemini":
            request = urllib.request.Request(
                GEMINI_URL % self.model,
                data=json.dumps({"contents": [{"parts": [{"text": prompt}]}]}).encode("utf-8"),
                headers={"Content-Type": "application/json", "x-goog-api-key": self.key},
            )
        else:
            request = urllib.request.Request(
                OPENROUTER_URL,
                data=json.dumps({
                    "model": self.model,
                    "messages": [{"role": "user", "content": prompt}],
                }).encode("utf-8"),
                headers={"Content-Type": "application/json",
                         "Authorization": "Bearer " + self.key},
            )
        self._wait_for_slot()
        try:
            with urllib.request.urlopen(request, timeout=60) as response:
                payload = json.loads(response.read().decode("utf-8"))
        except urllib.error.HTTPError as error:
            if error.code in (429, 500, 503):
                raise RateLimited("HTTP %s" % error.code)
            if error.code in (401, 403, 404):
                raise DeadChannel("HTTP %s" % error.code)
            raise
        if self.kind == "gemini":
            return payload["candidates"][0]["content"]["parts"][0]["text"]
        return payload["choices"][0]["message"]["content"]



def log(message):
    """Serialises the console so parallel workers do not interleave a line."""
    with _print_lock:
        print(message, flush=True)


class Pool:
    """Round-robin over the channels, skipping any that is cooling down."""

    def __init__(self, channels):
        self.channels = channels
        self.index = 0
        self.lock = threading.Lock()

    def pick(self):
        """Returns the next usable channel, waiting out the shortest cooldown."""
        while True:
            with self.lock:
                if not self.channels:
                    raise SystemExit("every credential is dead - nothing left to try")
                now = time.time()
                count = len(self.channels)
                for step in range(count):
                    channel = self.channels[(self.index + step) % count]
                    if channel.available(now):
                        self.index = (self.index + step + 1) % count
                        return channel
                soonest = min(channel.cooldown_until for channel in self.channels)
            time.sleep(max(soonest - time.time(), 0.5) + 0.5)

    def drop(self, channel):
        with self.lock:
            if channel in self.channels:
                self.channels.remove(channel)


def load_channels(rpm):
    """Every credential the tree offers, deduplicated, as one pool."""
    env = read_pairs(".env")
    functions = read_pairs(os.path.join("functions", ".env"))
    channels = []
    seen = set()

    def add(label, kind, key, model):
        if not key or key in seen:
            return
        seen.add(key)
        channels.append(Channel(label, kind, key, model, rpm))

    add("gemini(.env)", "gemini", env.get("GEMINI_API_KEY"), GEMINI_MODEL)
    add("gemini(functions)", "gemini", functions.get("GEMINI_API_KEY_LOCAL"),
        GEMINI_MODEL)
    add("openrouter(.env)", "openrouter", env.get("OPENROUTER_API_KEY"),
        OPENROUTER_MODEL)
    add("openrouter(functions)", "openrouter", functions.get("OPENROUTER_API_KEY"),
        OPENROUTER_MODEL)
    if not channels:
        raise SystemExit("no credentials found in .env / functions/.env")
    return Pool(channels)


def ask(pool, prompt, tries=6):
    """Returns the model's text, or None after exhausting retries.

    A 429 cools its channel and the next attempt takes the next credential, so one
    exhausted key no longer stalls every worker at once.
    """
    for attempt in range(tries):
        channel = pool.pick()
        try:
            return channel.call(prompt)
        except RateLimited as error:
            channel.cool(45 * (attempt + 1), str(error))
        except DeadChannel as error:
            pool.drop(channel)
            log("    %s dropped (%s)" % (channel.label, error))
        except Exception as error:  # noqa: BLE001 - keep the run alive
            log("    %s: %s (retry %d/%d)" % (type(error).__name__, error,
                                              attempt + 1, tries))
            time.sleep(4)
    return None
def parse_list(text, expected):
    """Pulls a JSON array of `expected` strings out of the model's answer."""
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
    return [str(value).strip() for value in values]


def build_prompt(language, english_texts):
    numbered = "\n".join("%d. %s" % (i + 1, text)
                         for i, text in enumerate(english_texts))
    return (
        "Translate these %d short story summaries into %s for a Chinese-learning "
        "app aimed at adult beginners. Return ONLY a JSON array of %d strings in "
        "the same order, no commentary and no code fence. Translate every word - "
        "never leave a phrase in English. Keep proper names (people, places), "
        "numerals and any trailing ellipsis. Write natural %s, not word for word.\n\n%s"
        % (len(english_texts), language, len(english_texts), language, numbered)
    )


def translate_chunk(pool, language, english_texts, depth=0):
    """Returns {index: translation} for whatever the model answered.

    A batch that comes back malformed or truncated is retried in halves, so one
    bad answer costs a few summaries instead of the whole locale. Indices are
    relative to `english_texts`, which keeps the caller's mapping intact.
    """
    values = parse_list(ask(pool, build_prompt(language, english_texts)),
                        len(english_texts))
    if values is not None:
        return {index: value for index, value in enumerate(values) if value}

    if len(english_texts) <= 2 or depth >= 4:
        log("    gave up on %d summaries" % len(english_texts))
        return {}

    mid = len(english_texts) // 2
    left = translate_chunk(pool, language, english_texts[:mid], depth + 1)
    right = translate_chunk(pool, language, english_texts[mid:], depth + 1)
    merged = dict(left)
    merged.update({mid + index: value for index, value in right.items()})
    return merged


def write_locale(path, data, order):
    """Rewrites one locale file in canonical order, exactly as the app expects.

    Written to a sibling temp file and swapped in with `os.replace`, so a kill
    mid-write leaves the previous good file rather than a truncated one. A long
    unattended run is exactly where that matters.
    """
    ordered = {link: data[link] for link in order if link in data}
    for link, entry in data.items():
        if link not in ordered:
            ordered[link] = entry
    temp = path + ".tmp"
    with open(temp, "w", encoding="utf-8") as handle:
        json.dump(ordered, handle, ensure_ascii=False, indent=2)
        handle.write("\n")
    os.replace(temp, path)

def run_locale(locale, language, pool, english, order, args, deadline, tally):
    path = os.path.join(L10N_DIR, PREFIX + locale + ".json")
    if not os.path.exists(path):
        log("%-3s no locale file, skipped" % locale)
        return
    with open(path, encoding="utf-8") as handle:
        data = json.load(handle)

    pending = [link for link in order
               if link in data
               and (not (data[link].get("summary") or "").strip()
                    or (data[link].get("summary") or "").strip() == english[link].strip())]
    if not pending:
        log("%-3s complete, nothing pending" % locale)
        return

    log("%-3s %d summaries pending" % (locale, len(pending)))
    written = unchanged = 0
    for start in range(0, len(pending), args.batch):
        if time.time() > deadline:
            log("%-3s time budget reached, %d left for the next run"
                % (locale, len(pending) - start))
            break
        chunk = pending[start:start + args.batch]
        english_texts = [english[link] for link in chunk]
        answers = translate_chunk(pool, language, english_texts)
        if not answers:
            log("%-3s batch at %d failed, will retry next run" % (locale, start))
            break
        for index, value in answers.items():
            link = chunk[index]
            if value.strip() == english[link].strip():
                unchanged += 1
            data[link]["summary"] = value
            written += 1
        write_locale(path, data, order)
        log("%-3s %d/%d translated%s"
            % (locale, min(start + args.batch, len(pending)), len(pending),
               " (%d identical to English)" % unchanged if unchanged else ""))
    tally.append((locale, written, len(pending)))


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

    with open(BASE_FILE, encoding="utf-8") as handle:
        base = [entry for entry in json.load(handle) if isinstance(entry, dict)]
    english = {entry["link"]: (entry.get("summary_en") or entry.get("summary") or "")
               for entry in base if entry.get("link")}
    order = [entry["link"] for entry in base if entry.get("link")]

    def pending_for(locale):
        path = os.path.join(L10N_DIR, PREFIX + locale + ".json")
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
        return [link for link in order
                if link in data
                and (not (data[link].get("summary") or "").strip()
                     or (data[link].get("summary") or "").strip() == english[link].strip())]

    if args.dry_run:
        total = 0
        for locale, _language in locales:
            pending = pending_for(locale)
            total += len(pending)
            print("%-3s %3d pending -> %d request(s) at batch %d"
                  % (locale, len(pending), -(-len(pending) // args.batch), args.batch))
        print("total pending: %d summaries" % total)
        return

    channels = load_channels(args.rpm)
    deadline = time.time() + args.seconds
    tally = []
    log("factory: %d locale(s), batch %d, %d worker(s), %d rpm/channel, %.0fs budget"
        % (len(locales), args.batch, args.workers, args.rpm, args.seconds))
    log("channels: %s" % ", ".join(channel.label for channel in channels.channels))
    with ThreadPoolExecutor(max_workers=args.workers) as executor:
        futures = [executor.submit(run_locale, locale, language, channels, english,
                                   order, args, deadline, tally)
                   for locale, language in locales]
        for future in futures:
            future.result()

    log("--- run summary ---")
    for locale, written, pending in sorted(tally):
        log("%-3s %3d/%3d written" % (locale, written, pending))
    log("total written this run: %d" % sum(item[1] for item in tally))


if __name__ == "__main__":
    main()

