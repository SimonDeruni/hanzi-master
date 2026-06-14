# 🗺️ Hanzi Master - Project Map & Manifest

This document serves as the "Big Picture" guide to the Hanzi Master codebase.

---

## 📂 1. Directory Structure

### 🏗️ `/lib` (Core Application)
Follows a **Feature-First Clean Architecture**.

#### 🧩 `/core` (Universal Logic)
- **`/models`**: Shared data structures (e.g., `PronunciationGrade`).
- **`/providers`**: Global state logic (e.g., `PremiumController`).
- **`/services`**: Hardware & API integrations.
    - `api_key_pool.dart`: Rotates 10 Gemini API keys to bypass quotas.
    - `gemini_service.dart`: High-level AI (Context, Vision, Chat).
    - `vision_service.dart`: Local ML Kit object detection.
    - `audio_service.dart`: Multi-tier audio (Assets -> Cache -> Cloud -> Local).
    - `speech_service.dart`: STT for pronunciation practice.
- **`/utils`**: Heuristics (e.g., `PinyinUtils`, `GeometryUtils`).

#### 🚀 `/features` (Modular Functionality)
- **`vision/`**: "The Scholar's Eye" - Real-time AR object recognition.
- **`reading/`**: "Cultural Reading Room" - Structural story reader and creator.
- **`echo_hall/`**: "Echo Hall" - Persona-based roleplay and feedback.
- **`chat/`**: Base infrastructure for AI-driven conversations.
- **`flashcards/`**: Core SRS, Character Details, and "Ask Tutor" Sidebar.
- **`course/`**: "The Living Scroll" - Galactic map and structured lessons.
- **`progression/`**: Ink Points (XP) and Scholar Ranks.
- **`premium/`**: OCR Scanner and RevenueCat monetization.
- **`quiz/`**: Recognition grids and semantic forging.
- **`onboarding/`**: Scroll of Origin and tutorials.

#### 🎨 `/shared` (Common UI)
- **`/widgets`**: Universal calligraphic components (e.g., `QuickLookSheet`, `TappableHanziText`).

### 📑 `/docs` (Governance & Management)
- **`AI_PROTOCOL.md`**: The technical "Operations Manual."
- **`PROJECT_GUIDELINES.md`**: Core mandates and project overview.
- **`ai_update_guidelines/`**: Modular standards for every tracking file.
- **`archive/`**: Deep storage for resolved issues and old changelogs.
- **`UI_UX_STANDARDS.md`**: The visual and haptic "Zen" guide.
- **`ARCHITECTURAL_DECISIONS.md`**: Choices regarding ML, State, and Persistence.
- **`FEATURE_MANIFEST.md`**: The pedagogical truth of implemented features.
- **`ISSUES.md`**: Active bug and task tracker.

---

## 🔄 2. Data Flow
`ML Radar (Local)` + `Deep Scan (Gemini)` -> `Translation` -> `Scholar Card (Quick Look)`
`Camera (Frame)` -> `OCR (ML Kit)` -> `Dictionary (SQLite)` -> `Display`
`User Voice` -> `STT (Google)` -> `Critique (Gemini)` -> `Audio Feedback`
