# 🛑 Hanzi Master - Anti-Patterns (What NOT to do)

This document records technical approaches that have been tested and REJECTED. Do not suggest or implement these.

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
*   **Implicit Animations:** Avoid `AnimatedContainer` for complex sequences. 
    *   *Why:* We need the precision of `AnimationController` for stroke timing.
