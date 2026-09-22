#!/usr/bin/env python3
"""Guarded codemod: make one-shot interface animations honour "Reduce Motion".

`docs/UI_UX_STANDARDS.md` requires every one-shot animation to collapse to
`Duration.zero` when the platform asks for reduced motion. The single-line form
is `ZenMotion.of(context, <token>)`.

Tier 1 files (stroke drawing + Hero flights) are never touched.
Run with --dry-run first.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

LIB = Path("lib")
MOTION_IMPORT = "package:hanzi_master/shared/utils/motion_preferences.dart"

FROZEN_FILES = {
    "drawing_canvas.dart",
    "stroke_matcher.dart",
    "character_loader.dart",
    "hero_transition.dart",
    "geometry_utils.dart",
}

SKIP_FILES = FROZEN_FILES | {"zen_motion.dart", "motion_preferences.dart"}

# Widgets whose named `duration:` is evaluated inside `build`, so `context` exists.
# `AnimatedSize` is deliberately absent: `Duration.zero` makes RenderAnimatedSize
# re-dirty itself during layout and throw (docs/ANTI_PATTERNS.md). Return the
# child unwrapped instead, as `ZenExpand` does.
ANIMATED_ANCHORS = [
    "AnimatedContainer", "AnimatedOpacity", "AnimatedScale", "AnimatedRotation",
    "AnimatedCrossFade", "AnimatedAlign", "AnimatedPadding",
    "AnimatedPositioned", "AnimatedDefaultTextStyle", "AnimatedSwitcher",
    "TweenAnimationBuilder",
]

# Route builders we can also collapse (their legs are explicit animations).
ROUTE_ANCHORS = ["PageRouteBuilder"]

TOKEN_DURATION_RE = re.compile(r"duration:\s*ZenMotion\.(?!of\b)(\w+)")
TOKEN_ROUTE_RE = re.compile(
    r"(?:reverse)?transitionDuration:\s*ZenMotion\.(?!of\b)(\w+)"
)
# `flutter_animate` chains, e.g. `.fade(duration: ZenMotion.page)`. These always
# live in a `build`, so `context` is available.
FLUTTER_ANIMATE_EFFECT_RE = re.compile(
    r"(\.(?:fade|fadeIn|fadeOut|slideY|slideX|slide|scale|scaleXY|blur|tint)"
    r"\(duration:\s*)ZenMotion\.(?!of\b)(\w+)"
)


def spans(src: str, anchor: str) -> list[tuple[int, int]]:
    found: list[tuple[int, int]] = []
    pattern = re.escape(anchor) + r"(?:<[^()<>]*>)?\s*\("
    for match in re.finditer(pattern, src):
        open_paren = src.rindex("(", match.start(), match.end())
        depth, i = 0, open_paren
        while i < len(src):
            char = src[i]
            if char in "\"'":
                quote = char
                i += 1
                while i < len(src) and src[i] != quote:
                    i += 2 if src[i] == "\\" else 1
            elif char == "(":
                depth += 1
            elif char == ")":
                depth -= 1
                if depth == 0:
                    found.append((open_paren, i + 1))
                    break
            i += 1
    return found


def depth_at(body: str, index: int) -> int:
    depth, i = 0, 0
    while i < index:
        char = body[i]
        if char in "\"'":
            quote = char
            i += 1
            while i < index and body[i] != quote:
                i += 2 if body[i] == "\\" else 1
        elif char == "(":
            depth += 1
        elif char == ")":
            depth -= 1
        i += 1
    return depth


def wrap(src: str, anchor: str, regex: re.Pattern) -> tuple[str, int]:
    """Wrap a token duration in `ZenMotion.of(context, ...)` inside one anchor."""
    edits: dict[tuple[int, int], str] = {}
    drop_const_at: set[int] = set()
    for start, end in spans(src, anchor):
        body = src[start:end]
        for match in regex.finditer(body):
            if depth_at(body, match.start()) != 1:
                continue  # nested widget's argument
            if "ZenMotion.of(" in match.group(0):
                continue
            pos = (start + match.start(), start + match.end())
            text = match.group(0)
            token = re.search(r"ZenMotion\.\w+", text).group(0)
            name = text.split(":", 1)[0].strip()
            edits[pos] = f"{name}: ZenMotion.of(context, {token})"
            # A `const` parent would no longer compile with a runtime value.
            prefix = src[:start].rstrip()
            if prefix.endswith("const"):
                drop_const_at.add(len(prefix) - len("const"))
    for position in sorted(drop_const_at, reverse=True):
        src = src[:position] + " " * len("const") + src[position + len("const"):]
    for (s, e), text in sorted(edits.items(), key=lambda kv: kv[0][0], reverse=True):
        src = src[:s] + text + src[e:]
    return src, len(edits)


def ensure_motion_import(src: str) -> tuple[str, bool]:
    """Adds the `reduceMotion` extension import where it is now used."""
    if "context.reduceMotion" not in src or MOTION_IMPORT in src:
        return src, False
    lines = src.split("\n")
    last_import = max(
        (
            i
            for i, line in enumerate(lines)
            if line.lstrip("\ufeff").startswith("import ")
        ),
        default=None,
    )
    if last_import is None:
        return src, False
    lines.insert(last_import + 1, f"import '{MOTION_IMPORT}';")
    return "\n".join(lines), True


def process(path: Path, dry_run: bool) -> dict:
    if path.name in SKIP_FILES:
        return {}
    original = path.read_text(encoding="utf-8")
    src = original
    stats: dict[str, int] = {}

    total_animated = 0
    for anchor in ANIMATED_ANCHORS:
        src, n = wrap(src, anchor, TOKEN_DURATION_RE)
        total_animated += n
    stats["animated"] = total_animated

    total_routes = 0
    for anchor in ROUTE_ANCHORS:
        src, n = wrap(src, anchor, TOKEN_ROUTE_RE)
        total_routes += n
    stats["routes"] = total_routes

    # flutter_animate effect durations (always inside a `build`).
    def _wrap_effect(match: re.Match) -> str:
        return f"{match.group(1)}ZenMotion.of(context, ZenMotion.{match.group(2)})"

    src, n = FLUTTER_ANIMATE_EFFECT_RE.subn(_wrap_effect, src)
    stats["animate-chain"] = n

    src, added = ensure_motion_import(src)
    stats["motion-import"] = 1 if added else 0

    total = sum(stats.values())
    if total and src != original and not dry_run:
        path.write_text(src, encoding="utf-8")
    return {k: v for k, v in stats.items() if v} if total else {}


def main() -> int:
    dry_run = "--dry-run" in sys.argv
    grand: dict[str, int] = {}
    touched = 0
    for path in sorted(LIB.rglob("*.dart")):
        if path.name.endswith(".g.dart"):
            continue
        stats = process(path, dry_run)
        if not stats:
            continue
        touched += 1
        detail = ", ".join(f"{k}={v}" for k, v in sorted(stats.items()))
        print(f"{path.as_posix()}: {detail}")
        for key, value in stats.items():
            grand[key] = grand.get(key, 0) + value
    print("-" * 60)
    mode = "DRY RUN - nothing written" if dry_run else "APPLIED"
    print(f"{mode}  files={touched}  totals={grand}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
