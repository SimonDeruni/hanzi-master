# Resolved Issues Archive - Volume 2
Older resolved issues from [ISSUES.md](file:///c:/Users/simon/Documents/hanzi_master/docs/ISSUES.md).

| Date Discovered | Issue Description | Status |
|-----------------|-------------------|--------|
| 2026-01-27      | **Complex Character Data Loading**: Fixed an issue where characters present in AnimCJK but missing from HSK1 legacy data would fail to load strokes. | ✅ FIXED |
| 2026-01-27      | **Lesson Flow - Stuck Step**: User was stuck in Guided Trace mode because the drawing widget state wasn't resetting between steps. | ✅ FIXED |
| 2026-01-27      | **Lesson Flow - Layout Distortion**: Drawing Canvas was auto-centering characters, causing misalignment with the grid and visual distortion. | ✅ FIXED |
| 2026-01-27      | **Lesson Crash - RangeError**: `RangeError (end): Invalid value: Not in inclusive range 0..8: -1`. Likely occurring during stroke list slicing. | ✅ FIXED |
| 2026-01-27      | **Initialization Loop**: Refactored auto-import logic to prevent infinite rebuild cycles in the flashcard controller. | ✅ FIXED |
| 2026-01-27      | **Font/Asset Crash**: Invalid font family reference causing potential startup failures. | ✅ FIXED |
| 2026-01-27      | **MasterySeal Index Crash**: Accessing empty path metrics in the mastery seal widget. | ✅ FIXED |
| 2026-01-27      | **Database Resilience**: App was crashing if Hive box wasn't fully ready or assets were missing. | ✅ FIXED |
| 2026-01-27      | **Lesson - Active Recall Hints**: Start (Green) and End (Red) dots are still visible in Active Recall mode (should be blank). | ✅ FIXED |
| 2026-01-27      | **Lesson - Ghost vs Guided**: No visual distinction between "Guided Trace" and "Ghost Trace" modes (both show the blue guide). Ghost should be faint gray. | ✅ FIXED |
| 2026-01-27      | **Drawing Canvas - Ghost Clutter**: The full static character was visible behind the active stroke, causing confusion. | ✅ FIXED |
| 2026-01-27      | **Drawing Canvas - Proportional Stretching**: Character appeared "allongé" due to flexible canvas sizing and missing grid anchors. | ✅ FIXED |
| 2026-01-27      | **Recall Grading - Strictness**: Draw from memory grading is too strict on start/end points. Should prioritize shape/direction over exact pixel coordinates. | ✅ FIXED |
| 2026-01-27      | **Course Map - Non-responsive Nodes**: Tapping character nodes in the "Living Scroll" path does not initiate the lesson screen. | ✅ FIXED |
| 2026-01-27      | **Course Map - Non-responsive Quiz FAB**: Tapping the "Practice Quiz" button does not open the quiz screen. | ✅ FIXED |
| 2026-01-30      | **App-wide Crash on Interaction**: Clicking nodes or library items caused crashes/freezes due to aggressive provider invalidation and unsafe path access. | ✅ FIXED |
| 2026-01-30      | **Hero Tag Collision Crash**: App crashed with `Multiple heroes that share the same tag` error due to multiple FABs in `IndexedStack` sharing the default tag. | ✅ FIXED |
| 2026-03-12      | **Empty Radical Nodes**: Some radical nodes (e.g., `阝`) were invisible/empty because stroke data was missing for isolated forms. | ✅ FIXED (Proxy Rescue) |
| 2026-03-12      | **Metadata Question Marks**: Missions and Forge steps displayed `？` for characters like `那`, `面`, `飞` due to incomplete JSON decomposition data. | ✅ FIXED |
| 2026-03-12      | **Backup Process Lock**: A 6GB background process locked the 3.5GB backup ZIP, preventing user access. | ✅ FIXED (Cleaned & Shrinked) |
