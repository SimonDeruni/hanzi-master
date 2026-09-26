"""Give every story-generation call the `useCache: !forceRegenerate` bypass.

`gemini_service.dart` contains **two** near-identical story methods that share the
exact same call text, so a targeted edit cannot be anchored uniquely - it matched
twice and refused, correctly. Hand-wiring one of them would have left the other
regenerating from the cache, which is a bug the user would have met as "I pressed
regenerate and nothing changed".

So: for each `final text = await makeOpenRouterCall(` line, walk backwards to find
whether the enclosing method takes a `forceRegenerate` parameter, and only then
insert the bypass, preserving indentation. Idempotent, and the post-condition is
asserted rather than assumed.

Dry run by default; pass --apply to write.
"""

import re
import sys
from pathlib import Path

TARGET = Path(r"C:\Users\simon\Documents\hanzi_master\lib\core\services\gemini_service.dart")
CALL_OPEN = re.compile(r"^(\s*)final text = await makeOpenRouterCall\($")
# A method that offers a regeneration switch, e.g.
#   {bool forceRegenerate = false}) async {
SIGNATURE = re.compile(r"forceRegenerate")
BYPASS = "useCache: !forceRegenerate,"
COMMENT = "// A deliberate regeneration must not be answered from the cache."


def enclosing_method_is_regenerable(lines: list, index: int) -> bool:
    """Look backwards from a call for the nearest enclosing method signature."""
    for back in range(index - 1, max(0, index - 400) - 1, -1):
        line = lines[back]
        if SIGNATURE.search(line) and "bool forceRegenerate" in line:
            return True
        # A method boundary with a closing brace at the body indent ends the search.
        if re.match(r"^  \}\s*$", line) and "forceRegenerate" not in line:
            return False
    return False


def main() -> int:
    apply = "--apply" in sys.argv
    lines = TARGET.read_text(encoding="utf-8").splitlines()
    print("MODE:", "APPLY" if apply else "DRY RUN")

    inserts = []  # (line_index_of_call_open, indent_of_param)
    for i, line in enumerate(lines):
        match = CALL_OPEN.match(line)
        if not match:
            continue
        # Already wired? (idempotence)
        if any(BYPASS in nxt for nxt in lines[i + 1:i + 8]):
            continue
        if not enclosing_method_is_regenerable(lines, i):
            continue
        inserts.append((i, match.group(1) + "  "))

    print("calls that need the bypass: %d" % len(inserts))
    for index, indent in inserts:
        print("  line %d -> %s%s" % (index + 1, indent, BYPASS))

    if apply:
        for index, indent in reversed(inserts):
            lines[index + 1:index + 1] = ["%s%s" % (indent, COMMENT), "%s%s" % (indent, BYPASS)]
        TARGET.write_text("\n".join(lines) + "\n", encoding="utf-8")

        # Post-condition: no covered call remains.
        after = TARGET.read_text(encoding="utf-8").splitlines()
        uncovered = [
            i + 1
            for i, line in enumerate(after)
            if CALL_OPEN.match(line)
            and enclosing_method_is_regenerable(after, i)
            and not any(BYPASS in nxt for nxt in after[i + 1:i + 8])
        ]
        if uncovered:
            print("FAILED - still uncovered at lines: %s" % uncovered)
            return 1
        print("post-condition: every regenerable story call bypasses the cache")
    print("OK" + ("" if apply else "  (dry run - re-run with --apply)"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
