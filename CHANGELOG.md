# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-06-12

### Added
- **The Scholar's Eye (Hybrid Vision System)**:
    - Implemented `VisionService` using Google ML Kit for real-time local object detection.
    - Integrated `GeminiService` with Vision capabilities for high-fidelity "Deep Scans".
    - Created `VisionState` and `VisionNotifier` providers to manage camera life-cycle and object detection stream.
    - Added support for translating local ML labels into full `Flashcard` entities via Gemini.
