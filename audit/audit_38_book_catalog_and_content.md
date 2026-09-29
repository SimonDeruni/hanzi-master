# Audit 38: Book Catalog And Remote Book Content

**Status:** 🔴 FAIL
**Date:** 2026-09-26

## 📊 Executive Summary

All 86 books download; the **catalog's chapter counts disagree with 67 of them**
(sometimes by 360 chapters, surfacing as *"Chapter 200 of 15"*), and roughly 30
books carry source-text corruption - pirate-site watermarks, full-width English
where Chinese should be, and in one case another book's Project Gutenberg header.

---

## 🔍 Method

`grand_library_catalog.json` lists the books; the content is fetched at runtime
from `https://hanzi-master-books.web.app/<id>.json` and validated by
`BookDownloadService._decodeAndValidate`. The audit mirrors that validation and
adds the checks it cannot make:

| Instrument | What it does |
|---|---|
| `scratch/book_content_audit.py` | Fetches all 86 files (6 workers) and reports: `missing` (HTTP != 200), `badjson`, `chaptercount` (host vs catalog `totalChapters`), `indexgap` (`chapterIndex` not exactly 1..N), `badchapter` (the fields `_decodeAndValidate` rejects), `emptyfield`, and `nonhanzi` (a `chinese` value with no Hanzi). Report in `scratch/book_content_report.txt`. |
| `scratch/book_english_coverage.py` | Which books ship a bundled `english` per sentence, and samples of the bad `chinese` / empty `pinyin` rows. Report in `scratch/book_english_coverage.txt`. |
| `scratch/sync_book_chapter_counts.py` | Re-derives `totalChapters` from the host, line by line (not a re-serialisation, so the diff is only the changed lines). Dry-run by default. |

---

## 🚩 Findings (Prioritized)

### [P1 - High] - `totalChapters` was wrong for 67 of 86 books *(FIXED 2026-09-26)*

- **Evidence:** 54 entries claimed exactly **15** (a placeholder from an earlier
  build) and 11 claimed **12**; `dream_of_red_chamber` claimed 121 against the
  canonical 120. Host-vs-catalog deltas ran from `macbeth_shakespeare` (15 → 6)
  to `count_of_monte_cristo` (**15 → 381**) and `sherlock_holmes` (15 → 111).
- **Impact:** `totalChapters` is what the UI shows *before* download, so
  `l10n.chapterXOfY` ("Chapter {current} of {total}") rendered
  **"Chapter 200 of 15"** on the continue-reading card
  (`continue_reading_card.dart:67`) and against reading-room bookmarks
  (`reading_room_screen.dart:443`); the cover caption
  `'${book.totalChapters} 回'` (`calligraphic_book_cover.dart:284`) announced
  "15 回" for a 381-chapter novel; the detail screen printed "15 Chapters"
  (`book_detail_screen.dart:244`), a "Table of Contents (15)" header (`:611`) and
  a "download 15 chapters" prompt (`:624`). The *downloaded* screen uses
  `chapters.length`, so the number visibly changed from 15 to 381 once the book
  arrived.
- **Remediation (shipped):** `scratch/sync_book_chapter_counts.py --write`
  re-derived all 67 values from the host - the chapters the reader actually
  receives. Diff: **67 insertions / 67 deletions**, nothing else touched.
  Re-running `scratch/book_content_audit.py` now reports **zero** `chaptercount`
  mismatches.

### [P1 - High] - Source-text corruption in the `chinese` field of ~30 books *(watermarks FIXED 2026-09-26)*

- **Evidence** (samples from `scratch/book_english_coverage.txt`; full cleanup
  report in `scratch/book_watermark_report.txt`):
  - **Pirate-site watermarks inside the prose**, e.g. `ＷＷw.xiＡosＨuotxt.ＣＯＭ`
    (`macbeth_shakespeare`, `rickshaw_boy`),
    `w w w. xiao shuotxt. co m` (`the_family_bajin`, `spring_bajin`,
    `faust_goethe`), `wＷw．xiＡoshＵotxt.cＯm` (`moby_dick_melville`,
    `black_cat_poe`), `xiaoshuo txt.coＭ`, and `bookcover` (`jane_eyre`) -
    28 books in all.
  - **Full-width English masquerading as Chinese**: `dawn_blossoms_luxun`
    `"Ｉｓ ｉｔ ａ ｒａｔ?"`, `teahouse_laoshe` `Ａｌｌ　ｒｉｇｈｔ？`,
    `wandering_luxun` `"Ｍｙ　ｄｅａｒ，ｐｌｅａｓｅ."`.
  - **Non-Chinese European fragments**: `war_and_peace` (French),
    `crime_and_punishment` (`"ich danke①！」`), `fortress_besieged`
    (`"ola，la！"`), `les_miserables`, `walden_thoreau` (Latin),
    `the_decameron` (`1980．8．18`), `sherlock_holmes` (`Ｓ.Ｈ．`),
    `picture_dorian_gray` (`The Preface`).
  - **Another title's Project Gutenberg header inside `romance_sui_tang`**:
    `"The Project Gutenberg eBook of The Great K. & A. Robbery, by Paul Leic…"`.
    A data mix-up, not just noise. **Not fixable by regex - the wrong text has to
    be replaced from a correct source.**
  - **Layout / OCR debris**: `steppenwolf_hesse` box-drawing (`└───┘┌──┐`),
    `the_mysterious_island` a rule of dashes, `frankenstein_shelley` a
    private-use glyph (`” \ue0bc`), and quote-only lines in `border_town`,
    `autumn_bajin`, `boule_de_suif`, `twenty_thousand_leagues`,
    `the_metamorphosis`, `death_in_venice`.
  - `animal_farm`'s first "sentence" is `《》目录 第一章` - the table-of-contents
    marker is glued onto the prose, with an empty `《》` pair rendering as text.
- **Impact:** The reader displayed the watermarks, the TTS read them aloud, and
  tapping one did a dictionary lookup that could not resolve. `nonhanzi` counts
  ran to 60 (`anna_karenina`), 57 (`war_and_peace`) and 53 (`fathers_and_sons`).
- **Remediation (watermarks shipped):** `scratch/clean_book_watermarks.py`
  removes them. The shapes are one string spelled a dozen ways, so the matcher
  builds a fuzzy phrase from the letters - a tolerant separator between every
  letter (spaces, full-width spaces, `.`, `．`, `。`, `·`, `,`) and each ASCII
  letter also matching its full-width form - and it needs separators *between*
  words as well as inside them (missing that made the first version silently
  match nothing, 20 rows instead of 264). NFKC normalisation was rejected: it
  would fold the Chinese punctuation too. Result: **28 books, 229 junk rows
  dropped, 35 rows repaired** - where the watermark shared a sentence with real
  prose the prose is *recovered* (`家06`, `春4`, `悲剧 第一部 书序` were glued to
  their watermark). The unused `pinyin` column was cleaned in the same pass.
  Row-dropping is structural, so the files are re-serialised - safe here because
  `json.dumps(data, indent=2, ensure_ascii=False)` reproduces these files byte for
  byte (`scratch/_roundtrip_check.py`). Diff: **35 insertions / 1180 deletions**
  across 28 files. Pinned by the watermark rule in the guard test.
- **Remediation (still open):** the wrong-book Gutenberg header, the full-width
  English and the European fragments need a better source, not a regex.
  **And the host still serves the old files** - the cleanup has to be re-uploaded
  to `hanzi-master-books.web.app` before a reader sees any of it.

### [Not a bug - WITHDRAWN 2026-09-26] - `dream_of_red_chamber`'s 265 "missing" pinyin rows are never displayed

- **Originally reported as:** P2 - the only book in the corpus with empty `pinyin`
  on **265** of its 35,399 sentences (its first sentence is `第一回也。` with
  `pinyin: ""`), so the reader's pinyin line and ruby layout would render blank.
- **What the code actually does:** both readers build their ruby tokens from the
  **Chinese**, not from the file - `_getRubyTokens(sentence.chinese)` calls
  `PinyinHelper.getPinyinE(chinese, separator: ' ', format: PinyinFormat.WITH_TONE_MARK)`
  (`book_reader_screen.dart:61-70`, `audiobook_player_screen.dart:365-403`).
  A search for `sentence.pinyin` across both screens returns **0** consumers.
- **Consequence:** the 265 empty values have **no user-visible effect**; the
  reader already renders the correct pinyin for those rows from `lpinyin`.
  Nothing was changed, and a 265-value rewrite was deliberately *not* shipped -
  it would have introduced a second reading convention into the data (see below)
  for zero visible gain.
- **Wider finding:** the whole `pinyin` column - 653,424 values across the 86
  books - is **unused at render time**. It is not the largest part of the 176.6 MB
  corpus, but it is dead weight, and it is the reason `scratch/fill_book_pinyin.py`
  was abandoned after its validator showed it could only reproduce the file's own
  convention 56% of the time.
- **Why the 56% mattered:** the validator regenerated pinyin for the 34,944
  single-line rows that already had it and compared. The mismatches were all
  *dictionary disagreements*, not formatting: the file writes `一` as `yī` even
  before a third tone (`yī diǎn`) and `bú` never appears at all across 35k rows,
  so the source pipeline applied **no 一/不 sandhi**, while pypinyin does; and
  pypinyin reads `弟子` as `dì zi` where the file has `dì zǐ`. Formatting *was*
  reproducible (one token per character, punctuation as its own token - `：“`
  becomes `： “`). Shipping pypinyin output for the 265 rows would therefore have
  put ~2-3% of syllables at odds with the book's own, unverifiable-without-a-native
  convention. Since the field is not rendered, the honest answer is to leave it.
  The analysis is kept in `scratch/probe_pinyin_style.py` for whoever maintains
  the content pipeline.

### [P2 - Minor] - The sync lowered 12 over-promised counts, and three books look
truncated on the host

- **Evidence:** For 12 books the catalog over-promised (`the_great_gatsby`
  15 → 9, `crime_and_punishment` 15 → 8, `call_of_the_wild` 15 → 9); the sync
  lowered them to what is actually downloadable.
- **Impact:** None now - recorded because it changes displayed numbers and a
  reviewer will see the diff.
- **Remediation:** None for the sync. But `nineteen_eighty_four` (6),
  `macbeth_shakespeare` (6) and `guiguzi` (6) are small enough to suspect the
  **host** content is truncated rather than the catalog being wrong - worth a
  content-team check.

### [P2 - Minor] - 176.6 MB of book JSON is committed to git but never reaches the app

- **Evidence:** `assets/data/books/` holds **86 files / 176.6 MB** (`git ls-files`
  tracks all of them; `anna_karenina.json` alone is 6.5 MB,
  `autumn_bajin.json` 3.9 MB). A previous build proves Flutter does **not**
  bundle it: `build/flutter_assets/assets/data/` contains `l10n/` and the
  top-level assets but **no `books/`** - the `assets/data/` declaration in
  `pubspec.yaml` is not recursive, which is why `assets/data/l10n/` has to be
  listed separately. Nothing in `lib/` reads the directory either (the only
  `books/` matches are `assets/images/books/`).
- **Impact:** ~177 MB in every clone, CI checkout and reviewer's diff for a
  directory the app never loads. It is also inconsistent with
  `assets/data/dictionary.db` (195 MB, correctly in `.gitignore`, and shipped as
  a declared asset instead). The copies are byte-identical in shape to the host
  (checked: `the_little_prince` 27/179/179, `animal_farm` 21/1642/0,
  `count_of_monte_cristo` 381/30473/0), so it is a redundant master copy rather
  than divergent content.
- **What still uses it:** only
  `test/unit_tests/grand_library_catalog_test.dart` (an existence check across
  all 86) and `scratch/build_font_subset.py`, whose stated purpose is to collect
  "every hanzi in `assets/data/books/*.json` - the reading room" for a font
  subset - and the app deliberately ships **no** custom font right now (see the
  `pubspec.yaml` comment), so that input is currently moot.
- **Remediation:** Decide the owner of this corpus. If the host is the source of
  truth, drop the directory from git (keep it as a build input via a fetch step,
  the way `dictionary.db` and the upstream Noto font are handled) and rewrite the
  one test to check the host or a small fixture. Do not delete it blind: the
  font-subset path and any future offline-book feature would want it.

---

## ⚖️ Documentation Sync

- **GEMINI.md Update Required?** No.
- **ROADMAP.MD Updated?** No.
- **Bugs.md Entry Created?** Yes - `ISSUES.md`, 2026-09-26.

## 🧪 Verification

- `scratch/book_content_audit.py` after the chapter-count sync: **86/86
  reachable**, **zero** `chaptercount` and **zero** `indexgap` findings.
- `scratch/clean_book_watermarks.py` re-run reports **0 books touched**, and a
  full re-scan of every `chinese` **and** `pinyin` field reports **no residual
  watermark**; all 86 files still parse.
- `scratch/_roundtrip_check.py`: `json.dumps(..., indent=2, ensure_ascii=False)`
  reproduces a book file **byte for byte**, which is what made the structural
  cleanup safe.
- `test/unit_tests/grand_library_catalog_test.dart` + `test/features/reading`
  **91/91**; `test/core/content_localization_guard_test.dart` **5/5** (the
  watermark rule scans 176 MB in ~8s); `flutter analyze lib` → 0 issues.
- The catalog diff is `67 insertions / 67 deletions`; the watermark diff is
  `35 insertions / 1180 deletions` across 28 files (`git diff --numstat`).

## 🔜 Not Done In This Step

- **Re-uploading the cleaned corpus.** The host is unchanged, so no reader sees
  the chapter-count fix or the watermark removal until
  `https://hanzi-master-books.web.app` is refreshed - the repo now leads the host.
- The wrong-book Gutenberg header in `romance_sui_tang`, the full-width English in
  the Lu Xun / Lao She books, the European fragments and the layout debris: a
  regex cannot invent the missing prose.
- Thai's three missing catalogs (`shows_th.json`, `channels_th.json`,
  `chapter_titles_th.json`) - recorded in audit 37, still on the allowlist.
- The `assets/data/books/` git-tracking decision (below).

## 🔗 Related

- Audit 37 (`audit/audit_37_content_localization.md`): the reader used to print
  the bundled English verbatim. **Correction:** that branch was unreachable in
  the **4 of 86 books that ship an `english` field** - measured by
  `scratch/book_english_coverage.py` - not in every book, as audit 37 first
  stated. The fix is unchanged and the Little Prince is one of the four.
