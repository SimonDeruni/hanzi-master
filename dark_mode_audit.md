# Dark Mode Audit — hanzi_master

**Generated:** 2026-07-08  
**Scope:** All 70 UI-bearing files under `lib/` (49 screens, 14 sheets, 3 dialogs, 3 overlays, 1 call summary)  
**Coverage:** 30 files with hardcoded light-mode colors that do not adapt to dark mode

---

## Legend

| Tier | Meaning | Files |
|------|---------|-------|
| **Tier 1** | Zero dark mode handling — every color hardcoded for light mode | 19 |
| **Tier 2** | Partial handling — `isDark` or `colorScheme` used somewhere but many unguarded hardcoded spots remain | 6 |
| **Tier 3** | Minor issues — well-adapted overall, 1–4 unguarded spots | 4 |

Each file entry lists every hardcoded color reference with:
- **Line(s)** — the exact line number in the file
- **Hardcoded Color** — the color value used
- **Element** — what widget or property it applies to
- **Dark Mode Fix** — what the color should become when `Brightness.dark`
- **Snippet** — the surrounding code for context

---

## Table of Contents

### Tier 1 — Zero Dark Mode Handling
1. [web_browser_screen.dart](#1-web_browser_screendart)
2. [smart_media_desk_screen.dart](#2-smart_media_desk_screendart)
3. [onboarding_screen.dart](#3-onboarding_screendart)
4. [story_summary_screen.dart](#4-story_summary_screendart)
5. [media_search_screen.dart](#5-media_search_screendart)
6. [simplified_article_reader_screen.dart](#6-simplified_article_reader_screendart)
7. [lesson_screen.dart](#7-lesson_screendart)
8. [radical_lesson_screen.dart](#8-radical_lesson_screendart)
9. [quiz_screen.dart](#9-quiz_screendart)
10. [session_summary_screen.dart](#10-session_summary_screendart)
11. [flashcard_form_screen.dart](#11-flashcard_form_screendart)
12. [translation_session_detail_screen.dart](#12-translation_session_detail_screendart)
13. [translation_history_screen.dart](#13-translation_history_screendart)
14. [tutorial_lesson_screen.dart](#14-tutorial_lesson_screendart)
15. [custom_story_creator_sheet.dart](#15-custom_story_creator_sheetdart)
16. [pronunciation_report_sheet.dart](#16-pronunciation_report_sheetdart)
17. [fullscreen_media_overlay.dart](#17-fullscreen_media_overlaydart)
18. [premium_subtitles_overlay.dart](#18-premium_subtitles_overlaydart)
19. [paywall_screen.dart](#19-paywall_screendart)

### Tier 2 — Partial Handling
20. [reading_room_screen.dart](#20-reading_room_screendart)
21. [course_screen.dart](#21-course_screendart)
22. [media_hub_screen.dart](#22-media_hub_screendart)
23. [cultural_context_screen.dart](#23-cultural_context_screendart)
24. [story_library_screen.dart](#24-story_library_screendart)
25. [story_cultural_insight_screen.dart](#25-story_cultural_insight_screendart)

### Tier 3 — Minor Issues
26. [global_blurred_bottom_sheet.dart](#26-global_blurred_bottom_sheetdart)
27. [paywall_sheet.dart](#27-paywall_sheetdart)
28. [interactive_image_overlay.dart](#28-interactive_image_overlaydart)
29. [custom_scenario_dialog.dart](#29-custom_scenario_dialogdart)

---

## Common Fix Pattern

```dart
final isDark = Theme.of(context).brightness == Brightness.dark;

// Xuan paper background → dark ink background
Color(0xFFFDFCF0) → isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)
// Dark ink text → paper text
Color(0xFF1A1A1B) → isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)
// White card → dark grey card
Colors.white       → isDark ? Colors.grey.shade900 : Colors.white
// Black87 text → white70 text
Colors.black87     → isDark ? Colors.white70 : Colors.black87
// Black54 text → white54 text
Colors.black54     → isDark ? Colors.white54 : Colors.black54
// Indigo button → adapted accent
Colors.indigo      → isDark ? Colors.indigo.shade200 : Colors.indigo
// Grey text → lighter grey in dark
Colors.grey        → isDark ? Colors.grey.shade400 : Colors.grey
```

---

# TIER 1 — Zero Dark Mode Handling

---

## 1. web_browser_screen.dart

**Path:** `lib/features/media/presentation/screens/web_browser_screen.dart`  
**Lines:** 1383  
**Hardcoded color spots:** 26

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 73 | `Color(0x00000000)` | WebView background | `isDark ? const Color(0xFF1A1A1B) : const Color(0x00000000)` |
| 555 | `Colors.amber` | Auto-fix icon | `isDark ? Colors.amber.shade200 : Colors.amber` |
| 880 | `Color(0xFFFDFCF0)` | Container background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 922 | `Colors.grey[700]` | Subtitle text | `isDark ? Colors.grey.shade300 : Colors.grey[700]` |
| 931 | `Colors.grey[700]` | Subtitle text | same |
| 967 | `Colors.white` | Icon color | `isDark ? Colors.black87 : Colors.white` |
| 1001 | `Colors.grey` | Pinyin text | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 1020 | `Colors.blueAccent` | HSK level text | `isDark ? Colors.blueAccent.shade200 : Colors.blueAccent` |
| 1048 | `Colors.blueAccent` | HSK level text | same |
| 1126 | `Color(0xFFFDFCF0)` | Bottom sheet background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 1177 | `Colors.indigo` | Zen mode text toggle | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 1190 | `Colors.blueAccent` | Progress indicator | `isDark ? Colors.blueAccent.shade200 : Colors.blueAccent` |
| 1195 | `Color(0xFFFDFCF0)` | Container background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 1224 | `Colors.deepPurple` | Button background | `isDark ? Colors.deepPurple.shade200 : Colors.deepPurple` |
| 1225 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |
| 1236 | `Colors.white` | Loading spinner | `isDark ? Colors.black87 : Colors.white` |
| 1240 | `Colors.indigo` | Button background | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 1241 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |
| 1303 | `Color(0xFFFDFCF0)` | Dialog background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 1309 | `Colors.indigo` | Dialog text | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 1323 | `Colors.white` | Snackbar text | `isDark ? Colors.black87 : Colors.white` |
| 1332 | `Colors.indigo` | Tab active color | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 1351 | `Colors.indigo` | Cancel border | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 1354 | `Colors.indigo` | Cancel text | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 1361 | `Colors.indigo` | Confirm button | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 1362 | `Colors.white` | Confirm text | `isDark ? Colors.black87 : Colors.white` |

**Context:** `const Color(0xFFFDFCF0)` at lines 880/1126/1195/1303 is the warm Xuan paper background used throughout this file. In light mode it's a pleasant off-white; in dark mode it would be a blinding white sheet. No `Brightness.dark` check exists anywhere in this file.

---

## 2. smart_media_desk_screen.dart

**Path:** `lib/features/media/presentation/screens/smart_media_desk_screen.dart`  
**Lines:** ~700  
**Hardcoded color spots:** 23

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 152 | `Colors.orange` | HSK level badge | `isDark ? Colors.orange.shade200 : Colors.orange` |
| 273 | `Colors.amber` | Lightbulb icon | `isDark ? Colors.amber.shade200 : Colors.amber` |
| 310 | `Colors.white` | Card background | `isDark ? Colors.grey.shade900 : Colors.white` |
| 325 | `Colors.red` | Error text | `isDark ? Colors.red.shade200 : Colors.red` |
| 471 | `Color(0xFFFDFCF0)` | Scaffold background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 475 | `Color(0xFF1C2541)` | App bar title | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1C2541)` |
| 479 | `Color(0xFF1C2541)` | Icon theme | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1C2541)` |
| 482 | `Colors.indigo` | Caption icon | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 488 | `Colors.indigo` | Toggle thumb | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 494 | `Colors.indigo` | Toggle thumb | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 501 | `Colors.orange` | Toggle thumb | `isDark ? Colors.orange.shade200 : Colors.orange` |
| 507 | `Colors.redAccent` | Toggle thumb | `isDark ? Colors.redAccent.shade200 : Colors.redAccent` |
| 518 | `Colors.indigo` / `Colors.red` | Mic button | `isDark ? Colors.indigo.shade200 : Colors.indigo` / `isDark ? Colors.red.shade200 : Colors.red` |
| 519 | `Colors.white` | Mic icon | `isDark ? Colors.black87 : Colors.white` |
| 520 | `Colors.white` | Mic label | `isDark ? Colors.black87 : Colors.white` |
| 585 | `Colors.white` | Fullscreen icon | `isDark ? Colors.black87 : Colors.white` |
| 587 | `Colors.white` | Fullscreen label | `isDark ? Colors.black87 : Colors.white` |
| 633 | `Colors.red` | Error text | `isDark ? Colors.red.shade200 : Colors.red` |
| 645 | `Colors.green` / `Colors.red` | Feedback icon | `isDark ? Colors.green.shade200 : Colors.green` / `isDark ? Colors.red.shade200 : Colors.red` |
| 649 | `Colors.green` / `Colors.red` | Feedback text | same |

**Context:** Entire desk UI hardcoded to light paper theme (0xFFFDFCF0). White cards, dark text, indigo buttons — none adapt. In dark mode the screen is predominantly white.

---

## 3. onboarding_screen.dart

**Path:** `lib/features/onboarding/presentation/screens/onboarding_screen.dart`  
**Lines:** ~1000  
**Hardcoded color spots:** 41

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 108 | `Color(0xFFFDFCF0)` | Scaffold background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 147 | `Colors.redAccent` | Accent text | `isDark ? Colors.redAccent.shade200 : Colors.redAccent` |
| 207 | `Color(0xFF1A1A1B)` | Heading text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 232 | `Colors.red[700]` | Step indicator | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 241 | `Colors.red[900]` | Step indicator | `isDark ? Colors.red.shade300 : Colors.red[900]` |
| 277 | `Color(0xFF1A1A1B)` | Skip button text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 278 | `Color(0xFF1A1A1B)` | Skip button border | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 309 | `Colors.red[700]` | Progress bar | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 314 | `Colors.red[700]` | Progress label | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 328 | `Color(0xFF1A1A1B)` | Body text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 377 | `Colors.red[700]` | Left border accent | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 414 | `Color(0xFF1A1A1B)` | Body text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 477 | `Color(0xFF1A1A1B)` | Body text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 544 | `Color(0xFF1A1A1B)` | Body text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 583 | `Colors.red[700]` | Icon | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 626 | `Color(0xFF1A1A1B)` | Body text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 658 | `Colors.white` | Card text | `isDark ? Colors.black87 : Colors.white` |
| 667 | `Colors.red[700]` | Icon | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 724 | `Colors.red[700]` | Badge background | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 754 | `Color(0xFF1A1A1B)` | Option text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 772 | `Color(0xFF1A1A1B)` / `Colors.white` | Selected/unselected toggle | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` / `isDark ? Colors.grey.shade800 : Colors.white` |
| 775 | `Color(0xFF1A1A1B)` | Selected card bg | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 792 | `Color(0xFFFDFCF0)` / `Color(0xFF1A1A1B)` | Chip text toggle | Inverse pair |
| 802 | `Color(0xFFFDFCF0)` | Selected chip text | Inverse |
| 809 | `Color(0xFFFDFCF0)` | Check icon | Inverse |
| 820 | `Colors.white` | Card background | `isDark ? Colors.grey.shade900 : Colors.white` |
| 837 | `Colors.red[700]` | Accent text | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 869 | `Colors.white` | Card background | `isDark ? Colors.grey.shade900 : Colors.white` |
| 872 | `Colors.red[700]` | Selected indicator | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 893 | `Color(0xFF1A1A1B)` | Body text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 911 | `Colors.red[700]` | Selected indicator | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 932 | `Colors.white` | Card background | `isDark ? Colors.grey.shade900 : Colors.white` |
| 935 | `Colors.red[700]` | Selected indicator | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 952 | `Colors.red[700]` | Selected indicator | `isDark ? Colors.red.shade300 : Colors.red[700]` |
| 960 | `Color(0xFF1A1A1B)` | Body text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 980 | `Color(0xFF1A1A1B)` | Get Started button | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` (swap bg & fg) |
| 981 | `Color(0xFFFDFCF0)` | Get Started text | Inverse of above |
| 982 | `Color(0xFF1A1A1B)` | Disabled button bg | Inverse |
| 983 | `Color(0xFFFDFCF0)` | Disabled button text | Inverse |

**Context:** Entire onboarding flow designed on warm paper background (0xFFFDFCF0) with dark ink text (0xFF1A1A1B) and red accent (0xFF1A1A1B[700]). Every single color reference is hardcoded. In dark mode this screen would be blinding white with black text that technically works but is visually jarring — the warm paper aesthetic becomes harsh.

---

## 4. story_summary_screen.dart

**Path:** `lib/features/media/presentation/screens/story_summary_screen.dart`  
**Lines:** 507  
**Hardcoded color spots:** 29

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 127 | `Color(0xFFFDFCF0)` | Scaffold background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 135 | `Color(0xFF1A1A1B)` | AppBar background | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 136 | `Colors.white` | AppBar text | `isDark ? Colors.black87 : Colors.white` |
| 168 | `Color(0xFF8B0000)` | HSK badge | Keep as-is (deep red accent) or `isDark ? Color(0xFFCF6679) : Color(0xFF8B0000)` |
| 174 | `Colors.white` | Badge text | `isDark ? Colors.black87 : Colors.white` |
| 186 | `Color(0xFF1A1A1B)` | Native badge bg | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 192 | `Colors.white` | Native badge text | `isDark ? Colors.black87 : Colors.white` |
| 204 | `Color(0xFF1A1A1B)` | Category border | `isDark ? const Color(0xFFFDFCF0).withValues(alpha: 0.4) : const Color(0xFF1A1A1B).withValues(alpha: 0.2)` |
| 210 | `Color(0xFF1A1A1B)` | Title text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 227 | `Color(0xFF1A1A1B)` | Chinese title | `isDark ? const Color(0xFFFDFCF0).withValues(alpha: 0.6) : const Color(0xFF1A1A1B).withValues(alpha: 0.6)` |
| 238 | `Color(0xFF1A1A1B)` | Summary heading | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 253 | `Color(0xFF1A1A1B)` | Loading spinner | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 263 | `Color(0xFF1A1A1B)` | Spinner track | `isDark ? const Color(0xFFFDFCF0).withValues(alpha: 0.4) : const Color(0xFF1A1A1B).withValues(alpha: 0.4)` |
| 275 | `Color(0xFF1A1A1B)` | Summary text | `isDark ? const Color(0xFFFDFCF0).withValues(alpha: 0.8) : const Color(0xFF1A1A1B).withValues(alpha: 0.8)` |
| 287 | `Color(0xFF1A1A1B)` | Key Words heading | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 314 | `Color(0xFF8B0000)` | Button shadow | Keep or `isDark ? Color(0xFFCF6679).withValues(alpha: 0.3) : Color(0xFF8B0000).withValues(alpha: 0.3)` |
| 334 | `Color(0xFF8B0000)` | "Open Original" button | Keep deep red or use `isDark ? Color(0xFFCF6679) : Color(0xFF8B0000)` |
| 335 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |
| 364 | `Color(0xFF8B0000)` | "Start Reading" shadow | same as 314 |
| 373 | `Color(0xFF8B0000)` | "Start Reading" button | same as 334 |
| 374 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |
| 408 | `Color(0xFF8B0000)` | Keywords spinner | `isDark ? const Color(0xFFCF6679) : const Color(0xFF8B0000)` |
| 416 | `Color(0xFF1A1A1B)` | Error text | `isDark ? const Color(0xFFFDFCF0).withValues(alpha: 0.5) : const Color(0xFF1A1A1B).withValues(alpha: 0.5)` |
| 437 | `Color(0xFF1A1A1B)` | Empty list text | same |
| 459 | `Colors.white` | Keyword card bg | `isDark ? Colors.grey.shade900 : Colors.white` |
| 461 | `Color(0xFF1A1A1B)` | Keyword card border | `isDark ? const Color(0xFFFDFCF0).withValues(alpha: 0.1) : const Color(0xFF1A1A1B).withValues(alpha: 0.1)` |
| 480 | `Color(0xFF1A1A1B)` | Keyword hanzi | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 488 | `Color(0xFF1A1A1B)` | Keyword pinyin | Inverse |
| 497 | `Color(0xFF1A1A1B)` | Keyword meaning | Inverse |

**Context:** Pre-reading screen with deep red (`0xFF8B0000`) call-to-action buttons and dark ink (`0xFF1A1A1B`) text on paper (`0xFFFDFCF0`) background. In dark mode the deep red buttons on dark background would be nearly invisible.

---

## 5. media_search_screen.dart

**Path:** `lib/features/media/presentation/screens/media_search_screen.dart`  
**Lines:** ~350  
**Hardcoded color spots:** 10

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 106 | `Color(0xFFFDFCF0)` | Scaffold background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 124 | `Colors.white` | Search field fill | `isDark ? Colors.grey.shade800 : Colors.white` |
| 135 | `Colors.indigo` | Send icon | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 143 | `Colors.red` | Error text | `isDark ? Colors.red.shade200 : Colors.red` |
| 150 | `Colors.indigo` | Loading spinner | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 229 | `Colors.white` | Card background | `isDark ? Colors.grey.shade900 : Colors.white` |
| 266 | `Colors.white` | Card badge text | `isDark ? Colors.black87 : Colors.white` |
| 282 | `Colors.white` | CC icon | `isDark ? Colors.black87 : Colors.white` |
| 284 | `Colors.white` | CC label | `isDark ? Colors.black87 : Colors.white` |
| 298 | `Colors.white` | Play icon | `isDark ? Colors.black87 : Colors.white` |

**Context:** Search results screen with white cards on paper background. In dark mode the entire results area becomes a white wall.

---

## 6. simplified_article_reader_screen.dart

**Path:** `lib/features/media/presentation/screens/simplified_article_reader_screen.dart`  
**Lines:** ~120  
**Hardcoded color spots:** 7

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 24 | `Color(0xFFFDFCF0)` | Scaffold background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 31 | `Colors.grey` | Pinyin toggle off | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 31 | `Colors.blue` | Pinyin toggle on | `isDark ? Colors.blue.shade200 : Colors.blue` |
| 43 | `Colors.grey` | Translation toggle off | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 43 | `Colors.purple` | Translation toggle on | `isDark ? Colors.purple.shade200 : Colors.purple` |
| 54 | `Color(0xFFFDFCF0)` | Container background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 80 | `Colors.grey` | Article text | `isDark ? Colors.grey.shade300 : Colors.grey` |
| 96 | `Colors.blueGrey` | Article metadata | `isDark ? Colors.blueGrey.shade200 : Colors.blueGrey` |

**Context:** Simple article reader with paper background and grey text. In dark mode: blinding white background with potentially unreadable grey-on-dark if brightness isn't checked.

---

## 7. lesson_screen.dart

**Path:** `lib/features/course/presentation/screens/lesson_screen.dart`  
**Lines:** ~150  
**Hardcoded color spots:** 4

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 34 | `Colors.white` | Speed icon | `isDark ? Colors.black87 : Colors.white` |
| 53 | `Colors.grey` | Close icon | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 57 | `Colors.indigo` | Warm Up heading | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 98 | `Colors.indigo` | Loading spinner | `isDark ? Colors.indigo.shade200 : Colors.indigo` |

**Context:** Small file, few spots. White icon on unknown background could become invisible in dark mode if the background is dark.

---

## 8. radical_lesson_screen.dart

**Path:** `lib/features/course/presentation/screens/radical_lesson_screen.dart`  
**Lines:** ~400  
**Hardcoded color spots:** 17

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 125 | `Colors.grey` | Close icon | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 148 | `Colors.grey` | Step heading (Origin) | `isDark ? Colors.grey.shade300 : Colors.grey` |
| 168 | `Colors.grey` | Step heading (Forge) | same |
| 205 | `Colors.green` / `Colors.amber` / `Colors.brown.shade300` | Forge state | `isDark ? Colors.green.shade200 : Colors.green` / `isDark ? Colors.amber.shade200 : Colors.amber` / `isDark ? Colors.brown.shade200 : Colors.brown.shade300` |
| 215 | `Colors.indigo` | Target hanzi | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 217 | `Colors.amber` | Add icon | `isDark ? Colors.amber.shade200 : Colors.amber` |
| 234 | `Colors.indigo` | Tile bg (correct) | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 236 | `Colors.indigo` | Dragging tile | same |
| 237 | `Colors.indigo` | Tile bg | same |
| 253 | `Colors.green` | Success text | `isDark ? Colors.green.shade200 : Colors.green` |
| 268 | `Colors.white` | Tile text | `isDark ? Colors.black87 : Colors.white` |
| 291 | `Colors.grey` | Step heading (Hunt) | `isDark ? Colors.grey.shade300 : Colors.grey` |
| 321 | `Colors.green` | Hunt found icon | `isDark ? Colors.green.shade200 : Colors.green` |
| 323 | `Colors.green` | Hunt found border | same |
| 328 | `Colors.white` | Check icon | `isDark ? Colors.black87 : Colors.white` |
| 372 | `Colors.indigo` | Touch icon | `isDark ? Colors.indigo.shade200 : Colors.indigo` |

**Context:** Gamified radical lesson with colored step indicators (grey, indigo, amber, green, brown). All colors hardcoded. In dark mode the white tile text on light indigo would have poor contrast, and grey headings on dark bg become invisible.

---

## 9. quiz_screen.dart

**Path:** `lib/features/quiz/presentation/screens/quiz_screen.dart`  
**Lines:** ~220  
**Hardcoded color spots:** 8

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 103 | `Colors.grey` | Close icon | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 120 | `Colors.white` | Question card bg | `isDark ? Colors.grey.shade900 : Colors.white` |
| 128 | `Colors.grey` | Question number | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 136 | `Colors.indigo` | Option text | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 158 | `Colors.white` | Variable initialization | `isDark ? Colors.grey.shade900 : Colors.white` |
| 199 | `Colors.indigo` | Score text | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 204 | `Colors.indigo` | Return button bg | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 207 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |

**Context:** Quiz screen with white question card. In dark mode the card remains white while the scaffold background may be dark — likely a `Colors.white` card on `Colors.white` scaffold (no scaffold bg color check either).

---

## 10. session_summary_screen.dart

**Path:** `lib/features/flashcards/presentation/screens/session_summary_screen.dart`  
**Lines:** ~120  
**Hardcoded color spots:** 9

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 31 | `Colors.amber` | Trophy icon | `isDark ? Colors.amber.shade200 : Colors.amber` |
| 36 | `Colors.indigo` | Score heading | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 48 | `Colors.grey` | Accuracy label | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 54 | `Colors.green` / `Colors.orange` | Accuracy color | `isDark ? Colors.green.shade200 : Colors.green` / `isDark ? Colors.orange.shade200 : Colors.orange` |
| 62 | `Colors.green` | Correct count | `isDark ? Colors.green.shade200 : Colors.green` |
| 85 | `Colors.indigo` | Continue button | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 91 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |
| 107 | `Colors.grey[600]` | Stat label | `isDark ? Colors.grey.shade400 : Colors.grey[600]` |

**Context:** Post-quiz session summary with amber/indigo/green color scheme. Hardcoded colors may work in dark mode if they're on a dark background, but the white button text on indigo needs checking.

---

## 11. flashcard_form_screen.dart

**Path:** `lib/features/flashcards/presentation/screens/flashcard_form_screen.dart`  
**Lines:** ~140  
**Hardcoded color spots:** 2

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 122 | `Colors.indigo` | Save button bg | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 125 | `Colors.white` | Save button text | `isDark ? Colors.black87 : Colors.white` |

**Context:** Small form screen. Only the save button has hardcoded colors.

---

## 12. translation_session_detail_screen.dart

**Path:** `lib/features/live_translate/presentation/screens/translation_session_detail_screen.dart`  
**Lines:** ~160  
**Hardcoded color spots:** 4

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 86 | `Colors.white` | User message bubble bg | `isDark ? Colors.grey.shade800 : Colors.white` |
| 86 | `Colors.blue.shade50` | System message bubble bg | `isDark ? Colors.blue.shade900 : Colors.blue.shade50` |
| 96 | `Colors.grey` | User message timestamp | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 96 | `Colors.blueAccent` | System message timestamp | `isDark ? Colors.blueAccent.shade200 : Colors.blueAccent` |
| 131 | `Colors.white` | Input background | `isDark ? Colors.grey.shade900 : Colors.white` |

**Context:** Chat-style translation detail view. White user bubbles and light blue system bubbles. In dark mode the white bubbles would be glaring and the light blue bubbles would be wrong-toned.

---

## 13. translation_history_screen.dart

**Path:** `lib/features/live_translate/presentation/screens/translation_history_screen.dart`  
**Lines:** ~80  
**Hardcoded color spots:** 2

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 52 | `Colors.blueAccent` | Avatar circle bg | `isDark ? Colors.blueAccent.shade200 : Colors.blueAccent` |
| 53 | `Colors.white` | History icon | `isDark ? Colors.black87 : Colors.white` |

**Context:** Small history list with blue circle avatars. Low impact.

---

## 14. tutorial_lesson_screen.dart

**Path:** `lib/features/onboarding/presentation/screens/tutorial_lesson_screen.dart`  
**Lines:** ~320  
**Hardcoded color spots:** 21

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 71 | `Colors.indigo` | Loading spinner | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 73 | `Colors.indigo` | Loading text | same |
| 84 | `Colors.grey` | Close icon | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 121 | `Colors.amber` | Success icon | `isDark ? Colors.amber.shade200 : Colors.amber` |
| 125 | `Colors.amber` | Success heading | same |
| 144 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |
| 161 | `Colors.indigo` | Section heading | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 168 | `Colors.cyan` | Component box (Water) | `isDark ? Colors.cyan.shade200 : Colors.cyan` |
| 173 | `Colors.grey` | Component box (Work) | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 178 | `Colors.indigo` | Component box (River) | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 191 | `Colors.indigo` | Button bg | same |
| 192 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |
| 227 | `Colors.amber` | Scroll icon | `isDark ? Colors.amber.shade200 : Colors.amber` |
| 229 | `Colors.amber` | "THE SCROLL OF ORIGIN" | same |
| 240 | `Colors.indigo` | Button bg | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 241 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |
| 254 | `Colors.indigo` | Title text | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 286 | `Colors.green` | Check circle | `isDark ? Colors.green.shade200 : Colors.green` |
| 292 | `Colors.green` | Success text | same |
| 304 | `Colors.green` | Button bg | same |
| 305 | `Colors.white` | Button text | `isDark ? Colors.black87 : Colors.white` |

**Context:** Gamified tutorial with colored accent elements (indigo, amber, green, cyan). White box backgrounds and white button text — all hardcoded. In dark mode the white boxes would be jarring and the colored accent texts need adaptation.

---

## 15. custom_story_creator_sheet.dart

**Path:** `lib/features/reading/presentation/widgets/custom_story_creator_sheet.dart`  
**Lines:** ~260  
**Hardcoded color spots:** 12

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 94 | `Colors.white` | Sheet background | `isDark ? Colors.grey.shade900 : Colors.white` |
| 109 | `Colors.indigo` | Selected tab label | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 110 | `Colors.grey` | Unselected tab label | `isDark ? Colors.grey.shade500 : Colors.grey` |
| 130 | `Colors.amber[800]` | AI mode icon | `isDark ? Colors.amber.shade200 : Colors.amber[800]` |
| 150 | `Colors.grey[600]` | Info icon | `isDark ? Colors.grey.shade400 : Colors.grey[600]` |
| 169 | `Colors.amber[800]` | Checkmark | `isDark ? Colors.amber.shade200 : Colors.amber[800]` |
| 170 | `Colors.amber[800]` / `Colors.grey` | HSK avatar | same |
| 186 | `Colors.indigo` | Multi-select checkmark | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 235 | `Colors.indigo` | Document icon | same |
| 252 | `Colors.indigo` | Create button bg | same |
| 253 | `Colors.white` | Create button text | `isDark ? Colors.black87 : Colors.white` |

**Context:** Bottom sheet for creating custom stories. White background with indigo/amber accent scheme. In dark mode the white sheet would be a bright rectangle on a dark screen.

---

## 16. pronunciation_report_sheet.dart

**Path:** `lib/features/echo_hall/presentation/widgets/pronunciation_report_sheet.dart`  
**Lines:** ~140  
**Hardcoded color spots:** 12

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 13 | `Colors.white` | Sheet background | `isDark ? Colors.grey.shade900 : Colors.white` |
| 65 | `Colors.orange` | Score label | `isDark ? Colors.orange.shade200 : Colors.orange` |
| 68 | `Colors.orange` | Arrow icon | same |
| 85 | `Colors.orange` | Accuracy dial | same |
| 86 | `Colors.green` | Completeness dial | `isDark ? Colors.green.shade200 : Colors.green` |
| 87 | `Colors.orange` | Fluency dial | `isDark ? Colors.orange.shade200 : Colors.orange` |
| 106 | `Colors.orange` | Auto-awesome icon | same |
| 110 | `Colors.orange` | Encouragement text | same |
| 114 | `Colors.orange` | Divider | same |
| 128 | `Colors.green` / `Colors.red` | Word correctness | `isDark ? Colors.green.shade200 : Colors.green` / `isDark ? Colors.red.shade200 : Colors.red` |
| 133 | `Colors.grey` | Correct label | `isDark ? Colors.grey.shade400 : Colors.grey` |

**Context:** Pronunciation feedback sheet with metric dials (orange, green) and word-by-word correctness indicators. White background with light grey containers — in dark mode the entire report would be a white rectangle, and grey text on white would be fine but on dark it would be invisible. **Near-invisible text in dark mode.**

---

## 17. fullscreen_media_overlay.dart

**Path:** `lib/features/media/presentation/widgets/fullscreen_media_overlay.dart`  
**Lines:** ~420  
**Hardcoded color spots:** 7

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 290 | `Colors.red` | Recording active state | `isDark ? Colors.red.shade300 : Colors.red` |
| 295 | `Colors.redAccent` | Recording active state | `isDark ? Colors.redAccent.shade200 : Colors.redAccent` |
| 313 | `Colors.white` | Text/icon overlay | Keep (this is over video — always needs white) |
| 321 | `Colors.white` | Text overlay | Keep (video overlay) |
| 363 | `Color(0xFF4CAF50)` | Good score color | `isDark ? Color(0xFF81C784) : Color(0xFF4CAF50)` |
| 363 | `Color(0xFFFF5252)` | Bad score color | `isDark ? Color(0xFFEF9A9A) : Color(0xFFFF5252)` |
| 411 | `Colors.white` | Text overlay | Keep (video overlay) |

**Note:** This is a video player overlay where dark scrim backgrounds and white text are intentional. The score feedback colors (green/red) are the main concern for dark mode adaptation. **Low priority.**

---

## 18. premium_subtitles_overlay.dart

**Path:** `lib/features/media/presentation/widgets/premium_subtitles_overlay.dart`  
**Lines:** ~100  
**Hardcoded color spots:** 2

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 67 | `Colors.white` / `Colors.white60` | Subtitle text | Keep (video overlay — always needs contrast) |
| 70 | `Colors.blueAccent` | Subtitle shadow | `isDark ? Colors.blueAccent.shade200 : Colors.blueAccent` |

**Note:** Video subtitle overlay — black bg with white text is intentional for readability over video. **Low priority.**

---

## 19. paywall_screen.dart

**Path:** `lib/features/monetization/presentation/screens/paywall_screen.dart`  
**Lines:** ~100  
**Hardcoded color spots:** 8

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 55 | `Color(0xFF1A1A1B)` | Scaffold background | Keep (intentionally dark — carbon ink aesthetic) |
| 60 | `Colors.white` | Close icon | Keep |
| 61 | `Colors.white` | Close icon | Keep |
| 64 | `Colors.white` | Loading spinner | Keep |
| 70 | `Color(0xFFFDFCF0)` | Premium icon | Keep |
| 75 | `Color(0xFFFDFCF0)` | Heading text | Keep |
| 90 | `Color(0xFFFDFCF0)` | CTA button bg | Keep |
| 91 | `Color(0xFF1A1A1B)` | CTA button text | Keep |

**Note:** This screen intentionally uses a dark "carbon ink" background (`Color(0xFF1A1A1B)`) with light paper text (`Color(0xFFFDFCF0)`) for a premium feel. It is effectively "always dark mode" and looks correct regardless of system theme. **Low priority / no change needed.**

---

# TIER 2 — Partial Dark Mode Handling

---

## 20. reading_room_screen.dart

**Path:** `lib/features/reading/presentation/screens/reading_room_screen.dart`  
**Lines:** ~400  
**Dark mode handling:** Partial — `colorScheme.surface` for scaffold bg (line 93)  
**Hardcoded color spots:** 18

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 110 | `Colors.indigo` | Search icon | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 112 | `Colors.white` | Search field fill | `isDark ? Colors.grey.shade800 : Colors.white` |
| 156 | `Colors.indigo` | Chip selected | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 157 | `Colors.white` / `Colors.black87` | Chip text toggle | `isDark ? Colors.black87 : Colors.white` / `isDark ? Colors.white70 : Colors.black87` |
| 158 | `Colors.white` | Chip background | `isDark ? Colors.grey.shade800 : Colors.white` |
| 196 | `Color(0xFF3F51B5)` / `Color(0xFF5C6BC0)` | Gradient start/end | `isDark ? Color(0xFF7986CB) : Color(0xFF3F51B5)` / `isDark ? Color(0xFF9FA8DA) : Color(0xFF5C6BC0)` |
| 203 | `Colors.indigo` | Gradient outline | `isDark ? Colors.indigo.shade200.withValues(alpha: 0.3) : Colors.indigo.withValues(alpha: 0.3)` |
| 214 | `Colors.white` | Gradient text | Keep (already on dark gradient) |
| 217 | `Colors.white` | Gradient icon | Keep |
| 227 | `Colors.white` | Gradient heading | Keep |
| 260 | `Colors.indigo` | Section heading | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 291 | `Colors.white` | Card background | `isDark ? Colors.grey.shade900 : Colors.white` |
| 294 | `Colors.black` | Card shadow | `isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05)` |
| 329 | `Colors.indigo.shade300` / `Colors.deepPurple.shade400` | Gradient | `isDark ? Colors.indigo.shade100 : Colors.indigo.shade300` / `isDark ? Colors.deepPurple.shade200 : Colors.deepPurple.shade400` |
| 339 | `Colors.white` | Gradient text | Keep |
| 347 | `Colors.grey[100]` | Section background | `isDark ? Colors.grey.shade800 : Colors.grey[100]` |
| 350 | `Colors.indigo` | See all link | `isDark ? Colors.indigo.shade200 : Colors.indigo` |
| 374 | `Colors.black` | Card subtitle | `isDark ? Colors.white70 : Colors.black.withValues(alpha: 0.6)` |
| 387 | `Colors.indigo` | Card accent | `isDark ? Colors.indigo.shade200.withValues(alpha: 0.08) : Colors.indigo.withValues(alpha: 0.08)` |
| 392 | `Colors.indigo` | Card HSK text | `isDark ? Colors.indigo.shade200 : Colors.indigo` |

**Context:** Scaffold background uses `colorScheme.surface` (adapts correctly). However ALL inner elements — chips, search bar, cards, gradients, text — are hardcoded for light mode. White cards on dark surface = visible but wrong-tinted.

---

## 21. course_screen.dart

**Path:** `lib/features/course/presentation/screens/course_screen.dart`  
**Lines:** ~170  
**Dark mode handling:** Partial — `isDark` used only for the AtlasPainter background (line 45)  
**Hardcoded color spots:** 6

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 31 | `Colors.brown` | AppBar title | `isDark ? Colors.brown.shade200 : Colors.brown` |
| 123 | `Colors.brown` | Loading spinner | same |
| 124 | `Colors.red` | Error text | `isDark ? Colors.red.shade200 : Colors.red` |
| 138 | `Colors.white` | Loading spinner | `isDark ? Colors.black87 : Colors.white` |
| 140 | `Colors.white` | Loading text | `isDark ? Colors.black87 : Colors.white` |
| 161 | `Colors.indigo` | FAB background | `isDark ? Colors.indigo.shade200 : Colors.indigo` |

**Context:** Only the AtlasPainter background has dark mode handling. All UI chrome (app bar, loading overlay, FAB, error text) is hardcoded. The loading overlay uses white text on what might be a dark scrim.

---

## 22. media_hub_screen.dart

**Path:** `lib/features/media/presentation/screens/media_hub_screen.dart`  
**Lines:** ~520  
**Dark mode handling:** Good — `isDark` + `colorScheme` used in many places  
**Hardcoded color spots:** 10+

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 54–130 | `Color(0xFFFF0000)`, `Color(0xFF1E88E5)`, `Color(0xFFBB1919)`, `Color(0xFF555555)`, `Color(0xFFE65100)`, `Color(0xFF2932E1)` | Brand colors (media source logos) | Keep (brand colors are intentional) |
| 160 | `Colors.grey` | Empty state text | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 191 | `Colors.redAccent` | Delete icon | `isDark ? Colors.redAccent.shade200 : Colors.redAccent` |
| 334 | `Colors.black` | Card border | `isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05)` |
| 337 | `Colors.black` | Card bg accent | `isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.02)` |
| 433 | `Colors.black` | Overlay tint | `isDark ? Colors.white.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.2)` |
| 461 | `Colors.black` | Thumbnail overlay | Keep (image overlay) |
| 477 | `Colors.greenAccent` / `Colors.white` | Progress badge | `isDark ? Colors.greenAccent.shade200 : Colors.greenAccent` / `isDark ? Colors.grey.shade900 : Colors.white` |
| 488 | `Colors.white` | Card image bg | `isDark ? Colors.grey.shade900 : Colors.white` |
| 501 | `Colors.white` | Media card text | `isDark ? Colors.black87 : Colors.white` |
| 509 | `Colors.white` | Media card meta | `isDark ? Colors.black87 : Colors.white` |

**Context:** This file has the best dark mode adaptation of all Tier 2 files — it correctly uses `isDark` with `colorScheme.surface/primary/onSurface` for many elements. However approximately 10+ older hardcoded spots remain, mostly card backgrounds, text overlays, and progress indicators. Likely a partially-migrated file with regressions.

---

## 23. cultural_context_screen.dart

**Path:** `lib/features/media/presentation/screens/cultural_context_screen.dart`  
**Lines:** ~200  
**Dark mode handling:** Good — `isDark` + `colorScheme` used extensively  
**Hardcoded color spots:** 5

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 44 | `Colors.black12` | Decorative element | `isDark ? Colors.white12 : Colors.black12` |
| 45 | `Colors.black12` | Decorative element | same |
| 113 | `Colors.amber` | Insight icon | `isDark ? Colors.amber.shade200 : Colors.amber` |
| 127 | `Color(0xFFF9F7F1)` | Section header bg | Already has isDark ternary: `isDark ? Colors.white.withValues(alpha: 0.03) : const Color(0xFFF9F7F1)` — correct |
| 130 | `Colors.black` | Card border | Already has isDark ternary: `isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05)` — correct |

**Context:** Mostly well-adapted. The 5 spotted lines are already partially handled (lines 127 and 130 already have isDark ternaries). The remaining issues are minor: `Colors.amber` and `Colors.black12` used without isDark guard.

---

## 24. story_library_screen.dart

**Path:** `lib/features/media/presentation/screens/story_library_screen.dart`  
**Lines:** ~620  
**Dark mode handling:** Partial — `colorScheme.surfaceContainerHighest` / `colorScheme.surface` used in places  
**Hardcoded color spots:** 30+

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 133 | `Color(0xFFFDFCF0)` | Scaffold background | `isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)` |
| 138 | `Color(0xFF1A1A1B)` | AppBar foreground | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 145 | `Color(0xFF8B0000)` | Loading spinner | `isDark ? const Color(0xFFCF6679) : const Color(0xFF8B0000)` |
| 162 | `Color(0xFF8B0000)` | FAB background | Same |
| 163 | `Colors.white` | FAB icon | `isDark ? Colors.black87 : Colors.white` |
| 164 | `Colors.white` | FAB label | `isDark ? Colors.black87 : Colors.white` |
| 174 | `Colors.white` | Search field fill | `isDark ? Colors.grey.shade800 : Colors.white` |
| 178 | `Colors.black` | Search shadow | `isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05)` |
| 188 | `Colors.grey` | Search icon | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 194 | `Colors.grey` | Clear icon | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 221 | `Color(0xFF1A1A1B)` | Category chip selected | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 223 | `Colors.white` / `Color(0xFF1A1A1B)` | Chip text toggle | `isDark ? Colors.black87 : Colors.white` / inverse |
| 241 | `Color(0xFF1A1A1B)` | HSK chip selected | same as 221 |
| 243 | `Colors.white` / `Color(0xFF1A1A1B)` | HSK chip text toggle | same as 223 |
| 275 | `Color(0xFF1A1A1B)` | "Story of the Day" heading | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 283 | `Colors.grey` | Empty state text | `isDark ? Colors.grey.shade400 : Colors.grey` |
| 356 | `Colors.black` | Divider | `isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.1)` |
| 372 | `Colors.black` | Image overlay | Keep (image overlay — needs dark) |
| 379 | `Colors.black` | Image overlay | Keep |
| 393 | `Colors.white` | Day card bg | `isDark ? Colors.grey.shade900 : Colors.white` |
| 399 | `Color(0xFF1A1A1B)` | Day card text | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 413 | `Colors.white` | Story card bg | `isDark ? Colors.grey.shade900 : Colors.white` |
| 426 | `Colors.white` | Card text | `isDark ? Colors.black87 : Colors.white` |
| 448–449 | `Color(0xFF2C3E50)`, `Color(0xFF1A1A1B)` | Day card gradient | `isDark ? Color(0xFF455A64) : Color(0xFF2C3E50)` / `isDark ? Color(0xFF37474F) : Color(0xFF1A1A1B)` |
| 470–473 | `Color(0xFF8B0000)`, `Color(0xFF2C3E50)`, `Color(0xFF2E8B57)`, `Color(0xFFD35400)` | Category accent colors | These are brand accent colors — keep or adapt as `isDark ? lighter : original` |
| 496 | `Colors.black` | Card border | `isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05)` |
| 538 | `Colors.black` | Button overlay | `isDark ? Colors.white.withValues(alpha: 0.6) : Colors.black.withValues(alpha: 0.6)` |
| 550 | `Colors.white` | Card bg (alt) | `isDark ? Colors.grey.shade900 : Colors.white` |
| 580 | `Color(0xFF1A1A1B)` | Card title | `isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B)` |
| 591 | `Color(0xFF1A1A1B)` | Card subtitle | `isDark ? const Color(0xFFFDFCF0).withValues(alpha: 0.6) : const Color(0xFF1A1A1B).withValues(alpha: 0.6)` |

**Context:** The main library screen with story cards, search, and category filtering. Background and some surfaces use `colorScheme` correctly, but most text, badges, chips, cards, and buttons use hardcoded colors. The deep-red (`0xFF8B0000`) FAB with white text is a particular concern for dark mode.

---

## 25. story_cultural_insight_screen.dart

**Path:** `lib/features/media/presentation/screens/story_cultural_insight_screen.dart`  
**Lines:** ~251  
**Dark mode handling:** Good — uses `colorScheme.surface/primary/onPrimary/onSurface`  
**Hardcoded color spots:** 3

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 85 | `Colors.white` | AppBar text shadow | `isDark ? Colors.black45 : Colors.white` (swap on dark) |
| 105 | `Colors.black` | Scrim gradient end | `isDark ? Colors.black.withValues(alpha: 0.8) : Colors.black.withValues(alpha: 0.8)` — already fine, but could use `isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)` for a lighter scrim |
| 188 | `Colors.red` | Error icon | `isDark ? Colors.red.shade200 : Colors.red` |

**Context:** Mostly well-adapted with colorScheme throughout. The white text (line 85) is on an image overlay where white text is correct. Red error icon is standard. **Low severity.**

---

# TIER 3 — Minor Issues

---

## 26. global_blurred_bottom_sheet.dart

**Path:** `lib/shared/widgets/global_blurred_bottom_sheet.dart`  
**Lines:** ~50  
**Dark mode handling:** N/A (wrapper)  
**Hardcoded color spots:** 1

| Line(s) | Hardcoded Color | Element | Dark Mode Fix |
|---------|----------------|---------|---------------|
| 15 | `Colors.black.withValues(alpha: 0.6)` | Modal barrier | Standard for modal backdrop — acceptable in both modes |

**Context:** This is a shared bottom sheet wrapper. The black barrier is standard UX pattern. **No change needed.**

---

## 27. paywall_sheet.dart

**Path:** `lib/features/premium/presentation/screens/paywall_sheet.dart`  
**Lines:** ~60  
**Dark mode handling:** N/A (RevenueCat native UI)  
**Hardcoded color spots:** 0

**Context:** Uses RevenueCat's native paywall UI which handles its own theming. **Clean — no change needed.**

---

## 28. interactive_image_overlay.dart

**Path:** `lib/features/premium/presentation/widgets/interactive_image_overlay.dart`  
**Lines:** ~60  
**Dark mode handling:** Yes — uses `colorScheme.primary`  
**Hardcoded color spots:** 0

**Context:** Uses `colorScheme.primary` at lines 43 and 45. **Clean — no change needed.**

---

## 29. custom_scenario_dialog.dart

**Path:** `lib/features/echo_hall/presentation/widgets/custom_scenario_dialog.dart`  
**Lines:** ~250  
**Dark mode handling:** Yes — uses `colorScheme.primary/onPrimary`  
**Hardcoded color spots:** 0

**Context:** Uses `colorScheme.primary` and `colorScheme.onPrimary` throughout. **Clean — no change needed.**

---

## Files Already Correct — No Audit Needed

These files were verified to have proper `isDark` or `colorScheme` handling throughout:

| File | Pattern Used |
|------|-------------|
| `auth_screen.dart` | Full `isDark` coverage |
| `contact_screen.dart` | Full `isDark` coverage |
| `travel_interpreter_screen.dart` | Full `isDark` coverage |
| `story_reader_screen.dart` | Full `isDark` coverage |
| `ai_hub_screen.dart` | Full `isDark` + `colorScheme` |
| `universal_scanner_screen.dart` | `colorScheme` throughout |
| `live_call_summary_screen.dart` | `colorScheme` throughout |
| `notification_permission_screen.dart` | Full `isDark` coverage |
| `quick_look_sheet.dart` | Full `isDark` (nested prop) |
| `calligraphy_canvas_sheet.dart` | Full `isDark` coverage |
| `mission_briefing_sheet.dart` | Full `isDark` coverage |
| `radical_detail_sheet.dart` | Full `isDark` coverage |
| `ai_deck_generator_sheet.dart` | Full `isDark` coverage |
| `ai_explainer_sheet.dart` | Full `isDark` coverage |
| `character_chat_sheet.dart` | Full `isDark` coverage |
| `deck_settings_sheet.dart` | Full `isDark` coverage |
| `deck_selection_sheet.dart` | Full `isDark` coverage |
| `study_mode_selection_sheet.dart` | Full `isDark` coverage |
| `word_detail_dialog.dart` | Full `isDark` coverage |
| `flashcard_edit_dialog.dart` | Full `isDark` coverage |
| `tome_manager_screen.dart` | Full `isDark` coverage |
| `course_selection_screen.dart` | Full `isDark` coverage |
| `scenario_selection_screen.dart` | Full `isDark` coverage |
| `translation_hub_screen.dart` | Full `isDark` coverage |
| `shadowing_studio_screen.dart` | Full `isDark` coverage |
| `stats_screen.dart` | Has handling |
| `settings_screen.dart` | Has handling |
| `review_screen.dart` | Has handling |
| `radical_library_screen.dart` | Has handling |
| `profile_screen.dart` | Has handling |
| `main_navigation_screen.dart` | Has handling |
| `deck_detail_screen.dart` | Has handling |
| `deck_card_picker_screen.dart` | Has handling |
| `character_detail_screen.dart` | Has handling |
| `dictionary_screen.dart` | Has handling |
| `story_mode_screen.dart` | Has handling |
| `live_call_screen.dart` | Has handling |
| `conversation_screen.dart` | Has handling |
| `dashboard_screen.dart` | Has handling |

---

## Summary Statistics

| Metric | Count |
|--------|:-----:|
| Total UI files audited | 70 |
| Files with issues | 30 |
| — Tier 1 (zero handling) | 19 |
| — Tier 2 (partial handling) | 6 |
| — Tier 3 (minor issues) | 5 |
| Files already correct | 40 |
| Total hardcoded color spots | ~300+ |
| Most impacted file | `onboarding_screen.dart` (41 spots) |
| Largest file | `web_browser_screen.dart` (1383 lines, 26 spots) |

### Priority Fix Order

1. **web_browser_screen.dart** — largest file, most used feature (story/media reader)
2. **smart_media_desk_screen.dart** — core media interaction screen
3. **onboarding_screen.dart** — first impression of the app
4. **story_summary_screen.dart** — pre-reading screen with invisible deep-red buttons
5. **story_library_screen.dart** (Tier 2) — main story browsing, 30+ spots
6. **reading_room_screen.dart** (Tier 2) — reading room, 18 spots
7. **media_search_screen.dart** — search results all white
8. **media_hub_screen.dart** (Tier 2) — partially migrated, regressions
9. **pronunciation_report_sheet.dart** — near-invisible text
10. **translation_session_detail_screen.dart** — white chat bubbles
