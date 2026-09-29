#!/usr/bin/env python3
"""Give every poet's collection a real summary, then translate it.

    python tooling/build_poet_bios.py           # build the Chinese summaries
    python tooling/build_poet_bios.py --translate [--only LOCALE] [seconds]

The source is the corpus's own author index - `全唐诗/authors.tang.json` and
`authors.song.json`, i.e. the same MIT-licensed `chinese-poetry` revision the
poems came from. Those entries are long (median 382 characters, up to 1541) and
written in classical 繁体, so Gemini **condenses** them into two plain modern
sentences: summarising a supplied biography is faithful work, whereas writing one
from scratch would be the invention `docs/PROJECT_GUIDELINES.md` forbids.

The two files are 繁体, so their names and text are run through the same pinned
OpenCC character map `fetch_poetry_collections.py` uses; without it only 13 of
the 37 poets match (李白 matches either way, 苏轼 does not match 蘇軾).

Eight poets are absent from both files - five 元曲 writers, 李煜, 曹操 and
纳兰性德. They get a line built **only** from what this app already knows: their
dynasty and how many poems the collection holds. No biography is invented, and
the provenance field says so.

Output:
  assets/data/poet_bios.json               {poet: {summary, source, savedAt}}
  assets/data/l10n/poet_bios_<locale>.json {poet: summary}
"""
import collections
import json
import os
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STORE = os.path.join("assets", "data", "famous_chinese_poetry.json")
BIOS = os.path.join("assets", "data", "poet_bios.json")
L10N_DIR = os.path.join("assets", "data", "l10n")
PREFIX = "poet_bios_"

REVISION = "b8594f8"
CORPUS = "https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/" + REVISION
OPENCC = ("https://raw.githubusercontent.com/BYVoid/OpenCC/ver.1.1.6"
          "/data/dictionary/TSCharacters.txt")
AUTHOR_FILES = [("全唐诗/authors.tang.json", "authors.tang.json"),
                ("全唐诗/authors.song.json", "authors.song.json")]

# `全唐诗` carries an author index, but the single-poet anthologies do not — for
# those the README holds the biography.
README_SOURCES = {
    "纳兰性德/README.md": "纳兰性德",
    "曹操诗集/README.md": "曹操",
}

# The 词 side's author index: a different file with a different field name.
SONG_CI_AUTHORS = "宋词/author.song.json"

# Names that are not people. 佚名 means "anonymous", and this app's 佚名
# collection gathers anonymous poems from *several* anthologies (诗经, 全唐诗,
# 宋词…), so condensing one "anonymous poet" entry from an author index described
# the wrong thing entirely — it claimed 月泉吟社 collected all fifty, when only
# some came from there. These are described as what they are: a collection.
COLLECTIVE_AUTHORS = {
    "佚名": "作者不详的古典诗歌集，选自《诗经》《全唐诗》《宋词》等选本。",
}

# CC0, so no attribution or share-alike obligation travels into the app — unlike
# a Wikipedia extract, which would.
WIKIDATA_SEARCH = ("https://www.wikidata.org/w/api.php?action=wbsearchentities"
                   "&format=json&language=zh&uselang=zh&limit=1&search=")

MODEL = "gemini-flash-latest"
# The Gemini free tier rate-limits this kind of bulk job (and the app's own
# `gemini-3.6-flash` is exhausted outright), so OpenRouter carries the load when
# its key is present. Qwen is chosen for Chinese->multilingual work.
OPENROUTER_MODEL = os.environ.get("OPENROUTER_MODEL", "google/gemini-2.5-flash")
OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions"
CACHE = os.path.join(os.environ.get("TEMP", "."), "poetry_corpus")

LANGS = [
    ("ar", "Arabic"), ("de", "German"), ("es", "Spanish"), ("fr", "French"),
    ("hi", "Hindi"), ("id", "Indonesian"), ("it", "Italian"), ("ja", "Japanese"),
    ("ko", "Korean"), ("pt", "Portuguese"), ("ru", "Russian"), ("th", "Thai"),
    ("vi", "Vietnamese"),
    # English is the app's base locale, so it is not one of the 13 content
    # locales a reader selects; it is listed last so `--only en` can produce the
    # English biography the book's `descriptionEn` needs.
    ("en", "English"),
]


def fetch_text(url):
    request = urllib.request.Request(
        url, headers={"User-Agent": "HanziMasterPoetBios/1.0"})
    with urllib.request.urlopen(request, timeout=90) as response:
        return response.read().decode("utf-8")


def cached(name, url):
    path = os.path.join(CACHE, name)
    if os.path.exists(path):
        return open(path, encoding="utf-8").read()
    os.makedirs(CACHE, exist_ok=True)
    text = fetch_text(url)
    with open(path, "w", encoding="utf-8") as handle:
        handle.write(text)
    return text


def load_env(name):
    """A value from `.env`. The key never leaves this script."""
    if not os.path.exists(".env"):
        return None
    for line in open(".env", encoding="utf-8"):
        if line.strip().startswith(name + "="):
            return line.split("=", 1)[1].strip().strip('"')
    return None


def load_key():
    value = load_env("GEMINI_API_KEY")
    if not value:
        raise SystemExit("no GEMINI_API_KEY in .env")
    return value


def opencc_map():
    mapping = {}
    for line in cached("TSCharacters.txt", OPENCC).splitlines():
        parts = line.split()
        if len(parts) >= 2:
            mapping[parts[0]] = parts[1]
    return mapping


def _post(url, headers, body, tries, label):
    """A decoded JSON response, retried, with the reason logged on failure.

    Logging matters here: the 429 path used to be silent and surfaced as an
    "empty reply", which quietly cost a whole batch with no explanation.
    """
    for attempt in range(tries):
        request = urllib.request.Request(url, data=body, headers=headers)
        try:
            with urllib.request.urlopen(request, timeout=120) as response:
                return json.loads(response.read().decode("utf-8"))
        except urllib.error.HTTPError as error:
            detail = error.read().decode("utf-8", "replace")[:150].replace("\n", " ")
            if error.code in (429, 500, 502, 503):
                print("    %s: HTTP %s, backing off (%d/%d)"
                      % (label, error.code, attempt + 1, tries))
                time.sleep(5 * (attempt + 1))
                continue
            print("    %s: HTTP %s %s" % (label, error.code, detail))
            return None
        except Exception as error:  # noqa: BLE001
            print("    %s: %s" % (label, type(error).__name__))
            time.sleep(4)
    return None


def ask_openrouter(prompt, tries=4):
    key = load_env("OPENROUTER_API_KEY")
    if not key:
        return None
    body = json.dumps({
        "model": OPENROUTER_MODEL,
        "messages": [{"role": "user", "content": prompt}],
    }).encode("utf-8")
    payload = _post(OPENROUTER_URL,
                    {"Content-Type": "application/json",
                     "Authorization": "Bearer " + key}, body, tries, "openrouter")
    if not payload:
        return None
    choices = payload.get("choices") or []
    if not choices:
        print("    openrouter: no choices: %s" % json.dumps(payload)[:150])
        return None
    return ((choices[0].get("message") or {}).get("content") or "").strip()


def ask_gemini(key, prompt, tries=4):
    url = ("https://generativelanguage.googleapis.com/v1beta/models/%s:generateContent"
           % MODEL)
    body = json.dumps({"contents": [{"parts": [{"text": prompt}]}]}).encode("utf-8")
    payload = _post(url,
                    {"Content-Type": "application/json", "x-goog-api-key": key},
                    body, tries, "gemini")
    if not payload:
        return None
    candidates = payload.get("candidates") or []
    if not candidates:
        print("    gemini: no candidates: %s" % json.dumps(payload)[:150])
        return None
    parts = (candidates[0].get("content") or {}).get("parts") or []
    return (parts[0].get("text") or "").strip() if parts else ""


def ask(key, prompt, tries=4):
    """OpenRouter when it is configured, Gemini otherwise."""
    text = ask_openrouter(prompt, tries)
    if text:
        return text
    return ask_gemini(key, prompt, tries)


def strip_fences(text):
    return re.sub(r"^```(?:json)?|```$", "", text.strip(), flags=re.MULTILINE).strip()


def parse_array(text, expected, label=""):
    """Pulls a JSON array of `expected` strings out of the model's answer.

    Tolerant on purpose: the model sometimes wraps the array in a sentence, and
    sometimes returns `[{"summary": "..."}]` instead of bare strings.
    """
    if not text:
        print("    %s: empty reply" % label)
        return None
    cleaned = strip_fences(text)
    start, end = cleaned.find("["), cleaned.rfind("]")
    if start == -1 or end == -1:
        print("    %s: no array in reply: %s" % (label, cleaned[:200].replace("\n", " ")))
        return None
    try:
        values = json.loads(cleaned[start:end + 1])
    except Exception as error:  # noqa: BLE001
        print("    %s: unparseable (%s): %s"
              % (label, type(error).__name__, cleaned[:200].replace("\n", " ")))
        return None
    if isinstance(values, list) and values and isinstance(values[0], dict):
        for key in ("summary", "text", "bio", "translation"):
            if key in values[0]:
                values = [item.get(key, "") for item in values]
                break
    if not isinstance(values, list) or len(values) != expected:
        print("    %s: expected %d items, got %s"
              % (label, expected, len(values) if isinstance(values, list) else "?"))
        return None
    return [str(value).strip() for value in values]
DYNASTY_ERA = {
    "Tang": "唐代", "Song": "宋代", "pre-Qin": "先秦", "Han": "汉代",
    "Yuan": "元代", "Qing": "清代", "Five Dynasties": "五代",
}


def poet_facts(store):
    """Poem counts, dynasty and poems per published poet, from the store alone."""
    counts = collections.Counter(e["sourceName"] for e in store)
    dynasty = {}
    by_poet = collections.defaultdict(list)
    for entry in store:
        poet = entry["sourceName"]
        dynasty.setdefault(poet, (entry.get("dynasty") or "").strip())
        by_poet[poet].append(entry)
    return counts, dynasty, by_poet


def compose_prompt(poet, fact, era, genre, count):
    """The only source is a Wikidata one-liner, so compose from stated facts.

    The model is given the facts and forbidden from adding any - a one-line
    "who they were" is all CC0 offers, and this turns it into a sentence without
    inventing a biography.
    """
    return (
        "Write ONE sentence of plain modern Simplified Chinese, at most 70 "
        "characters, describing the poet %s for a learner opening their poem "
        "collection in a Chinese poetry reading app. Use ONLY these facts and add "
        "nothing else:\n"
        "- who they were (Wikidata, CC0): %s\n"
        "- era: %s\n"
        "- what they wrote: %s\n"
        "- the collection holds %d poems\n"
        "Do not quote this list, do not add a heading or quotation marks, and do "
        "not invent dates, titles or events. Reply with the sentence only."
        % (poet, fact, era, genre, count))


def corpus_bios(mapping):
    """Poet -> (biography, file it came from), simplified."""
    bios = {}
    for path, name in AUTHOR_FILES:
        url = CORPUS + "/" + urllib.parse.quote(path)
        try:
            entries = json.loads(cached(name, url))
        except Exception as error:  # noqa: BLE001
            print("  ! %s unavailable (%s)" % (name, type(error).__name__))
            continue
        for entry in entries:
            who = "".join(mapping.get(c, c) for c in (entry.get("name") or "").strip())
            desc = "".join(mapping.get(c, c) for c in (entry.get("desc") or "").strip())
            if who and desc:
                bios.setdefault(who, (desc, name))
    return bios


def readme_bios(mapping):
    """The per-anthology READMEs that carry a biography of their poet.

    `全唐诗` has an author index, but the single-poet anthologies do not - their
    README is where the biography lives. Only the prose before the first `##`
    section is a biography; everything after it documents the data format.
    """
    bios = {}
    for path, poet in README_SOURCES.items():
        # Cache under the whole path, not its basename: both READMEs are called
        # `README.md`, so a basename key made the second one read the first one's
        # file — which quietly handed 曹操 纳兰性德's biography.
        try:
            text = cached(path.replace("/", "_"),
                          CORPUS + "/" + urllib.parse.quote(path))
        except Exception as error:  # noqa: BLE001
            print("  ! %s unavailable (%s)" % (path, type(error).__name__))
            continue
        prose = text.split("\n## ")[0]
        paragraphs = [line.strip() for line in prose.splitlines()
                      if line.strip() and not line.strip().startswith("#")]
        body = " ".join(paragraphs).strip()
        if body:
            bios[poet] = ("".join(mapping.get(c, c) for c in body), path)
    return bios


def song_ci_bios(mapping):
    """`宋词/author.song.json`: the 词 side's author index.

    Its field is `description`, not `desc`, and it is 简体 already, so only the
    fallback names need simplifying.
    """
    bios = {}
    try:
        entries = json.loads(cached("author.song.json",
                                    CORPUS + "/" + urllib.parse.quote(SONG_CI_AUTHORS)))
    except Exception as error:  # noqa: BLE001
        print("  ! %s unavailable (%s)" % (SONG_CI_AUTHORS, type(error).__name__))
        return bios
    for entry in entries:
        who = "".join(mapping.get(c, c) for c in (entry.get("name") or "").strip())
        desc = " ".join(
            "".join(mapping.get(c, c) for c in str(entry.get(key) or "").strip())
            for key in ("description", "short_description")
        ).strip()
        if who and desc:
            bios.setdefault(who, (desc, SONG_CI_AUTHORS))
    return bios


def wikidata_descriptions(poets):
    """A one-line "who they were" per poet, from Wikidata.

    Wikidata is **CC0**, so unlike a Wikipedia extract it carries no attribution
    or share-alike obligation into a commercial app. The line is short by design,
    which is why it is only a fallback and always combined with the dynasty and
    collection size this app already records.
    """
    found = {}
    for poet in poets:
        url = (WIKIDATA_SEARCH + urllib.parse.quote(poet))
        try:
            data = json.loads(fetch_text(url))
        except Exception:  # noqa: BLE001
            continue
        hits = data.get("search") or []
        if not hits:
            continue
        label = (hits[0].get("label") or "").strip()
        description = (hits[0].get("description") or "").strip()
        # Reject a hit that is a different person: the label must be the poet.
        if label == poet and description:
            found[poet] = (description, hits[0].get("id"))
    return found


def genre_from_sources(poems):
    """The genre the poet wrote, read off the corpus their poems came from."""
    paths = " ".join(str(poem.get("sourcePath") or "") for poem in poems)
    if "元曲" in paths:
        return "散曲作家"
    if "五代诗词" in paths:
        return "词人"
    if "宋词" in paths:
        return "词人"
    if "诗经" in paths:
        return "作品"
    if "曹操诗集" in paths:
        return "诗人"
    return "诗人"


def condense_prompt(poet, biography):
    return (
        "Below is the classical Chinese biography of the poet %s, taken from the "
        "全唐诗 author index. Rewrite it as ONE or TWO sentences of plain modern "
        "Simplified Chinese, at most 110 characters, for a learner opening this "
        "poet's collection in a Chinese poetry reading app. Keep only who they "
        "were, when they lived, and what they are known for. Do NOT add any fact "
        "that is not in the text below, and do not use quotation marks or a "
        "heading. Reply with the sentences only.\n\n%s" % (poet, biography)
    )


def condense_batch_prompt(chunk):
    """One call for several poets, **keyed by name**.

    A positional JSON array proved unsafe for *generation*: one batch returned
    纳兰性德's biography in 曹操's slot — paraphrased, so a duplicate check missed
    it — and a count-only parse accepted it. Keying the reply by each poet's own
    name makes the association explicit instead of positional.
    """
    listed = "\n\n".join("%s:\n%s" % (poet, biography)
                         for poet, biography, _source in chunk)
    return (
        "Below are the classical Chinese biographies of %d poets, taken from the "
        "全唐诗 author index. For EACH poet, rewrite that poet's OWN biography as "
        "ONE or TWO sentences of plain modern Simplified Chinese, at most 110 "
        "characters, for a learner opening that poet's collection in a Chinese "
        "poetry reading app. Keep only who they were, when they lived, and what "
        "they are known for. Do NOT add any fact, use no quotation marks or "
        "headings, and never carry text from one poet's entry into another's.\n"
        "Return ONLY a JSON object whose keys are exactly these poet names (any "
        "order) and whose values are the sentences, with no commentary:\n%s"
        % (len(chunk), listed))


def parse_object(text, names):
    """A `name -> text` mapping from the model's reply, or None if unusable."""
    if not text:
        print("    empty reply")
        return None
    cleaned = strip_fences(text)
    start, end = cleaned.find("{"), cleaned.rfind("}")
    if start == -1 or end == -1:
        print("    no object in reply: %s" % cleaned[:160].replace("\n", " "))
        return None
    try:
        values = json.loads(cleaned[start:end + 1])
    except Exception as error:  # noqa: BLE001
        print("    unparseable (%s): %s"
              % (type(error).__name__, cleaned[:160].replace("\n", " ")))
        return None
    if not isinstance(values, dict):
        print("    reply was a %s, not an object" % type(values).__name__)
        return None
    found = {name: values[name].strip() for name in names
             if isinstance(values.get(name), str) and values[name].strip()}
    if len(found) != len(names):
        print("    object covered %d of %d poets" % (len(found), len(names)))
    return found or None


def mentions_other_poet(poet, summary, all_poets):
    """True when a summary names a different poet and not its own subject.

    A legitimate biography can name a contemporary ("与李商隐齐名"), so this only
    fires when the subject is absent *and* another poet of ours is present — the
    exact signature of a slot that received the wrong poet's text.
    """
    if poet in summary:
        return False
    return any(other in summary for other in all_poets if other != poet)


def build(key, force=False):
    store = json.load(open(STORE, encoding="utf-8-sig"))
    counts, dynasty, by_poet = poet_facts(store)
    mapping = opencc_map()

    # A biography that already exists is never regenerated: it has been reviewed
    # and its 14 translations have been reviewed with it, and asking the model
    # again would return different words and silently invalidate all of them.
    # `--force` is for when the Chinese source genuinely changed.
    existing = {}
    if os.path.exists(BIOS) and not force:
        existing = json.load(open(BIOS, encoding="utf-8-sig"))
    kept = [p for p in counts
            if str((existing.get(p) or {}).get("summary") or "").strip()]
    if kept:
        print("keeping %d existing biographies (rerun with --force to rebuild)"
              % len(kept))

    # Every real source, in order of authority: the 全唐诗 author indexes, then
    # the single-poet READMEs, then the 词 side's own author index.
    sources = {}
    for label, resolver in (("authors index", corpus_bios),
                            ("anthology README", readme_bios),
                            ("宋词 author index", song_ci_bios)):
        for poet, (text, where) in resolver(mapping).items():
            sources.setdefault(poet, (text, "%s [%s]" % (where, label)))

    unsourced = [p for p in counts
                 if p not in sources and p not in COLLECTIVE_AUTHORS]
    wikidata = wikidata_descriptions(unsourced)
    covered = [p for p in counts
               if p in sources and p not in COLLECTIVE_AUTHORS]
    print("poets: %d   with a real source: %d   Wikidata only: %d   nothing: %d"
          % (len(counts), len(covered), len(wikidata),
             len([p for p in unsourced if p not in wikidata])))

    result = {}
    for poet in kept:
        result[poet] = existing[poet]
    # Collective names first: they must never be looked up as a person.
    for poet, text in COLLECTIVE_AUTHORS.items():
        if poet not in counts or poet in result:
            continue
        result[poet] = {"summary": text, "origin": "collective",
                        "source": "described from the collection's own sources"}
        print("  %-8s collective name, described the collection instead" % poet)
    # Only the poets this app actually publishes: the author indexes hold
    # thousands more, and writing biographies for those would grow the catalogue
    # past what any collection shows.
    with_bios = sorted([p for p in covered if p not in result],
                       key=lambda p: -counts[p])
    for start in range(0, len(with_bios), 5):
        chunk = [(p, sources[p][0], sources[p][1])
                 for p in with_bios[start:start + 5]]
        names = [poet for poet, _text, _where in chunk]
        values = parse_object(ask(key, condense_batch_prompt(chunk)), names)
        if values is None:
            print("  batch at %d unusable, falling back to one call per poet" % start)
            values = {}
        for poet, text, where in chunk:
            summary = (values.get(poet) or "").strip()
            if not summary:
                summary = (ask(key, condense_prompt(poet, text)) or "").strip()
            if summary and mentions_other_poet(poet, summary, with_bios):
                # A slot carrying another poet's name is a misaligned batch reply:
                # re-ask for this poet alone, which cannot misalign.
                print("  %-8s summary named another poet; re-asking individually"
                      % poet)
                summary = (ask(key, condense_prompt(poet, text)) or "").strip() or summary
            if summary:
                result[poet] = {"summary": summary, "origin": "source-text",
                                "source": "%s @%s" % (where, REVISION)}
                print("  %-8s condensed %d -> %d chars from %s"
                      % (poet, len(text), len(summary), where))
            else:
                result[poet] = {"summary": text[:110], "origin": "source-truncated",
                                "source": "%s @%s" % (where, REVISION)}
                print("  %-8s truncated the source" % poet)

    # Only a CC0 Wikidata one-liner exists: turn it into one sentence built from
    # the stated facts, inventing nothing.
    for poet in sorted([p for p in unsourced
                        if p in wikidata and p not in result],
                       key=lambda p: -counts[p]):
        fact, qid = wikidata[poet]
        era = DYNASTY_ERA.get(dynasty.get(poet, ""), "")
        genre = genre_from_sources(by_poet[poet])
        summary = (ask(key, compose_prompt(poet, fact, era, genre, counts[poet]))
                   or "").strip()
        if not summary:
            summary = "%s%s。本集收录 %d 首。" % (era, genre, counts[poet])
        result[poet] = {"summary": summary, "origin": "wikidata-cc0",
                        "source": "Wikidata %s (CC0)" % qid}
        print("  %-8s from Wikidata %s: %s" % (poet, qid, summary))

    # Nothing at all: only the dynasty, genre and size this app already records.
    for poet in sorted([p for p in unsourced
                        if p not in wikidata and p not in result],
                       key=lambda p: -counts[p]):
        era = DYNASTY_ERA.get(dynasty.get(poet, ""), "")
        genre = genre_from_sources(by_poet[poet])
        result[poet] = {
            "summary": "%s%s。本集收录 %d 首。" % (era, genre, counts[poet]),
            "origin": "derived-from-store",
            "source": "dynasty + corpus genre + poem count",
        }
        print("  %-8s no source, wrote a data-derived line" % poet)

    with open(BIOS, "w", encoding="utf-8", newline="\r\n") as handle:
        handle.write("\ufeff")
        json.dump(result, handle, ensure_ascii=False, indent=2)
        handle.write("\n")
    print("wrote %d summaries to %s" % (len(result), BIOS))
    return 0


def translate(key, only, budget, force=False):
    deadline = time.time() + budget
    order = list(json.load(open(BIOS, encoding="utf-8-sig")).items())
    locales = [pair for pair in LANGS if only is None or pair[0] == only]
    done = 0
    for locale, language in locales:
        path = os.path.join(L10N_DIR, PREFIX + locale + ".json")
        data = json.load(open(path, encoding="utf-8")) if os.path.exists(path) else {}
        if force:
            # The Chinese source changed, so every existing translation is stale.
            pending = [(poet, entry["summary"]) for poet, entry in order]
        else:
            pending = [(poet, entry["summary"]) for poet, entry in order
                       if not (data.get(poet) or "").strip()]
        if not pending:
            continue
        for start in range(0, len(pending), 20):
            if time.time() > deadline:
                print("%s: budget reached, %d left" % (locale, len(pending) - start))
                break
            chunk = pending[start:start + 20]
            numbered = "\n".join("%d. %s" % (i + 1, text)
                                 for i, (_poet, text) in enumerate(chunk))
            prompt = (
                "Translate these %d short Chinese poet biographies into %s for a "
                "Chinese-learning app. They are already 1-2 sentences each; keep "
                "them that length and do not shorten or expand them. Return ONLY a "
                "JSON array of %d strings in the same order, no commentary. Keep "
                "Chinese proper names in their usual %s form, and keep any dates "
                "and dynasty names. Where the Chinese names a literary genre or "
                "title (词, 曲, 诗, or a poem's name), render it as the recognised "
                "term in %s - for 词 that is 'ci' or the local name for the form, "
                "never a literal or invented word.\n\n%s"
                % (len(chunk), language, len(chunk), language, language, numbered))
            values = parse_array(ask(key, prompt), len(chunk),
                                 "%s@%d" % (locale, start))
            if values is None:
                print("%s: batch at %d failed, resumable - rerun to continue"
                      % (locale, start))
                break
            for (poet, _text), value in zip(chunk, values):
                data[poet] = value
                done += 1
            ordered = {poet: data[poet] for poet, _ in order if poet in data}
            for poet, value in data.items():
                ordered.setdefault(poet, value)
            # The l10n catalogues carry no BOM and use LF, so match them.
            with open(path, "w", encoding="utf-8", newline="\n") as handle:
                json.dump(ordered, handle, ensure_ascii=False, indent=2)
                handle.write("\n")
            print("%s: %d/%d translated"
                  % (locale, min(start + 20, len(pending)), len(pending)))
    print("translated this run: %d" % done)
    return 0


def main():
    argv = list(sys.argv[1:])
    only = None
    if "--only" in argv:
        index = argv.index("--only")
        only = argv[index + 1]
        del argv[index:index + 2]
    translate_mode = "--translate" in argv
    force = "--force" in argv
    if translate_mode:
        argv.remove("--translate")
    if force:
        argv.remove("--force")
    budget = float(argv[0]) if argv else 600.0
    key = load_key()
    if translate_mode:
        return translate(key, only, budget, force=force)
    return build(key, force=force)


if __name__ == "__main__":
    sys.exit(main())

