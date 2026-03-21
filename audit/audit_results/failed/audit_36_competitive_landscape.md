# Audit 36: Competitive Landscape Feature Audit
**Status:** 🔴 FAIL
**Date:** 2026-03-15

## 📊 Executive Summary
Hanzi Master possesses a world-class calligraphic drawing engine and innovative pedagogy (Constellation Maps, Context Steps), but critically fails on foundational language retention via missing Audio, lack of Pinyin Tone Colors, and no HSK 2+ progression.

## 🚩 Findings (Prioritized)
### [P0 - Critical] - Missing Audio & TTS
- **Evidence:** `lib/features/course/` (No audio playback widgets)
- **Impact:** Users cannot hear the pronunciation of characters, crippling listening skills.
- **Remediation:** Implement `flutter_tts` or native audio recordings for every character.

### [P0 - Critical] - Lack of Tone Color Coding
- **Evidence:** `lib/features/flashcards/` (Pinyin rendered uniformly without tone logic)
- **Impact:** Fails industry standard of coloring pinyin by tone (red/yellow/green/blue) for visual memory.
- **Remediation:** Create a `RichText` parser for pinyin syllables to apply tone colors.

### [P0 - Critical] - Progression Blocked at HSK 1
- **Evidence:** `assets/data/hsk1_` files are the only viable syllabus.
- **Impact:** Users abandon the app after reaching the HSK 1 ceiling.
- **Remediation:** Fast-track the HSK 2 Tome expansion logic.

### [P1 - High] - No Gamification / Retention Hooks
- **Evidence:** `lib/features/flashcards/presentation/widgets/streak_seal.dart` is the only hook.
- **Impact:** Low long-term retention compared to competitors like HelloChinese.
- **Remediation:** Implement "Ink Points" (XP), daily quests, and Scholar's Ranks.

## ✅ Corrective Actions Taken
- N/A (These are foundational architectural gaps that require dedicated feature branches, not immediate isolated bug fixes. Issues have been securely logged to `docs/ISSUES.md`).

## ⚖️ Documentation Sync
- **GEMINI.md Update Required?** No
- **ROADMAP.MD Updated?** No (Many of these fall into Phase 8/9 concepts)
- **Bugs.md Entry Created?** Yes (Logged in ISSUES.md)
