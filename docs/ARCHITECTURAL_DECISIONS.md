# 🏗️ Architectural Decision Records (ADR)

This document records the critical technical choices made for Hanzi Master to ensure consistency across AI sessions.

---

## 💎 1. State Management: Riverpod
- **Decision:** Use Riverpod 2.0 with `@riverpod` annotations.
- **Rationale:** Handles complex galactic map state and async AI requests with compile-time safety.
- **Rule:** Prefer `AsyncNotifier` for character data.

## 🧬 2. Stroke Validation: Simplified Hausdorff
- **Decision:** Use Simplified Hausdorff distance + Centroid Check.
- **Rationale:** Best "feel" for kinesthetic feedback without the performance cost of Frechet.
- **Rule:** Normalize points to **1000x1000** before comparison.

## 🤖 3. AI Strategy: Hybrid Intelligence
- **Decision:** Split intelligence between **Google ML Kit (Local)** and **Gemini 2.5 Flash (Cloud)**.
- **Rationale:** Local ML provides 30fps latency for Radar and OCR. Gemini provides the "Scholarship" (Etymology, Chat, Deep Vision).
- **Rule:** Use Local ML as the primary "Radar" and Gemini as the secondary "Deep Dive."

## 🔑 4. Quota Management: Scholar's Key Pool
- **Decision:** Multi-key round-robin rotation for Gemini API.
- **Rationale:** Bypasses free-tier limits by distributing requests across a pool of up to 10 keys.
- **Rule:** Implement rotation at the service layer; never hardcode a single key in high-volume services.

## 📦 5. Persistence: Hive & SQLite
- **Decision:** Hive for SRS/User state, SQLite for the 50k+ entry Master Dictionary.
- **Rule:** All user-data Hive boxes MUST be encrypted with `HiveCipher`.

## 🎨 6. UI Mandate: Zen & Ink (Xuan/Carbon)
- **Decision:** Rigid adherence to Xuan Paper (`#FDFCF0`) and Carbon Ink (`#1A1A1B`).
- **Rationale:** Differentiates the app as a "Calligraphic Tool" rather than a generic flashcard app.
