# Audit 37: Content Localization (books, stories, shows, poetry)

**Status:** 🔴 FAIL
**Date:** 2026-09-26

## 📊 Executive Summary

The ARB layer is healthy and guarded; the **content** layer underneath it was
never measured, so every non-English locale silently ships English prose - for
Mandarin Bean stories the translations exist but no code reads them, and Thai is
missing three catalogs outright.

---

## 🔍 Method

Content text does not live in `lib/l10n/*.arb`. It is one JSON file per locale
under `assets/data/l10n/`, with an English source of truth that the app falls
back to at runtime. Because the fallback is silent, a missing file or an
untranslated row is invisible: the user sees English and no test objects.

Three instruments were built:

| Instrument | What it does |
|---|---|
| `scratch/content_l10n_audit.py` | Pairs every locale file with its English base and reports, per locale: missing files, keys absent, values byte-identical to English, values still classified English by a script/stopword test. Also lists orphan assets and byte-identical file clusters. Writes `scratch/content_l10n_report.txt`. |
| `scratch/verify_content_l10n.py` | Field-level detail: per-locale English counts split by field, placeholder rows, English tails in chapter titles, `book_titles` rows identical to English. |
| `test/core/content_localization_guard_test.dart` | Four ratchets in the repo's own harness: locale coverage, placeholder markers, orphan families, and a Mandarin Bean ceiling. Verified to fail when a baseline is removed. |

The classifier is deliberately conservative (it under-reports "still English"), so
no figure below is inflated by false positives.

---

## 🚩 Findings (Prioritized)

### [P0 - Critical] - The Mandarin Bean overlays are translated but never read *(FIXED 2026-09-26)*

- **Evidence:** `assets/data/l10n/mandarin_bean_stories_<locale>.json` × 13 exist,
  but `loadLocalizedTitlesById` is called only with `'poetry'` and
  `'book_titles'` (`lib/features/media/data/story_fetcher_service.dart:496,499`,
  `lib/features/reading/data/repositories/book_repository.dart:63,102`). All 150
  titles are translated in every locale and **no code path could reach them**:
  `LibraryStory.localizedSummaries` is only ever populated for poetry, so
  `localizedSummary()` falls back to `summaryEn` on every screen.
  The only "reference" was a comment at
  `lib/features/media/presentation/screens/story_summary_screen.dart:111`
  promising a read that did not exist.
- **Impact:** Every reader of every language saw English story summaries and
  titles. 13 × 150 translated strings were dead weight in the bundle.
- **Remediation (shipped):** `StoryFetcherService._loadBeanOverlay` loads the
  overlay for both `title` and `summary`, keyed by the same `link` the story data
  carries, in its own `try`/`catch` (a missing locale file must degrade to English,
  never to an empty shelf) and memoised per process so the thirteen files are read
  once rather than on every shelf rebuild. Both loader blocks now pass
  `localizedTitles` / `localizedSummaries`. Pinned by
  `test/features/media/story_localization_wiring_test.dart`. The orphan rule in
  `test/core/content_localization_guard_test.dart` caught this in the first place
  and its allowlist is now one entry shorter.

### [P1 - High] - Mandarin Bean summaries are English inside the files *(FIXED 2026-09-27)*

- **Evidence (measured 2026-09-26; a sweep is live in another agent's tree, so
  re-run `scratch/content_l10n_audit.py` for the current figures):** at the time
  of the first measurement: 57 de · 139 fr · 142 es · 145 pt · 148 id · and a
  full 150/150 in hi, it, ja, ko, ru, th, vi — `ar` was the only completed sweep.
  By the end of this pass the same instrument read **0 de · 0 es · 0 it ·
  103 pt · 148 id**, and hi, ja, ko, ru, th, vi were still at 150/150. The
  ceilings in the guard test were tightened to those values.
- **Impact:** Even once the wiring above lands, most locales would still show
  English until the sweep finishes.
- **Remediation (shipped 2026-09-27):** `scratch/summaries_factory.py` finished
  the sweep in one pooled run - **841 summaries written** (hi 100, id 18, ja 100,
  ko 100, pt 73, ru 150, th 150, vi 150) plus the last `pt` straggler at batch 1,
  taking the family to **1,950/1,950, every locale at 150/150**. The runner pools
  credentials the way the app's "Scholar's Key Pool" does, because the first
  single-key attempt stalled outright when `GEMINI_API_KEY` started returning
  `429` and the old runner retried that silently. The guard ceilings were lowered
  from `hi 150 / id 148 / ja 150 / ko 150 / pt 103 / ru 150 / th 150 / vi 150` to
  **zero for all thirteen locales**, and `scratch/summaries_quality_check.py`
  confirmed 0 wrong-script values in ar/hi/ja/ko/ru/th and no truncated summary.
  Because the P0 wiring above landed first, this sweep reaches the shelf.

### [P1 - High] - Every locale covered only half the show synopses, and this audit scored the family 100% *(FIXED 2026-09-27)*

- **Evidence:** `shows_{loc}.json` held **56-67 rows** against the **128** keys in
  the generated `const Map<String, String> showSummaries`
  (`lib/features/media/data/repositories/show_summaries.dart`, produced by
  `tools/generate_show_summaries.py`): `id` 56, `it` 56, `ko` 67, `de` 60. Each
  locale covered a *different* subset, and the union of all twelve files was 108 -
  so twenty shows had no translation anywhere.
- **Impact:** `LocalizedCatalogService.getShowSummary` falls back to `fallbackEn`
  for any show without a row, so a German reader saw English for **68 of 128**
  shows, an Indonesian reader for 72. This is the largest user-visible
  localization gap found in this whole audit, and it shipped while the family read
  "TRANSLATED 100%".
- **Why the instrument missed it:** every rule in `content_l10n_audit.py` compares
  a locale file against the English *for the keys that file contains*. A file with
  60 keys and 60 translations therefore scores 100%, and **absence is never
  measured at all**. Coverage and correctness are different questions; only the
  second one was being asked.
- **Remediation (shipped 2026-09-27):** `scratch/catalog_factory.py --family shows
  --locale <loc>` reads the English key set out of `show_summaries.dart` and
  translates every missing row (**1,112 rows across 13 locales**, batch 8 because a
  four-sentence synopsis will not share a batch with a chapter name). Pinned by a
  new guard rule that reads the generated map rather than a hard-coded count, so
  it cannot drift from its source.

### [P1 - High] - Thai is missing three catalogs entirely *(FIXED 2026-09-27)*

- **Evidence:** `shows_th.json`, `channels_th.json` and `chapter_titles_th.json`
  do not exist. `LocalizedCatalogService` catches the load error, caches `{}` and
  returns `fallbackEn` - so Thai show summaries and channel description bullets
  are English; chapter titles degrade to the prefix-only path
  (`บทที่ N`) with an English name after it.
- **Impact:** A whole locale visibly falls out of the translation system.
- **Remediation:** Translate the 60 summaries, the 11 channel bullet lists and
  the 535 chapter titles; then delete the three entries from
  `_kKnownMissingLocaleFiles`.

### [P1 - High] - The Little Prince shows hard-coded English instead of translating *(FIXED 2026-09-26)*

- **Evidence:** `https://hanzi-master-books.web.app/the_little_prince.json` ships
  each sentence as `{chinese, pinyin, english}`. The reader branched on
  `sentence.english.isNotEmpty ? Text(sentence.english) : TranslatedText(...)`
  (`lib/features/reading/presentation/screens/book_reader_screen.dart:2093`), and
  the same ternary existed in the audiobook player (`:1785`). The field is
  populated in **4 of the 86 books** - `call_to_arms_luxun` 825/825,
  `dawn_blossoms_luxun` 703/703, `old_tales_retold` 533/533 and
  `the_little_prince` 179/179, 2,240 sentences in all; the other 82 books ship
  `english: ""` for all 651,184 sentences (measured by
  `scratch/book_english_coverage.py`). In those four the `TranslatedText` branch -
  the only path that consults the translator for the user's target language - was
  **unreachable**, and the Little Prince is one of them, which is why it was the
  report.
- **Impact:** A German or Japanese reader was handed the hard-coded English for
  every sentence of those four books, and the API the app already pays for was
  never asked. Because the two branches carried byte-identical styles, the ternary
  was pure dead weight.
- **Remediation (shipped):** `TranslatedText` gained `englishFallback`. When the
  target language **is** English it renders that string and spends no request;
  for every other target it is the in-flight placeholder and the Chinese is
  translated through the existing cached pipeline. Both reader sites collapsed to
  a single `TranslatedText` call. Pinned by
  `test/core/translated_text_english_fallback_test.dart`.

### [P2 - Minor] - A Hindi placeholder shipped as chapter title text *(FIXED 2026-09-26)*

- **Evidence:** Five rows in `chapter_titles_by_id_hi.json` read
  `"Hindi translation unavailable, using English: Chapter 40: ..."`.
- **Impact:** A translation-pipeline debug string was user-visible.
- **Remediation (shipped):** Chapters 40-44 of Journey to the West were translated
  into Hindi in the file's own convention (`अध्याय N: ...`, matching the 95
  neighbouring rows). **Produced in-house rather than by the translation
  pipeline, so a native reviewer should still read them** - but they are chapter
  titles about wood-element symbolism and a dragon prince, not prose. The
  placeholder allowlist in the guard test is now **empty**, and its staleness
  check keeps it that way.

### [P2 - Minor] - Orphan assets and a half-translated tail *(FIXED 2026-09-27)*

- **Evidence:** `idiom_stories_*.json` (6 files, byte-identical to each other,
  entirely English, no reader). `chapter_titles_<locale>.json` keeps English
  tails after a localized head in de/fr/id/it/ja/pt
  (`"Kapitel 10: Asteroid 325: The King Who Rules Solitude"`). `books_zh.json`
  and `shows_zh.json` serve a `zh` locale the app does not ship. `poetry_de.json`
  has 2 English titles; `radicals_de.json` 6 identical `name` values (mostly
  correct cognates such as *Person*, *Hand*, *Wind*; *Metal* should be *Metall*).
  `book_titles_<locale>.json` differences are all proper nouns
  (*Tao Te Ching*, *Zhuangzi*, *Les Misérables*) and are **correct as they are**.
- **Impact:** Bundle weight and review noise; the chapter-tail case is a visible
  half-English string.
- **Remediation (shipped 2026-09-27):** `idiom_stories_*`, `books_zh.json` and
  `shows_zh.json` were **deleted** (~490 KB; `zh` is not in
  `localizedContentLanguageCodes`, so nothing could load the latter two). The
  English tails were **379 rows across twelve locales**, not the six locales this
  entry names - the measurement was narrowed by a different key, and the real
  count is 31 rows per locale (38 in French). All repaired by
  `scratch/catalog_factory.py`, which translates the whole title rather than
  splicing a tail into the existing value; single-word tails that are correct in
  the target language (`Chapitre 1: Prologue`) are deliberately left. The 2 German
  poem titles were fixed (*Der Garten des Goldenen Tals*, *Die Gasse der
  schwarzen Gewänder*), and **`radicals_de.json` needed no change** - `钅` already
  reads `Metall`, and *Person*, *Hand*, *Wind*, *Gold* and *Jade* are correct
  German, so the parenthetical above was a false positive. The repair's first
  attempt corrupted 99 rows and is documented here as a lesson: see the
  `is_sane()` guard and the two new guard-test rules that now pin both the tail
  and the doubled prefix.

### [P2 - Minor] - A referenced asset does not exist, and one has a BOM *(FIXED 2026-09-27)*

- **Evidence:** `assets/data/mandarin_bean_stories_en.json` is requested from
  three sites (`story_fetcher_service.dart:460,566`,
  `lib/features/reading/presentation/providers/story_controller.dart:362`) and
  does not exist; each is wrapped in a bare `catch (_)` so the base file is
  always used and nobody notices. `assets/data/famous_chinese_poetry.json`
  starts with a UTF-8 BOM, which Dart's decoder tolerates but strict JSON
  parsers reject.
- **Impact:** Silent fallbacks hide intent; the BOM breaks tooling.
- **Remediation (shipped 2026-09-27):** the two `_en` lookups in
  `story_fetcher_service.dart` now read `mandarin_bean_stories.json` directly -
  that *is* the English base, and the `catch (_)` was hiding a `FileNotFoundError`
  on every call. (`story_controller.dart` no longer has one.) The BOM was
  stripped by the new `scratch/strip_json_bom.py`, which also found **a second
  BOM'd asset this entry missed: `assets/data/poet_bios.json`**. The defect is not
  theoretical - a survey script crashed on the file in this very session, with a
  plain `utf-8` reader, which is exactly the "breaks tooling" impact claimed
  above. Zero BOM'd JSON now remains under `assets/data`.

---

## ⚖️ Documentation Sync

- **GEMINI.md Update Required?** No - the mandate already covers this.
- **ROADMAP.MD Updated?** No.
- **Bugs.md Entry Created?** Yes - `ISSUES.md`, 2026-09-26.

## 🧪 Verification

- `flutter analyze lib` → **No issues found**.
- `test/core/translated_text_english_fallback_test.dart` **4/4**; each ratchet in
  `test/core/content_localization_guard_test.dart` **4/4**, re-run with one
  allowlist entry removed to confirm it fails.
- `test/features/reading` **87/87**; `test/unit_tests/definition_translation_test.dart`
  and the guard suites **20/20**.
- `test/features/media` retains 4 pre-existing failures owned by another agent
  (three in `cultural_context_book_parity_test.dart`, one `NotoSerifSC`
  typography assertion in `simplified_reader_prose_test.dart`); neither file
  references any file changed here.

## 🔜 Not Done In This Step

- ~~The remaining sweeps (Thai catalogs, the bean summaries, the five Hindi rows,
  the chapter-name tails)~~ - **all four landed.** The bean summaries finished on
  2026-09-27 (`scratch/summaries_factory.py`, 1,950/1,950), and the Thai catalogs
  plus the chapter-name tails the same day (`scratch/catalog_factory.py`, 914 +
  377 rows). The five Hindi rows were already clean when this pass ended.
- `lib/features/reading/presentation/screens/story_reader_screen.dart:896`
  prints `sentence.english` for stories with no translation path at all; it was
  left alone because it is a different entity and its own suites pin it. It is
  the same class of defect and should follow the reader. **Still open.**
- **Found after this pass, and fixed:** the `shows` family was scored against the
  keys each file happened to hold, so it read "TRANSLATED 100%" while every locale
  covered only 56-67 of the 128 synopses in `show_summaries.dart` - see the P1
  entry above. The lesson for this instrument is that **coverage and correctness
  are different questions**, and only the first was being asked here.
