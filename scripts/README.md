# 🌐 Hanzi Master Localization Scripts

This directory contains the automation scripts for scanning, managing, and synchronizing app localizations.

---

## 1. extract_and_sync_app_en_arb.py (Scan & Extract UI Strings)
Scans all Dart files in lib/ for any newly added hardcoded English UI strings (dialogs, buttons, prompts, onboarding, study feedback, error messages, menus), filters out technical code identifiers, and cleanly injects them into lib/l10n/app_en.arb.

### Usage:
`ash
python scripts/extract_and_sync_app_en_arb.py
`

---

## 2. 	ranslate_all_arb_files.py (Multilingual ARB Translator)
Translates all missing keys in all 12 target .arb localization files (pp_ar.arb, pp_de.arb, pp_es.arb, pp_fr.arb, pp_hi.arb, pp_id.arb, pp_it.arb, pp_ja.arb, pp_ko.arb, pp_pt.arb, pp_ru.arb, pp_th.arb, pp_vi.arb) against pp_en.arb.

* **Protects ICU placeholders** (e.g. {score}, {count}, {name}) so translation never corrupts Flutter formatting.
* Automatically formats and indents JSON.

### Usage:
`ash
python scripts/translate_all_arb_files.py
`

---

## 3. Regenerate Flutter Bindings
After updating any .arb file, run:
`ash
flutter gen-l10n
`
