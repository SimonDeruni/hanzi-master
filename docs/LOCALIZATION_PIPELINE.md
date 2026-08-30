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
