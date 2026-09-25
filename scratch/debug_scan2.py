"""Find where the depth counter desynchronises inside the Scaffold body."""
import importlib.util
import re
import sys
from pathlib import Path

spec = importlib.util.spec_from_file_location(
    "asr", Path("scratch/add_screen_reveals.py")
)
asr = importlib.util.module_from_spec(spec)
sys.modules["asr"] = asr
spec.loader.exec_module(asr)

path = "lib/features/auth/presentation/screens/auth_screen.dart"
src = Path(path).read_text(encoding="utf-8")
open_paren, close = asr.spans(src, "Scaffold")[0]
body = src[open_paren:close]
match = next(m for m in re.finditer(r"\bbody:\s*", body) if asr.depth_at(body, m.start()) == 1)
start = open_paren + match.end()

# Walk to the Scaffold's own closing paren and report the running depth.
depth, i = start, 0
while i < close + 1:
    nxt = asr.advance(src, i)
    if nxt != i:
        i = nxt
        continue
    char = src[i]
    if char in "([{":
        depth += 1
    elif char in ")]}":
        depth -= 1
        if i == close:
            print(f"depth at the Scaffold close: {depth + 1} (expected 1)")
            break
    i += 1

# Per-line net balance, with the skipper, to spot the odd line.
depth = 0
for number, line in enumerate(src[: close + 1].split("\n"), start=1):
    j = 0
    while j < len(line):
        nxt = asr.advance(line, j)
        if nxt != j:
            j = nxt
            continue
        if line[j] in "([{":
            depth += 1
        elif line[j] in ")]}":
            depth -= 1
        j += 1
    if number >= 309:
        print(f"line {number:4d} depth={depth:3d}  {line.strip()[:70]}")
