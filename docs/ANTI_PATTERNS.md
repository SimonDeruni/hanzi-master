# 🛑 Hanzi Master - Anti-Patterns (What NOT to do)

This document records technical approaches that have been tested and REJECTED. Do not suggest or implement these.

---

## 🧊 Frozen Motion (Do Not Touch)

These are not approaches to avoid — they are **frozen assets**, and touching them
*is* the anti-pattern.

### Frozen Core Motion (P0)
- **Trap:** Restyling, re-timing, re-curving or "tidying up" the **stroke/drawing
  animation** (`drawing_canvas.dart`, `stroke_matcher.dart`, `CharacterLoader`
  median paths, `ZenMotion.forStrokes`) or the **Hero flight animation**
  (`hero_transition.dart`, any `Hero(` call site).
- **Why:** `docs/ROADMAP.MD` records two P0 emergencies where the stroke animation
  was destroyed by a refactor and had to be rebuilt from backup. The Hero flight
  relies on namespaced tags (`'<scope>::<id>'`); the same card renders in several
  rails (shelf, "continue reading", category grid), so an innocent tag change
  throws at runtime.
- **Better Way:** Treat Tier 1 as read-only. When a request says "animation", it
  means Tier 2 (interface motion) — see `docs/UI_UX_STANDARDS.md` § Motion.

### Bespoke Chrome Timings
- **Trap:** Inventing a new duration for a tab switch, sheet, dialog or toast
  because the existing one "felt slightly off".
- **Why:** This is how the app accumulated a 220ms tab cross-fade beside 300ms
  ones, six different `AnimatedSwitcher` durations (180/250/300/350/400/500ms),
  and route pushes at 300/500/600ms for one gesture the user cannot tell apart.
- **Better Way:** Use the vocabulary table in `docs/UI_UX_STANDARDS.md`. One
  duration and one curve per interaction, app-wide. A second value is a bug.

### Spring, Bounce & Elastic Chrome
- **Trap:** Adding spring physics or an overshoot to an interface surface (tab,
  sheet, button, panel).
- **Why:** It reads as playful rather than classic, and fights the "Zen & Ink"
  calm. Exactly one gesture earns an overshoot: a reward.
- **Better Way:** `natural` / `settle` / `enter` / `breathe` — decelerating only.
  Rewards use `ZenMotion.arrival`.

### The `flutter_animate` `.ms` Dialect
- **Trap:** Writing `duration: 200.ms` (or any `.ms` / `.seconds` shorthand) in a
  widget.
- **Why:** It is a second duration dialect that no audit can see by grepping for
  `Duration(`, so those ~30 literals escape every motion review.
- **Better Way:** `ZenMotion.*` — the token is already a `Duration`.

---

## 🏗️ Architectural Anti-Patterns
*   **Manual JSON Edits:** Never edit `assets/data/*.json` by hand. 
    *   *Why:* Tooling scripts in `tooling/` will overwrite your changes. Always fix the script first.
*   **Global State Overuse:** Do not use `StateProvider` for logic that belongs in a `Notifier`.
    *   *Why:* It leads to "Ghost Rebuilds" and makes debugging hard for the next agent.
*   **Deep Inheritance:** Avoid deep widget trees. Use extraction into small, stateless "Atoms."

## 🧬 Logic Anti-Patterns
*   **Hardcoded Thresholds:** Avoid putting `150.0` or `200.0` directly in the match logic. 
    *   *Why:* It fails for tiny characters. Use relative thresholds based on stroke length.
*   **Print Debugging:** Do not leave `print()` statements in production code. 
    *   *Why:* It clutters the founder's debug logs. Use the prefixed `debugPrint` or `logger`.

## 🎨 UI Anti-Patterns
*   **Generic Buttons:** Never use standard `ElevatedButton` for core learning actions.
    *   *Why:* It breaks the "Zen" aesthetic. Use custom calligraphic themed widgets.
*   **Perpetual Loops Without a Motion Check:** Never call `.repeat()` (or `flutter_animate`'s `onPlay: repeat`) without consulting `context.reduceMotion`.
    *   *Why:* A loop that ignores the OS "Reduce Motion" setting pulses forever — a
        genuine problem for users with vestibular disorders. Start loops from
        `didChangeDependencies` via `MotionResolution.resolve(...).apply()` so they
        can rest at a static frame.
*   **Starting Loops in `initState`:** Never begin an animation there.
    *   *Why:* `initState` cannot read `MediaQuery`, so the reduced-motion
        preference is invisible and the loop can never be suppressed.
*   **Raw Motion Literals:** Never write a duration or curve inline
    (`Duration(milliseconds: 250)`, `Curves.easeInOut`).
    *   *Why:* `docs/UI_UX_STANDARDS.md` mandates one feel. Use `ZenMotion.*` — it was
        previously scattered across 26 `easeInOutQuart` literals.
*   **Overriding the Platform Transition:** Never register a different
    `PageTransitionsBuilder` for a platform that needs the native back gesture.
    *   *Why:* iOS/macOS must keep `CupertinoPageTransitionsBuilder`; replacing it
        removes the interactive edge-swipe back affordance.
*   **Bare Section Spinners:** Never place a raw `CircularProgressIndicator` directly inside a `Center` for a loading section or screen.
    *   *Why:* It appears in a single frame, which reads as a flicker. Use
        `ZenLoader` so it fades in. In-button spinners use `LoadingSwap` instead.
*   **Zero-Duration `AnimatedSize`:** Never pass `Duration.zero` to `AnimatedSize` for reduced motion.
    *   *Why:* `RenderAnimatedSize` re-dirties itself during layout and throws
        ("mutated in its own performLayout"). Return the child unwrapped instead —
        see `ZenExpand`.
*   **Jumping Panels:** Never grow or shrink a panel by flipping `maxLines` on its own.
    *   *Why:* The surrounding content teleports. Wrap the growable region in
        `ZenExpand`.
*   **Pixel-Sized Text Boxes:** Never give a box that holds text a hard-coded width/height.
    *   *Why:* German, French, Spanish, Italian, Portuguese, Russian, Vietnamese and
        Thai expand a label by up to ~2x English (worst cases 5-9x), so
        `SizedBox(width: 60, child: Text(label))` clipped every translated label.
        Use intrinsic sizing, `Flexible`/`Expanded`/`Wrap`, or a `Table` with
        `IntrinsicColumnWidth()`.
*   **Inflexible Localized Buttons in a `Row`:** Never place a text-bearing button in a `Row` without `Expanded`/`Flexible`/`Wrap`.
    *   *Why:* The `Row` lays out its inflexible children at their intrinsic width,
        so a longer translation pushes the whole row past the screen edge
        (English *"Report"* -> Vietnamese *"Báo cáo chi tiết"*, 2.7x).
*   **Fixed-Size Buttons:** Never set `fixedSize` or `maximumSize` on a button.
    *   *Why:* They clamp the label to its English width. `AppTheme` declares a
        minimum size only; let the label decide the real width.
*   **Tracking on Labels:** Never add `letterSpacing` above 0.5 to button labels.
    *   *Why:* The former `labelLarge` `letterSpacing: 1.0` inflated every Latin and
        Cyrillic label by roughly 10-15% and caused locale overflow app-wide.
*   **Implicit Animations:** Avoid `AnimatedContainer` for complex sequences. 
    *   *Why:* We need the precision of `AnimationController` for stroke timing.
