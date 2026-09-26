# 🪧 Hanzi Master — iPad / Adaptive Layout Plan

**Status:** 🚧 IN PROGRESS — **Phase 0 ✅ and Phase 1 ✅ landed** (2026-09-26); Phases 2–5 are the remaining worklist, enforced by the new ratchets
**Scope:** all 61 screens under `lib/features/*/presentation/screens/` + the 61 presentation widgets (sheets, dialogs, canvases) + the iOS project configuration
**Method:** every number below was measured on 2026-09-26 with the commands in the Appendix. Nothing here is estimated.

### What is already implemented (this pass)

| Area | State | Where |
|---|---|---|
| B1 — Split View / Stage Manager | ✅ `UIRequiresFullScreen` → `false` | `ios/Runner/Info.plist` |
| B2 — orientation policy | ✅ phones portrait, tablets all orientations | `lib/core/layout/zen_device.dart`, `lib/main.dart:52` |
| B3 — in-feature portrait locks | ✅ gated on the device class **and** released in `dispose` | `universal_scanner_screen.dart`, `smart_media_desk_screen.dart` |
| F3 — window classes + content caps | ✅ `ZenWindow`, `ZenContentPane`, `ZenGrid`, `zenValue`, `ZenBreakpoints` | `lib/core/layout/zen_layout.dart` |
| F4 — adaptive shell + two-pane | ✅ `ZenNavigationRail` (rail at ≥600dp, extended at ≥840) + `ZenTwoPaneScaffold`; the shell already uses the rail | `lib/core/layout/zen_adaptive_scaffold.dart`, `zen_two_pane.dart`, `main_navigation_screen.dart` |
| F5 — one overlay entry point | ✅ `zenSheet` / `zenDialog` / `zenPicker` / `ZenOverlayFrame` — **and 39 of 46 call sites converted** (the rest are allow-listed); the sheet→dialog switch happens at *expanded* (≥840dp), because 600-839dp is a large phone or a Split View half | `lib/shared/widgets/zen_overlay.dart` + `scratch/ipad_adoption.py` |
| F7 — density-driven grids | ✅ `ZenGrid.tiles/covers/media`, **all 10 fixed-column grids converted** keeping their proportions | `scratch/ipad_grids.py` |
| F3 — raw size reads | ✅ `MediaQuery.of(context).size` → `MediaQuery.sizeOf(context)`, **29 → 0** | `scratch/ipad_adoption.py` |
| F9.1 — iPad + landscape viewports | ✅ `kIpadViewports`, `kLandscapePhoneViewports`, `kAllViewports` — **plus a harness bug fix, see below** | `test/support/locale_layout_harness.dart` |
| F9.2 — ratchets | ✅ 4 ratchets + 4 coverage tests | `test/core/adaptive_layout_guard_test.dart` |
| F9.3 — primitive contract tests | ✅ 14 behavioural tests (phone vs tablet for each primitive) | `test/core/adaptive_layout_test.dart` |
| F6/F7/F8/F10 + per-screen Phases 2–5 | ⏳ open — the ratchets keep it honest | this document, Part 2 |

### 🐛 The harness bug this uncovered (worth knowing before Phase 3)

`tester.binding.setSurfaceSize(size)` **no longer reaches `MediaQuery`** on Flutter 3.38.7 — a probe
that sets `390x844` still reports `Size(800, 600)`. So every viewport in the locale matrix has been
ignored: the sweep has been rendering at the 800×600 default all along, whatever `kTightViewports`
said. The harness now sets the view directly:

```dart
tester.view.devicePixelRatio = 1.0;
tester.view.physicalSize = size;
addTearDown(tester.view.resetPhysicalSize);
addTearDown(tester.view.resetDevicePixelRatio);
```

Consequences to expect: the suite is now genuinely tight (320dp and 2× text scale are real), and any
history of "the sweep is green" before this fix only proved 800×600. Re-run it before trusting a
layout change.

---

## 🚨 Part 0 — Three things block iPad *entirely* (do these first, ~1 hour)

These are not layout work. They are configuration, and without them the rest of the plan is invisible to the user.

| # | Finding | Effect today | Fix |
|---|---|---|---|
| **B1** | `ios/Runner/Info.plist` sets **`UIRequiresFullScreen = true`** | The app **cannot** use Split View, Slide Over or Stage Manager. Two apps side-by-side — the most-used iPad study pattern ("reader + notes") — is impossible. | Delete the key (or set `<false/>`). Keep every orientation entry. Apps built against the iPadOS 26 SDK are expected to be resizable; this key is an explicit opt-out. |
| **B2** | `lib/main.dart:52-56` locks **portrait only, globally** (`portraitUp` + `portraitDown`) | On a 12.9" iPad the app is a phone-shaped column in a 1366pt window. The plist declares all four iPad orientations (`UISupportedInterfaceOrientations~ipad` exists) but `main()` overrules it. | Move the lock out of `main()`. Policy: phones → portrait; tablets (`shortestSide >= 600`) → all four. Decide per route for camera/canvas screens, and **unlock on pop** (F2). |
| **B3** | Two more hard portrait locks inside features: `universal_scanner_screen.dart:129` (`.lockCaptureOrientation(portraitUp)`) and `smart_media_desk_screen.dart:266,755` | Landscape iPad users get the device yanked upright in the scanner and the media desk. | Gate both on window class; on tablet give the camera a **side panel** instead of a rotation lock (screens #32 and #60). |

**Verification for Part 0:** app launches in Split View at ⅓, ½ and ⅔ width; the reader rotates to landscape; the scanner no longer force-rotates an iPad.

Already correct, verify once (iPad App Store hygiene): `TARGETED_DEVICE_FAMILY = "1,2"` ✔ and `UIApplicationSupportsIndirectInputEvents` ✔ (pointer/trackpad **hover events are already delivered** — the app just never uses them: **0** `MouseRegion` in the codebase). The App Store requires **iPad screenshots** for a universal app — check `ios/fastlane/screenshots` has an iPad set.

---

## 🧱 Part 1 — Foundations (build once, then every screen gets cheaper)

There is **no adaptive layer at all** today:

| Infrastructure | State measured 2026-09-26 |
|---|---|
| Breakpoint system | **Does not exist** (`kBreakpoint`/`Breakpoints.` → 0 hits). Only four one-off local flags: `shadowing_studio_screen.isCompact`, `calligraphic_pitch_contour.isCompact`, `show_catalog_screen._ShowCard.isWide`, `onboarding_screen:243 isCompact = constraints.maxHeight < 600` |
| `LayoutBuilder` | 10 files (of 61 screens) |
| `MediaQuery.of(context).size` | 29 matches across 20 files — read inline, rebuilds on every metric change |
| Content width caps | `maxWidth:` in ~8 screens only → cards stretch to 1366pt on iPad |
| Shell | `main_navigation_screen.dart` = `Stack` of 4 kept-alive tabs + `BottomNavigationBar` + `NowPlayingBar`. **0** `NavigationRail`, no two-pane anywhere |
| Modals | **42** `showModalBottomSheet` across **25** files (a full-width sheet on iPad looks broken) |
| Grids | 10 hardcoded `crossAxisCount: 2/3/4` + `childAspectRatio` (F7) |
| Pointer / keyboard / Pencil | `MouseRegion`/`onHover` = **0**, `Shortcuts`/`LogicalKeyboardKey` = **0**, stylus = **0**, drag & drop = 3 matches in 2 files |
| Big-screen test coverage | `test/support/locale_layout_harness.dart` viewports are **390×844 and 320×568, both portrait** → iPad and landscape layouts have **never been executed by a test**, including all the localization guards |

### F1 — Project config
See Part 0.

### F2 — Orientation policy per device class
New `lib/core/layout/zen_device.dart`:
- `ZenDevice.tablet` = `View.of(context).physicalSize.shortestSide / devicePixelRatio >= 600` (Material-3 threshold; iPad mini portrait is 744dp so it qualifies).
- `main.dart` asks this helper instead of hardcoding portrait.
- Per route: `ZenOrientationLock.portraitOnly()` for camera/canvas, with an automatic unlock in the route's `dispose` — `universal_scanner_screen.dart:129` locks today and never restores.

### F3 — Breakpoint core + content pane (the keystone)
New `lib/core/layout/zen_layout.dart`, using Material-3 window classes:

| Class | Width (dp) | Typical device |
|---|---|---|
| compact | `< 600` | phones, iPhone landscape |
| medium | `600–839` | iPad mini/Air portrait, **Split View ½** |
| expanded | `840–1199` | iPad Air/Pro portrait, iPad landscape |
| large | `1200–1599` | iPad Pro 12.9" portrait, Stage Manager |
| extraLarge | `>= 1600` | iPad Pro landscape, external display |

API: `ZenWindow.of(context)` plus `context.isTablet`, `context.isLandscape`, `context.windowClass`, and `ZenContentPane({maxWidth, child})` = `Center` + `ConstrainedBox`. Recommended caps — **per surface, never one cap for the app**:

- **Reading text**: 680dp (≈60–75 characters per line; wider is measurably harder to read). Two-page mode: 2 × 620dp.
- **Forms / auth / settings panes**: 560dp.
- **Study surfaces (flashcard, quiz)**: 720dp.
- **Dashboards, tables, grids, canvases**: unbounded, but gutters step 16 → 24 → 32dp at medium/expanded.

While touching each screen, swap `MediaQuery.of(context).size` for `MediaQuery.sizeOf(context)` (same value, no rebuild on unrelated metric changes) — ratchet the 29 sites to 0 in F9.

### F4 — Adaptive shell + a two-pane primitive
`lib/core/layout/zen_adaptive_scaffold.dart`:
- The 4 destinations render as `BottomNavigationBar` at compact, **`NavigationRail`** at medium, **extended rail** at expanded+.
- `NowPlayingBar` moves out of the bottom bar (a phone artifact on a 12.9" screen) to the rail footer at expanded widths, or a slim top bar.
- Keep the existing `_KeepAliveTab` cross-fade and the `logScreenView` analytics call on navigate.

`lib/core/layout/zen_two_pane.dart` — `ZenTwoPaneScaffold(list:, detail:, emptyState:)`: compact keeps today's push/pop navigation **unchanged**, medium+ puts the list in a 320–360dp pane with the detail beside it. Six screens adopt it in Phase 2; each removes a push/pop round trip on iPad.

### F5 — One modal entry point
`lib/shared/widgets/zen_overlay.dart` (✅ implemented): `zenSheet()`, `zenDialog()`, `zenPicker()` choosing by window class:
- compact → `showModalBottomSheet` (phones do not regress),
- medium+ → a centred Material dialog via `ZenOverlayFrame`, width-capped at 640dp (420dp for [zenPicker]) and never taller than 85 % of the window,
- **pickers** (tone, app language, deck, voice, study mode) → `MenuAnchor`/`PopupMenuButton` popovers anchored to their control — the iPad-correct idiom,
- canvases (calligraphy, drawing) stay full-bleed but gain a Pencil toolbar.

Adoption is mechanical and ratchetable: **42 → 0** direct `showModalBottomSheet` calls. Until a call site is converted, it still behaves as it does today (the ratchet only blocks *new* ones).

### F6 — Pointer, keyboard, Pencil, drag & drop (the "why bother with iPad" features)
None of these exist today. They are what makes an iPad build feel intentional instead of stretched.

- **Hover** — `MouseRegion`/`InkWell(onHover:)` in shared list items, cards and library tiles (`staggered_list_item`, `zen_filter_pill`, cover cards, book spines). Trackpad and Stage Manager make hover a first-class affordance. Bonus: `Cursor` (`SystemMouseCursors.click`) on tappable hanzi.
- **External keyboard** — one `Shortcuts`/`Actions` layer at the app root, per-surface maps:
  - Study/review: `Space` = flip, `1`–`4` = grade, `⌘Z` = undo.
  - Reader: `←`/`→` = page, `⌘+`/`⌘-` = type size, `⌘F` = in-book search.
  - Shell: `⌘1`–`⌘4` = tabs, `Esc` = close overlay/clear selection, `⌘Enter` = primary action.
- **Apple Pencil** — `Listener` + `PointerDeviceKind.stylus` in `drawing_canvas.dart` and `calligraphy_canvas_sheet.dart`: pressure → stroke width (`path_drawing` and `vector_math` are already dependencies), Pencil **hover** → ghost stroke preview, **palm rejection** (ignore touch while the stylus is down), double-tap → eraser, a real undo/redo stack. The marquee iPad feature for a calligraphy app.
- **Drag & drop** — card → deck, dictionary word → custom deck, image/PDF → scanner, transcript line → shadowing drill, and (once B1 is fixed) **text dragged in from Safari/Notes** into the dictionary. 3 matches in the codebase today.

### F7 — Density and grids on wide screens
Replace every fixed-column grid with density-driven delegates:
```dart
// today: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.8)
// iPad:  const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, mainAxisExtent: 260)
```
10 sites: `dictionary_screen.dart:928` (3), `radical_detail_screen.dart:299` (4), `radical_library_screen.dart:156` (3), `radical_detail_sheet.dart:207` (2), `story_library_screen.dart:451` (2), `book_catalog_screen.dart:490/576/659` (2/2/2), `quiz_step.dart:126` (2), `shadowing_studio_screen.dart:1358` (2). `maxCrossAxisExtent` fixes the column count at every width, and `mainAxisExtent` replaces `childAspectRatio` — which also removes the vertical-clipping risk the locale guards flagged. Charts (`stats_screen`, 11 `fl_chart` sites) should spend the width on a 2-column chart grid rather than taller single charts.

### F8 — iPad-native ideas worth building (product, not layout)
- **Two-page book spread** in `book_reader_screen` — the #1 iPad reading win: per-page measure, facing pages, Pencil margin notes. (`book_reader_screen` is 2417 lines with 3 scroll views and only 1 `maxWidth:` today.)
- **Split study bench** — flashcard/review on the left, character detail (strokes, words, etymology, AI explainer) on the right, Pencil practice in the detail pane.
- **Split View study** (enabled by B1) — review cards on half the screen while reading in Safari/Notes; drag a word back in.
- **Hover quick-look** — `quick_look_sheet.dart` already exists; on pointer hover over a hanzi/cover, present it as a **popover** instead of tap-to-open.
- **Picture-in-Picture** for the media desk / audiobook (background audio already works via `audio_service`; PiP video is the addition), plus an **AirPlay route picker**.
- **Kiosk/conversation mode** for `travel_interpreter_screen` — the iPad held between two people, each half rotated toward one of them. A genuinely new product surface, and the app already ships an iPad split-screen concept in `docs/marketing_mini_apps.md:18`.
- **Stage Manager** — because F3 makes layout breakpoint-driven, the same screens work from 320 to 1600+dp. That is why F3 exists instead of per-screen hacks.

### F9 — Tests and guards (match the repo's ratchet culture)
1. `test/support/locale_layout_harness.dart`: add `kIpadViewports` — `1024×1366`, `1366×1024`, `834×1194`, `1194×834`, `744×1133`, `820×1180`, plus landscape phone `844×390` — and include them in `expectNoOverflowAcrossLocales`. Cheapest high-value step in the plan: it immediately reveals what clips in landscape at 2× text scale.
2. New `test/core/adaptive_layout_guard_test.dart`, same ratchet style as `locale_layout_guard_test.dart`:
   - `crossAxisCount`: **10 → 0**
   - raw `MediaQuery.of(context).size`: **29 → 0** (`sizeOf` allowed)
   - direct `showModalBottomSheet`: **42 → 0**
   - `SystemChrome.setPreferredOrientations` only in `main.dart` + the camera route (blocks new portrait locks)
   - screens with an `AppBar` but **no** scroll view (`radical_detail`, `radical_library`, `show_catalog`, `explore`, `ai_hub`, `paywall`) must survive `1366×1024` — the sweep in (1) proves it.
3. Widget tests for the new primitives: `ZenTwoPaneScaffold` collapses to push-navigation below 600dp and shows both panes above it; `zenSheet` returns a dialog above 600dp and a sheet below.

### F10 — iPad platform details that bite
- Safe areas: 56 `SafeArea` uses ✔, but iPad also needs `MediaQuery.viewPadding` for the home indicator and the **floating keyboard** — check `resizeToAvoidBottomInset` on form sheets (the classic iPad overlap bug).
- Sheets: `useSafeArea: true`, `isScrollControlled: true`, and a **max width of 420–640dp** so they don't become full-width strips.
- Dialogs: centred and capped (~560dp) instead of stretched.
- Decode discipline on a 2732×2048 screen: pass `memCacheWidth` to `cached_network_image` so a 12-cover grid doesn't decode 12 full-size bitmaps.
- Readers drive pages with gestures/`PageView` in places; on iPad a `PageView` **fights two-finger trackpad scrolling**. Prefer tap zones + an explicit page control at medium+ (screens #22, #23).
- Android tablets and ChromeOS get all of this free from the same work — keep that in mind when choosing breakpoints.

---

## 📱 Part 2 — Screen-by-screen plan

Legend — **P0** = without it iPad feels like a stretched phone · **P1** = clear iPad win · **P2** = polish.
"Shape" = the structural facts measured from the source (grids/sheets/camera/PageView/scroll), so you can judge the effort before opening the file.

### 2.1 Shell, hubs and dashboards

| # | Screen | Shape today | P | What to do on iPad |
|---|---|---|---|---|
| 1 | `main_navigation_screen` (187) | `Stack` of 4 kept-alive tabs + `BottomNavigationBar` + `NowPlayingBar`; no adaptive flags | **P0** | Adopt `ZenAdaptiveScaffold`: `NavigationRail` (extended) at medium+, `NowPlayingBar` to the rail footer, hover + `⌘1`–`⌘4`. Keep `_KeepAliveTab` cross-fade and the analytics call. |
| 2 | `explore_screen` (160) | no `AppBar`, no scroll view, 2 Rows | **P1** | Hub tiles → 2-col (medium) / 3-col (expanded) grid via `maxCrossAxisExtent`; add a scroll view so tall content can't clip in landscape. |
| 3 | `ai_hub_screen` (147) | no `AppBar`, no scroll, 2 Rows | **P1** | Same as #2; AI tools as tiles with hover + "recent" rail on the right at expanded. |
| 4 | `dashboard_screen` (1007) | 1 scroll, 1 sheet, 12 Rows | **P1** | Two-column dashboard at medium+ (streak/rings left, daily insight + review queue right); keep single column at compact. |
| 5 | `daily_study_dashboard_screen` (224) | 1 scroll | **P1** | Same 2-col treatment; today's plan can gain a right-hand "deck queue" pane. |
| 6 | `notification_permission_screen` (378) | 1 scroll, 1 `LayoutBuilder` | **P2** | `ZenContentPane(maxWidth: 480)` — permission copy should never stretch to 1366pt. |
| 7 | `course_selection_screen` (296) | 1 `AppBar`, no scroll | **P1** | 3-col course cards at expanded; scroll view for landscape. |
| 8 | `profile_screen` (418) | 1 scroll | **P2** | 2-col cards; stats tiles become a 4-across row. |
| 9 | `settings_screen` (684) | 1 scroll, 1 dialog | **P1** | **Settings as master–detail** at medium+ (list pane + detail pane) via `ZenTwoPaneScaffold`; forms capped at 560dp. |
| 10 | `stats_screen` (909) | 11 charts, 1 `LayoutBuilder`, 1 `maxWidth:`, 2 scrolls | **P1** | 2–3 column chart dashboard; give the heatmap the full width; charts get a `mainAxisExtent`. Sets the pattern for all analytics. |
| 11 | `qa_screen` (255) | 1 scroll | **P2** | Capped 720dp content column. |
| 12 | `contact_screen` (230) | 1 scroll | **P2** | Capped column + `⌘Enter` to send. |
| 13 | `ai_data_privacy_screen` (161) | 1 scroll, 1 `LayoutBuilder` | **P2** | Already caps content — port it to `ZenContentPane` so the cap lives in one place. |

### 2.2 Study loop (flashcards, review, sessions)

| # | Screen | Shape today | P | What to do on iPad |
|---|---|---|---|---|
| 14 | `review_screen` (951) | no scroll, 9 Rows, 12 Cols, 1 `LayoutBuilder` | **P0** | Split bench: card left, grading + streak/stats rail right. `Space` = flip, `1`–`4` = grade. Grade buttons get hover + keyboard focus rings. |
| 15 | `deck_review_session_screen` (641) | 1 scroll | **P0** | Same split bench; session progress as a rail widget instead of a cramped top bar. |
| 16 | `deck_detail_screen` (957) | 7 Rows, 2 dialogs, 1 sheet, no scroll | **P1** | Card list left / card preview right (no push). Sheet → popover for deck options. |
| 17 | `deck_card_picker_screen` (211) | 1 `AppBar`, no scroll | **P1** | 3–4 col picker, hover, and **drag cards into the deck** (F6). |
| 18 | `flashcard_form_screen` (133) | 1 scroll | **P1** | Form capped 560dp, front/back fields side by side, `⌘Enter` = save. |
| 19 | `session_summary_screen` (255) | 1 scroll | **P2** | 2-col summary (numbers left, chart right). |
| 20 | `study_mode_selection_sheet` | sheet | **P1** | Popover/menu at medium+ instead of a full-width sheet. |
| 21 | `story_mode_screen` (669) | 1 scroll, 1 sheet | **P1** | Story canvas centred with a wide measure; Pencil annotation layer (F6). |
| 22 | `character_detail_screen` (1633) | `PageView`, 17 `MediaQuery`, 1 grid, 2 sheets, 1 `maxWidth:` | **P0** | The paging carousel is the biggest single restructure: at medium+ show **strokes / words / etymology / practice side by side** instead of horizontally paged pages; Pencil practice pane; hover tooltips on hanzi. ✅ **landed 2026-09-26** — the "carousel" was an anatomy-component `PageView`, not a character pager, and a two-column wide layout already existed; the landed core is the class-based gate (was a raw `> 600`) and the expanded **side-by-side sections** with the pill bar dropped (see the row at the end of this doc). Pencil pane + hover tooltips remain |
| 23 | `deck_settings_sheet`, `ai_deck_generator_sheet`, `ai_explainer_sheet`, `character_chat_sheet`, `word_detail_dialog`, `flashcard_edit_dialog` | sheets/dialogs | **P1** | Route through `zenSheet`/`zenDialog`: form sheets ≤640dp, explainer/chat as a **side panel** at expanded (chat especially — a chat wants height, not a sheet). |

### 2.3 Dictionary, radicals, characters

| # | Screen | Shape today | P | What to do on iPad |
|---|---|---|---|---|
| 24 | `dictionary_screen` (1196) | 3 scrolls, 2 grids (`:928` 3-col), 1 sheet | **P0** | **The flagship master–detail**: search + result list left (340dp), definition pane right; radical grid → `maxCrossAxisExtent`; hover quick-look popover; `⌘F` focus search. |
| 25 | `radical_library_screen` (253) | no scroll, 2 grids (`:156` 3-col) | **P1** | Density-driven grid; hover preview of the radical's strokes. |
| 26 | `radical_detail_screen` (380) | no scroll, 2 grids (`:299` 4-col) | **P1** | 6–8 col grid at expanded; add a scroll view (currently clips in landscape). |
| 27 | `radical_detail_sheet` (widget) | 2-col grid (`:207`) | **P2** | Popover at medium+; grid → `maxCrossAxisExtent`. |
| 28 | `calligraphy_canvas_sheet` (widget) | full-bleed sheet | **P0** | Pencil pressure + palm rejection + hover preview + undo/redo; at expanded, show the reference glyph beside the canvas instead of above it. |

### 2.4 Reading (the biggest iPad payoff)

| # | Screen | Shape today | P | What to do on iPad |
|---|---|---|---|---|
| 29 | `book_reader_screen` (2417) | 1 scroll area + 4 sheets, 16 Rows, only 1 `maxWidth:` | **P0** | **Two-page facing spread** at expanded landscape (2 × 620dp measure, gutter shadow), single 680dp column at portrait; `⌘+`/`⌘-` type size, `⌘F` in-book search; Pencil margin notes; replace any paging gesture with tap zones so trackpad scrolling works. Look up words by hover+click at medium+. |
| 30 | `book_catalog_screen` (1474) | **6 grids** (`:490`, `:576`, `:659` are 2-col), 1 `AppBar`, no scroll | **P0** | Cover shelves via `maxCrossAxisExtent` (+`mainAxisExtent`) so 2→4→6 covers per row; left filter sidebar at expanded; hover card → quick-look popover; **drag a book into a shelf**. |
| 31 | `book_detail_screen` (782) | 2 scrolls, 1 dialog | **P1** | Two-pane: cover + metadata left, chapter list + progress right. |
| 32 | `reading_room_screen` (586) | 2 scrolls, 1 sheet | **P1** | 3-col shelf + a "continue reading" rail; the sheet becomes a pane. |
| 33 | `story_library_screen` (739) | 2-col grid (`:451`), 1 sheet, 3 scrolls | **P1** | Adaptive grid; story preview pane at expanded. |
| 34 | `story_reader_screen` (947) | 2 scrolls, 1 sheet | **P1** | Facing columns on iPad: hanzi left, pinyin/translation right (instead of stacked/toggled); per-column measure cap; type-size control. |
| 35 | `story_summary_screen` (523) | 1 scroll | **P2** | 2-col summary + vocabulary table using real width. |
| 36 | `simplified_article_reader_screen` (309) | 1 `maxWidth:` already | **P1** | Keep the measure cap, add a vocabulary/grammar sidebar at expanded. |
| 37 | `audiobook_player_screen` (1922) | 13 `MediaQuery`, 4 sheets, 1 `maxWidth:`, 1 Stack | **P0** | Landscape: artwork + scrubber left, **chapter list + live transcript right** (the iPad is the transcript device); big transport controls; keyboard transport (`Space`, `←`/`→`); PiP (F8); sheets → popovers. |
| 38 | `story_cultural_insight_screen` (252) | 1 scroll | **P2** | 2-col article + image gallery. |
| 39 | `cultural_context_screen` (660) | 1 scroll, 3 `CustomPaint` | **P1** | TOC sidebar + article pane; paintings larger with hover captions. |
| 40 | `now_playing_bar` (widget) | bottom bar | **P1** | Becomes the rail-footer mini-player at expanded (see #1). |
| 41 | `continue_reading_card`, `reading_progress_strip`, `calligraphic_book_cover`, `poetry_painting_cover` | cards | **P2** | Bigger targets, hover lift, 2-up layout inside the rails. |

### 2.5 Media (video, stories, web)

| # | Screen | Shape today | P | What to do on iPad |
|---|---|---|---|---|
| 42 | `media_hub_screen` (804) | `PageView`, 1 `LayoutBuilder`, 2 scrolls | **P1** | Replace `PageView` with a tab bar / rail at medium+ (a swipe carousel on a 1366pt screen hides content); 3-col media cards. |
| 43 | `media_search_screen` (833) | 1 `AppBar`, no scroll, 9 Rows | **P1** | Two-pane: results left, preview/metadata right; **drag a result into a deck**; hover preview. |
| 44 | `smart_media_desk_screen` (1208) | **7 web embeds**, 2 `CustomPaint`, 1 sheet, **portrait lock at `:266`/`:755`** | **P0** | Remove the portrait lock on tablets; landscape split: video + subtitles left, AI prep/notes/transcript right; PiP for the video; subtitle overlay typography scaled for iPad viewing distance. ✅ **split landed 2026-09-26** — the desk is `split = context.zenWindow.isExpanded` with the video + its transport in the left pane and the AI prep + transcript in the right; the phone column is expressed once (`if (!split)` returns `Column(videoPane, Expanded(contentPane), controlPane)`), the video and content were extracted (`_buildVideoPane()` / `contentPane`) so there is still **exactly one** `YoutubePlayer`, and the subtitle/top/bottom chrome ramps with the window class. ⛔ **PiP is NOT done and is not layout work:** an iframe cannot enter picture-in-picture, so it needs `AVPictureInPictureController` plus a player that supports it (and the AirPlay route picker alongside). |
| 45 | `channel_videos_screen` (685) | 1 `AppBar`, no scroll, 4 Rows | **P1** | 3-col video grid + scroll view; hover play affordance. |
| 46 | `show_catalog_screen` (450) | no `AppBar`, no scroll, has a local `isWide` flag (`:277`) | **P1** | Promote the local flag to `ZenWindow`; 3–4 col poster grid; keep the poster aspect (`mainAxisExtent`). |
| 47 | `show_detail_screen` (457) | 2 scrolls, 2 Stacks | **P2** | Two-pane: episodes left, now-playing/detail right. |
| 48 | `web_browser_screen` (2578) | 1 web view, 4 `CustomPaint`, 4 sheets | **P1** | iPad is a real browser: tabs/back-forward affordances at the top, trackpad two-finger scroll verified, share/drag-out, reader mode with a capped measure, sheets → popovers. ✅ **extracted-words sidebar landed 2026-09-26** (see the Phase 3 status). Still open: tabs, back/forward chrome, drag-a-link-out, sheet→popovers. |
| 49 | `fullscreen_media_overlay` (widget) | overlay | **P1** | 16:9 letterboxed with an AirPlay route picker and PiP button; keep `audio_session` background audio behaviour. |
| 50 | `premium_subtitles_overlay`, `premium_transcript_line`, `premium_video_top_bar/bottom_bar`, `premium_ai_prep_card` | subtitles/transcript | **P1** | Subtitle font size control (iPad viewing distance), transcript as a scrollable rail, `mainAxisExtent` instead of fixed heights. ✅ **subtitles landed 2026-09-26** — `premium_subtitles_overlay` now ramps all three lines with the window class via `zenValue` (hanzi 36/40/44, pinyin 22/24/26, English 16/17/18) instead of pinning 36/22/16 at every viewing distance; a phone is unchanged. Verified **behaviourally** (this widget takes plain data, so `test/features/media/premium_subtitles_typography_test.dart` pumps the real overlay at compact/medium/large and reads the resolved `TextStyle`s back: 3/3, `ipad-sweep`). ✅ **transcript line landed too** — `premium_transcript_line`'s reading text ramps the same way (hanzi 22/24/26); its secondary pinyin/translation lines stay at a fixed 14pt on purpose. Still open: a user-facing size *control*, the transcript rail, and `mainAxisExtent` for the bars/cards |

### 2.6 Speaking (Live Translate + Echo Hall)

| # | Screen | Shape today | P | What to do on iPad |
|---|---|---|---|---|
| 51 | `shadowing_studio_screen` (2589) | 3 scrolls, 1 grid (`:1358` 2-col), 4 sheets, 1 dialog, 1 `CustomPaint`, 15 `MediaQuery`, local `isCompact` | **P0** | Landscape two-pane: waveform + pitch contour left (bigger = more useful), transcript + per-syllable scores right. Replace `isCompact` with `ZenWindow`. Number-key grading. Pencil on the contour. |
| 52 | `travel_interpreter_screen` (1163) | no scroll, 1 sheet, 9 Rows, 9 Cols | **P1** | **Kiosk mode**: two halves facing opposite directions for face-to-face translation (F8); a device/mic picker popover; large type. |
| 53 | `calligraphic_pitch_contour` (widget) | `isCompact` margins | **P1** | Take its size from the pane, not a bool; hover to scrub a tone. |
| 54 | `interactive_grading_text`, `tone_graph_painter` (widgets) | painters | **P2** | Hover scrubbing; larger tap targets on syllables. |
| 55 | `scenario_selection_screen` (1339) | no scroll, 2 sheets, 1 dialog, 1 `CustomPaint`, 14 Rows | **P1** | Two-pane: scenario list left, briefing/preview right; 3-col cards; scroll view for landscape. |
| 56 | `conversation_screen` (934) | 2 scrolls, 3 Stacks, 1 sheet | **P1** | Presenter view: AI avatar / video large, transcript rail on the right, controls in a bottom strip that doesn't cover content. |
| 57 | `live_call_screen` (1766) | 3 Rows, 6 Cols, 2 Stacks, 1 `CustomPaint`, 1 `maxWidth:` | **P1** | Same presenter view + a notes/pronunciation panel; audio route picker (iPad speakers/mic vs AirPods). |
| 58 | `live_call_summary_screen`, `pronunciation_report_sheet` (widgets) | report screens | **P2** | 2-col report with charts using the extra width; sheet → dialog. |

### 2.7 Course, quiz, onboarding

| # | Screen | Shape today | P | What to do on iPad |
|---|---|---|---|---|
| 59 | `course_screen` (218) | 1 `CustomPaint`, no scroll | **P1** | The "Living Scroll" path is a canvas: at expanded, show the path with a **lateral lesson-preview panel**; hover nodes for a preview card; keep the path centred rather than stretched. |
| 60 | `tome_manager_screen` (1700) | 2 scrolls, 1 sheet, 2 dialogs, 1 `CustomPaint`, 9 Rows | **P1** | Two-pane manager (tomes list ↔ detail/editor) + **drag-to-reorder** on iPad; dialogs → form sheets capped 640dp. |
| 61 | `radical_lesson_screen` (548) | `PageView`, no scroll | **P1** | Steps as a left rail + active step filling the pane (a horizontal pager wastes 1366pt); the drawing step gets a Pencil-aware canvas and a bigger practice area. |
| 62 | `lesson_screen` (180) + lesson steps (`context_step`, `discovery_step`, `drawing_step`, `quiz_step`) | step widgets; `quiz_step` has a 2-col grid (`:126`) | **P1** | `quiz_step`: adaptive answer grid + number-key answers; `drawing_step`: Pencil pressure + palm rejection; all steps: two-pane at medium+ (content + feedback). |
| 63 | `tutorial_lesson_screen` (456) | `PageView`, no scroll | **P2** | Same rail + pane treatment as #61. |
| 64 | `quiz_screen` (227) | **2 `AppBar`s**, no scroll, 3 Cols | **P1** | Adaptive answer layout; `1`–`4`/`A`–`D` keyboard answers; `⌘Enter` submit; keep the compact layout untouched. |
| 65 | `onboarding_screen` (1042) | `PageView`, `LayoutBuilder`, `isCompact = maxHeight < 600` (`:243`) | **P1** | Centre a 560dp card (onboarding must not stretch); step the illustrations up in size; replace the height-only `isCompact` with `ZenWindow` so landscape iPad gets the two-column variant. |
| 66 | `onboarding_mini_lesson_screen` (1633) | 1 scroll, 6 Rows, 14 Cols | **P1** | Two-pane lesson (content + practice); capped measure for prose. |
| 67 | `mission_briefing_sheet` (widget) | sheet | **P2** | Form sheet ≤640dp at medium+. |

### 2.8 Auth, monetisation, scanner, and the shared overlays

| # | Screen | Shape today | P | What to do on iPad |
|---|---|---|---|---|
| 68 | `auth_screen` (845) | 1 scroll, 2 Cols | **P0** | Centre a 480dp card (unchanged sign-in logic) + keyboard-safe layout; on iPad show a brand pane beside the form at expanded; Apple/Google buttons keep the platform styling. |
| 69 | `delete_account_screen` (255) | 1 scroll, 1 dialog | **P2** | Capped 560dp form. |
| 70 | `paywall_screen` (126), `custom_paywall_screen` (1365), `paywall_sheet` (44) | full-screen paywalls + a sheet | **P1** | Hero left / plans right at expanded; a real comparison `Table` using the width; `paywall_sheet` → form sheet ≤640dp (never a full-width strip); keep `purchases_ui_flutter` native sheets where they are. |
| 71 | `universal_scanner_screen` (2105) | 3 camera refs, 3 `CustomPaint`, 2 `maxWidth:`, portrait lock `:129` | **P0** | Landscape: **live camera left (4:3), OCR/markup results right**; Pencil annotation + hover for AR boxes; multi-page scan with a thumbnail rail; remove the rotation lock on tablets. |
| 72 | `quick_look_sheet` | drag-positioned sheet | **P1** | Pointer hover → **popover** anchored to the word; tap → sheet only at compact. |
| 73 | `app_language_picker_sheet`, `deck_selection_sheet`, `deck_scenario_picker_sheet`, `audiobook_voice_sheet`, `study_mode_selection_sheet`, `zen_rating_sheet`, `zen_soundscape_sheet`, `tone_comparison_sheet`, `nuance_compare_sheet` | pickers as sheets | **P1** | All are `zenPicker()` candidates → anchored menus/popovers at medium+. |
| 74 | `ai_consent_sheet`, `custom_story_creator_sheet`, `custom_scenario_dialog`, `flashcard_edit_dialog`, `word_detail_dialog` | forms as sheets/dialogs | **P1** | `zenDialog()`: centred, ≤640dp, `⌘Enter` = confirm, `Esc` = cancel. |
| 75 | `global_blurred_bottom_sheet`, `staggered_list_item`, `zen_filter_pill`, `zen_search_bar`, `hanzi_text_field`, `translated_text`, `tappable_hanzi_text` | shared primitives | **P0** | These carry the whole adaptation: sheet→dialog behaviour, hover/pointer states, focus rings, and search fields that respond to `⌘F`. Fixing them fixes dozens of screens at once. |

---

## ✨ Part 2b — iPad-*special* treatments (beyond layout)

Everything above is about *fitting* the iPad. These are the surfaces where the iPad can be **better
than the phone**, because of what it has: a pressure-sensitive stylus, a big canvas, a camera, a
keyboard, and room for two things at once.

Type column: **A** = adaptation of something that already exists · **N** = new feature surface.

### Pencil — the app's real differentiator (the domain logic already exists)

`StrokeMatcher` is *already wired into the app*, not just tests: `drawing_canvas.dart:263` grades each
stroke with `masteryLevel`, and `review_screen.dart:213` matches a whole attempt asynchronously. Every
`Flashcard` carries `strokePaths`, and `mastery_seal`/`hanko_seal_stamp` already celebrate a correct
write. What is missing is only the *input quality and the room*.

| Screen / file | iPad-special idea | Type |
|---|---|---|
| `drawing_canvas.dart`, write-mode in `review_screen`, `drawing_step`, `calligraphy_canvas_sheet` | **Practice bench**: a full-width canvas with the reference glyph beside it (not above), pressure → stroke width, Pencil **hover** → ghost stroke, **palm rejection**, double-tap → eraser, undo/redo stack, and the per-stroke verdict rendered as you write (`StrokeMatcher.matchStroke` already returns it) | A |
| `character_detail_screen` | Hover the stroke list with the Pencil → preview that stroke on the big glyph (`strokePaths` is already loaded) | A |
| `mastery_seal`, `hanko_seal_stamp` | Pressure-sensitive seal stamping — a small, memorable delight | A |

**✅ Step 1 landed 2026-09-26 — the input layer.** `DrawingCanvas` now takes `stylusInput`,
`palmRejection` and `hoverPreview` (all default on, and all **inert without a stylus**, so touch
rendering is untouched): pressure tapers the live stroke (`_drawTaperedStroke` — 0.5 pressure is exactly
the old finger width, so the brush only grows or thins around it), a palm that lands while the Pencil is
down never draws, Pencil hover shows a landing ring **and peeks at the guide stroke** even when the streak
setting has hidden it, and the lesson step's writing surface grows from the phone's 300dp to 460dp on an
iPad. Raw `Listener`/`MouseRegion` observe pressure and pointer kinds; the `GestureDetector` still owns
the gesture arena, so scrolling parents behave as before. Verified by
`test/features/flashcards/drawing_canvas_stylus_test.dart` (synthesised `PointerDeviceKind.stylus` and
palm events; 4/4) and pinned in the adoption ledger.

**Still to do:** the bench *composition* (canvas + context panel as one screen, with undo/redo and the
per-stroke score list) and the practice-session wrapper with replay — steps 2 and 3 below.

**✅ Steps 2 + 3 landed 2026-09-26 — the bench itself.** `lib/features/flashcards/presentation/screens/writing_bench_screen.dart`:
the canvas (capped at **560dp** so it stays reachable on a 12.9" iPad) beside a persistent context panel —
the character with its stroke-order animation, pinyin, definition, the session progress (*1 / 2*), the
per-stroke verdicts as coloured bars using the canvas's own heatmap thresholds, and a completion badge.
It is a **session**, not a single card: Previous / Next / Clear / Skip stroke, and **Replay**, which
redraws the learner's own attempt via the canvas's existing `readOnly` + `initialUserStrokes`. On a phone
the identical screen lays out in one column (the canvas keeps the height, the panel scrolls in a strip).
Entry point: the **iPad insight rail** on the deck screen (a `Practice Writing` button — iPad-only by
construction, since the rail only exists at ≥840dp). Tested by `test/features/flashcards/writing_bench_test.dart`
(4/4: two-pane on iPad, one column on a phone, session advances and steps back, empty deck handled) plus a
ledger row.

### Camera / OCR

| Screen | Idea | Type |
|---|---|---|
| `universal_scanner_screen` | Landscape: live camera left, OCR/markup right; **multi-page scan** with a thumbnail rail (the scanner currently captures one shot at a time); Pencil markup on the captured page; pointer magnifier over the AR boxes (`ar_bounding_box_painter` exists) | A |

### Video, audio — the "study desk"

| Screen | Idea | Type |
|---|---|---|
| `audiobook_player_screen` **+** `book_reader_screen` | **Player and text side by side**, chapter-synced: the audiobook keeps playing while the matching page is open (both are keyed by book id, `audio_service` already exposes position, `now_playing_bookProvider` already links them). Plus PiP and an AirPlay route picker | ✅ **landed 2026-09-26:** `lib/features/reading/presentation/screens/listen_and_read_screen.dart` — the transport (400dp) beside the text, both as **embedded panes**: the player already had no `AppBar`, and the reader gained `embedded` (drops its `AppBar` and its "Resumed: Ch.x" toast, which a chapter-following remount would otherwise fire every chapter). **The audio is the clock** (a location event that changes the chapter re-keys the reader pane onto that chapter; the spoken *sentence* moves it only on a chapter change or an explicit follow press, because per-sentence re-keying would reset the reading scroll), and **nothing stops the audiobook** — the old phone path `stop()`s playback and `pushReplacement`s the reader, so the desk becomes the `isExpanded` branch of that same `_switchToReadingMode` button and the phone path stays *byte-for-byte* below it. The transport's read button becomes "put the text where the audio is". Zero new ARB keys (`chapterXOfY` + the book's own title). Guarded by `test/features/reading/listen_and_read_desk_test.dart` (7 tests, `ipad-sweep`) + 3 rows in the adoption ledger, and the phone-path invariant is pinned by source ordering. Still open from this row: **PiP** and the **AirPlay route picker** | A |
| `smart_media_desk_screen` | Three columns: video + subtitles / AI prep / transcript, with PiP so it survives app switching | A |
| `web_browser_screen` | Real browser chrome (tabs, back/forward), trackpad two-finger scroll, drag a link/word **out** into the dictionary; and the existing `ExtractedWordsReviewSheet` (`web_browser_screen.dart:2196`) as a **sidebar** instead of a sheet | A |
| `channel_videos_screen`, `show_detail_screen` | 3-column grid + PiP; resume position surfaced on the card | A |

### Two-person / kiosk (a new product surface, not an adaptation)

| Screen | Idea | Type |
|---|---|---|
| `travel_interpreter_screen` | The iPad held between two people: each half rotated toward its reader | A/N |
| `live_call_screen`, `conversation_screen` | Presenter view: AI partner large, transcript as a rail, controls in a strip that never covers content | A |
| — | **Two-player quiz** across the iPad: the app's own `docs/marketing_mini_apps.md:18` proposes exactly this, and `quiz_step` + `deck_review_session` already contain the question/grading logic | N |

### Charts, dashboards, analytics

| Screen | Idea | Type |
|---|---|---|
| `stats_screen` | 2–3 column chart dashboard, full-width heatmap, **hover tooltips** on `fl_chart`, share/export | A |
| `dashboard_screen`, `daily_study_dashboard_screen` | A study desk: today's plan, streak, review queue and the audiobook transport visible at once (2–3 columns) | A |
| `daily_goal_review_ring`, `streak_flame_badge` | Bigger, hover-animated on a pointer | A |

### Reading depth (beyond the two-page spread)

| Screen | Idea | Type |
|---|---|---|
| `book_reader_screen`, `story_reader_screen`, `simplified_article_reader_screen`, `cultural_context_screen` | **Hover-to-look-up**: hover a hanzi and the definition appears in a popover — no tap, no context switch. `TappableHanziText` + `quick_look_sheet` are already used in 10+ screens, so this is one shared-widget change. Plus Pencil margin notes, and the article readers get a **vocabulary sidebar** (the extracted-words pipeline exists) | A |
| `story_reader_screen` | Facing columns — hanzi on the left, pinyin/translation on the right — instead of a toggle | A |

### Keyboard-first (a hardware keyboard changes the whole flow)

| Screen | Idea | Type |
|---|---|---|
| `dictionary_screen` | `⌘F` to focus search, **arrow keys through results**, `Enter` to open, `Esc` to clear: with a keyboard, incremental search beats tapping | A |
| `review_screen`, `deck_review_session_screen` | `Space` flip, `1`–`4` grade, `⌘Z` undo, `Esc` end session | A |
| `quiz_screen`, `quiz_step` | `A`–`D` / `1`–`4` to answer, `Enter` to advance | A |
| `hanzi_text_field` | `⌘Enter` submit, `Esc` cancel, a sensible tab order | A |
| `main_navigation_screen` | `⌘1`–`⌘4` for the four destinations (the rail already exists) | A |

**✅ Started 2026-09-26:** `lib/core/layout/zen_shortcuts.dart` — a `ZenShortcuts` widget that takes
`activator → callback` pairs, autofocuses (a `Shortcuts` widget sees nothing until focus is inside it),
and offers `ZenShortcuts.primary(key, cb)` to bind both `⌘key` and `Ctrl+key` so an iPad Magic Keyboard
and an Android tablet both work. Wired into the **writing bench** first (⌘←/⌘→ between cards, ⌘R to
clear), tested with synthesised key events. The remaining rows above are each a `ZenShortcuts` wrapper at
the screen's top level.

### Pointer / hover depth (the iPad is a pointer device now)

| Screen | Idea | Type |
|---|---|---|
| `radical_library_screen`, `character_detail_screen`, `book_catalog_screen`, `story_library_screen`, `channel_videos_screen` | Hover lift on tiles, and **Pencil/Pointer hover over a character previews its stroke order** (`strokePaths` is already on the model) | A |
| `shadowing_studio_screen`, `calligraphic_pitch_contour`, `tone_graph_painter` | Hover to scrub the contour with a live Hz readout instead of tapping blindly | A |
| `quick_look_sheet` | On hover, present as a popover anchored to the word instead of a sheet — one shared widget; **19 UI files** reference this pair today | ✅ **landed 2026-09-26:** `showQuickLookPeek` + `QuickLookPeekHandle` give a **non-modal** overlay peek (deliberately `IgnorePointer`, so the page stays interactive and a tap still opens the real sheet with its actions), and `TappableHanziText` shows it on hover after a 320ms **hover-intent** delay, dismisses after a 520ms grace period, and never fires below 600dp. The hit-test is exact: the `RenderParagraph` maps the pointer to a text offset (`hoverSourceText`), so the *hovered character* is the one peeked. `TappableMarkdownHanziText` returns `null` from `hoverSourceText` — its rendered text is pre-processed, so offsets would lie; a follow-up. Callers can opt out with `hoverPeek: false` | A |
| `web_browser_screen` | Hover link targets and show the URL before committing to a tap | N |

### iPad-only surfaces (need configuration or new work)

| Idea | What it needs | Type |
|---|---|---|
| **Two windows of our own app** — the dictionary in one, the reader in another; a reference window while practising in the main one | `UIApplicationSceneManifest` in `Info.plist` (absent today) **plus a check of Flutter's multi-view support on iPadOS** — verify before promising; Split View with *other* apps already works since B1 | N |
| **External display in Stage Manager** — a "study wall" (today's plan + stats) while the app stays usable | Same scene work as above | N |
| **iPad widgets** — a large "today's reviews" widget; a study-session Live Activity (iPadOS 17+) | `home_widget` is already wired (`widget_service.dart`); widget families for iPad sizes are not defined yet | A |
| **Cross-app drag & drop** — text from Safari/Notes into the dictionary; a photo into the scanner; a word into a deck | `DragTarget`/`Draggable` (3 uses today) + Split View (already unblocked) | A |
| **Accessibility on the canvases** — the big `CustomPaint` surfaces (drawing, calligraphy, pitch contour, scanner markup) expose **nothing** to VoiceOver/Switch Control, and an iPad is a common accessibility device | ✅ **started 2026-09-26:** `DrawingCanvas` takes `semanticsLabel`/`semanticsValue` and wraps itself in a `Semantics` node when either is set; the **writing bench** passes `'Practice Writing: 难'` + the live `'3 / 7 Strokes'`, and the panel's stroke-order animation is labelled too. Still to do: the same two arguments from `calligraphy_canvas_sheet`, the scanner markup and the pitch contour | A |

### Where I would start (highest value per unit of risk)

1. **Pencil practice bench** (`drawing_canvas` + `StrokeMatcher` + a big screen). It is the one change that
   makes the iPad build *better* rather than roomier, and every piece exists: the matcher grades strokes
   today, `strokePaths` is on every card, and the canvas is already a widget.
2. **Audiobook + book side by side** (`audiobook_player_screen` + `book_reader_screen`). Both are keyed by
   book id and `audio_service` already exposes position, so "listen and follow along" is mostly layout.
3. **Hover quick-look** in `TappableHanziText`/`quick_look_sheet` — one shared-widget change that improves
   **19 UI files** at once (dictionary, character detail, all three readers plus the audiobook, chat, live
   call, scanner, stats…).

The two genuinely *new* product surfaces — the two-player quiz and multi-window scenes — should be decided
as products, not smuggled into a layout pass.

---

## 🚀 Part 3 — Execution order, with acceptance criteria

Each phase is independently shippable, and each one leaves the phone experience provably unchanged (the locale sweep is the proof).

### Phase 0 — Unblock iPad *(config only, ~1h)* — ✅ **DONE 2026-09-26**
B1 (`UIRequiresFullScreen` → `false`), B2 (orientation policy in `main.dart` + `ZenDevice`), B3 (the two in-feature portrait locks, now device-gated and released on dispose), plus F9.1 (`kIpadViewports`/`kLandscapePhoneViewports`/`kAllViewports` and the harness viewport fix).
**Done when:** the app runs in Split View at ⅓/½/⅔; the reader rotates; the scanner no longer force-rotates; iPad viewports are in the matrix. ✅ (Hardware check on a real iPad is still worth doing before release.)

### Phase 1 — Layout kit + shell *(the foundation, 1-2 days)* — ✅ **DONE 2026-09-26**
`zen_layout.dart` (F3), `zen_adaptive_scaffold.dart` + `zen_two_pane.dart` (F4), `zen_overlay.dart` (F5), the shell rail (#1), the two guard suites, and the `ipad-sweep` tag.
**Done when:** the rail appears at ≥840dp ✅ (it appears at ≥600dp, extended at ≥840dp); `adaptive_layout_guard_test.dart` exists with the four ratchets ✅.
Content caps on the 8 most-visited screens (#4, 5, 10, 14, 24, 29, 68) are **still pending** — `ZenContentPane` exists but most screens do not call it yet; that lands with each screen's Phase 2/3 work.

### Phase 2 — Two-pane set *(6 screens: #24, 30, 16, 9, 55, 22)* — 🚧 **started 2026-09-26**

**Structural correction discovered while implementing (important):** the plan assumed these screens
open their details with `Navigator.push`, so a detail pane could simply host the pushed widget. That
is true for only some of them:

| Screen | How it opens a detail today | iPad treatment | Status |
|---|---|---|---|
| `deck_detail_screen` | pushes for review/picker; the numbers live in a scrolling header | **insight rail** beside the card list (due/new/learning + daily goals), actions stay in the list pane | ✅ **done** — `_DeckInsightRail`, tested by `test/features/flashcards/deck_detail_ipad_layout_test.dart` (iPad shows the rail, iPhone **and** a 700dp Split View slice do not) |
| `dictionary_screen` | pushes only for *other features* (scanner, radical library, tome manager); word details are inline cards | width shaping: cap the hub column and lay the lexicon section out in 2 columns at expanded — a detail pane has nothing to bind to — **partly done**: the hub is wrapped in `ZenContentPane(maxWidth: 1100, padding: zero)`, which stops the shelf rows stretching on an iPad; a true definition pane still needs a detail widget to bind to | 🚧 |
| `book_catalog_screen` | no `Navigator.push` at all — covers use a hero route | its grid win already landed (`ZenGrid.covers` 2 → adaptive columns); a preview pane needs the cover tap intercepted to set a selection — **done**: the cover tap sets `_previewBook` at ≥840dp (phones still push), and the pane hosts the same `BookDetailScreen` in a new `embedded: true` mode so it renders no back button (there is no route to pop) | ✅ |
| `settings_screen` | sections are inline; sub-flows are dialogs | centred column capped at ~760dp (a 1366dp-wide form is wrong) — the edit is one wrapper around its `ListView` — **done**: unconditional `ZenContentPane(maxWidth: 760, padding: zero)`, which is a no-op on any phone and centres the form on an iPad | ✅ |
| `scenario_selection_screen` | no `Navigator.push` — briefing/detail open as sheets | **already improved**: those sheets now become width-capped dialogs at expanded via `zenSheet` (F5), which is the correct iPad idiom for a short form | ⏳ (F5 covered it) |
| `character_detail_screen` | `PageView.builder` with a `PageController` (1708 lines) | replace the pager with **side-by-side columns** at expanded (strokes / words / etymology / practice) — the one screen where the structure itself must change | ✅ **landed 2026-09-26, but smaller than this row feared.** Audit first: the screen *already* had a two-column wide layout (`_buildLandscapeLayout`: character card left, details right), and the `PageView` is **not a character carousel** — it pages the character's anatomy/radical components inside one section. So the real work was (a) the gate: `constraints.maxWidth > 600` → `context.zenWindow.isAtLeastMedium && constraints.maxWidth > ZenBreakpoints.compactMax` (no magic number, and a Split View slice can no longer be handed the iPad layout just because a raw pixel count crossed a threshold — this was the file's only raw-width comparison, so it now also passes the adoption ledger's scan); (b) at **expanded** the detail sections are arranged as **side-by-side columns** (`_buildDetailColumns`, two `Expanded` columns, even/odd split) and the pill bar is **not built** — its only job was jumping between stacked sections — while the narrow path keeps the pill-navigated stack untouched; (c) the anatomy `PageView` becomes a row of component cards at expanded (a swipe carousel on a wide screen hides content and fights two-finger trackpad scrolling — the caveat this doc raises at line 165/493), keeping the pager for the narrow path. Both arrangements are built from one `_detailSectionWidgets` list so they cannot drift. Guarded by `test/features/flashcards/character_detail_ipad_layout_test.dart` (7 tests, `ipad-sweep`) + an adoption-ledger row; one older guard needed repair (`common_words_tab_test`'s section-mounting anchor). Still open from this row: the **Pencil practice pane** and **hover tooltips on hanzi** (F6 / the hover work) | ✅ (core) |

**The recipe that keeps iPhones safe** (used for `deck_detail`, reuse it everywhere):

```dart
final Widget body = <the existing screen, unchanged>;
if (!context.zenWindow.isExpanded) return body;   // iPhone + Split View: byte-identical
return Row(children: <Widget>[
  Expanded(child: body),
  _WideRail(...),                                  // or ZenTwoPaneScaffold for list → detail
]);
```

Two rules that make this safe: the wide branch is **additive** (never a rewrite of the phone layout),
and it fires at *expanded* (≥840dp), so a 600-839dp Split View slice keeps the phone layout.

**Test pattern** (copy `deck_detail_ipad_layout_test.dart`): pump the screen through a
`ProviderScope` + the `tester.view.physicalSize` API at 1024×1366 (wide branch visible) and at
390×844 **and** 700×1000 (wide branch absent). Tag it `ipad-sweep`.
**Done when:** at 1024×1366 both panes render with **no** pushed route; at ≤599dp the navigation flow is character-for-character the current one (verified by the existing sweep, which must stay green).

### Phase 3 — Reading, media and iPad-native surfaces *(#29, 37, 51, 44, 71, 48, 68, 70)*
**Done when:** two-page spread works at 1194×834 and up; audiobook landscape shows artwork + transcript; shadowing and scanner are two-pane in landscape; the sweep is green across `kIpadViewports`.

**Status 2026-09-26 — slices landed:** ✅ subtitle + transcript typography for viewing distance (#50); ✅ the audiobook/reader listen-and-read desk (#37); ✅ the browser's **extracted-words sidebar** (#48) — the review is a 380dp pane beside the page at expanded, same widget, optional callbacks that default to the modal path. ⏳ **Still open — so the clause above is NOT met:** the two-page spread (#29, needs the reading-order decision), the scanner two-pane (#71 — **landed for the live-preview and results states**, see the map below), the media-desk split + PiP (#44), browser tabs (#48's larger half) — **update 2026-09-26:** the browser sidebar, the scanner split and the media-desk split all landed; PiP remains, and it is native rather than layout.

**Scanner map (measured 2026-09-26, for whoever takes #71):** body is `Scaffold(extendBodyBehindAppBar: true)` -> `CameraPreview` at `:725` then `_buildMainContent` at `:877`. **The trap:** `ScannerOverlay`/`ScannerOverlayPainter` (`:2069`/`:2093`) paint from `screenSize: MediaQuery.sizeOf(context)` (`:1155`), so a split must scope that painter to the camera pane or the OCR boxes are drawn over the results column. Multi-page capture + thumbnail rail is a new capability, not a layout branch. Sequence: read 651-877 -> extract camera pane and results pane with no behaviour change -> add the ZenWindow-gated Row -> scope the painter -> test.

**✅ Landed 2026-09-26, with that sequence, and scoped.** The camera became `_buildCameraPreview()` — which is what makes the split correct, because the aspect-fit math now runs against the pane constraints instead of the window — the preview keeps `widthFactor: 0.45` on the left, and the content takes `wideSplit ? 0.55 : 1.0` on the right, so **every phone and medium window is byte-identical**. `wideSplit` deliberately excludes `_showingInteractiveImage`, because that is exactly where the painter trap lives: scope `ScannerOverlayPainter` before splitting that state. Still open from this row: **multi-page capture + thumbnail rail** (a new capability, not a layout branch) and the painter scoping.

### Phase 4 — Inputs *(F6: hover, keyboard, Pencil, drag & drop)*
**Done when:** `Space`/`1-4` grade a review, `←`/`→` page the reader, `⌘1-4` switch tabs (widget tests for each); Pencil pressure changes stroke width with palm rejection; at least one drag-and-drop path (card → deck) works with a pointer.

### Phase 5 — Long tail + guards to zero *(the rest of Part 2)*
**Done when:** `crossAxisCount` 0, raw `MediaQuery.of(context).size` 0, direct `showModalBottomSheet` 0, orientation locks only in `main.dart` + camera routes; `docs/UI_UX_STANDARDS.md` gains an **Adaptive layout** section pointing here; this document's status flips from 📋 PLAN to ✅ DONE.

---

## ⚠️ Risks, and what NOT to do

- **Do not fork the design language.** Adaptation is layout, density and input — same Zen & Ink palette, same motion tiers (`ZenMotion`), same haptics. No "iPad theme".
- **The three big restructures are the schedule risk**: `book_reader_screen` (2417 lines), `character_detail_screen` (1633), `shadowing_studio_screen` (2589). Each is a rewrite of a pager/carousel into panes. Do them **behind `ZenWindow` branches**, never as an in-place redesign, so compact behaviour stays covered by the existing sweep.
- **Pencil features must degrade.** No functionality may exist only for Pencil: touch and phone users keep the current path. On devices without a stylus, `PointerDeviceKind.stylus` simply never fires — make sure the code path is additive.
- **Removing `UIRequiresFullScreen` shrinks the app.** Split View can hand the app a 320dp-wide window: compact layouts must be genuinely robust, not "phone-shaped by luck". The 320×568 sweep already guards this — keep it in the matrix.
- **Trackpad vs `PageView`**: two-finger horizontal scroll fights a pager. Where a pager stays (character detail, lessons), prefer explicit controls at medium+ rather than swipe-only.
- **Don't add an adaptive-layout dependency** (e.g. `flutter_adaptive_scaffold`) unless it's a team decision — the repo has zero adaptive deps, and the primitives in F3–F5 are ~300 lines.
- **Don't eyeball it.** The only trustworthy acceptance is the sweep at iPad sizes with 12 locales and 2× text scale; a screenshot at 1.0 scale in English proves nothing (see the localization thread).
- **iPad ≠ desktop.** No menu bar, no multi-window scenes, no keyboard-first redesign. Stage Manager resizing is a *side effect* of doing F3 properly, not a deliverable.

---

## ✅ Start here — the first two pull requests

**PR 1 (Phase 0, tiny, immediately user-visible):**
1. `ios/Runner/Info.plist` — drop `UIRequiresFullScreen`.
2. `lib/main.dart` — replace the hardcoded portrait list with the device-class helper (F2).
3. `universal_scanner_screen.dart:129` + `smart_media_desk_screen.dart:266,755` — gate on tablet.
4. `test/support/locale_layout_harness.dart` — add `kIpadViewports` (F9.1) and run the sweep; the failure list **is** the Phase 3 worklist.

**PR 2 (Phase 1, the foundation):** `zen_layout.dart` + `zen_adaptive_scaffold.dart` + the shell (#1) + the four guard ratchets in `adaptive_layout_guard_test.dart`, with baselines measured before touching a single screen.

---

## 📎 Appendix — how every number was measured

Run from the repo root. PowerShell 5.1 mangles UTF-8 in these docs unless you ask for it, so every command starts with `[Console]::OutputEncoding = [System.Text.Encoding]::UTF8`.

**Screen inventory (61 screens, 61 presentation widgets):**
```powershell
Get-ChildItem lib -Recurse -Filter *.dart | Where-Object { $_.FullName -match 'presentation\\screens\\' } |
  ForEach-Object { $n = (Get-Content $_.FullName | Measure-Object -Line).Lines; '{0,5} {1}' -f $n, $_.Name }
```

**Adaptive infrastructure (counts in Part 1):**
```powershell
$pats = [ordered]@{ LayoutBuilder='LayoutBuilder\('; MQsize='MediaQuery\.of\(context\)\.size';
  breakpoints='(kBreakpoint|Breakpoints?\.|isTablet|isWide|_isNarrow|isCompact)'; grid='crossAxisCount';
  maxW='maxWidth:'; hover='(MouseRegion|onHover)'; keys='(Shortcuts\(|LogicalKeyboardKey|SingleActivator)';
  stylus='(PointerDeviceKind|stylus|Tablet)'; drag='(Draggable|DragTarget)'; sheet='showModalBottomSheet';
  rail='NavigationRail'; safe='SafeArea\(' }
foreach ($k in $pats.Keys) { $m = Get-ChildItem lib -Recurse -Include *.dart | Select-String -Pattern $pats[$k] -AllMatches
  '{0,-14} matches={1,-5} files={2}' -f $k, (($m | ForEach-Object { $_.Matches.Count }) | Measure-Object -Sum).Sum, ($m | Select-Object -ExpandProperty Path -Unique).Count }
```

**Fixed grids (the 10 sites in F7):**
```powershell
Get-ChildItem lib -Recurse -Include *.dart | Select-String -Pattern 'crossAxisCount|childAspectRatio' |
  ForEach-Object { $_.Filename + ':' + $_.LineNumber + '  ' + $_.Line.Trim() }
```

**iOS configuration (B1/B2):**
```powershell
Select-String -Path ios\Runner\Info.plist -Pattern 'UIRequiresFullScreen' -Context 0,2
Select-String -Path ios\Runner.xcodeproj\project.pbxproj -Pattern 'TARGETED_DEVICE_FAMILY' | Select-Object -Unique
Select-String -Path lib\main.dart -Pattern 'setPreferredOrientations' -Context 0,4
Get-ChildItem lib -Recurse -Include *.dart | Select-String -Pattern 'setPreferredOrientations|lockCaptureOrientation'
```

**Per-screen shape (the "Shape today" column in Part 2):** read each screen once and count the structural widgets, e.g.
```powershell
$t = [IO.File]::ReadAllText('lib/features/reading/presentation/screens/book_reader_screen.dart')
foreach ($p in 'AppBar\(','PageView','GridView|SliverGrid','CameraPreview','showModalBottomSheet','CustomPaint\(','maxWidth:') {
  '{0,-24} {1}' -f $p, ([regex]::Matches($t, $p)).Count
}
```

**Test matrix today (`test/support/locale_layout_harness.dart`):** `kTightViewports = [390×844, 320×568]` (both portrait) × 12 `kExpansionLocales` × text scales `[1.0, 2.0]` — that is the coverage this plan extends, not replaces.
