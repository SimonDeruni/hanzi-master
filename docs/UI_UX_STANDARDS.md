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
    **Adoption (2026-09-25):** the plain `AsyncValue.when(data: …)` branches that
    return a single widget are now wrapped (12 branches, 12 files). The exceptions
    are branches with early returns, and *spread* branches — see
    *Accepted limits* below.
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
    *   *To add a flight:* wrap **both** ends in `HeroTransition.wrap` with a
        `HeroTransition.heroTag('<scope>', id)` tag. The `<scope>` names the
        source screen, so the same card rendered in two rails stays distinct.

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

| Interaction | Token | Duration | Curve | Carrier in the app | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Tab / segmented switch | `ZenMotion.swap` | 180ms | `natural` | `MainNavigationScreen` (`_KeepAliveTab`), `ZenFilterPill` | shipped |
| Sheet, dialog, panel open + close | `ZenMotion.quick` | 300ms | `natural` | `GlobalBlurredBottomSheet`, every `showModalBottomSheet` / `showDialog` | shipped |
| Popover / Quick Look | `ZenMotion.swap` | 180ms | `natural` | `QuickLookSheet` | shipped |
| Content swap in place (`AnimatedSwitcher`, `AnimatedCrossFade`) | `ZenMotion.swap` | 180ms | `natural` | `lesson_screen` (lesson step), `story_reader_screen`, `channel_videos_screen` | shipped |
| Inline expand / collapse (`ZenExpand`) | `ZenMotion.quick` | 300ms | `natural` | `ZenExpand` | shipped |
| Full-screen push (forward) | `ZenMotion.page` | 500ms | `settle` | `ZenPageTransitionsBuilder` (both themes) | shipped |
| Full-screen pop (reverse) | `ZenMotion.pageReverse` | 350ms | `settle` | `reverseTransitionDuration` on the routes that declare one | shipped |
| Toast / snackbar in-out | `ZenMotion.swap` | 180ms | `natural` | `ZenToast` (root overlay) | shipped |
| Toast dwell time | `ZenMotion.toast` | 2000ms | — | `ZenToast` | shipped |
| Button / tile press feedback | `ZenMotion.tap` | 130ms | `natural` | `BouncingButton` (its default duration) | shipped |
| Tap ink bleed (every `InkWell` / `InkResponse` / Material button) | `ZenMotion.quick` | 300ms | `enter` | `ZenInkSplashFactory` (both themes: `splashFactory` + `splashColor`) | shipped |
| Pronounced contour draws itself | `ZenMotion.quick` | 300ms | `enter` | `CalligraphicPitchContour` (the brush lays the tone down left to right; replays only for a genuinely new contour, never on a streaming update) | shipped |
| Card flies into the deck | `ZenMotion.quick` | 300ms | `enter` | `ZenFlight.to()` (root overlay, from `deck_card_picker_screen`) | shipped |
| Radical parts assemble into a character | `ZenMotion.entrance` + `ZenMotion.stagger` | 400ms each, 50ms apart | `enter`, then `arrival` on the settle | `ZenAssembly` (`radical_lesson_screen`, the forge) | shipped |
| In-button icon ⇄ spinner swap | `ZenMotion.swap` | 180ms | `natural` | `LoadingSwap` | shipped |
| List item entrance | `ZenMotion.entrance` | 400ms | `enter` | `StaggeredListItem` | shipped |
| List stagger step (per item) | `ZenMotion.stagger` | 50ms | — | `StaggeredListItem` (its default delay) | shipped |
| List item exit / removal | `ZenMotion.exit` | 250ms | `natural` | `ZenExit` (data-driven removal; `Dismissible` covers the swipe case) | shipped |
| Reward arrival (seal, streak, unlock) | `ZenMotion.quick` | 300ms | `arrival` | `InkStoneWidget`, `session_summary_screen` score count-up | shipped |
| Ambient loop (breathing, shimmer) | `ZenMotion.ambient` | 2000ms | `breathe` | `BreathingWidget`, `ShimmerSkeleton`, `media_search_screen` | shipped |
| Fast ambient (recording / listening pulse) | `ZenMotion.ambientFast` | 1000ms | `breathe` | `live_call_screen` recording pulse | shipped |
| Error shake | `ZenMotion.shake` | 500ms | `natural` | `ZenShake` (rise-only trigger) | shipped |
| Loading spinner fade-in | `ZenMotion.quick` | 300ms | `natural` | `ZenLoader` / `ZenFadeIn` | shipped |

**Every row is shipped.** This table was re-stamped on 2026-09-25 after the
motion sweep; the seven rows that read "⚠️ to add" (`pageReverse`, `toast`,
`tap`, `entrance`, `stagger`, `ambientFast`, `shake`) had all been implemented
and only the paperwork was stale. Status is a claim about *usage*, so it is
measured, not assumed — the reference count in `lib/` at the time of re-stamping
was: `swap` 58 · `natural` 52 · `page` 40 · `enter` 34 · `quick` 32 · `ambient`
11 · `arrival` 8 · `entrance` 8 · `pageReverse` 7 · `ambientFast` 6 · `toast` 5 ·
`tap` 4 · `breathe` 4 · `settle` 1 · `stagger` 1 · `shake` 1 · `of(context, …)`
84.

**Deliberately not counted as shipped.** A future re-stamp must not "fix" these:

*   `ZenMotion.beat` — the choreography step for sequenced reveals. Since
    2026-09-26 it has **exactly one consumer**: the gap between two impacts of a
    `HapticsManager` pattern, pinned by `test/core/feedback_guard_test.dart`.
    That is the point of it — § 5 asks motion and haptics to feel like one thing,
    so they share one beat instead of each carrying its own literal. It is still
    not *interface motion*, so it is not counted in the table above.
*   `ZenMotion.strokeUnit` / `ZenMotion.forStrokes` — **Tier 1 documentation.**
    The frozen canvas hard-codes its own budget (`widget.paths.length * 700`, see
    `drawing_canvas.dart`), so `forStrokes` is asserted by the tests but never
    called. That is intentional: re-timing the drawing is exactly what destroyed
    it twice before.

**The tap is part of the vocabulary too.** `ThemeData.splashFactory` was never
set, so every one of the app's `InkWell`s painted Flutter's stock grey disc --
the last place the app still spoke in Material's voice. Both themes now set
`splashFactory: ZenInkSplashFactory()` (`lib/core/theme/zen_ink_splash.dart`),
which draws a touch as a **drop of ink on paper**: a feathered, slightly
irregular blob that spreads fast, soaks, then dissipates. Three rules come with it:

*   `splashColor` **is** the tint, and the factory thins it to 10% -- so the
    theme keeps a full-strength accent (`accentLight` cinnabar on paper,
    `accentDark` amber on ink, because cinnabar is invisible on the dark
    surface). Never pre-multiply the alpha in the theme.
*   Clipping is Flutter's, not ours: the factory mirrors the SDK's private
    `_getClipCallback` and clips with `customBorder.getOuterPath(...)` /
    `borderRadius.toRRect(...)` / `clipRect`. **Only a widget that contains its ink**
    is clipped that way — a Material button, a card, an `InkWell` asking for
    containment. A widget that does not (the bottom navigation bar, every
    `IconButton`, a plain `InkWell`, which is the default) is not clipped at all, so
    its *reach* is what keeps it in place — next rule.
*   **Reach is bounded.** A contained widget bleeds across its whole surface. An
    uncontained one gets Flutter's own bounded radius instead
    (`Material.defaultSplashRadius`, and never more than half the control's *shorter*
    side), i.e. a drop the size of the thing that was touched. It used to get the
    widget's **diagonal**: 113dp on the 98×56 bottom-nav tile — an unclipped
    terracotta disc twice the tile in every direction, painted over the page above the
    bar (*"a little bit too strong"*). See `ZenInkSplashFactory.dropRadius`, and the
    `target radius` group in `test/core/zen_ink_splash_test.dart`.
*   Under Reduce Motion the ink is simply *put down* at a fixed tint with **no
    ticker**, and resolves instantly on tap-up. The feedback stays; the travel
    goes. Like every other `InkWell` honouring `MediaQuery.disableAnimations`,
    this is a *response to a touch*, so it does not violate "nothing animates as
    decoration".


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
*   **A row that leaves should leave.** A data-driven removal — a card added to a
    deck leaving the picker, a word leaving a list — must not simply cease to
    exist: wrap it in `ZenExit` (fade + collapse on `ZenMotion.exit`) and commit
    the removal in `onRemoved`, not on the tap, or the animation has nothing left
    to draw. `Dismissible` already covers the swipe case.
*   **Never animate a list item into existence with a `Timer`.** Encode the
    stagger as a hold at the head of the animation's own timeline, as
    `StaggeredListItem` does.
*   **A rejection moves as well as recolours.** `ZenShake` plays one damped
    shake on a **rising** trigger only, so the tile that stops being the rejected
    one falls back to `0` silently; its rest state is exactly `0`, and reduced
    motion drops the travel entirely. Always pair it with
    `HapticsManager.error()` / `.heavy()`.
*   **An in-button spinner is a swap, never a bare spinner.** `LoadingSwap`
    cross-fades the idle icon to the spinner at a constant footprint, so the
    surrounding `Row` cannot jitter. A bare `CircularProgressIndicator` belongs
    in neither a section nor a button.
*   **Hero flights come only from `HeroTransition.wrap`.** They must be paired: a
    `Hero` on one route alone never flies (dead code), and a tag that is not the
    namespaced `<scope>::<id>` scheme cannot be relied on to match a destination
    — an object `hashCode` in a tag can never match a *different* instance.
    Two same-tag `Hero`es must never share a route; read the `dashboard_screen`
    hazard in `ISSUES.md` before pairing anything.
*   **Pair motion with haptics** (`HapticsManager`) as described below.
*   **The no-raw-literal rule is enforced, not aspirational.**
    `test/core/motion_vocabulary_test.dart` is a shrink-only ratchet: raw
    `Curves.` (baseline **1** — the frozen canvas only), raw
    `Duration(milliseconds|seconds:)` (**123**), the `flutter_animate`
    `.ms` / `.seconds` shorthand (**10**) and bare `MaterialPageRoute` (**23**)
    may only fall, and `ZenMotion.` references may not fall below **240**.
    Adding one literal fails the suite.
    *   **A trap worth knowing:** the "only the frozen canvas may hold a raw
        curve" check scans **raw source without stripping comments** (unlike the
        counts, which do strip them), so merely *mentioning* `Curves.<x>` in a
        comment in any other file fails the suite. Say "an easeOutQuad curve"
        instead.

#### 2.4 Accepted limits (do not "fix" these)

Material's own affordances animate on the **SDK's** internal timings, which cannot
be tokenised without forking the widget: `SwitchListTile` (8), `CheckboxListTile`
(2), `Slider` (9), `BottomNavigationBar` (13), `DropdownButton` (11),
`ExpansionTile` (1), `RefreshIndicator` (2). *"Never write a raw `Duration` or
`Curves.x`"* is a rule about **our** code; these are Flutter's. Counted 2026-09-25.

Three further shapes are accepted as-is, with the reason recorded so a later sweep
does not "fix" them repeatedly:

*   **A `data:` branch that returns a `List<Widget>`** — a *spread*
    `...async.when(...)` merged into a `children` / `slivers` list — cannot be
    wrapped in `ZenFadeIn`, which needs a single widget. Wrap the individual items
    (e.g. in `StaggeredListItem`, which the surrounding list usually already
    does), or leave it.
*   **A branch with early returns** is left alone rather than fading only its last
    `return`, because that would fade some paths and snap others.
*   **The three `SnackBarAction` sites** (`deck_detail_screen` undo,
    `cross_reference_text` retry, `universal_scanner_screen` open-Settings) keep a
    Material snackbar: `ZenToast` has no action slot by design, and none of them
    sits over a modal barrier.

Empty-state motion, background loops and scroll-triggered reveals stay out on
purpose: *"A surface moves only because the user moved it. Nothing animates as
decoration."*

### 🔗 3. One page transition

`ZenPageTransitionsBuilder` is registered in both themes, so every push shares
one transition: a cross-fade with a 3% lift on `settle`. iOS/macOS keep
`CupertinoPageTransitionsBuilder` because it supplies the interactive edge-swipe
back gesture that `SwipeBackRoute` depends on (12 call sites — the convention).

**The builder supplies the curve; the route supplies the duration.** Routes that
declare one now source it from the vocabulary: the onboarding arc,
`onboarding_mini_lesson_screen` and `notification_permission_screen` run
`ZenMotion.page` forward and `ZenMotion.pageReverse` on the way back;
`quick_look_sheet` uses `ZenMotion.swap` (it is a popover, not a page); and
`custom_paywall_screen` uses `ZenMotion.page` where it animates at all — two of
its routes are deliberately `Duration.zero`.

**Known drift.** A bare `MaterialPageRoute` still runs Material's own 300ms
default rather than `ZenMotion.page`, and **20** such sites remain. The ratchet
holds the count steady (baseline 23, may only fall) but does not convert them, so
this is the one place where the vocabulary is not yet unanimous.

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

**One gate.** Every buzz in the app goes through `HapticsManager`
(`lib/core/services/`), because that is the only thing the Settings "**Haptic
Feedback**" switch reaches — a raw `HapticFeedback.*` call is unfixable from
Settings, which is exactly how the paywall and the shadowing studio used to buzz
with haptics switched *off*. `test/core/feedback_guard_test.dart` holds that at a
**zero** baseline. The same file guards the sibling promise: nothing may play an
`sfx_*` / `zen_*` asset except `ZenSoundService`, the one place the "**Sound
Effects**" switch reaches — which is how the quiz used to grade out loud with
sound effects off.

*   **Success:** `HapticsManager.success()` (double tick, one `ZenMotion.beat`
    apart).
*   **Stroke Hit:** `HapticsManager.light()` (micro-tap).
*   **Error:** `HapticsManager.error()` — a **three-impact pattern**. Do not reach
    for `heavy()` to mean "wrong answer": `heavy()` is a single long pulse, and it
    is the ingredient, not the outcome.
*   **Milestone:** `HapticsManager.milestone()` — the **rising** crescendo
    (light → medium → heavy) for an achievement: a rank crossed, a mastery seal
    earned. The rise *is* the meaning, where the refusal is the same weight three
    times over — so never use it for a refusal, and never for an ordinary award
    (that is `success`).
*   **Destructive:** `HapticsManager.destructive()` — the only impact here that is
    **not a Taptic tap** (iOS: the system vibration; Android: `LONG_PRESS`, where
    the taptic styles share one constant). A **single** buzz, never a pattern, so
    it cannot be confused with the refusal's triple. Reserved for what cannot be
    undone — today that is confirming account deletion — and it must stay that
    rare, or it stops meaning anything.
*   **The widget owns the moment.** A shared widget that *is* the feedback fires
    its own impact, and call sites must **not** pair it again:
    `ZenShake` (refusal), `ZenToast.error` (refusal — it is the app's one "no"
    funnel, which is what turned 22 forgotten call sites into a guarantee),
    `ZenFlipCard` (reveal), `MasterySeal` (milestone as the stamp lands),
    `InkStoneWidget` (milestone on a rank, `success` on points) and
    `StreakFlameBadge` (`success` when the streak grows). Pairing one of those at
    the call site is a **double buzz**, which is why `quiz_step` and
    `radical_lesson_screen` had their local calls removed.
*   **Sliders.** A discrete slider (`divisions` set) ticks per detent in
    `onChanged`; a continuous one ticks **once** in `onChangeEnd`. Ticking a
    continuous slider in `onChanged` is a continuous buzz, not feedback.
*   **Not every tap.** Haptics mark outcomes and value changes, not taps: the
    Settings *switch* and *slider* tick, while the Settings **navigation rows**
    deliberately do not, because the ink bleed already confirms a tap.
*   **Patterns never stack.** Starting a pattern retires any pattern still in
    flight, so three wrong answers in quick succession play **one** outcome
    instead of queueing nine impacts. Switching haptics off retires the running
    one too, so "off" is immediate rather than "when the current buzz finishes".

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
