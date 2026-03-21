# Changelog
All notable changes to the "Hanzi Master" project will be documented in this file.

## [Unreleased]
* **Focus:** Developing the Stroke Validation Logic using geometric distance.

## [2026-01-25]
### Added
* **Phase 4: Polish:**
    * Implemented **Linguistic Calligraphy Scoring** (`Y*1.5 + X`) for rock-solid guidance dot placement and grading.
    * Implemented **Sequential Character Drawing** for multi-character words, giving each character a full-sized canvas.
    * Added a **Celebration Delay** (1.2s) to show completed characters before clearing the canvas.
    * Optimized drawing performance by switching to `Path` rendering, eliminating lag.
    * Added **Visual Start/End Hints** (Green/Red dots) with centroid refinement for perfect alignment.
    * Added a bottom-bar **Skip Stroke** fallback for Guided Mode.
    * Fixed upside-down character rendering by unifying coordinate normalization in `CharacterLoader`.
    * Resolved "impossible to pass" grading bug by passing actual canvas size for user-point normalization.
    * Wired up Onboarding logic in `main.dart` to show tutorial only on first run.
    * Generated native App Icons (Adaptive for Android, iOS).
    * Generated Native Splash Screen.
* **Phase 3: SRS & Persistence:**
    * Integrated SM-2 Spaced Repetition Algorithm (`SrsLogic`).
    * Implemented performance tracking for cards (attempts, last score, success count).
    * Integrated Daily Streak tracking using `SharedPreferences`.
    * Added "Mastered" status detection and visual badges in the UI.
    * Updated Stats screen to reflect real-time SRS data and retention health.
* **Project Initialization:** Created MVP structure.
* **Documentation:** Added `GEMINI.md`, `ROADMAP.md`, and `CHANGELOG.md`.
* **Core:** Implemented basic touch-drawing canvas.
* **Logic:** Implemented `StrokeGrader` with multi-factor scoring (count, order, length, etc.).
* **Data:** Implemented `CharacterLoader` for SVG path parsing and normalization.
* **Features:** Added `ReviewScreen` with Guided and Free drawing modes.
* **Features:** Implemented HSK 1 data import from local JSON and fallback online sources.
* **Features:** Added Text-to-Speech (TTS) support for character pronunciation and integrated it into the review flow.
* **Features:** Integrated haptic feedback for drawing strokes and grading results.

### Defined
* **Strategy:** Pivot to "HSK 3.0 Specialist" niche.
* **Constraint:** "No Backend" architecture for rapid MVP development.