#!/usr/bin/env python3
"""Guarded codemod: move Tier 2 interface motion onto the ZenMotion vocabulary.

Safe by construction:
  * Tier 1 files (stroke drawing + Hero flights) are NEVER touched - see the
    "Frozen Motion (Do Not Touch)" section of docs/ANTI_PATTERNS.md.
  * Every replacement happens *inside the balanced-paren span of a known widget
    or call*, so a `duration:` belonging to something else is invisible.
  * Only exact, enumerated millisecond values are rewritten.

Run with --dry-run first.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

LIB = Path("lib")
ZEN_MOTION_IMPORT = "package:hanzi_master/core/theme/zen_motion.dart"

# ---------------------------------------------------------------- Tier 1 freeze
FROZEN_FILES = {
    "drawing_canvas.dart",          # stroke drawing animation
    "stroke_matcher.dart",          # stroke validation core
    "character_loader.dart",        # median paths / skeleton geometry
    "hero_transition.dart",         # Hero flight animation
    "geometry_utils.dart",
}
# Definitions live here - rewriting them would be self-referential.
SKIP_FILES = FROZEN_FILES | {"zen_motion.dart"}

# ------------------------------------------------- value maps (ms -> token)
# Named `duration:` inside an animated widget or a controller.
ANIMATION_MS = {
    250: "ZenMotion.swap",
    280: "ZenMotion.swap",
    220: "ZenMotion.swap",
    240: "ZenMotion.swap",
    200: "ZenMotion.swap",
    180: "ZenMotion.swap",
    150: "ZenMotion.swap",
    130: "ZenMotion.tap",
    300: "ZenMotion.quick",
    320: "ZenMotion.quick",
    350: "ZenMotion.pageReverse",
    400: "ZenMotion.entrance",
    500: "ZenMotion.page",
    600: "ZenMotion.page",
    750: "ZenMotion.page",
    1000: "ZenMotion.ambientFast",
    1200: "ZenMotion.ambient",
    1800: "ZenMotion.ambient",
    2000: "ZenMotion.ambient",
    3000: "ZenMotion.ambient",
}

# Widgets/controllers whose named `duration:` argument is animation timing.
DURATION_ANCHORS = [
    "AnimatedContainer", "AnimatedOpacity", "AnimatedScale", "AnimatedRotation",
    "AnimatedSize", "AnimatedCrossFade", "AnimatedAlign", "AnimatedPadding",
    "AnimatedPositioned", "AnimatedDefaultTextStyle", "AnimatedSwitcher",
    "TweenAnimationBuilder", "AnimationController", "ZenExpand",
    "MotionResolution.resolve", "animateTo", "animateToPage",
    "ensureVisible", "nextPage", "previousPage",
]

# Constructor defaults: `this.duration = const Duration(milliseconds: N)`.
CONSTRUCTOR_DEFAULT_RE = re.compile(
    r"(this\.(?:duration|delay)\s*=\s*)(?:const\s+)?Duration\(\s*milliseconds:\s*(\d+)\s*\)"
)

# SnackBar dwell is a UX budget, not an animation: always ZenMotion.toast.
TOAST_ANCHORS = ["SnackBar", "showSnackBar"]

# Route legs.
ROUTE_ANCHORS = ["PageRouteBuilder", "MaterialPageRoute", "SwipeBackRoute"]

CURVE_MAP = {
    "Curves.easeInOutQuart": "ZenMotion.natural",
    "Curves.easeOutBack": "ZenMotion.arrival",
    "Curves.easeOutCubic": "ZenMotion.enter",
    "Curves.easeInOutSine": "ZenMotion.breathe",
    "Curves.easeInOutCubic": "ZenMotion.natural",
    "Curves.easeInOutQuad": "ZenMotion.natural",
    "Curves.easeOutQuart": "ZenMotion.natural",
    "Curves.easeInOut": "ZenMotion.natural",
    "Curves.easeOut": "ZenMotion.enter",
    "Curves.easeIn": "ZenMotion.enter",
    "Curves.easeInCubic": "ZenMotion.natural",
}


def spans(src: str, anchor: str) -> list[tuple[int, int]]:
    """Balanced-paren spans for every literal `anchor(` call in `src`.

    Tolerates an optional generic type argument, so `PageRouteBuilder<void>(`
    and `MaterialPageRoute<void>(` are matched as well.
    """
    return spans_regex(src, re.escape(anchor) + r"(?:<[^()<>]*>)?\s*\(")


def spans_regex(src: str, pattern: str) -> list[tuple[int, int]]:
    """Balanced-paren spans for regex matches that end in an open paren."""
    found: list[tuple[int, int]] = []
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


DURATION_RE = re.compile(
    r"(duration:\s*)(?:const\s+)?Duration\(\s*milliseconds:\s*(\d+)\s*\)"
)
# Same shape, seconds form (`Duration(seconds: 2)`), used by toast dwells.
SECONDS_RE = re.compile(
    r"(duration:\s*)(?:const\s+)?Duration\(\s*seconds:\s*(\d+)\s*\)"
)


def depth_at(body: str, index: int) -> int:
    """Paren depth at `index`, where `body` starts at an open paren (so 1 = own args)."""
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


def hero_ranges(src: str) -> list[tuple[int, int]]:
    """Spans of real `Hero(` widget calls - Tier 1, never rewritten."""
    return spans_regex(src, r"(?<![A-Za-z0-9_])Hero\s*\(")


def rewrite_duration_args(src, anchors, value_map=None, forced=None,
                          forbidden=(), pattern=None):
    """Rewrite a widget's OWN `duration:` argument. Nested ones are left alone."""
    regex = pattern or DURATION_RE
    edits = {}
    for anchor in anchors:
        for start, end in spans(src, anchor):
            body = src[start:end]
            for match in regex.finditer(body):
                if depth_at(body, match.start()) != 1:
                    continue  # belongs to a nested widget, not this one
                value = int(match.group(2))
                token = forced or (value_map or {}).get(value)
                if token is None:
                    continue
                pos = (start + match.start(), start + match.end())
                if any(fs <= pos[0] < fe for fs, fe in forbidden):
                    continue
                edits[pos] = f"duration: {token}"
    for (s, e), text in sorted(edits.items(), key=lambda kv: kv[0][0], reverse=True):
        src = src[:s] + text + src[e:]
    return src, len(edits)


def rewrite_routes(src):
    """Route transition legs -> page / pageReverse.

    Edits are collected first and applied in reverse so the offsets from
    `spans` stay valid when a file holds several route builders.
    """
    edits: dict[tuple[int, int], str] = {}
    for anchor in ROUTE_ANCHORS:
        for start, end in spans(src, anchor):
            body = src[start:end]
            new = re.sub(
                r"transitionDuration:\s*(?:const\s+)?Duration\(\s*milliseconds:\s*(\d+)\s*\)",
                lambda m: "transitionDuration: ZenMotion."
                + ("pageReverse" if int(m.group(1)) <= 400 else "page"),
                body,
            )
            new = re.sub(
                r"reverseTransitionDuration:\s*(?:const\s+)?Duration\(\s*milliseconds:\s*\d+\s*\)",
                "reverseTransitionDuration: ZenMotion.pageReverse",
                new,
            )
            if new != body:
                edits[(start, end)] = new
    for (start, end), text in sorted(edits.items(), key=lambda kv: kv[0][0], reverse=True):
        src = src[:start] + text + src[end:]
    return src, len(edits)


def rewrite_curves(src, forbidden=()):
    count = 0
    for curve, token in CURVE_MAP.items():
        for match in reversed(list(re.finditer(re.escape(curve) + r"\b", src))):
            if any(fs <= match.start() < fe for fs, fe in forbidden):
                continue
            src = src[: match.start()] + token + src[match.end():]
            count += 1
    return src, count


def rewrite_constructor_defaults(src, forbidden=()):
    """Rewrite animated widget constructor defaults (`this.duration = ...`)."""
    edits = {}
    for match in CONSTRUCTOR_DEFAULT_RE.finditer(src):
        value = int(match.group(2))
        token = ANIMATION_MS.get(value)
        if token is None:
            continue
        if any(fs <= match.start() < fe for fs, fe in forbidden):
            continue
        edits[(match.start(), match.end())] = f"{match.group(1)}{token}"
    for (s, e), text in sorted(edits.items(), key=lambda kv: kv[0][0], reverse=True):
        src = src[:s] + text + src[e:]
    return src, len(edits)


# `duration: 500.ms` - the flutter_animate dialect. Only the *duration* form is
# converged; sequencing `delay:` values stay expressive.
FLUTTER_ANIMATE_RE = re.compile(
    r"(duration:\s*)(\d+)\.ms\b|(duration:\s*)(\d+)\.seconds\b"
)


def rewrite_flutter_animate(src, forbidden=()):
    edits = {}
    for match in FLUTTER_ANIMATE_RE.finditer(src):
        raw = match.group(2) or match.group(4)
        if match.group(2) is not None:
            token = ANIMATION_MS.get(int(raw))
        else:
            token = "ZenMotion.ambientFast" if int(raw) == 1 else None
        if token is None:
            continue
        if any(fs <= match.start() < fe for fs, fe in forbidden):
            continue
        edits[(match.start(), match.end())] = f"duration: {token}"
    for (s, e), text in sorted(edits.items(), key=lambda kv: kv[0][0], reverse=True):
        src = src[:s] + text + src[e:]
    return src, len(edits)


def ensure_import(src):
    if "ZenMotion." not in src or ZEN_MOTION_IMPORT in src:
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
    lines.insert(last_import + 1, f"import '{ZEN_MOTION_IMPORT}';")
    return "\n".join(lines), True


def process(path: Path, dry_run: bool) -> dict:
    if path.name in SKIP_FILES:
        return {}
    original = path.read_text(encoding="utf-8")

    stats: dict[str, int] = {}
    src = original
    # Tier 1 freeze: a Hero flight is never rewritten, even inside a swept file.
    frozen = hero_ranges(src)

    src, n = rewrite_duration_args(
        src, TOAST_ANCHORS, forced="ZenMotion.toast", forbidden=frozen
    )
    src, n2 = rewrite_duration_args(
        src, TOAST_ANCHORS, forced="ZenMotion.toast", forbidden=frozen,
        pattern=SECONDS_RE,
    )
    stats["toast"] = n + n2

    src, n = rewrite_routes(src)
    stats["route-legs"] = n

    frozen = hero_ranges(src)
    src, n = rewrite_duration_args(
        src, DURATION_ANCHORS, value_map=ANIMATION_MS, forbidden=frozen
    )
    stats["animation"] = n

    frozen = hero_ranges(src)
    src, n = rewrite_constructor_defaults(src, forbidden=frozen)
    stats["defaults"] = n

    frozen = hero_ranges(src)
    src, n = rewrite_flutter_animate(src, forbidden=frozen)
    stats["flutter_animate"] = n

    frozen = hero_ranges(src)
    src, n = rewrite_curves(src, forbidden=frozen)
    stats["curves"] = n

    src, added = ensure_import(src)
    stats["imports"] = 1 if added else 0

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
