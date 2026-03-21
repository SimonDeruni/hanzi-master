# 🗺️ Project Roadmap: Hanzi Master

## Phase 1: The Core Engine (✅ COMPLETE)
> *Goal: Build a working drawing canvas that detects stroke quality.*
- [x] **Basic Canvas:** Set up Flutter CustomPainter for touch input.
- [x] **Stroke Validation:** Implement `StrokeGrader` logic (Coordinate comparison).
- [x] **Visual Feedback:** Turn stroke Green (Correct) or Red (Wrong).
- [x] **Error Animation:** Add "Shake" effect on bad strokes.
- [x] **Ghost Overlay:** Show the "Blue Guide Stroke" (reference path).
- [x] **Snap-to-Grid:** Auto-correct the user's line to the perfect vector on success.

## Phase 2: The Data Injection (✅ COMPLETE)
> *Goal: Stop using hardcoded test data and use the real HK 150 JSON.*
- [x] **Data Import:** Import `HK 150` character list JSON.
- [x] **Parser Logic:** Create a `CharacterLoader` to parse SVG paths from the JSON into Flutter Paths.
- [x] **Home Screen:** Create a Grid View to select characters from the imported list.
- [x] **Loading State:** Handle async loading of the JSON file without freezing the UI.

## Phase 3: The "Brain" (SRS & Persistence) (✅ COMPLETE)
> *Goal: Remember what the user learned.*
- [x] **Local Storage:** Set up `shared_preferences` and `Hive`.
- [x] **Progress Tracking:** Save which characters are "Mastered."
- [x] **SRS Algorithm:** Integrated SM-2 Spaced Repetition logic.

## Phase 4: Polish & Launch (✅ COMPLETE)
- [x] **Coordinate & Grading Alignment:** Fixed upside-down data and scaling issues.
- [x] **Audio:** Add Text-to-Speech (TTS) for character pronunciation.
- [x] **Haptic Feedback:** Add vibration on success/fail.
- [x] **Onboarding:** Simple 3-slide tutorial for new users.
- [x] **App Icon & Splash Screen.**
- [x] **Performance Optimization:** Lag-free drawing and sequential character flow.

**Phase 4 Complete. Moving to Phase 5: Advanced Features.**