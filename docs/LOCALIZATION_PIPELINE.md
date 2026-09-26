# 🌐 Hanzi Master — Localization & Translation Pipeline Guide

This guide documents the **100% Free, Automated Multi-Language Localization System** used in Hanzi Master across all **13 supported languages**.

---

## 🏛️ 1. Architecture: The Two Layers of Text

Hanzi Master separates application text into two clean layers:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        Hanzi Master Text Layers                        │
├──────────────────────────────────┬─────────────────────────────────────┤
│ 1. Static UI Chrome              │ 2. Dynamic Content Catalog          │
│ • Buttons, headers, tabs         │ • 96 Novel & Book Synopses/Authors  │
│ • Dialogs, error messages, menus │ • 50+ Show & Drama Summaries        │
│ • Settings & form labels         │ • YouTube Curated Playlists & Lore  │
│ • ARB files (`app_<locale>.arb`) │ • Roleplay Scenarios & Objectives   │
│ • `AppLocalizations.of(context)` │ • JSON Catalogs in `assets/data/`   │
└──────────────────────────────────┴─────────────────────────────────────┘
```

---

## 🌍 2. Supported Locales (13 Languages)

| Code | Language | Native Name | Code | Language | Native Name |
|:---:|---|---|:---:|---|---|
| `en` | English | English | `ar` | Arabic | العربية |
| `fr` | French | Français | `hi` | Hindi | हिन्दी |
| `es` | Spanish | Español | `ja` | Japanese | 日本語 |
| `de` | German | Deutsch | `ko` | Korean | 한국어 |
| `it` | Italian | Italiano | `vi` | Vietnamese | Tiếng Việt |
| `pt` | Portuguese | Português | `id` | Indonesian | Bahasa Indonesia |
| `ru` | Russian | Русский | `zh` | Chinese | 中文 (简体) |

---

## ⚡ 3. The 100% Free Translation Engine

### Google AI Studio Free Tier (Zero-Cost API)
* **Limits**: 15 Requests Per Minute (RPM), 1,500 Requests Per Day (RPD).
* **Cost**: **$0.00** (Free of charge by default, no billing attached).
* **Batch Efficiency**: 50 strings are translated across **all 13 languages simultaneously in a single prompt**, requiring only ~25-30 total API calls for the entire app.

### Zero-Key Fallback (`deep-translator`)
* If offline or if API keys are unavailable, the pipeline automatically falls back to Python's `deep-translator` library connecting to the public translation endpoints with zero credentials needed.

---

## 🛠️ 4. Step-by-Step Workflow for Future Updates

### Step 1: Scan & Extract All Strings
Run the master extraction script to find new hardcoded strings across `lib/` and `assets/`:
```bash
python scratch/extract_everything.py
```
*Output: Generates `lib/l10n/master_translation_catalog.json` and `untranslated_ui_strings.json`.*

### Step 2: Batch Translate Across 13 Languages
Execute the multi-target batch translator:
```bash
python scratch/batch_translate_13_languages.py
```
*Output: Automatically populates all 13 `.arb` files with pristine UTF-8 translations.*

### Step 3: Regenerate Flutter Localization Classes
Run the Flutter code generator:
```bash
flutter gen-l10n
```
*Output: Updates `app_localizations.dart` and all 13 language-specific `.dart` classes.*

### Step 4: Verify Hygiene
```bash
dart analyze lib/l10n/
```

### Step 5: Verify the Layout Survives the Translation
A string can be perfectly translated and still break the UI: German, French,
Spanish, Italian, Portuguese, Russian, Vietnamese and Thai expand a label by up
to ~2x English (worst cases 5-9x). Run the locale sweep every time `.arb` files
change:

```bash
flutter test test/core/locale_layout_guard_test.dart   # source ratchets, instant
flutter test --tags locale-sweep                       # the worst-case sweep
```

The sweep in `test/support/locale_layout_harness.dart` renders widgets across the
worst-case locales x viewports (390x844, 320x568) x text scales (1.0x, 2.0x) and
**fails on any overflow**. If it reports one, do not silence it: make the
offending text flexible (see `docs/UI_UX_STANDARDS.md` -> "Localization Layout
Budget").

**This gate is enforced in CI, and it is blocking** — it used to be documentation
only, which is why translations still reached users overflowing their buttons:

| Where | Job | What it runs |
|---|---|---|
| GitLab | `flutter_test_locale` (stage `test`) | the guard test, then the tagged sweep; report kept as an artifact for 30 days |
| GitHub | `.github/workflows/locale_guard.yml` | the same two steps on pushes and pull requests |

Both jobs also publish the per-locale **expansion report** as an artifact at
`build/reports/arb_expansion.txt` (UTF-8):

```bash
python scratch/arb_expansion_audit.py --out build/reports/arb_expansion.txt
flutter test --tags locale-sweep   # `grep -rl "locale-sweep" test` lists the suites it selects
```

**Adding a screen to the sweep is one line:** annotate the suite with the tag,
and CI picks it up automatically (the job derives its file list from the tag).

```dart
@Tags(<String>['locale-sweep'])
library;
```

Audit scripts live in `scratch/`:

| Script | Purpose |
|---|---|
| `scratch/arb_expansion_audit.py` | Per-locale expansion ratios + the worst expanding keys (`--out PATH`) |
| `scratch/fixed_width_text_audit.py` | Containers that size text by pixel, non-flexible button rows |
| `scratch/layout_l10n_audit.py` | Untranslated UI literals (the ratchet baseline) |
| `scratch/fix_mojibake.py` | Byte-exact repairs for cp1252-decoded UTF-8 in `lib/` |

---

## 🛡️ 5. Critical Best Practices
1. **Never use bang (`!`) on `AppLocalizations.of(context)` during `initState()` or frame 0**:
   ```dart
   // ❌ CRASH:
   title: AppLocalizations.of(context)!.myTitle
   
   // ✅ SAFE:
   onGenerateTitle: (context) => AppLocalizations.of(context)?.myTitle ?? 'My Title'
   ```
2. **Always ensure UTF-8 encoding without double-encoding**:
   * Use standard UTF-8 string encoding when generating `.arb` files to prevent Mojibake (`Ã¨` vs `è`).
3. **Budget the layout for the longest language, not English**:
   * Design every label, button and row for **2.0x the English width**, and never
     fix the height of a box containing text (Hindi/Thai/Arabic line boxes are
     taller). See `docs/UI_UX_STANDARDS.md` -> "Localization Layout Budget".

