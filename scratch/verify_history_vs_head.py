"""Compare the VSCode local-history version of two files against git HEAD.

Byte-accurate: reads both sides as UTF-8 text and normalises line endings, so a
BOM or CRLF difference cannot produce a false mismatch.
"""
from __future__ import annotations

import hashlib
import json
import os
import subprocess
from pathlib import Path

FILES = {
    "auth_screen.dart": "lib/features/auth/presentation/screens/auth_screen.dart",
    "tome_manager_screen.dart": "lib/features/course/presentation/screens/tome_manager_screen.dart",
}

history_root = Path(os.environ["APPDATA"]) / "Code" / "User" / "History"


def normalise(text: str) -> str:
    return text.lstrip("\ufeff").replace("\r\n", "\n")


def digest(text: str) -> str:
    return hashlib.sha256(normalise(text).encode("utf-8")).hexdigest()[:16]


for label, repo_path in FILES.items():
    head_raw = subprocess.run(
        ["git", "show", f"HEAD:{repo_path}"],
        capture_output=True,
        cwd=".",
    ).stdout.decode("utf-8", errors="replace")

    found = False
    for folder in history_root.iterdir():
        entries = folder / "entries.json"
        if not entries.is_file():
            continue
        data = json.loads(entries.read_text(encoding="utf-8"))
        if not data.get("resource", "").endswith(label):
            continue
        for version in data["entries"]:
            blob = folder / version["id"]
            blob_text = blob.read_text(encoding="utf-8", errors="replace")
            same = digest(blob_text) == digest(head_raw)
            print(
                f"{label}\n"
                f"    history version : {version['id']}  ({version.get('timestamp')})\n"
                f"    history sha     : {digest(blob_text)}\n"
                f"    HEAD sha        : {digest(head_raw)}\n"
                f"    IDENTICAL TO HEAD: {same}"
            )
            found = True
    if not found:
        print(f"{label}: no local-history entry found")
