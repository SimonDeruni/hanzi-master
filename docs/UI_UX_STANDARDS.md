# 🖌️ Hanzi Master - UI/UX & Aesthetic Standards

This document defines the visual language of the application to ensure consistency.

---

## 🎨 Color Palette (The "Calligraphy" Theme)
*   **Paper (Background):** `#FDFCF0` (Warm Xuan Paper).
*   **Ink (Text/Strokes):** `#1A1A1B` (Deep Carbon Ink).
*   **Guide (Guidance):** `#3F51B5` (Indigo Silk - 10% opacity for guides).
*   **Success:** `#2E7D32` (Jade Green).
*   **Error:** `#C62828` (Cinnabar Red).

## 📐 Spacing & Layout
*   **The Grid:** All margins/paddings must be multiples of **8dp**.
*   **Safe Zones:** Large characters must have at least **40dp** of padding from the canvas edge.
*   **Aspect Ratio:** Drawing surfaces MUST be **1:1** squares.

## ⏳ Loading States
*   **Never use a bare spinner for a section or screen.** Use `ZenLoader`
    (`lib/shared/widgets/zen_loader.dart`): it fades in with a small upward drift
    instead of appearing in a single frame, and it accepts the same options as
    `CircularProgressIndicator` (`color`, `strokeWidth`, `value`, `backgroundColor`).
    ```dart
    // before: const Center(child: CircularProgressIndicator())
    const Center(child: ZenLoader())
    // with a caption: ZenLoader(label: l10n.aiIsThinking)
    ```
    Tiny **in-button** spinners are a different case: use `LoadingSwap`, which
    cross-fades an icon to a spinner at a constant footprint so a `Row` never
    jitters.
*   **Fade result content in.** Wrap content that replaces a loader in
    `ZenFadeIn` so it eases in rather than snapping.
*   **Ease panel height changes.** Wrap a "Show more" / "Show less" region in
    `ZenExpand` (`lib/shared/widgets/zen_expand.dart`) instead of changing
    `maxLines`, which otherwise resizes the panel in a single frame.
*   **Reduced motion:** `ZenLoader` and `ZenFadeIn` collapse to instant, and
    `ZenExpand` returns its child with no animator. Never pass
    `Duration.zero` to `AnimatedSize` — `RenderAnimatedSize` re-dirties itself
    during layout and throws.

---

## ✨ Motion

Motion has **two tiers with opposite rules**. Read this section before touching
any animation.

### 🧊 1. Tier 1 — Frozen Core (P0): DO NOT TOUCH

Two systems are **frozen**. They are load-bearing learning mechanics, hand-tuned,
and every refactor of them so far has regressed quality. They are **explicitly
out of scope** whenever a request says "animation".

*   **Stroke & drawing animation** — `lib/features/flashcards/presentation/widgets/drawing_canvas.dart`,
    `lib/core/stroke_matcher.dart`, and the `CharacterLoader` median paths.
    *   *Frozen:* the skeleton geometry, the progressive draw, the shake/hint
        feedback, the `1000x1000` coordinate transform, `ZenMotion.forStrokes`.
    *   *Why:* `docs/ROADMAP.MD` records two P0 emergencies where this animation
        was lost during a refactor and had to be rebuilt from a backup.
*   **Hero flight animation** — `lib/shared/utils/hero_transition.dart` and every
    `Hero(` call site.
    *   *Frozen:* the flight mechanics, the namespaced tag scheme
        (`'<scope>::<id>'`), and the flight curve.
    *   *Why:* the tags are collision-proof by design, because the same card is
        rendered in several rails (horizontal shelf, "continue reading", category
        grid). A naive tag change throws at runtime.

**Rule:** never restyle, re-time, re-curve or "tidy up" Tier 1. It requires a
written audit, and a motion task never includes it.

### 🎛️ 2. Tier 2 — Interface Motion (P1/P2): THE UNIFORMISATION TARGET

This is the app's "chrome": tab switching, sheets, dialogs, popovers, page
pushes, toasts, buttons, expand/collapse, list entrances, ambient loops.
**When someone says "animation", they mean this tier.**

#### 2.1 The feel: classic, calm, satisfying

*   **Classic.** Use the vocabulary every user already knows — a fade, a small
    lift, a cross-fade. No novelty, no springs, no elastic.
*   **Calm.** A surface moves *only* because the user moved it. Nothing animates
    as decoration. Nothing is faster than the eye can track (**>=130ms**) or
    slower than a breath (**<=500ms**).
*   **Satisfying.** Curves **decelerate**: content arrives and settles instead of
    winding up. Exactly one gesture earns an overshoot — a reward
    (`ZenMotion.arrival`).
*   **One value per interaction.** Each interaction below has **one** duration and
    **one** curve, app-wide. A second value for the same interaction is a bug.

#### 2.2 The vocabulary (mandatory)

`ZenMotion` (`lib/core/theme/zen_motion.dart`) is the **single source of truth**.
Never write a raw `Duration(...)` or `Curves.x` in a widget — including the
`200.ms` form exported by `flutter_animate`.

| Interaction | Token | Duration | Curve | Status |
| :--- | :--- | :--- | :--- | :--- |
| Tab / segmented switch | `ZenMotion.swap` | 180ms | `natural` | shipped |
| Sheet, dialog, panel open + close | `ZenMotion.quick` | 300ms | `natural` | shipped |
| Popover / Quick Look | `ZenMotion.swap` | 180ms | `natural` | shipped |
| Content swap in place (`AnimatedSwitcher`, `AnimatedCrossFade`) | `ZenMotion.swap` | 180ms | `natural` | shipped |
| Inline expand / collapse (`ZenExpand`) | `ZenMotion.quick` | 300ms | `natural` | shipped |
| Full-screen push (forward) | `ZenMotion.page` | 500ms | `settle` | shipped |
| Full-screen pop (reverse) | `ZenMotion.pageReverse` | 350ms | `settle` | ⚠️ to add |
| Toast / snackbar in-out | `ZenMotion.swap` | 180ms | `natural` | shipped |
| Toast dwell time | `ZenMotion.toast` | 2000ms | — | ⚠️ to add |
| Button / tile press feedback | `ZenMotion.tap` | 130ms | `natural` | ⚠️ to add |
| List item entrance | `ZenMotion.entrance` | 400ms | `enter` | ⚠️ to add |
| List stagger step (per item) | `ZenMotion.stagger` | 50ms | — | ⚠️ to add |
| Reward arrival (seal, streak, unlock) | `ZenMotion.quick` | 300ms | `arrival` | shipped |
| Ambient loop (breathing, shimmer) | `ZenMotion.ambient` | 2000ms | `breathe` | shipped |
| Fast ambient (recording / listening pulse) | `ZenMotion.ambientFast` | 1000ms | `breathe` | ⚠️ to add |
| Error shake | `ZenMotion.shake` | 500ms | — | ⚠️ to add |

**The only permitted curves.** Any curve outside this list is a violation:
`natural` (`Curves.easeInOutQuart`) · `settle` (`Curves.easeInOutQuart`) ·
`enter` (`Curves.easeOutCubic`) · `breathe` (`Curves.easeInOutSine`) ·
`arrival` (`Curves.easeOutBack`, reward moments only).
The banned strays are `Curves.easeIn`, `Curves.easeInOut`, `Curves.easeOut`,
`Curves.easeInCubic`, `Curves.easeInOutCubic`, `Curves.easeInOutQuad` and
`Curves.easeOutQuart` — each was previously scattered as a one-off.

#### 2.3 Hard rules

*   **Sheets and dialogs converge, they do not fly in.** A modal is a surface the
    user summoned; it fades and lifts a few percent. No horizontal slide-in, no
    scale-from-zero.
*   **A tab switch is not a page push.** Switching tabs is an in-place swap
    (`swap`, 180ms). Only a real route push uses `page` (500ms).
*   **Toasts respect the longest translation.** Use `ZenMotion.toast` (2000ms);
    a 500ms toast is unreadable in Russian or Vietnamese
    (see *Localization Layout Budget* below).
*   **Never animate a list item into existence with a `Timer`.** Encode the
    stagger as a hold at the head of the animation's own timeline, as
    `StaggeredListItem` does.
*   **Pair motion with haptics** (`HapticsManager`) as described below.

### 🔗 3. One page transition

`ZenPageTransitionsBuilder` is registered in both themes, so every push looks
identical. iOS/macOS keep `CupertinoPageTransitionsBuilder` because it supplies
the interactive edge-swipe back gesture that `SwipeBackRoute` depends on.
Forward pushes use `ZenMotion.page`; reverse pops use `ZenMotion.pageReverse`.

A route that declares its own `transitionDuration` is a violation of *One value
per interaction* — the onboarding arc currently runs 500ms forward / 350ms
reverse, and the paywall 600ms, beside the themed 300ms default.

### ♿ 4. Reduced motion is mandatory

Read `context.reduceMotion` (`lib/shared/utils/motion_preferences.dart`) and
never let a decorative effect repeat forever:

*   Perpetual loops must call `MotionResolution.resolve(...).apply()` from
    `didChangeDependencies` so they rest at a static frame when the user has
    enabled the OS "Reduce Motion" setting.
*   **One-shot animations must also collapse**, to `Duration.zero`: every
    `Animated*` widget, `AnimationController`, `TweenAnimationBuilder` and
    `flutter_animate` chain — not only the looping ones.
*   Never start a loop in `initState`: that is a build-phase context, so the
    platform preference cannot be read there.

### 📳 5. Pair motion with haptics

Every motion in the vocabulary above is paired with a `HapticsManager` call, as
defined in the next section. Motion without haptics feels synthetic; haptics
without motion feels broken.

## 📳 Haptic Language
*   **Success:** `HapticsManager.success()` (Double vibration).
*   **Stroke Hit:** `HapticsManager.light()` (Micro-tap).
*   **Error:** `HapticsManager.heavy()` (Long pulse).

---

## 🌍 Localization Layout Budget
Every screen must survive the **longest** supported translation, not just English.
Measured from `lib/l10n/app_*.arb` (p95 expansion versus English): Russian 2.08x,
Vietnamese 2.08x, Thai 2.00x, Italian 2.00x, Portuguese 1.94x, French 1.93x,
Spanish 1.90x, German 1.86x, Indonesian 1.86x, Arabic 1.80x, Hindi 1.79x.
The worst single labels reach 5-9x (e.g. the AI persona glosses).

*   **Budget:** design for **2.0x the English width**. Scripts with taller line
    boxes (Hindi, Thai, Arabic) also need vertical slack, so **never fix the
    height** of a row or box that contains text.
*   **Never size text by pixel.** `SizedBox(width: 60, child: Text(label))`
    clipped every translated label. Prefer intrinsic sizing, `Flexible`/
    `Expanded` inside a `Row`, `Wrap` for an action pair, or a `Table` with
    `IntrinsicColumnWidth()` when columns must stay aligned across rows.
*   **Buttons inherit their geometry from `AppTheme`.** `AppTheme` declares a
    *minimum* size only (`Size(0, 48)`); never set `fixedSize` or `maximumSize`,
    which clamp a label back to its English width.
*   **In a `Row`, every child that renders localized text must be flexible.**
    Two actions side by side need `Expanded` / `Flexible` / `Wrap`: English
    *"Report"* becomes Vietnamese *"Báo cáo chi tiết"* (2.7x), so an inflexible
    button overflows the moment the locale expands.
*   **If a width is genuinely required** (a Hanzi glyph tile, a numeric badge),
    give the `Text` a `maxLines` + `overflow:` strategy, or wrap it in
    `FittedBox(fit: BoxFit.scaleDown)`. Never rely on silent clipping.
*   **Text tracking stays at or below 0.5.** The former `labelLarge`
    `letterSpacing: 1.0` inflated every Latin and Cyrillic label by ~10-15%.
*   **Verify, never assume.** `test/support/locale_layout_harness.dart` sweeps
    the worst-case locales x viewports x text scales and *fails* on overflow,
    and `test/core/locale_layout_guard_test.dart` blocks the anti-patterns above
    from returning.
