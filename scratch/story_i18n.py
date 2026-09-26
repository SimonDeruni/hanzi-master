#!/usr/bin/env python
"""Workflow for translating the micro-read titles and summaries by hand.

    python scratch/story_i18n.py --gaps
    python scratch/story_i18n.py --source titles 1 40
    python scratch/story_i18n.py --source summaries 1 5 --locale fr
    python scratch/story_i18n.py --apply scratch/story_i18n/fr.json

No network, no API keys: the translations are written into a JSON table and
merged here.

Canonical order
---------------
Stories 1..150 follow the order of `assets/data/mandarin_bean_stories.json`, and
every locale file is keyed by the same 150 links (verified 150/150 shared). So a
table can address stories by 1-based index instead of by URL, which is what
makes a 150-title batch fit in one readable file.

Table format
------------
    {"fr": {"1": {"title": "..."}, "2": {"title": "...", "summary": "..."}}}

Either field may be omitted. Values are written into
`assets/data/l10n/mandarin_bean_stories_<locale>.json`; files are rewritten in
the canonical order so every locale lines up, and English is the source
(`title_en` / `summary_en` from the base file).
"""
import argparse
import glob
import json
import os
import sys

BASE_FILE = os.path.join("assets", "data", "mandarin_bean_stories.json")
L10N_DIR = os.path.join("assets", "data", "l10n")
PREFIX = "mandarin_bean_stories_"


def load_base():
    """Returns the 150 (link, english title, english summary) triples in order."""
    with open(BASE_FILE, encoding="utf-8") as handle:
        raw = json.load(handle)
    stories = []
    for entry in raw:
        if not isinstance(entry, dict):
            continue
        link = entry.get("link")
        if not link:
            continue
        stories.append((
            link,
            entry.get("title_en") or entry.get("title") or "",
            entry.get("summary_en") or entry.get("summary") or "",
        ))
    return stories


def locale_path(locale):
    return os.path.join(L10N_DIR, PREFIX + locale + ".json")


def is_ascii(text):
    try:
        text.encode("ascii")
        return True
    except UnicodeEncodeError:
        return False


def command_gaps():
    stories = load_base()
    print("canonical stories: %d" % len(stories))
    print("%-4s %-8s %-9s" % ("loc", "titles", "summaries"))
    for path in sorted(glob.glob(os.path.join(L10N_DIR, PREFIX + "*.json"))):
        locale = os.path.basename(path)[len(PREFIX):-len(".json")]
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
        missing_titles = missing_summaries = 0
        for link, _title, _summary in stories:
            entry = data.get(link)
            if not isinstance(entry, dict):
                missing_titles += 1
                missing_summaries += 1
                continue
            value = entry.get("title") or ""
            if not value or is_ascii(value):
                missing_titles += 1
            value = entry.get("summary") or ""
            if not value or is_ascii(value):
                missing_summaries += 1
        print("%-4s %-8d %-9d" % (locale, missing_titles, missing_summaries))


def command_source(args):
    stories = load_base()
    locale = args.locale or "en"
    path = locale_path(locale)
    # English has no locale file of its own: the base file is the source.
    if os.path.exists(path):
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
    else:
        data = {}
    start = max(1, args.start or 1)
    end = min(len(stories), args.end or len(stories))
    for index in range(start, end + 1):
        link, title, summary = stories[index - 1]
        entry = data.get(link) or {}
        current = entry.get(args.source) or ""
        source = title if args.source == "title" else summary
        flag = "TODO" if (not current or is_ascii(current)) else "done"
        print("[%d] %s  %s" % (index, flag, source))


def command_apply(args):
    with open(args.apply, encoding="utf-8") as handle:
        table = json.load(handle)
    stories = load_base()
    total = 0
    for locale, entries in table.items():
        path = locale_path(locale)
        if not os.path.exists(path):
            print("skipping %s: no file at %s" % (locale, path))
            continue
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
        applied = 0
        for index_text, fields in entries.items():
            if index_text in ("titles", "summaries"):
                # Lean form: a list of consecutive values starting at --start.
                field = "title" if index_text == "titles" else "summary"
                for offset, value in enumerate(fields):
                    if not value:
                        continue
                    index = (args.start or 1) + offset
                    link = stories[index - 1][0]
                    entry = data.get(link)
                    if not isinstance(entry, dict):
                        entry = {"title": "", "summary": ""}
                        data[link] = entry
                    entry[field] = value
                    applied += 1
                continue
            index = int(index_text)
            if index < 1 or index > len(stories):
                print("  index out of range: %s" % index)
                continue
            link = stories[index - 1][0]
            entry = data.get(link)
            if not isinstance(entry, dict):
                entry = {"title": "", "summary": ""}
                data[link] = entry
            for field in ("title", "summary"):
                if fields.get(field):
                    entry[field] = fields[field]
                    applied += 1
        # Rewrite in canonical order so every locale file lines up.
        ordered = {}
        for link, _title, _summary in stories:
            if link in data:
                ordered[link] = data[link]
        for link, entry in data.items():
            if link not in ordered:
                ordered[link] = entry
        with open(path, "w", encoding="utf-8") as handle:
            json.dump(ordered, handle, ensure_ascii=False, indent=2)
            handle.write("\n")
        print("%-4s applied %d fields" % (locale, applied))
        total += applied
    print("total fields written: %d" % total)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--gaps", action="store_true")
    parser.add_argument("--source", choices=["titles", "summaries"])
    parser.add_argument("--locale")
    parser.add_argument("--start", type=int)
    parser.add_argument("--end", type=int)
    parser.add_argument("--apply")
    args = parser.parse_args()

    if args.gaps:
        command_gaps()
        return
    if args.apply:
        command_apply(args)
        return
    if args.source:
        args.source = "title" if args.source == "titles" else "summary"
        command_source(args)
        return
    parser.print_help()
    sys.exit(1)


if __name__ == "__main__":
    main()

