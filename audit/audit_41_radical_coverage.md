# Audit 41: Radical Coverage

**Status:** 🟡 AVG — the anatomy defect is fixed in this session; two P2s remain open
**Date:** 2026-10-02
**Trigger:** user report — *"I think there are issues for many words where we
actually do not have the right radicals available."* Confirmed, and worse than
reported.

---

## 📊 Executive Summary

The app ships **two** radical sources and treated the smaller, curated one as the
source of truth. `assets/data/radicals.json` is 71 radicals with a name, a meaning
and a mnemonic in 13 locales; `assets/data/hanzi_metadata.json` assigns a radical
to each of the **9574** characters it covers. The character sheet used the catalog
as a **veto**, so **39.6% of the assigned radicals were silently dropped** and
**4.7% of the HSK vocabulary (122 characters) rendered no anatomy at all**. The
data was never the problem — the filter was. The sheet now *enriches* through the
catalog instead of gating on it.

---

## 🚩 Findings (Prioritized)

### [P1 - High] The anatomy section vetoed radicals the catalog does not carry

- **Evidence:**
  - `lib/features/flashcards/presentation/screens/character_detail_screen.dart:257`
    — `if (primaryRadical != null && radicalData.containsKey(primaryRadical))`
  - `…:279` — `if (radicalData.containsKey(comp))` around the component list
  - measured by `scratch/radical_audit.dart` (raw output kept beside it)
- **Measurements** (source: the metadata the app itself ships):

  | Measurement | Value |
  |---|---|
  | Characters with an assigned radical | 9574 / 9574 |
  | …whose radical is **absent from the catalog** | **3795 (39.6%)** |
  | Distinct radicals missing from the catalog | **224** |
  | HSK vocabulary covered | 4862 words, 2595 distinct characters |
  | HSK characters that rendered **no anatomy at all** | **122 (4.7%)** |
  | HSK characters that rendered **fewer components than known** | **1993 (76.8%)** |

  - Worst offenders by affected characters: `虫` 197, `⺼` 177, `阝` 160, `言` 155,
    `⺮` 150, `釒` 135, `疒` 127, `糹` 126, `王` 104, `犭` 88, `鱼` 79, `鳥` 78,
    `鸟` 72, `酉` 67, `魚` 63, `貝` 62, `马` 54, `米` 50, `車` 49, `馬` 47, `穴` 46,
    `頁` 45, `飠` 44, `礻` 43, `門` 42, `页` 39, `攵` 36, `舟` 35 …
  - Characters that showed **nothing**: `出 对 非 公 鸡 几 乎 面 角 每 牛 外 么 色
    羊 也 已 包 单 了 冬 物 段 多 而 发 久 礼 鸟 爬 网 声 双 书 般 用 又 片 己 士 …`
  - The truncation is not only about missing radicals: `好` showed `女` alone,
    because `子` is not among the 71 either.
- **Impact:** the one feature whose job is to teach how a character is built was
  blank or incomplete for a large share of the vocabulary — and worst for exactly
  the characters a beginner meets first. It also contradicted the rest of the app:
  `radical_detail_screen.dart:52-74` already scans `hanzi_metadata.json` for
  `data['radical'] == radicalChar`, i.e. the metadata was always the intended
  source of truth.
- **Remediation (applied):** one helper, `describeComponent(char)` — the curated
  entry when the catalog has one (name + meaning + mnemonic, translated per
  locale), otherwise the metadata's own `definition` — and both veto sites now ask
  `describesComponent(...)`.

### [P2 - Minor] The radicals index is the same curated subset

- **Evidence:** `lib/core/services/localized_catalog_service.dart:214-264`
  (`getRadicals` returns the 71), consumed by
  `radical_library_screen.dart:52` and `dictionary_screen.dart:906`.
- **Impact:** a learner cannot browse or search `米`, `虫`, `阝`, `⺼`, `穴`, `舟`,
  `酉`, `隹` — the index silently presents 71 radicals as *the* set of radicals.
- **Remediation (not applied):** build the index from the metadata's distinct
  radicals ∪ the catalog keys, and reuse the identical enrichment (catalog for the
  mnemonic, metadata `definition` otherwise). Needs a decision on product scope,
  so it is left to a follow-up.

### [P2 - Minor] The course's radical sheet has no name fallback

- **Evidence:** `lib/features/course/presentation/widgets/radical_detail_sheet.dart:56`
  — `if (radicalsDb.containsKey(widget.sunNode.hanzi))`; otherwise `_radicalInfo`
  stays null and the sheet renders the character with no name or meaning.
- **Impact:** low (the course's lesson nodes are curated), but it is the same
  assumption that produced the P1.
- **Remediation (not applied):** fall back to the metadata definition, exactly as
  `radical_detail_screen.dart` already does.

---

## ✅ Corrective Actions Taken

| # | Action | Evidence |
|---|--------|----------|
| 1 | `describeComponent()` — catalog entry if present, else the metadata definition | `character_detail_screen.dart:243-276` |
| 2 | Primary radical no longer gated by the catalog (`describesComponent`) | `character_detail_screen.dart:291-297` |
| 3 | Component list no longer filtered by the catalog | `character_detail_screen.dart:312-327` |
| 4 | Regression test: every assignable radical is nameable, no HSK character resolves to nothing, and the screen no longer vetoes | `test/unit_tests/radical_coverage_test.dart` (5 tests) |
| 5 | Re-runnable before/after audit | `scratch/radical_audit.dart` |

**Re-audit (post-fix):**
- `flutter analyze` → **No issues found**.
- `flutter test test/unit_tests/radical_coverage_test.dart test/unit_tests/radical_localization_catalog_test.dart`
  → **6/6 pass**.
- Anatomy coverage after the fix: **122/122** previously-empty HSK characters now
  show a component (the metadata describes **224/224** of the radicals the catalog
  lacks), and 1993 characters show a more complete decomposition.

---

## 🔎 Method note

The audit **replicates the screen's own algorithm** rather than inspecting the data
at face value, because the defect was a filtering bug: the data was already
complete. Two false leads were closed in the process:

1. **Not a data gap.** `metadata` has no duplicate top-level keys (9574 raw = 9574
   distinct) and all 13 locales carry all 71 catalog entries — translations and the
   metadata were both intact. (PowerShell refuses to parse the file, reporting a
   duplicate key; that is a mojibake artefact of its console decoding, not a data
   error. Dart decodes it cleanly.)
2. **Not the dictionary.** `assets/data/dictionary.db` (`words`,
   `dictionary_metadata`) carries no radical column — no `row['radical']` anywhere
   in `lib/` — so the metadata really is the only assignment source.

`assets/data/radicals.json` is therefore best documented as **the curated showcase**
(name + meaning + mnemonic, localized) and `hanzi_metadata.json` as **the
assignment table**. Any future code that needs "the radical of X" must ask the
metadata; the catalog is only ever an enrichment.

## ⚖️ Documentation Sync

- **GEMINI.md Update Required?** No
- **ROADMAP.MD Updated?** No
- **Bugs.md / ISSUES.md Entry Created?** No — the P1 was remediated in-session; the
  two P2s are scoped follow-ups, not defects left broken.
