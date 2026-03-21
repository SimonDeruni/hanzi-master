# 🐛 Hanzi Master - Bug Tracker

*(Older resolved issues moved to `docs/archive/RESOLVED_ISSUES_VOL_1.md`)*

| Date Discovered | Issue Description | Status |
|-----------------|-------------------|--------|
*(Older resolved issues moved to [Archive](file:///c:/Users/simon/Documents/hanzi_master/docs/archive/RESOLVED_ISSUES_VOL_2.md))*
| 2026-03-14      | **Security - Plaintext Hive Storage**: `flashcards` box stores user progress and mastery data without encryption (`HiveCipher`). | ✅ FIXED (2026-03-14) |
| 2026-03-14      | **Aesthetic - Non-compliant Theme**: Project theme was using `Colors.indigo` instead of mandated "Zen & Ink" palette. | ✅ FIXED (Hardened 2026-03-15) |
| 2026-03-14      | **Hygiene - Linter Bloat**: 53 linter warnings and deprecated API uses detected across the project. | ✅ FIXED (2026-03-14) |
| 2026-03-15      | **Missing Audio (P0)**: No TTS or native audio playback for characters. Users cannot learn pronunciation. | ✅ FIXED |
| 2026-03-15      | **Missing Tone Colors (P0)**: Pinyin is uniform. Needs standard red/yellow/green/blue coding. | ✅ FIXED |
| 2026-03-15      | **HSK 1 Barrier (P0)**: HSK 2+ content is required to prevent user churn. | ✅ FIXED (Integrated & Clean) |
| 2026-03-15      | **Low Gamification (P1)**: Need XP system / daily quests to keep up with competitive retention metrics. | ✅ FIXED |
| 2026-03-15      | **Store Readiness (P0)**: Missing iOS permissions descriptions and encryption exemption in `Info.plist`. | ✅ FIXED |
| 2026-03-15      | **Visual Fragmentation (P1)**: `NotoSansSC` font family referenced but not registered in `pubspec.yaml`. | ✅ FIXED |
| 2026-03-15      | **Media Fidelity (P1)**: Reliance on TTS instead of native audio reduces premium feel compared to Pleco/Skritter. | ✅ FIXED (Hybrid Audio) |
| 2026-03-15      | **AI Gap (P1)**: Missing 2026 standard AI roleplay and grammar correction interactivity. | ⏳ PENDING |

*(Older resolved issues moved to [RESOLVED_ISSUES_VOL_2.md](file:///c:/Users/simon/Documents/hanzi_master/docs/archive/RESOLVED_ISSUES_VOL_2.md))*
| 2026-03-15      | **Stroke Order Animation Removed (P0)**: The sequential stroke order animation showing strokes drawn in correct order was removed during refactoring. Core learning visual is missing. | 🔴 CRITICAL - Animation still not working correctly after multiple attempts |
| 2026-03-15      | **Drawing Canvas Broken (P0)**: All drawing functionality is completely broken. Users cannot trace or practice writing. Core learning feature non-functional. | 🔄 PARTIALLY RESTORED - Animation restored but not to original quality |