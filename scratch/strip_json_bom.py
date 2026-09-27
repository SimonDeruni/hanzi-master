#!/usr/bin/env python
"""Strips the UTF-8 BOM that audit 37 found on `famous_chinese_poetry.json`.

    python scratch/_strip_bom.py

Dart's decoder tolerates a BOM, strict JSON parsers reject it - this very session
hit that when a survey script crashed reading the file with a plain `utf-8`
reader. Also sweeps the other bundled asset JSON for the same defect.
"""
import os

TARGETS = [
    os.path.join("assets", "data", "famous_chinese_poetry.json"),
    # Found by the same sweep on 2026-09-27: the second file in the bundle that
    # opened with a BOM. Both readers are Dart so neither had visible symptoms,
    # but every Python tool that touches the corpus had to special-case them.
    os.path.join("assets", "data", "poet_bios.json"),
]


def strip(path):
    raw = open(path, "rb").read()
    if raw.startswith(b"\xef\xbb\xbf"):
        with open(path, "wb") as handle:
            handle.write(raw[3:])
        return "stripped"
    return "clean"


def main():
    for path in TARGETS:
        if not os.path.exists(path):
            print("%-46s missing" % path)
            continue
        print("%-46s %s" % (path, strip(path)))
    # Report any other bundled JSON that carries one, so this cannot rot back.
    others = []
    for root, _dirs, files in os.walk(os.path.join("assets", "data")):
        for name in files:
            if name.endswith(".json"):
                path = os.path.join(root, name)
                if open(path, "rb").read(3) == b"\xef\xbb\xbf":
                    others.append(path)
    print("other BOM'd JSON under assets/data: %d %s" % (len(others), others[:5]))


if __name__ == "__main__":
    main()
