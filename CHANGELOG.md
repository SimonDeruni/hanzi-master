# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- Rewrote `rebuild_shows_catalog.dart` to strictly fetch shows that possess soft-coded Chinese captions (using `youtube_explode_dart` `_hasCaps` verification).
- Successfully populated `shows_data.dart` with 10 new soft-captioned shows, yielding a total of 14 hardcoded shows for instant playback without live YouTube Data API overhead.
- Optimized AI text processing in `web_browser_screen.dart` by removing artificial 500ms delays, substituting the DB query with an in-memory cache, and capping the JS text extraction to 3000 chars.
- **Smart Media Desk Enhancements**:
    - Reconstructed Chinese Hanzi characters from Pinyin-only subtitle tracks using background Gemini processing.
    - Integrated background translation of transcripts into the user's selected `targetLanguage` (aligned with device language).
    - Enabled seeking the video timeline by tapping anywhere on a transcript line card.
    - Highlighted active spoken characters in premium blue (`#1976D2`).
    - Reintroduced the yellow AI micro-lesson button (`Icons.auto_awesome`) on the bottom-right of each transcript card.
- **Unified Graph Architecture (Phase 2 - Stealth Reviews)**:
    - Updated custom AI Story Generation to dynamically fetch due flashcards and weave them into the narrative alongside new vocabulary, reinforcing spaced repetition naturally.
- **Unified Graph Architecture (Phase 1)**:
    - Added `sourceSentence` and `sourceContext` to Flashcard entities to maintain origin context from Reading/Story modes.
    - Upgraded `WordDetailDialog` to include an interactive Micro-Calligraphy scratchpad, eliminating the need to navigate away to practice.
    - Updated `RecallModeWidget` to display the origin sentence as a context clue with the target character blanked out.
    - Integrated `CalligraphyCanvasSheet` into `QuickLookSheet` via a new "Trace" button for immediate character practice.
    - Added "Extract & Simplify" button to `WebBrowserScreen` to instantly convert complex web Chinese into HSK-leveled stories using Gemini.
- **UI/UX Polish**:
    - **Premium AI Hub UI**: Completely redesigned the AI Hub layout into a strict, single-page, flexible dashboard (no scrolling) with deep ink aesthetics (`#131A29`) and textured Zen & Ink backgrounds for all action cards. Replaced the "Calligraphy" card with a focused "TODAY'S WORD" hero card, wired directly to `CharacterDetailScreen`.
    - Redesigned `TravelInterpreterScreen` layout for improved 180-degree split-screen visibility and dynamic state backgrounds.
    - Revamped `ShadowingStudioScreen` with an audio-first, mimicry-focused interface via `PageView`.
    - Added Tinder-style swipe gestures with corresponding haptic feedback and scale animations to `ReviewScreen` flashcard grading.
    - Expanded Reading Room features with an anchored audio player, inline sentence translation toggle, and 3-mode Pinyin display (All, Ghost, None).
- **Performance**:
    - Implemented a persistent `Hive` cache for Gemini character origin queries to eliminate duplicate AI latency.

### Fixed
- **Media Desk Search Crash**:
    - Fixed a `FormatException: Invalid radix-10 number` issue when youtube_explode_dart parses video search metadata on streams (e.g. viewCount/duration). Implemented manual iteration in `YoutubeRepository.searchVideos` to skip corrupt items instead of failing the entire query.
- **Localization**:
    - Extracted hardcoded UI strings into `AppLocalizations` for Echo Hall Scenarios, Master Lin greeting, Reading Room titles/descriptions, and Custom Story Creator Dialog.
    - Generated translations for all new strings across the 12 supported languages.
- **Build Errors**:
    - Fixed `SettingsController` constructor malformation causing Gradle build failures.
    - Resolved `invalid_constant` and `const_eval_method_invocation` errors across multiple UI screens caused by `AppLocalizations` lookups inside `const` widgets.
    - Fixed missing `strokePaths` and `modeStats` arguments in `Flashcard` instantiations within `vision_provider.dart`.
- **Media Playback**:
    - Fixed silent video bug during YouTube media playback by properly configuring the iframe player's unmute options.
- **Audio Processing**:
    - Resolved fragmented UI rendering of the user's pitch contour in the Shadowing Studio's Tone Graph by correctly scaling X/Y coordinates and continuously drawing the line despite zero-pitch pauses.
    - Fixed audio pitch extraction crash during Shadowing Studio grading by ensuring raw audio byte arrays are passed natively to the extraction tool instead of temporary file paths.
- **API Management**:
    - Implemented API key rotation for YouTube Data API to handle daily quota limits gracefully without blocking media search.

## [1.2.0] - 2026-06-17

### Added
- **UI Animations**:
    - Added `flutter_animate` package for declarative, chained animations.
    - Implemented global `FadeUpwardsPageTransitionsBuilder` and `CupertinoPageTransitionsBuilder` for premium navigation.
    - Added staggered entry animations for Dashboard elements and subtle breathing animation for the mascot.
    - Introduced a reusable `BouncingButton` widget to add micro-interactions to flashcard grading buttons.
- **Advanced AI Curriculum Engine**:
    - Implemented a Two-Pass AI strategy for high-level syllabus planning and detailed unit execution.
    - Added Component-Based Clustering using radical and decomposition metadata.
    - Integrated "Anchor Word" (Sun node) selection to improve visual and conceptual hierarchy in the Path.
    - Added Prerequisite Mapping to ensure simpler building blocks appear before complex characters.

## [1.1.0] - 2026-06-12

### Changed
- **Cultural Reading Room UI**:
    - Completely overhauled `StoryReaderScreen` to use a rich, word-by-word interactive layout with integrated Pinyin and Audio.
    - Updated `GradedStory` local storage models to `graded_stories_v2` to support `AiSentence` structure.
    - Fixed image rendering issues for Wikipedia images by injecting proper User-Agent headers.
    - Repopulated local database with 96 default HSK 1-6 stories using the new structural JSON schema.

### Added
- **The Scholar's Eye (Hybrid Vision System)**:
    - Implemented `VisionService` using Google ML Kit for real-time local object detection.
    - Integrated `GeminiService` with Vision capabilities for high-fidelity "Deep Scans".
    - Created `VisionState` and `VisionNotifier` providers to manage camera life-cycle and object detection stream.
    - Added support for translating local ML labels into full `Flashcard` entities via Gemini.
