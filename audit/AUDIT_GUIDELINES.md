# 📖 Hanzi Master - Standardized Audit Framework (SAF)

This document defines the mandatory procedures for conducting technical, architectural, and security audits. Adherence to this framework ensures that findings are actionable, prioritized, and documented consistently across the "Hanzi Master" project.

---

## 🏗️ 1. Audit Report Template
Every audit must generate a Markdown report using the following structure:

```markdown
# Audit [ID]: [Title]
**Status:** [🟢 PASS | 🟡 AVG | 🔴 FAIL]
**Date:** [YYYY-MM-DD]

## 📊 Executive Summary
*One-sentence "North Star" summary of the system's health.*

## 🚩 Findings (Prioritized)
### [P0 - Critical] - [Title]
- **Evidence:** [File Path : Line Number]
- **Impact:** [Security breach, crash, or data loss risk]
- **Remediation:** [Mandatory code fix or configuration change]

### [P1 - High] - [Title]
- **Evidence:** [File Path]
- **Impact:** [Performance jank, confusing UI, or technical debt]
- **Remediation:** [Recommended improvement]

### [P2 - Minor] - [Title]
- **Evidence:** [File Path]
- **Impact:** [Documentation drift or slight inconsistency]
- **Remediation:** [Suggested update]

## ⚖️ Documentation Sync
- **GEMINI.md Update Required?** [Yes/No]
- **ROADMAP.MD Updated?** [Yes/No]
- **Bugs.md Entry Created?** [Yes/No]
```

---

## 🛡️ Audit 1: Security & Secrets
**Objective:** Zero exposure of sensitive data and absolute protection of user privacy.
**Scope:** `lib/`, `android/`, `ios/`, `.gitignore`, and all config files.

### 🛠️ Technical Playbook:
1.  **Secret Scan:** `grep_search(pattern: 'apiKey|token|secret|client_id|key:', total_max_matches: 100)`
2.  **Encryption Audit:** Open `lib/main.dart` and verify `Hive.openBox` uses a `HiveAesCipher`.
3.  **Input Sanitization:** Verify all `http.get` calls (e.g., in `flashcard_repository_impl.dart`) are wrapped in `try-catch` blocks.
4.  **Vulnerability Scan:** Ensure `.env` and `google-services.json` are explicitly listed in `.gitignore`.

**Pass/Fail Criteria:** 
- **PASS:** Zero hardcoded keys, all PII encrypted, .gitignore hardened.
- **FAIL:** Any hardcoded production keys or unencrypted user data.

---

## 🧬 Audit 2: Algorithmic & Logic (Stroke Matching)
**Objective:** Eliminate false negatives and ensure "smooth" kinesthetic feedback.
**Scope:** `lib/core/stroke_matcher.dart`, `lib/core/character_loader.dart`, `lib/features/flashcards/presentation/widgets/drawing_canvas.dart`.

### 🛠️ Technical Playbook:
1.  **Coordinate Consistency:** Verify that both Loader and Canvas use the **1000x1000** system.
2.  **Relative Threshold Audit:** Check `StrokeMatcher.dart` for `lengthFactor` logic. Ensure tiny strokes (dots) have a minimum absolute threshold of 35px.
3.  **Multi-Char Indexing:** Verify that `medianPaths` and `strokePaths` are index-synchronized in `flashcard_repository_impl.dart` (Check for separators).
4.  **Adaptive Mastery:** Confirm `masteryLevel` is correctly passed from `Flashcard` -> `DrawingCanvas` -> `StrokeMatcher`.

**Pass/Fail Criteria:**
- **PASS:** 100% coordinate alignment, functioning adaptive buffer zones.
- **FAIL:** Centering shifts between characters or missing "Dot" detection.

---

## ⚡ Audit 3: Performance & Fluidity
**Objective:** Maintain 60-120FPS fluidity and optimize memory lifecycle.
**Scope:** `lib/features/course/presentation/screens/course_screen.dart`, `lib/features/flashcards/presentation/widgets/drawing_canvas.dart`, `lib/core/character_loader.dart`.

### 🛠️ Technical Playbook:
1.  **Repaint Boundary Audit:** Verify static layers in `DrawingCanvas.dart` (Completed & Reference Strokes) are isolated with `RepaintBoundary`.
2.  **Cache Lifecycle:** Ensure `CharacterLoader._pathCache` has a size limit (Max 1000 entries) and a clear mechanism.
3.  **Isolate Evaluation:** Profile startup parsing in `main.dart`. If parsing `hsk1.json` exceeds 100ms, it must move to a background `compute`.
4.  **Asset Load Audit:** Verify `RiceGridPainter` uses `shouldRepaint` correctly to avoid redundant grid draws.

**Pass/Fail Criteria:**
- **PASS:** Repaint isolation confirmed, cache size restricted.
- **FAIL:** Main-thread blocking > 100ms or full-canvas repaints during drawing.

---

## ⚖️ Audit 4: Consistency & Source of Truth
**Objective:** Eliminate conflicting instructions or outdated feature descriptions.
**Scope:** `docs/GEMINI.md`, `docs/functionalities.md`, `docs/ROADMAP.MD`, `CHANGELOG.MD`.

### 🛠️ Technical Playbook:
1.  **Mandate Mapping:** Search for "Must Have" vs "Won't Have" in `GEMINI.md` and cross-reference with actual code status.
2.  **Status Sync:** Verify that every "Fixed" item in `CHANGELOG.MD` is marked as `[x]` in `ROADMAP.MD`.
3.  **Terminology Audit:** Ensure metaphors (Galaxies, Stars, Units) are consistent across all documentation and UI.
4.  **Instruction Drift:** Check if `GEMINI.md` logic rules (e.g., buffer sizes) match the actual values in `lib/core/`.

**Pass/Fail Criteria:**
- **PASS:** Zero contradictions between docs and code.
- **FAIL:** Conflicting feature status or outdated logic descriptions.

---

## 💰 Audit 6: Monetization & Gatekeeper
**Objective:** Secure the "Scholar's Edition" revenue stream and verify entitlement logic.
**Scope:** `lib/core/services/monetization_service.dart`, `lib/features/premium/presentation/widgets/paywall_sheet.dart`, and all `isPremium` gated features.

### 🛠️ Technical Playbook:
1.  **Entitlement Propagation:** Grep for `ref.watch(premiumControllerProvider)` in `DictionaryScreen`, `TomeManager`, and `OcrService`. Verify access is blocked if `isPremium` is false.
2.  **Dev Bypass Scan:** Search `paywall_sheet.dart` for "Dev Bypass" buttons. Ensure they are wrapped in `if (kDebugMode)`.
3.  **Restore Flow:** Manually trigger the "Restore Purchase" method in `MonetizationService`. Verify it handles empty receipt cases without crashing.
4.  **Price Formatting:** Ensure product prices are fetched dynamically from the store and not hardcoded in the UI.

**Pass/Fail Criteria:**
- **PASS:** Zero access to premium features for free users; no hardcoded prices.
- **FAIL:** Premium content accessible without an active entitlement.

---

## 👁️ Audit 7: OCR & Vision Performance
**Objective:** Ensure the "Magic Lens" and "Snapshot-to-Practice" features are stable and efficient.
**Scope:** `lib/core/services/ocr_service.dart`, `google_mlkit_text_recognition` integration.

### 🛠️ Technical Playbook:
1.  **Lifecycle Audit:** Verify that `TextRecognizer` and `CameraController` are closed in the `dispose()` method.
2.  **Memory Pressure:** Monitor memory usage during a "Snapshot-to-Practice" session with a large image.
3.  **Offline Verification:** Disable Wi-Fi/Data and attempt a scan. Ensure ML Kit doesn't hang waiting for a model download.
4.  **Accuracy Check:** Run the OCR against `assets/test_images/hsk1_list.png` and verify 90%+ character recognition.

**Pass/Fail Criteria:**
- **PASS:** Clean disposal of camera resources; functional offline recognition.
- **FAIL:** Memory leaks after multiple scans; app hangs when offline.

---

## 📚 Audit 8: Tome Library & Module Lifecycle
**Objective:** Guarantee a seamless and safe "Expansion Pack" experience.
**Scope:** `tooling/create_hsk2_module.dart`, `lib/features/course/presentation/screens/tome_manager_screen.dart`.

### 🛠️ Technical Playbook:
1.  **Atomic Injection:** Verify that `TomeManager` uses a transaction or batch operation when injecting new characters into Hive.
2.  **Conflict Check:** Ensure HSK 2 characters use unique UUIDs that do not overlap with HSK 1.
3.  **Proxy Inheritance:** Verify that newly installed characters can correctly access the `_radicalProxyMap` for their components.
4.  **Storage Audit:** Check the file size of the HSK 2 JSON bundle. It must be < 500KB.

**Pass/Fail Criteria:**
- **PASS:** Clean installation/uninstallation without corrupting HSK 1 data.
- **FAIL:** Duplicate entries in Hive or broken stroke data after a module update.

---

## 🗺️ Audit 9: Documentation & Structural Mapping
**Objective:** Ensure a clear "Big Picture" exists for future development.
**Scope:** All root-level documentation and project structure.

### 🛠️ Technical Playbook:
1.  **Folder Mapping:** Verify if `docs/PROJECT_MAP.md` exists and accurately describes the purpose of every top-level folder.
2.  **Pipeline Audit:** Trace the data flow from `tooling/` -> `assets/data/` -> `lib/`. Ensure this is documented.
3.  **Broken Link Check:** Verify that `GEMINI.md` and `README.md` correctly point to the moved `docs/` folder.
4.  **README Health:** Ensure every feature folder in `lib/features/` has a minimal `README.md` or comment block explaining its purpose.

**Pass/Fail Criteria:**
- **PASS:** New developers can understand the architecture in < 10 minutes.
- **FAIL:** Missing or outdated "Source of Truth" documents.

---

## 🔄 5. The Active Remediation Loop (Mandatory)
Auditing in Hanzi Master is an **Active** process, not just passive reporting. When you conduct an audit, you MUST follow this loop:
1.  **Execute Audit:** Run the playbook and identify any failures or warnings.
2.  **Attempt Fix (Remediation):** Immediately try to solve the identified P0/P1 issues. Do not just report them. Write the code, run the command, or fix the document.
3.  **Re-Audit:** Run the specific audit step again to verify your fix actually worked.
4.  **Update Report:** The final audit report MUST reflect the *post-remediation* state. If you fixed a problem during the audit session, log it under a "✅ Corrective Actions Taken" section. Only issues you *cannot* solve should be left as 🔴 FAIL and moved to `docs/ISSUES.md`.

---

## 📂 6. Result Storage & Lifecycle
1.  **Naming Convention:** `audit_[ID]_[title_snake_case].md`
2.  **Location:**
    - 🟢 **pass**: `audit/audit_results/pass/`
    - 🟡 **average**: `audit/audit_results/average/`
    - 🔴 **failed**: `audit/audit_results/failed/`
3.  **Changelog:** Append to `audit/audit_changelog.md` immediately after report generation.
4.  **Definition of Done:** 
    - [ ] Audit playbook executed.
    - [ ] **Active Remediation applied to all fixable findings.**
    - [ ] Re-audit performed to verify fixes.
    - [ ] Report stored (reflecting post-fix status) and Changelog updated.
    - [ ] `docs/ISSUES.md` updated ONLY for unfixable P0/P1 issues.
