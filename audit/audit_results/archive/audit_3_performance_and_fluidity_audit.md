# ⚡ Auditing 3: Performance & Fluidity Report

**Date:** March 14, 2026  
**Status:** ⚠️ ACTION REQUIRED  
**Objective:** Maintain 120FPS and optimize memory/startup.

---

## 🎨 1. Repaint Boundary Audit
**Goal:** Verify that static/heavy elements are isolated to prevent unnecessary repaints.

*   **`CourseScreen.dart`**: ✅ PASS
    *   The "Ancient Atlas" global background is correctly wrapped in a `RepaintBoundary`.
    *   *Observation:* The `CustomScrollView` uses a `cacheExtent` of 500, which is good for smooth scrolling.
*   **`DrawingCanvas.dart`**: ❌ FAIL (Partial)
    *   **Static Characters:** In `readOnly` mode, the `_CompletedStrokesPainter` (static reference) is correctly wrapped in a `RepaintBoundary`.
    *   **Active Drawing:** However, during active `strokeByStrokeMode`, the background "Completed Strokes" (which are static once drawn) and the "Reference Stroke" are NOT isolated from the user's active drawing layer. 
    *   **Recommendation:** Wrap the background `CustomPaint` (Completed Strokes + Reference) in a `RepaintBoundary` to prevent them from repainting every time the user moves their finger (on every `onPanUpdate`).

---

## 🧠 2. Memory Leak & Cache Audit
**Goal:** Ensure the in-memory SVG path cache doesn't grow indefinitely.

*   **`CharacterLoader.dart`**: ⚠️ WARNING
    *   **Implementation:** `static final Map<String, Path> _pathCache = {};` is an unbounded `Map`.
    *   **Risk:** While HSK 1 is small (~150 characters), if the app scales to HSK 6 (5000+ characters), this cache will consume significant memory.
    *   **Recommendation:** Implement a **LinkedHashMap**-based LRU (Least Recently Used) cache or use a package like `quiver`'s `LruMap` to limit the cache size to ~200-300 paths.

---

## ⚡ 3. JSON Pre-warming & Startup Audit
**Goal:** Prevent UI freezes (ANR) during heavy initialization.

*   **`hsk1.json` Size**: ✅ PASS
    *   **Actual Size:** ~13.7 KB.
    *   **Analysis:** This is significantly below the 5MB threshold. Parsing is currently instantaneous.
*   **`main.dart` Initialization**: ⚠️ IMPROVEMENT POSSIBLE
    *   **Logic:** `await container.read(flashcardRepositoryProvider).init();` is called on the main thread.
    *   **Current State:** Because `hsk1.json` is tiny, there is no noticeable lag.
    *   **Future-Proofing:** If the dataset grows (HSK 3.0 or full dictionary), this WILL block the main thread and cause a "jank" during the splash screen.
    *   **Recommendation:** Keep an eye on parsing time. If it exceeds 100ms, move `repository.init()` to a background **Isolate**.

---

## 🛠️ Summary of Recommended Fixes
1.  **Surgical Fix:** Wrap the static background layers in `DrawingCanvas.dart` (lines 350-358) with a `RepaintBoundary`.
2.  **Refactor:** Add a simple size check to `_pathCache` in `CharacterLoader.dart` to prevent it from exceeding 500 entries.
3.  **Optimization:** Wrap the `AncientAtlasPainter` in `CourseScreen.dart` with `const` if applicable (currently it's dynamic based on theme).

---
**Audit Level:** 🟠 MEDIUM PRIORITY  
*Focus on the DrawingCanvas RepaintBoundary to ensure 120FPS during writing.*
