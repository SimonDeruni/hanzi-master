#!/usr/bin/env python
"""Merges poem summaries into the poetry l10n store, keyed by poem order.

    python scratch/poetry_i18n.py --gaps
    python scratch/poetry_i18n.py --apply th scratch/poetry_i18n/th_part1.json scratch/poetry_i18n/th_part2.json

`assets/data/l10n/poetry_<locale>.json` is keyed by poem id and holds
`title` + `summary`. Story 1..N maps to the order of
`assets/data/famous_chinese_poetry.json`, so a translation table can be a plain
JSON list of summaries in that order, split across as many files as is
convenient.

No network: the translations are written by hand and merged here.
"""
import argparse
import glob
import json
import os

SOURCE = os.path.join("assets", "data", "famous_chinese_poetry.json")
L10N_DIR = os.path.join("assets", "data", "l10n")


def load_source():
    with open(SOURCE, encoding="utf-8-sig") as handle:
        raw = json.load(handle)
    rows = raw if isinstance(raw, list) else list(raw.values())
    return [r for r in rows if isinstance(r, dict) and r.get("id")]


def locale_path(locale):
    return os.path.join(L10N_DIR, "poetry_%s.json" % locale)


def command_gaps():
    rows = load_source()
    print("poems: %d" % len(rows))
    print("%-4s %-8s %-9s" % ("loc", "titles", "summaries"))
    for path in sorted(glob.glob(os.path.join(L10N_DIR, "poetry_*.json"))):
        locale = os.path.basename(path)[len("poetry_"):-len(".json")]
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
        missing_title = missing_summary = 0
        for row in rows:
            entry = data.get(row["id"])
            if not isinstance(entry, dict) or not (entry.get("title") or "").strip():
                missing_title += 1
            if not isinstance(entry, dict) or not (entry.get("summary") or "").strip():
                missing_summary += 1
        print("%-4s %-8d %-9d" % (locale, missing_title, missing_summary))


def command_apply(args):
    rows = load_source()
    values = []
    for path in args.files:
        with open(path, encoding="utf-8") as handle:
            values.extend(json.load(handle))
    path = locale_path(args.locale)
    with open(path, encoding="utf-8") as handle:
        data = json.load(handle)

    applied = 0
    for row, value in zip(rows, values):
        if not value:
            continue
        entry = data.get(row["id"])
        if not isinstance(entry, dict):
            entry = {"title": "", "summary": ""}
            data[row["id"]] = entry
        entry["summary"] = value
        applied += 1

    ordered = {row["id"]: data[row["id"]] for row in rows if row["id"] in data}
    for poem_id, entry in data.items():
        if poem_id not in ordered:
            ordered[poem_id] = entry
    with open(path, "w", encoding="utf-8") as handle:
        json.dump(ordered, handle, ensure_ascii=False, indent=2)
        handle.write("\n")
    print("%s: applied %d summaries" % (args.locale, applied))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--gaps", action="store_true")
    parser.add_argument("--apply")
    parser.add_argument("--locale")
    parser.add_argument("files", nargs="*")
    args = parser.parse_args()
    if args.gaps:
        command_gaps()
        return
    if args.apply:
        args.locale = args.apply
        command_apply(args)
        return
    parser.print_help()


if __name__ == "__main__":
    main()
