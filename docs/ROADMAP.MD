# 🗺️ Project Roadmap: Hanzi Master

## Phase 1: The Core Engine (✅ COMPLETE)
- [x] **Basic Canvas:** Set up Flutter CustomPainter for touch input.
- [x] **Stroke Validation:** Implement `StrokeMatcher` with **Simplified Hausdorff** logic.
- [x] **Visual Feedback:** Turn stroke Green (Correct) or Red (Wrong).
- [x] **Error Animation:** Add "Shake" effect on bad strokes.
- [x] **Ghost Overlay:** Show the "Blue Guide Stroke" (reference path).
- [x] **Snap-to-Grid:** Auto-correct the user's line to the perfect vector on success.

## Phase 2: Data & Persistence (✅ COMPLETE)
- [x] **Data Import:** Real HK 150 character list JSON integration.
- [x] **Parser Logic:** `CharacterLoader` for SVG paths to Flutter Paths.
- [x] **Local Storage:** SM-2 SRS Algorithm with Hive.
- [x] **Progress Tracking:** Persistence for scores, attempts, and mastery levels.

## Phase 3: Aesthetic & Polish (🚧 IN PROGRESS)
- [x] **Data Source Audit:** Pivoted to **AnimCJK** and **HanziVG** for perfectly aligned skeletons.
- [x] **Calligraphy Aesthetics:** Xuan Paper texture and Rice Grid lines.
- [x] **Advanced Smoothing:** Bézier interpolation for all skeleton-based animations.
- [x] **Brush Simulation:** Velocity-based variable thickness and professional tapering.
- [x] **Comparison View:** Side-by-side results with synchronized character cycling.
- [x] **Live Grading:** Real-time precision scoring displayed during guided practice.
- [x] **Dynamic Audio:**
    * [x] **Auto-Pronounce:** Trigger TTS immediately upon correct character completion.
    * [ ] **Sound FX:** Add a subtle "paper scratching" sound during active drawing.
- [ ] **Haptic Immersion:** Refine vibrations to feel like a brush hitting paper.

## Phase 4: Course Mode & Curriculum (✅ COMPLETE)
- [x] **Thematic Unit Architecture:**
    - [x] Group 150 HSK 1 words into thematic units (Foundations, Family, Nature, etc.).
    - [x] Create `course_structure.json` to define lesson sequences.
- [x] **Structured Lesson Flow (The 6-Step Ascension):**
    - [x] **Pinyin Tone Color mapping** (Visual memorization aid).
    - [x] **1. Discovery:** Visual/Audio intro with mnemonics.
    - [x] **2. Guided Trace:** Mandatory perfect-order tracing.
    - [x] **3. The Ghost:** Trace over a faint gray character.
    - [x] **4. The Anchors:** Draw using only Start (Green) and End (Red) dots.
    - [x] **5. Active Recall:** Draw from memory on a blank grid.
    - [x] **6. Context:** Fill-in-the-blank writing challenge within an HSK 1 sentence.
- [x] **'The Living Scroll' (Galactic Map):**
    - [x] **Constellation Topology:** Radical-based "Solar System" map layout.
    - [x] **Warm-Up Mechanic:** Contextual SRS integrated into the start of lessons.
    - [x] **Visual Mastery:** Amber (Mastered) and Jade (Galaxy Complete) visual states.

## Phase 5: The Scholar’s Library (Dictionary) (✅ COMPLETE)
- [x] **Searchable Word Database:** High-performance search by Hanzi, Pinyin, or English.
- [x] **Reference UI:** Grid-based layout with "Mastery Seals" (Hanko stamps).
- [x] **Advanced Insights:** Anatomy section (Radicals) and interactive Stroke Timeline.

## Phase 6: Premium Features (✅ CORE COMPLETE)
- [x] **📸 The "Magic Lens" Scanner:** OCR-based character extraction from camera/gallery.
- [x] **🏆 The "Snapshot-to-Practice":** Auto-generate custom decks from textbook photos.
- [x] **📚 The "Tome Library" (Modular Expansion):** Downloadable HSK 2+ modules.
- [ ] **🍿 The "Subtitle Harvester":** Screenshot-to-Practice for video subtitles.
- [ ] **🖨️ The "Cheat Sheet" Generator:** Export practice grids to printable PDFs.

## Phase 7: Business & Monetization (✅ COMPLETE)
- [x] **RevenueCat Integration:** Secure in-app purchase validation.
- [x] **Paywall UI:** Premium benefit explanation and purchase flows.
- [x] **Feature Gating:** `isPremium` checks for OCR, Tomes, and expansion content.

## Phase 8: Architectural Integrity (🚧 IN PROGRESS)
- [x] **Spatial Logic Hardening:** Centroid Check to prevent positional exploits.
- [x] **Data Rescue:** Radical Proxy Mapping for missing stroke data.
- [x] **Identity Card Reliability:** Mandatory briefing for every new character.
- [x] **SRS Soft Fail:** Leech protection for mature cards.
- [x] **Security Audit (Auditing 2):** Secret scan and .gitignore hardening.
- [x] **Data Encryption:** Implement `HiveCipher` for local database using secure storage for key derivation.

- [ ] **Performance:** Move grading/parsing to background isolates.
- [ ] **Local Backups:** JSON Export/Import for user progress.

## Phase 9: Living Foundations (✅ COMPLETE)
- [x] **Gamification:** XP System (Ink Points), Scholar Ranks, and Daily Quests.
- [ ] **Sound FX:** Subtle "paper scratching" audio during drawing.
- [ ] **Haptic Immersion:** Refined vibrations for brush-on-paper feel.

## Phase 10: The Ink Guild (Social & Community) (🚧 PLANNED)
- [ ] **📜 Scroll Publishing:** Share custom decks and calligraphy results.
- [ ] **🖋️ The Poetry League:** Weekly challenges for "Artisanship Points".
- [ ] **🤝 Collaborative Constellations:** Crowdsourced mnemonics for rare characters.

## Phase 11: The Echo Hall (Oral & Intelligence) (🔥 PRIORITIZED)
- [ ] **🗣️ Speech Recognition:** Integrated AI grading for tones and pronunciation.
- [ ] **🤖 AI Scribe:** LLM-driven roleplay chat using current HSK vocabulary.
- [ ] **🎥 Authentic Snippets:** High-fidelity native speaker video clips.
- [ ] **👂 Audio-Only Quiz Mode:** Test recognition via sound while mobile.

## Phase 12: The Living Scroll (Content & Flow) (🚧 PLANNED)
- [ ] **📖 Graded Readers:** Interactive short stories using known vocabulary.
- [ ] **📸 OCR-to-Ascension:** Instant lesson generation from textbook photos.
- [ ] **📝 PDF Scholar sheets:** Printable calligraphy practice grids.

## Phase 13: Precision Analytics (The Master's Audit) (🚧 PLANNED)
- [ ] **🔥 Mastery Heatmaps:** Visual HSK syllabus with retention color-coding.
- [ ] **⚖️ Calligraphic Balance:** Advanced grading for stroke symmetry and gravity.
- [ ] **⏳ Time-of-Ink Tracking:** Detailed study time breakdown per radical.

---

# 🚨 CRITICAL SESSION: Stroke Order & Drawing System Emergency (2026-03-15)

## 🔴 P0 - BLOCKING ISSUES

### Issue 1: Stroke Order Animation Removed
- **Description:** The sequential stroke order animation that showed strokes being drawn in the correct order was removed during recent refactoring.
- **Impact:** Users can no longer see the proper stroke sequence animation, breaking the learning flow.
- **Archive Reference:** Need to recover from previous working version (check git history or backup archives).
- **Status:** 🔴 NOT STARTED

### Issue 2: Drawing Canvas Completely Broken
- **Description:** All drawing functionality is broken. Users cannot trace or practice writing characters.
- **Impact:** Core learning functionality is completely non-functional.
- **Root Cause:** Unknown - possibly related to the same refactoring that removed stroke order animation.
- **Status:** 🔴 NOT STARTED

## 📋 Recovery Plan
1. **Restore Animation:** Find the working stroke order animation code from archive/backup and reintegrate
2. **Fix Drawing:** Debug and fix the drawing canvas functionality
3. **Verify:** Test all drawing modes (trace, ghost, anchors, freehand)
4. **Audit:** Ensure stroke validation still works correctly after fixes

## ✅ Recovery Status (2026-03-15)
- [x] **Restored from Backup:** Replaced `drawing_canvas.dart` with hybrid version combining animation from backup2 (`hanzi_master_backup.zip`) and current project's `StrokeMatcher`
- [x] **Key Animation Feature:** The `_SequentialFilledStrokePainter` now uses `extractPath()` to progressively draw strokes in correct order
- [ ] **Test Animation:** Need to run app and verify stroke order animation works correctly
- [ ] **Test Drawing:** Need to verify drawing and grading still work
- [ ] **Verify Coordinate Transformation:** Check that `CharacterLoader.transformPoint` is working correctly

## 🚨 CRITICAL: Stroke Order Animation Lost - NEEDS URGENT FIX

**THIS IS A CRITICAL BUG THAT MUST BE FIXED:**

The original high-quality stroke order animation was lost during refactoring and has NOT been successfully recovered. Current attempts have failed to recreate the original animation quality.

### What the Original Animation Did:
- Stroke is drawn progressively along the centerline/skeleton (from start point to end point)
- Like a pen moving across paper - NOT outline drawing, NOT fading
- Smooth, natural stroke animation showing proper stroke order

### Current State:
- Current animation either: (1) fades in strokes, (2) draws outline progressively, or (3) draws skeleton but not correctly
- The median paths are now being generated from stroke paths but animation still not correct

### What We've Tried:
1. Restored backup code with extractPath() - draws outline progressively
2. Added median path generation from stroke paths using CharacterLoader.samplePoints()
3. Attempted to use skeleton-based drawing

### Next Steps:
- Need to find the original working animation code OR recreate it from scratch
- May need to look at other backups or earlier git history
- Consider examining how other apps (like Skritter, Pleco) do this animation
