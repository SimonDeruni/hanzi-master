"""Debug: why does scan_value not terminate for auth_screen's Scaffold body?"""
import importlib.util
import sys
from pathlib import Path

spec = importlib.util.spec_from_file_location(
    "asr", Path("scratch/add_screen_reveals.py")
)
asr = importlib.util.module_from_spec(spec)
sys.modules["asr"] = asr
spec.loader.exec_module(asr)

src = Path("lib/features/auth/presentation/screens/auth_screen.dart").read_text(
    encoding="utf-8"
)
placements = asr.spans(src, "Scaffold")
print(f"Scaffold spans found: {len(placements)}")
for open_paren, close in placements:
    line = src.count("\n", 0, open_paren) + 1
    print(f"  span at line {line}, len {close - open_paren} chars")
    body = src[open_paren:close]
    for m in __import__("re").finditer(r"\bbody:\s*", body):
        d = asr.depth_at(body, m.start())
        print(f"    body: at rel {m.start()} depth={d}")
        if d == 1:
            start = open_paren + m.end()
            end = asr.scan_value(src, start)
            print(f"      value starts {repr(src[start:start+25])}")
            print(f"      scan_value -> {end} (file len {len(src)})")
            print(f"      value tail: {repr(src[max(start, end-45):end])}")
            print(f"      char at end: {repr(src[end:end+1])}")
