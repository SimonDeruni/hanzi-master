"""Scrub the leaked Azure Speech key out of every tracked file.

`lib/core/services/api_key_pool.dart` was only the visible instance: a single
`git grep` finds the same live, metered credential in a CI config, four dev
scripts and - worst of all - a **shipped web page** (`web_audiobook/index.html`)
that hands it to every visitor.

Replacement is context-aware, because a blind swap would break CI:

  * `codemagic.yaml` becomes a secret reference (`$AZURE_SPEECH_KEY`), which is
    the correct Codemagic pattern anyway - the literal must never be there.
  * everything else becomes `MISSING_KEY_SEE_ISSUES`, which fails loudly.

**Deleting the literal does not un-leak the key.** It must be rotated in the
Azure portal; see the URGENT entry in ISSUES.md.

Dry run by default.  Pass --apply to write.
"""

import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:\Users\simon\Documents\hanzi_master")
LEAKED = "AnZ5l470hrJMMOqPYYH085lWbpFHjRH8nZCkryg0TWFF8yaVzDdOJQQJ99CGACPV0roXJ3w3AAAYACOGk7C0"
PLACEHOLDER = "MISSING_KEY_SEE_ISSUES"
# A CI file must keep working, so it gets a secret reference rather than a
# placeholder: the value belongs in Codemagic's own secret store, not in git.
CI_REFERENCE = "$AZURE_SPEECH_KEY"
CI_FILES = ("codemagic.yaml",)


def _tracked_hits() -> list:
    """Files git knows about that contain the literal (fast, and ignores build dirs)."""
    result = subprocess.run(
        ["git", "grep", "-l", "-F", LEAKED],
        cwd=ROOT,
        capture_output=True,
        text=True,
    )
    return [line.strip() for line in result.stdout.splitlines() if line.strip()]


def main() -> int:
    apply = "--apply" in sys.argv
    print("MODE:", "APPLY" if apply else "DRY RUN")

    hits = _tracked_hits()
    print("tracked files containing the leaked key: %d" % len(hits))
    for relative in hits:
        replacement = CI_REFERENCE if relative in CI_FILES else PLACEHOLDER
        print("  %-42s -> %s" % (relative, replacement))
        if apply:
            path = ROOT / relative
            text = path.read_text(encoding="utf-8")
            path.write_text(text.replace(LEAKED, replacement), encoding="utf-8")

    if apply:
        left = _tracked_hits()
        if left:
            print("FAILED - still present in: %s" % ", ".join(left))
            return 1
        print("post-condition: the literal is gone from every tracked file")
        print("REMINDER: rotate the credential - it is still valid, and it is in git history.")
    print("OK" + ("" if apply else "  (dry run - re-run with --apply)"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
