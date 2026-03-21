# 📑 Hanzi Master - Comprehensive Audit Plan

This document outlines the strategic audits required to ensure the security, performance, and algorithmic integrity of the Hanzi Master application.

---

## 🛡️ Audit 1: Security & Secrets Audit
**Goal:** Protect the "Scholar's Edition" revenue and user privacy.
- **Secret Scan:** Audit for hardcoded RevenueCat keys or MLKit tokens.
- **Encryption Check:** Ensure Hive boxes for user progress and "Scholar's Edition" state are encrypted.
- **Input Sanitization:** Add try/catch blocks for AnimCJK CDN fetches and local JSON parsing.
- **Source Control:** Verify `.env` and sensitive JSON files are in `.gitignore`.

## 🧬 Audit 2: Algorithmic & Logic Audit
**Goal:** Guarantee that the writing feedback is never frustratingly wrong.
- **StrokeMatcher Validation:** Verify Hausdorff & Centroid logic for multi-character words.
- **Edge Case Testing:** Test very short strokes (Dots/Ticks) vs long curved strokes.
- **Coordinate Consistency:** Ensure 1000x1000 normalization is uniform across all painters.
- **Adaptive Mastery:** Verify that the "success buffer" correctly shrinks with user streaks.

## ⚡ Audit 3: Performance & Fluidity Audit
**Goal:** Silky-smooth drawing and map navigation (Target: 60-120FPS).
- **Repaint Isolation:** Verify `RepaintBoundary` usage in `DrawingCanvas` and `CourseMap`.
- **Memory Cache:** Implement size limits for `CharacterLoader._pathCache`.
- **Startup Optimization:** Profile the heavy JSON pre-warming in `main.dart`.

## ⚖️ Audit 4: Consistency & Source of Truth Audit
**Goal:** Eliminate conflicting instructions across documentation.
- **Cross-File Sync:** Reconcile `GEMINI.md`, `functionalities.md`, and `ROADMAP.MD`.
- **Code-Doc Alignment:** Verify that the "absolute truth" in docs matches the implementation.

## 📦 Audit 5: Data Integrity & Proxy Audit
**Goal:** Ensure 100% curriculum coverage and graceful degradation.
- **Radical Coverage:** Verify "Proxy Rescue" mapping for all HSK 1 radicals.
- **Fallback Logic:** Test UI behavior when all data sources (local/CDN) fail.

## 💰 Audit 6: Monetization & Gatekeeper Audit
**Goal:** Secure the "Scholar's Edition" revenue stream.
- **Premium Check Propagation:** Verify `isPremium` gates for OCR, Tomes, and HSK 2 content.
- **Dev Bypass Cleanup:** Ensure debug-only status for test payment buttons.

## 👁️ Audit 7: OCR & Vision Performance Audit
**Goal:** Ensure ML Kit features are stable and offline-capable.
- **Camera Lifecycle:** Verify correct disposal of camera resources.
- **Offline Integrity:** Ensure model availability without active internet.

## 📚 Audit 8: Tome Library & Module Lifecycle Audit
**Goal:** Guarantee a seamless "Expansion Pack" experience.
- **Injection Safety:** Ensure module installation doesn't corrupt existing progress.
- **Atomic Operations:** Audit for half-installed database states.

## 🗺️ Audit 9: Documentation & Structural Mapping Audit
**Goal:** Ensure clear architectural "Big Picture" for long-term maintenance.
- **Project Manifest:** Create `docs/PROJECT_MAP.md` defining folder purposes.
- **Pipeline Audit:** Document the path from `tooling/` scripts to `assets/data/`.

---

## 🚀 SAF Implementation Roadmap
1.  **Phase 1 (Done):** Establish `AUDIT_GUIDELINES.md` with SAF prioritized reporting.
2.  **Phase 2 (Immediate):** Conduct **Audit 9** to create the `PROJECT_MAP.md` and verify folder consistency.
3.  **Phase 3 (Logic):** Conduct **Audit 2** with a focus on "Dot" detection for HSK 2 characters.
4.  **Phase 4 (Security):** Re-verify Encryption status after recent Hive refactors.
