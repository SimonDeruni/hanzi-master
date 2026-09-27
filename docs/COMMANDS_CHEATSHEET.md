# ⚡ Hanzi Master - Quick-Start Commands

Use these exact commands for maintenance and development.

---

## 🛠️ Build & Maintenance
- **Rebuild Models/Providers:**
  `flutter pub run build_runner build --delete-conflicting-outputs`
- **Auto-Fix Linting Issues (Unused imports, etc.):**
  `dart fix --apply`
- **Clean Project:**
  `flutter clean`
- **Get Dependencies:**
  `flutter pub get`

## 🧪 Testing
- **Run Unit Tests:**
  `flutter test`
- **Run Specific Test:**
  `flutter test test/unit_tests/stroke_matcher_test.dart`
- **Locale layout gate** (CI runs exactly this, blocking — see `docs/LOCALIZATION_PIPELINE.md` §5):
  `flutter test test/core/locale_layout_guard_test.dart`
  `flutter test --tags locale-sweep`
- **Which suites the sweep covers:**
  `grep -rl "locale-sweep" test --include='*_test.dart'`
- **Translation expansion report** (also published as a CI artifact):
  `python scratch/arb_expansion_audit.py --out build/reports/arb_expansion.txt`

## 📦 Data Pipeline (Tooling)
- **Fetch HSK 1 Strokes:**
  `dart tooling/fetch_hanzivg.dart`
- **Generate HSK 1 Metadata:**
  `dart tooling/generate_hsk1_metadata.dart`
- **Build App Dictionary:**
  `dart tooling/build_dictionary.dart`
- **Generate Sentences:**
  `dart tooling/generate_sentences.dart`

## 🌐 Content Translation Factories
Both factories share one credential pool (`scratch/translation_pool.py`, every key in
`.env` / `functions/.env`), rotate on `429` and drop a dead key on `401/403/404`.
They only ever touch a row that is still the English source, so a hand-written
translation can never be overwritten.
- **What is still missing, per catalog family:**
  `python scratch/catalog_factory.py --survey`
- **Translate or repair a catalog family** (`shows` | `channels` | `chapter_titles`):
  `python scratch/catalog_factory.py --family chapter_titles --locale all`
- **Mandarin Bean micro-read summaries** (resumable; `--dry-run` first):
  `python scratch/summaries_factory.py --dry-run`
  `python scratch/summaries_factory.py --batch 25 --workers 4`
- **Progress and independent quality check:**
  `python scratch/summaries_progress.py`
  `python scratch/summaries_quality_check.py`
- **Per-locale audit of every content catalog:**
  `python scratch/content_l10n_audit.py --out build/reports/content_l10n.txt`
- **Strip a UTF-8 BOM from bundled JSON** (Dart tolerates it, strict parsers do not):
  `python scratch/strip_json_bom.py`
- **The rules that keep all of this honest:**
  `flutter test test/core/content_localization_guard_test.dart`
- **Expand Poetry Collections** (one book per poet, up to `--per-author` poems each;
  `--check` validates without fetching, `--dry-run` reports without writing):
  `python tooling/fetch_poetry_collections.py --per-author=50`
  `python tooling/fetch_poetry_collections.py --check`
- **Poet biographies** (condense the corpus author index, then translate; `--only <code>`
  narrows to one locale, and English is fetched with `--only en`):
  `python tooling/build_poet_bios.py`
  `python tooling/build_poet_bios.py --translate --only fr`
- **Poem title translations** (resumable — re-run to continue where it stopped;
  a title that is already translated is never re-sent):
  `python tooling/translate_poetry_chapters.py`
  `python tooling/translate_poetry_chapters.py 600 --only ja`
- **English poem titles** (the base locale reads the store's own `title_en`, since
  there is no `l10n/poetry_en.json`; resumable, `--dry-run` reports without writing):
  `python tooling/build_poem_titles_en.py`
  `python tooling/build_poem_titles_en.py --dry-run`

## 📱 Release & Store
- **Build Android App Bundle:**
  `flutter build appbundle`
- **Build iOS (No IPA):**
  `flutter build ios`

## 📦 Archiving & Rotation
- **Manual Issue Prune:** 
  *(Follow `docs/ai_update_guidelines/ROTATION_STANDARD.md` to move rows to `docs/archive/RESOLVED_ISSUES_VOL_X.md`)*
- **Audit Archive:** 
  `mv audit/audit_results/[folder]/audit_X.md audit/audit_results/archive/`

## 🌿 Git Environment
- **Baseline Commit:**
  `git add .; git commit -m "chore: Baseline commit"`
- **Status Check:**
  `git status -s`
- **History:**
  `git log --oneline -n 10`
