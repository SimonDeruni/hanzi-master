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
