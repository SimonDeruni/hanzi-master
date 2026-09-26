"""Print the line a Dart call opens on and the line it closes on.

Used while wrapping a screen body in `ZenContentPane` / a wide branch: guessing
the closing paren by eye is how you break a 900-line screen.

Run:  python scratch/find_close.py <file> "<call fragment>" [more fragments...]
"""

from __future__ import annotations

import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))

from ipad_adoption import call_span, read  # noqa: E402


def report(path: pathlib.Path, needle: str) -> None:
    text = read(path)
    cursor = 0
    found = False
    while True:
        at = text.find(needle, cursor)
        if at == -1:
            break
        cursor = at + len(needle)
        found = True
        open_line = text.count("\n", 0, at) + 1
        span = call_span(text, at, needle.rstrip("("))
        if span is None:
            print(f"  line {open_line}: {needle}  -> (not a call)")
            continue
        close = span[2]
        print(
            f"  line {open_line}: {needle}  -> closes on line "
            f"{text.count(chr(10), 0, close) + 1}"
        )
    if not found:
        print(f"  {needle}: not found")


def main() -> None:
    if len(sys.argv) < 3:
        print(__doc__)
        return
    path = pathlib.Path(sys.argv[1])
    print(f"{path.as_posix()}  ({len(read(path).splitlines())} lines)")
    for needle in sys.argv[2:]:
        report(path, needle)


if __name__ == "__main__":
    main()
