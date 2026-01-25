# Changelog
All notable changes to the "Hanzi Master" project will be documented in this file.

## [Unreleased]
* **Focus:** Developing the Stroke Validation Logic using geometric distance.

## [2026-01-25]
### Added
* **Store Readiness**: Added Phase 10 to the `ROADMAP.MD`, detailing the requirements for Google Play and Apple App Store publication (Legal, Metadata, Production signing).
* **Performance Audit**: Performed a full performance review (Rating: 8/10).
* **Security Hardening**: Performed a security audit (Rating: 6/10).
* **Security Mandates**: Added "Absolute Security Mandates" to `GEMINI.md` to ensure AI-generated code follows encryption and validation best practices.
* **The Master Roadmap**: Consolidates all features.
* **Scope Expansion**: Included Phase 4-9 covering everything from Multi-Modal learning to AI Handwriting Analysis.
* **Brainstorming Protocol**: Added Phase 8 to the Roadmap and a dedicated ideation section to `GEMINI.md`.
* **Brush Simulation**: Implemented velocity-based variable stroke thickness and tapering (thinner on flicks, thicker on slow presses).
* **Project Documentation**: Created `functionalities.md` to track all implemented features.
* **GEMINI Context**: Updated `GEMINI.md` to enforce reading of `functionalities.md`.

### Fixed
* **Smoothing Logic**: Upgraded to a weighted 5-point moving average algorithm.
* **Real-time Smoothing**: Added "Tail Smoothing" during active drawing to reduce jitter immediately.


    * **Results Page Overhaul**: Implemented a full-screen, immersive results page with a word summary card (Hanzi, Pinyin, Definition, Audio).
    * **Comparison View**: Added side-by-side 'Your Work' and 'Ideal Solution' previews on the results page.
    * **Synchronized Previews**: Character cycling now flips both 'Your Work' and 'Ideal Solution' at exactly the same time.
    * **Visual Ink Refinement**: Increased stroke thickness by 40% for a bolder, more satisfying drawing feel.
    * **Dynamic Centering**: Implemented separate centering logic for drawing (tracing) vs. results (preview) to ensure perfect alignment in all views.
    * **Score Persistence**: Guided mode now keeps your last score visible until you start drawing the next stroke.
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
* **Logic:** I1mplemented `StrokeGrader` with multi-factor scoring (count, order, length, etc.).
* **Data:** Implemented `CharacterLoader` for SVG path parsing and normalization.
* **Features:** Added `ReviewScreen` with Guided and Free drawing modes.
* **Features:** Implemented HSK 1 data import from local JSON and fallback online sources.
* **Features:** Added Text-to-Speech (TTS) support for character pronunciation and integrated it into the review flow.
* **Features:** Integrated haptic feedback for drawing strokes and grading results.

### Defined
* **Strategy:** Pivot to "HSK 3.0 Specialist" niche.
* **Constraint:** "No Backend" architecture for rapid MVP development.