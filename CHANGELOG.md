# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-06-17

### Added
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
