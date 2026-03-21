# 🏗️ Architectural Decision Records (ADR)

This document records the critical technical choices made for Hanzi Master to ensure consistency across AI sessions.

---

## 💎 1. State Management: Riverpod
- **Decision:** Use Riverpod 2.0 with `@riverpod` annotations.
- **Rationale:** Solo-founder friendly, compile-time safety, and handles the complex state of the "Living Scroll" map without global pollution.
- **Rule:** Never use `StateProvider`. Prefer `AsyncNotifier` for character data.

## 🧬 2. Stroke Validation: Simplified Hausdorff
- **Decision:** Use a simplified version of the Hausdorff distance algorithm + Centroid Check.
- **Rationale:** Frechet distance is too computationally expensive for real-time 120FPS drawing on mobile. Hausdorff provides the best "feel" for kinesthetic feedback while remaining performant.
- **Rule:** Always normalize points to **1000x1000** before running the comparison.

## 📦 3. Persistence: Hive
- **Decision:** Local-only NoSQL (Hive).
- **Rationale:** Instant read/write for the SM-2 SRS algorithm. No latency for dictionary searches.
- **Rule:** All boxes MUST be encrypted with `HiveCipher` to protect the "Scholar's Edition" gate.

## 🎨 4. Data Source: HanziVG & AnimCJK
- **Decision:** Use HanziVG for skeletons and AnimCJK for fallback.
- **Rationale:** Provides high-quality hand-drawn medians (centerlines) rather than robotic outlines. Essential for calligraphic feedback.
