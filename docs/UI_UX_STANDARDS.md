# 🖌️ Hanzi Master - UI/UX & Aesthetic Standards

This document defines the visual language of the application to ensure consistency.

---

## 🎨 Color Palette (The "Calligraphy" Theme)
*   **Paper (Background):** `#FDFCF0` (Warm Xuan Paper).
*   **Ink (Text/Strokes):** `#1A1A1B` (Deep Carbon Ink).
*   **Guide (Guidance):** `#3F51B5` (Indigo Silk - 10% opacity for guides).
*   **Success:** `#2E7D32` (Jade Green).
*   **Error:** `#C62828` (Cinnabar Red).

## 📐 Spacing & Layout
*   **The Grid:** All margins/paddings must be multiples of **8dp**.
*   **Safe Zones:** Large characters must have at least **40dp** of padding from the canvas edge.
*   **Aspect Ratio:** Drawing surfaces MUST be **1:1** squares.

## ✨ Animations & Motion
*   **Duration:** 
    *   Quick feedback (Haptics/Shake): **300ms**.
    *   Stroke animations: **Strokes * 800ms**.
*   **Curves:** Always use `Curves.easeInOutQuart` for a "natural brush" feel.

## 📳 Haptic Language
*   **Success:** `HapticsManager.success()` (Double vibration).
*   **Stroke Hit:** `HapticsManager.light()` (Micro-tap).
*   **Error:** `HapticsManager.heavy()` (Long pulse).
