# Audit 39: The Shadowing Rating

**Status:** 🔴 FAIL → findings F1-F6 all FIXED 2026-09-26
**Date:** 2026-09-26

## 📊 Executive Summary

The shadowing screen's rating was reporting a shaped story rather than a
measurement: it *invented* the tone you were told you used, let you skip half the
phrase and still score 100/100, graded you against a pronunciation reference the
screen never showed you, and mis-aligned that reference after any multi-character
word.

---

## 🔍 What "the rating" is

Four surfaces, all fed by `GeminiService.gradeAudio` (Azure Pronunciation
Assessment):

| Surface | Code |
|---|---|
| The big `Score: X/100` card + verdict text | `shadowing_studio_screen.dart:2163-2200` |
| Per-character pills with an accuracy % and colour band | `:2220-2525` |
| Per-syllable phoneme pills | `:2443-2525` |
| The **"Compare 4 tones"** sheet (the "Tone Accuracy" pillar) | `:2481-2488`, `:2600-2624` |

The convention this audit relies on - **`actualTone == 0` means "not measured"** -
was already established in the codebase before it: `CalligraphicPitchContour`
skips the comparison trace when `actualTone == null || <= 0`
(`calligraphic_pitch_contour.dart:74-75`) and `SpeakingFeedbackPanel` drops the
tone verdict with the comment *"there is nothing honest to plot … rather than
inventing a tone the learner never said"*
(`speaking_feedback_panel.dart:201-211`). Two places violated it.

---

## 🚩 Findings

### [P1 - High] - F1: the tone comparison was fabricated from the accuracy score *(FIXED)*

- **Evidence:** `actualTone: acc >= 80 ? tone : (tone % 4 + 1)` in both
  `ToneComparisonSheet.show` call sites in the shadowing screen (`:2486`, `:2605`),
  and `actualTone: isCorrect ? expected : actual` in the onboarding mini lesson
  (`onboarding_mini_lesson_screen.dart:1375`).
- **Impact:** A learner who produced the tone perfectly but slurred the vowel
  (accuracy 70) was told they used the **wrong tone** - a specific, invented
  claim. One who used the wrong tone clearly (accuracy 85) was told the tone was
  fine. The "Tone Accuracy" pillar was not measuring tone.
- **Fix:** both shadowing call sites and the onboarding call site now pass the
  grader's tone through; `0` means "not measured"; `ToneComparisonSheet` gained a
  `toneMeasured` guard so an unmeasured tone renders an em dash in a muted colour
  instead of a tone name in the "wrong" amber (0 previously fell through to
  *neutral tone*, which read as a verdict). A source ratchet now refuses both
  shapes.

### [P1 - High] - F2: the grader overwrote a real tone to force a mismatch *(FIXED)*

- **Evidence:** `gemini_service.dart:2624-2626` and `:2672-2674`:
  `if (!isCorrect && actTone == expTone) actTone = expTone == 4 ? 2 : (expTone % 4 + 1);`
  with the comment *"reflect tone discrepancy so downstream diagnostics and
  comparisons do not falsely claim actualTone matches expectedTone"*.
- **Impact:** Whenever a word was graded incorrect, a **genuinely matching** tone
  was replaced with a wrong one - data falsified to satisfy the UI. Azure never
  reports the tone that was heard (only a reference syllable and an `ErrorType`),
  so the fabricated value was indistinguishable from a measurement to every
  consumer.
- **Fix:** removed both overrides. `actualTone` is now the reference tone when
  Azure graded the word error-free (real evidence) and `0` otherwise. The test
  that pinned the old behaviour (`onboarding_pronunciation_rating_test.dart`,
  "calibrates tone divergence on mispronunciation", asserting `actualTone == 2`
  for `战` whose Azure syllable is the tone-less `zhan`) was corrected and renamed.

### [P1 - High] - F3: omitting words cost nothing *(FIXED)*

- **Evidence:** the grader accumulated only *evaluated* words -
  `if (!isOmitted && wErrorType != 'Insertion') { totalAccuracy += wAccuracy; evaluatedWords++; }`
  - and then used `fairScore = (totalAccuracy / evaluatedWords).round()`. Azure's
  `CompletenessScore` was computed, returned, and never used for the score, nor
  shown anywhere in the shadowing screen.
- **Impact:** **Saying 3 of 8 words perfectly and omitting 5 scored 100/100** with
  *"Perfect pronunciation! Sounds like a native speaker."* For a shadowing drill,
  completeness is the exercise.
- **Fix:** omissions now count in the denominator (an omitted word has accuracy
  0), so the mean is the completeness penalty the old denominator discarded.
  Insertions stay excluded deliberately - they are not in the reference, so
  counting them would double-penalise one mistake.

### [P1 - High] - F4: the expected reading ignored the pinyin on screen *(FIXED)*

- **Evidence:** both branches derived the reference from
  `PinyinHelper.getPinyinE(...)` **per character** (`:2604`, `:2648`), and the
  caller-supplied `expectedPinyin` was only a fallback for when that returned
  empty - which for Hanzi never happens.
- **Impact:** every 多音字 was graded against `lpinyin`'s context-free default, so a
  learner who read the sentence exactly as displayed could be marked wrong.
- **Fix:** precedence is now the caller's `expectedPinyin`, then Azure's own
  syllable, then the per-character lookup.

### [P2 - Medium] - F5: the expected-pinyin index drifted *(FIXED)*

- **Evidence:** `pinyinIndex++` ran once per word (`:2698`) while a
  multi-character word consumes two or more syllables and never read
  `expectedPinyinWords`; the index therefore fell behind by `chars − 1` after
  every such word.
- **Impact:** latent - masked by F4 making the lookup unreachable, which is
  exactly why F5 had to be fixed **before** F4 or the two together would have
  started mis-aligning pinyin.
- **Fix:** the index advances by the number of Hanzi consumed (0 for a token with
  no Hanzi), and non-Hanzi tokens no longer borrow a neighbouring syllable.

### [P2 - Medium] - F6: the tone card overflowed by 46px on a mismatch *(FIXED)*

- **Evidence:** `_buildToneCard` - `Row(pinyin, 8, badge)` with no flexible child.
  Found by the new mismatch test; reproduced at 430px in French. Pre-existing: the
  match path only ever drew one badge and hid it.
- **Impact:** `A RenderFlex overflowed by 46 pixels on the right` on exactly the
  screen a learner sees after a mistake, in every expansion locale.
- **Fix:** `Flexible` + `maxLines: 1` + `TextOverflow.ellipsis` on the pinyin - the
  degradation the locale guard asks for.

### [P3 - Minor] - Not fixed, recorded

- The onboarding mini lesson's **Four Tones** step drives its demo from a hardcoded
  sample (`onboarding_mini_lesson_screen.dart:400-431`) containing
  `expectedTone: 4, actualTone: 2`. It is scripted tutorial data rather than a
  measurement, so it was left alone - but it teaches the same "mispronounced means
  this specific wrong tone" fiction and deserves a product decision.
- Error strings in the shadowing screen remain hardcoded English
  (`:426, 444, 461, 474, 518-520`).
- `_getLocalizedOverallFeedback` (`:2139-2149`) switches on the grader's **exact
  English sentences**, so rewording one silently drops localization to English.
- A missing phoneme accuracy is treated as **100** (`:2599`).
- `_userPitch`/`_idealPitch` and the pitch graph are commented out ("hidden for V1
  MVP as requested by user"), so no real contour exists to derive a genuine heard
  tone from. That is the only route to a *measured* tone verdict; the code now
  says "not measured" instead of guessing.

---

## ⚖️ Documentation Sync

- **GEMINI.md Update Required?** No.
- **ROADMAP.MD Updated?** No.
- **Bugs.md Entry Created?** Yes - `ISSUES.md`, 2026-09-26.

## 🧪 Verification

- `test/core/services/pronunciation_grader_test.dart` (**new, 8 tests**) drives the
  real grader with a stub `http.Client` (the service already accepted one) and a
  canned Azure payload: F2 (a fabricated wrong tone fails; a verified match
  passes; no value is ever neither `0` nor the reference), F3 (a half-omitted take
  scores < 60; a complete take still scores 100), F4 (`长` graded as `zhǎng` =
  third tone), F5 (`吗` after `你好` keeps `ma` and neutral tone), and the F1
  source ratchet.
- **Each fix was probed by reverting it:** F3 fails without the omission change,
  F4 fails without the authored-pinyin preference, F5 fails with `pinyinIndex++`.
- `test/features/echo_hall/tone_comparison_sheet_test.dart` **+2** tests: an
  unmeasured tone renders `—`; a measured mismatch still renders.
- `onboarding_pronunciation_rating_test.dart` **2/2** after correcting the
  expectation its own name encoded.
- `flutter analyze lib` → **No issues found**.
- `test/features/onboarding` + `test/features/live_translate` +
  `test/features/echo_hall` **107/107**; `test/features/flashcards` **146/146**;
  `test/core/locale_layout_guard_test.dart` + `test/core/motion_guard_test.dart`
  **16/16**.

## 🔜 Not Done In This Step

- No tone verdict can be *measured* until the pitch contour is reinstated or Azure
  returns a recognized tone. The honest state today is "not measured", and that is
  what ships.
- The three other `gradeAudio` consumers (live call, echo hall roleplay, flashcards
  speaking mode) inherit the corrected score, so their numbers move on takes that
  omit words. Their suites pass unchanged, but the change is user-visible and worth
  a release note.
