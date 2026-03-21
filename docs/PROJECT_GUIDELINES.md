# 📜 Hanzi Master - Project Guidelines & Mandates

This document contains the foundational rules, mandates, and philosophical pillars of the Hanzi Master project.

---

## 1. 🎯 Project Overview
We are building **Hanzi Master**, a Flutter application for mastering Mandarin Chinese characters through high-precision kinesthetic feedback.
*   **Target:** HSK 3.0 Level 1 (expanding to Level 2).
*   **Unique Value:** Real-time **Geometric Stroke Matching** (Simplified Hausdorff) and the **"Living Scroll"** constellation-based curriculum.

---

## 2. 🛡️ Core Mandates (The Absolute Truth)
*   **Solo Founder Constraints:** 90% AI-generated code. Code must be simple, readable, and **teachable**. Use descriptive naming and one-line comments for every logical block.
*   **Zero Hallucination:** Never invent or hallucinate Chinese data, mnemonics, or definitions. Use the HSK assets in `assets/data/` as the only source of truth.
*   **Tech Stack Lock:** Flutter (Dart) ONLY. Riverpod for state. Hive for persistence.
*   **Coordinate System:** Everything MUST use the **1000x1000 Y-down** coordinate system. Normalization is mandatory.

---

## 🛡️ 3. Absolute Security Mandates
1.  **Zero Secrets:** Never hardcode API keys, tokens, or sensitive strings.
2.  **Privacy & Encryption:** Use **encrypted Hive boxes** (`HiveCipher`) for all user progress, performance data, and premium status.
3.  **Untrusted Input:** Treat all external data (JSON from CDNs, SVG paths) as untrusted. Wrap all parsing and fetches in `try-catch` blocks.

---

## 🕵️ 4. Auditing & Quality Assurance
*   **Audit Protocol:** No major refactor or HSK Level expansion can happen without a formal audit.
*   **Reference:** Follow the step-by-step procedures in `audit/AUDIT_GUIDELINES.md`.
*   **Changelog:** All audit results (Passed/Average/Failed) are recorded in `audit/audit_changelog.md`.

---

## 🎨 5. UI & Aesthetic Standards
*   **Xuan Paper:** All lesson and drawing screens must use the `CalligraphyBackground` widget.
*   **Typography:** Mandatory font for Chinese characters is `NotoSansSC`.
*   **Haptics:** Every successful stroke must trigger `HapticsManager.light()`.
