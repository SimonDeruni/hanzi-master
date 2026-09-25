#!/usr/bin/env python3
"""Repair the imports the undo script wrongly stripped.

`undo_screen_reveals.py` removed `import .../zen_loader.dart` from files where it
was only there for `ZenFadeIn` - but several of those files also use `ZenLoader`,
so the import had to stay. This restores it wherever the symbol is used and the
import is missing.
"""
from __future__ import annotations

import re
from pathlib import Path

LIB = Path("lib")
IMPORT_LINE = "import 'package:hanzi_master/shared/widgets/zen_loader.dart';"
DEFINITION_FILE = "zen_loader.dart"

fixed = 0
for path in sorted(LIB.rglob("*.dart")):
    if path.name == DEFINITION_FILE or path.name.endswith(".g.dart"):
        continue
    src = path.read_text(encoding="utf-8")
    uses = re.search(r"\bZen(Loader|FadeIn)\b", src)
    if not uses or IMPORT_LINE in src:
        continue
    lines = src.split("\n")
    last = max(
        (i for i, l in enumerate(lines) if l.lstrip("\ufeff").startswith("import ")),
        default=None,
    )
    if last is None:
        print(f"SKIP (no imports) {path.as_posix()}")
        continue
    lines.insert(last + 1, IMPORT_LINE)
    path.write_text("\n".join(lines), encoding="utf-8")
    print(f"restored import: {path.as_posix()}")
    fixed += 1

print(f"total restored: {fixed}")
