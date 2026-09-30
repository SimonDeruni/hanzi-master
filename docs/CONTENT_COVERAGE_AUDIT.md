# Content Coverage Audit — Books and Poetry

**Date:** 2026-09-27
**Question answered:** for every book and poem the UI can reach, does it have a
synopsis, an author/poet biography, and are those translated?

Every number below was **measured from the shipped assets**, not estimated. The
commands are in [How these numbers were produced](#how-these-numbers-were-produced).

---

## Verdict in one table

| Content | Synopsis | Author biography | Translated |
|---|---|---|---|
| **100 poet collections** (poetry as books) | ✅ — the poet's biography | ✅ 100 / 100 | ✅ all 14 locales |
| **100 catalogued books** (prose) | ⚠️ **22 / 100** | ⚠️ **19 / 85 authors** | ⚠️ **22 / 100** |

**Poetry is done. Books are the gap.** That is the whole finding.

---

## What the UI actually renders

A field only matters if a screen reads it. These are the real resolution chains:

| Surface | Reads | Falls back to | When nothing exists |
|---|---|---|---|
| Book detail — synopsis | `books_<locale>` | `book.descriptionEn`, then `book.description` | **blank section** |
| Book detail — author | `author_bios_<locale>` via `BundledAuthorBiographyService` | `author_bios_en` | **section omitted** (service returns `null`) |
| Book card — title | `book_titles_<locale>` | `book.titleEn`, then `book.title` | English/Chinese title |
| Chapter list — titles | `chapter_titles_by_id_<locale>` | `chapter.titleEn`, then `chapter.title` | untranslated title |
| Poet card | the poet's name | — (a proper noun needs no translation) | — |
| Poet book detail — synopsis | `poet_bios_<locale>` | `poet_bios.json` (Chinese) | — |

---

## 1. Poetry — complete, no work needed

| Item | Coverage |
|---|---|
| Poet biographies, Chinese (`poet_bios.json`) | **100 / 100** |
| Poet biographies, translated (`poet_bios_<locale>`) | **100 / 100 in all 14 locales** |
| Poet-collection synopsis | = the biography, so **100 / 100 in all 14 locales** |
| Poem titles, Chinese + English | **4,237 / 4,237** |
| Poem titles, translated (`poetry_<locale>`) | **4,237 / 4,237 in all 13 locales** |

Because a poet's collection takes its synopsis from the poet's biography, **every
poet book has a translated synopsis today**. The one gap is poem-level and not a
translation problem:

| Item | Coverage | Note |
|---|---|---|
| Poem summaries (`summary`, `summary_en`) | **100 / 4,237** | the 100 featured poems only — **there is no Chinese source for the other 4,137**, so nothing is untranslated, just unsourced |
| Poem summaries, translated | 100 non-empty, 4,137 deliberately empty | matches the source exactly |

**So: nothing in the poetry section is missing a translation.** The 4,137 poems
have titles in every language and no synopsis in any — consistently, because none
was ever written in Chinese.

---

## 2. Books — the gap

### 2a. Synopses: 78 of 100 missing, in every language

| Item | Have | Missing |
|---|---|---|
| Chinese synopsis (`catalog.description`) | 22 | **78** |
| English synopsis (`catalog.descriptionEn`) | 22 | **78** |
| Translated synopsis (`books_<locale>`) | 22 × 13 | **78 × 13 = 1,014** |
| Translated title (`book_titles_<locale>`) | 22 × 13 | **78 × 13 = 1,014** |

The 78 are the imports from Project Gutenberg and chinese-poetry. Their catalogue
rows carry `title`, `titleEn`, `author`, `category`, `dynastyOrEra`, `hskLevel`
and `tags` — but `description` and `descriptionEn` are empty strings. The
catalogue has no `authorBio` field at all, so author text lives only in
`author_bios_<locale>`.

**User-visible effect:** open any of those 78 books and the detail screen shows no
synopsis at all. The imported books are 78% of the library.

### 2b. Author biographies: 66 of 85 authors have none

| Item | Have | Missing |
|---|---|---|
| Distinct Chinese authors in the catalogue | — | **85** |
| Authors with a biography (`author_bios_<locale>`) | **19** | **66** |
| **Books affected** | — | **76** |
| Translations needed | 19 × 14 exist | **66 × 14 = 924** |

`BundledAuthorBiographyService` returns `null` when an author is absent from both
the locale file and the English file, and the detail screen **omits the section
entirely** — so those 76 books show an author name with no explanation of who it
was.

Authors with no biography include: Ainajushi, Aiyuezhuren, Anonymous,
Baiyundaoren, Banyunyou, Boyuan, Li E, Liu Guanzhong, Luo Hongzu, Xu Huineng,
Ji Liu, Jingzi Wu, Yan Danzi, Yuli Zi — and 52 more.

### 2c. Chapter titles: 1,927 of 3,132 untranslated

| Item | Have | Missing |
|---|---|---|
| Chapters across all 100 books | — | **3,132** |
| Chapter titles translated (`chapter_titles_by_id_<locale>`) | **1,205** | **1,927** |
| Translation units if every locale is completed | — | **1,927 × 13 = 25,051** |

This is the largest item by volume, and it is **not** a blocker for the other two —
it degrades gracefully, with the reader seeing the Chinese title.

---

## What needs to be done, in order

Ordered so each step is useful on its own, and so nothing is written twice.

### 1. Write the 78 Chinese synopses and their English counterparts *(unblocks 1,014 translations)*
Sources are already on disk: the Project Gutenberg headers imported during the
book work carry author and subject lines, and `docs/BOOK_SOURCES.md` records where
each book came from. Write a factual Chinese synopsis plus its English original
into `catalog.description` / `catalog.descriptionEn`.
**No API needed** — this is authorship, not translation — and it must happen
**before** `--phase l10n`, or the pipeline translates empty strings.

### 2. Write the 66 missing author biographies *(unblocks 924 translations)*
Same shape: one Chinese biography and one English original per author, then the
existing `author_bios_<locale>` pipeline carries them to the other 12 locales.
**No API needed.** Note that several "authors" are not people —
`Anonymous`, `Aiyuezhuren` ("Master of the Love of Moonlight") — and need a
biography that says so rather than a fabricated life.

### 3. Run `--phase l10n` to completion
`book_titles_*`, `books_*`, `author_bios_*` — **222 units × 13 locales = 2,886**
translations. Resumable; blocked by API rate limits, not by code.

### 4. Chapter titles — decide, don't just translate
**25,051** machine translations is a different order of problem, and most books
have purely mechanical chapter names (第N回 / 卷). Recommended: generate a
localised pattern in code ("Chapter N" / "Chapitre N" / …), which is exact, free,
and arguably clearer than translating 回 markers. Reserve real translation for the
books whose chapter titles carry meaning — 《紅樓夢》's couplets, for instance.
**This is a decision to make, not a default to fall into.**

### 5. Poem summaries for the other 4,137 *(optional, lowest priority)*
No Chinese source exists, and the titles are already translated in all 13 locales,
so nobody is blocked. Only worth doing if poem-level synopses are a product goal.

---

## Deliberately not part of this audit

| Item | Tracked where |
|---|---|
| Cover provenance, and the 100 orphaned poetry covers | `docs/BOOK_SOURCES.md` and the cover work |
| The commercial-scan book covers still shipped | needs the same treatment as the 31 removed books |
| `zhuzijiaxun` — the one book with no cover | `scratch/book_covers.py`, resumable |
| Trademark and translation legal questions | still owed to a lawyer |

---

## How these numbers were produced

All counts come from the shipped JSON, so they can be re-verified at any time.

```powershell
# Book synopsis coverage
python -c "import json; d=json.load(open('assets/data/grand_library_catalog.json',encoding='utf-8-sig')); b=d if isinstance(d,list) else d['books']; print(sum(1 for x in b if str(x.get('descriptionEn') or '').strip()),'of',len(b))"

# Author biography coverage
python -c "import json; d=json.load(open('assets/data/grand_library_catalog.json',encoding='utf-8-sig')); b=d if isinstance(d,list) else d['books']; a={x['author'].strip() for x in b if x.get('author')}; ab=json.load(open('assets/data/l10n/author_bios_en.json',encoding='utf-8-sig')); print(len(a),'authors;',len([x for x in a if x not in ab]),'lack a biography')"

# Chapter title coverage
python -c "import json,os; n=sum(len(json.load(open('assets/data/books/'+f,encoding='utf-8-sig'))) for f in os.listdir('assets/data/books')); t=len(json.load(open('assets/data/l10n/chapter_titles_by_id_fr.json',encoding='utf-8-sig'))); print(t,'of',n,'chapter titles translated')"

# Poem summary coverage
python -c "import json; p=json.load(open('assets/data/famous_chinese_poetry.json',encoding='utf-8-sig')); print(sum(1 for x in p if str(x.get('summary') or '').strip()),'of',len(p),'poems have a summary')"
```

**The locale files are UTF-8 with a BOM.** Read them with `utf-8-sig`, or every
parse fails on the first character.

---

## 3. Covers — every book has one, and the provenance splits three ways

Audited 2026-09-30 with `python scratch/cover_audit.py` (the inventory) and
`python scratch/cover_bytes_check.py` (the bytes), after feedback asking whether
every book has a cover and which of them were *fetched* rather than made.

| family | count | where it came from | state |
|---|---|---|---|
| library books — CC0 fetches | 23 | Cleveland Open Access API, `book_cover_manifest.json` | 600x800, licence + hash + accession recorded |
| library books — Build #184 automation | 90 | unattributed | **200x300 and friends** (128x192 … 386x500) |
| poet collections | 100 | Cleveland CC0, `poetry_cover_manifest.json` | 600x800, licence + hash recorded |
| poem plates | 100 | project-owned, `test/fixtures/poetry_cover_manifest.json` (schema v2) | 600x800, hash + perceptual-distinctness checked |

**Nothing is missing.** 113/113 catalog books and 100/100 poet collections have a
file. The two places that draw a cover in code — `CalligraphicBookCover` for a
poetry-category book, and a lone poem's plate — are design decisions, not a gap: the
11 books that had no file until 2026-09-30 were every poetry anthology, and 10 of
them still draw the code plate in the reading grid.

**Guarded now:** `test/unit_tests/book_cover_manifest_test.dart` — every catalog book
and every poet collection has its file (via the app's own `bookCoverAssetPath` /
`poetryDigest`), every manifest entry matches its file's path and SHA-256 and is CC0
art made before 1929 at 600x800, and no image is bundled twice. Probed by deleting a
cover: three of the four checks fail, by name.

**Open — quality, not coverage:**

1. **The 90 unattributed covers are thumbnails.** 89 of 113 book covers are not
   600x800: 200x300 for most, `the_art_of_war` at 128x192, others up to 386x500 with
   at least four different aspect ratios. These are the ones Build #184 called
   *"96 authentic high-res book covers"*, and they are the only covers in the app
   with no provenance record at all. `scratch/book_covers.py` refuses to overwrite an
   existing cover *by design* ("a hand-picked cover is a decision, not a gap to
   fill"), so re-sourcing them needs a `--replace` mode in that script. **Not done:
   it restyles 90 covers, which is a product decision.**
2. **Two poem plates are perceptually identical** — a pre-existing failure in
   `test/unit_tests/poetry_cover_manifest_test.dart`: `poetry_tang_d1d69a75` and
   `poetry_tang_4dc5fa06` sit at dHash distance 5 where the suite demands > 5. They
   are project-owned plates, which the *reader* no longer shows (it draws its own
   cover) but the media library still loads.
3. **Ten fetched covers are not displayed anywhere yet.** The ten poetry-category
   books (诗经, 楚辞, 曹操诗集, 花间集, 南唐二主词, 宋词, 元曲, 纳兰性德, 千家诗,
   唐诗三百首) draw their cover in code, so their new 600x800 CC0 files are carried
   for any view that resolves the asset rather than the plate.

---

## Headline

- **Poetry needs nothing.** 100/100 poet biographies in 14 locales; 4,237/4,237
  poem titles in 13. The section is complete, and poet books get their synopsis
  from the biography for free.
- **Books need authorship before they need translation.** 78 of 100 have no
  synopsis in any language; 76 have no author biography at all. Machine
  translation cannot help with either — there is nothing to translate.
- **Chapter titles (25,051 units) should be solved in code**, unless a specific
  book's titles genuinely warrant translation.

