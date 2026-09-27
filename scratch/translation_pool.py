#!/usr/bin/env python
"""Shared credential pool and transport for the translation scripts.

    from translation_pool import load_channels, ask, parse_json_array

Why this module exists
----------------------
The free tier 429s a single key after a burst, and the first single-key run of
`summaries_factory.py` **stalled outright with nothing in the log** - the model
answered `429` and the retry path slept silently. The app already solves this
with its "Scholar's Key Pool", so the scripts pool credentials the same way:
every key the tree offers is collected, each gets its own requests-per-minute
clock and cooldown, a `429` cools only the channel that earned it, and a channel
answering `401/403/404` is dropped as dead.

Both `summaries_factory.py` and `catalog_factory.py` translate into the same
pool, so the quota is shared rather than fought over, and neither script has its
own copy of this logic.

Secrets are read from `.env` / `functions/.env` and never printed or logged.
"""
import collections
import json
import os
import threading
import time
import urllib.error
import urllib.request

GEMINI_URL = ("https://generativelanguage.googleapis.com/v1beta/models/"
              "%s:generateContent")
GEMINI_MODEL = "gemini-3.6-flash"
OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions"
OPENROUTER_MODEL = "google/gemini-3.6-flash"

_print_lock = threading.Lock()


class RateLimited(Exception):
    """The channel answered 429, so it has a quota rather than a fault."""


class DeadChannel(Exception):
    """401/403/404: this credential or model will never work."""


def log(message):
    """Serialises the console so parallel workers do not interleave a line."""
    with _print_lock:
        print(message, flush=True)


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
    add("gemini(functions)", "gemini", functions.get("GEMINI_API_KEY_LOCAL"), GEMINI_MODEL)
    add("openrouter(.env)", "openrouter", env.get("OPENROUTER_API_KEY"), OPENROUTER_MODEL)
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


def parse_json_array(text, expected):
    """Pulls a JSON array of `expected` strings out of the model's answer."""
    import re
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


def translate_batch(pool, instruction, items, depth=0):
    """Returns {index: translation} for whatever the model answered.

    A batch that comes back malformed or truncated is retried in halves, so one
    bad answer costs a few items instead of the whole file. Indices are relative
    to `items`, which keeps the caller's mapping intact.
    """
    numbered = "\n".join("%d. %s" % (i + 1, text) for i, text in enumerate(items))
    prompt = (
        "%s Return ONLY a JSON array of %d strings in the same order, no commentary "
        "and no code fence. Translate every word - never leave a phrase in English. "
        "Keep proper names (people, places, brands), numerals, emails, handles and "
        "any trailing ellipsis.\n\n%s" % (instruction, len(items), numbered)
    )
    values = parse_json_array(ask(pool, prompt), len(items))
    if values is not None:
        return {index: value for index, value in enumerate(values) if value}

    if len(items) <= 2 or depth >= 4:
        log("    gave up on %d items" % len(items))
        return {}

    mid = len(items) // 2
    left = translate_batch(pool, instruction, items[:mid], depth + 1)
    right = translate_batch(pool, instruction, items[mid:], depth + 1)
    merged = dict(left)
    merged.update({mid + index: value for index, value in right.items()})
    return merged


def write_json_atomic(path, data):
    """Writes JSON as UTF-8 with a trailing newline, via a temp file + rename.

    A kill mid-write leaves the previous good file rather than a truncated one,
    which is exactly what a long unattended run needs.
    """
    temp = path + ".tmp"
    with open(temp, "w", encoding="utf-8") as handle:
        json.dump(data, handle, ensure_ascii=False, indent=2)
        handle.write("\n")
    os.replace(temp, path)

