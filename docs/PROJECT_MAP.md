# 🗺️ Hanzi Master - Project Map & Manifest

This document serves as the "Big Picture" guide to the Hanzi Master codebase.

---

## 📂 1. Directory Structure

### 🏗️ `/lib` (Core Application)
Follows a **Feature-First Clean Architecture**.
- **`/core`**: Universal logic. Stroke matching, SVG parsing, and global providers.
- **`/features`**: Independent functional modules (Course, Flashcards, Premium, Quiz, Onboarding).

### 📑 `/docs` (Governance & Management)
- **`AI_PROTOCOL.md`**: The technical "Operations Manual."
- **`PROJECT_GUIDELINES.md`**: Core mandates and project overview.
- **`ai_update_guidelines/`**: Modular standards for every tracking file.
- **`archive/`**: Deep storage for resolved issues and old changelogs.
- **`ANTI_PATTERNS.md`**: Historical record of rejected approaches.
- **`UI_UX_STANDARDS.md`**: The visual and haptic "Zen" guide.
- **`ARCHITECTURAL_DECISIONS.md`**: Why we chose Riverpod, Hive, and Hausdorff.
- **`FEATURE_MANIFEST.md`**: The pedagogical truth of implemented features.
- **`ISSUES.md`**: Active bug and task tracker.

### 🕵️ `/audit` (Quality Assurance)
- **`AUDIT_PLAN.md`**: The strategy for technical reviews.
- **`AUDIT_GUIDELINES.md`**: Step-by-step procedures for audits.
- **`audit_results/`**: Historical records categorized by status.
    - **`archive/`**: Superseded or legacy audit results.

### 🛠️ `/tooling` (Maintenance & Data)
Dart scripts for offline processing.
- `fetch_hanzivg.dart`: Scrapes high-quality vector skeletons from source.
- `build_dictionary.dart`: Processes raw SVG data into optimized app JSON.
- `generate_sentences.dart`: Curates example sentences for Context steps.

---

## 🔄 2. Data Flow
`Tooling (Scrape/Parse)` -> `Assets (JSON)` -> `Core (Loader)` -> `Features (UI/Match)`
