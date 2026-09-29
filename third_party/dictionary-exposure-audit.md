# Dictionary exposure audit — how many words are affected

`python tooling/audit_dictionary_exposure.py` — re-runnable, reads the shipped
database, quotes the repository's own build records.

## The headline

| | Values | Share |
|---|---|---|
| **Definition values shipped** (all languages) | **1,494,641** | 100% |
| — English (CC-CEDICT, licence confirmed) | 125,009 | 8% |
| — Localised (13 languages) | 1,369,632 | 92% |
| **Behind a licence read and confirmed commercial-OK** | **252,901** | **17%** |
| **Behind a source whose licence is unestablished** | **1,241,740** | **83%** |

Of **125,009 headwords**, English and only 127,892 localised values are traceable
to a confirmed licence. Everything else — 83% of all definition text — rests on
sources whose licence nobody has yet established.

## Wholly exposed — 6 languages, 616,418 values

These columns' shipped counts **equal** the totals their build reported, and that
build was populated entirely from sources with no established licence (Pleco /
Big BKRS). Nothing else contributed, so the whole column is exposed.

| Language | Values | Share of all 125,009 words |
|---|---|---|
| **ru** | 124,268 | **99.4%** |
| **fr** | 102,057 | 81.6% |
| **vi** | 99,084 | 79.3% |
| **ja** | 97,256 | 77.8% |
| **es** | 96,976 | 77.6% |
| **ko** | 96,777 | 77.4% |
| | **616,418** | |

**Russian is the worst case in the whole database: 124,268 of 125,009 words
(99.4%) get their definition from a column with no established licence.**

## Mixed — 7 languages, 753,214 values

Here a plausible or confirmed source contributed too, so only part is exposed.

| Language | Values | Behind a confirmed licence | Note |
|---|---|---|---|
| hi | 117,992 | 0 | **no source recorded anywhere** |
| de | 117,470 | 0 | HanDeDict (unverified) + Pleco |
| id | 111,548 | 82,903 | FreeDict+WikDict (CC BY-SA) is the bulk |
| pt | 111,283 | 29,319 | OpenWN-PT (**CC BY 4.0**) + WikDict (CC BY-SA) |
| it | 110,917 | 15,670 | WikDict (CC BY-SA) + ItalWordNet (unverified) |
| ar | 94,250 | 0 | Arabic WordNet (unverified) + Pleco |
| th | 89,754 | 0 | OMW (permissive) + **PanLex (NonCommercial, CC BY-NC-SA 4.0)** + **MUSE (NonCommercial, CC BY-NC 4.0)** |

## The NonCommercial exposure specifically

**Two sources in the Thai column forbid commercial use, not one — corrected
2026-09-27.** The first is **Facebook MUSE (CC BY-NC 4.0)**. The second is
**PanLex**, which this file had wrongly recorded as "generally released CC0":
https://panlex.org/license/ states the database is provided under
**CC BY-NC-SA 4.0** and that "Commercial use of these materials is permitted only
by obtaining written permission from PanLex". Thai held 14,552 definitions before
build #301 and 89,754 after; that build names OMW (permissive), PanLex *and*
MUSE, and does not record how much each contributed. So the whole **75,202-value**
expansion is NonCommercial-tainted unless OMW alone accounts for it — and that
cannot be narrowed from the data. **The Thai column as it stands cannot ship
commercially; it has to be rebuilt from OMW alone, or PanLex/MUSE licensed.**

## A second finding: rows no build record explains

| Language | Shipped | Explained | **Unexplained** |
|---|---|---|---|
| hi | 117,992 | 0 | **117,992** |
| it | 110,917 | 15,670 | **95,247** |
| pt | 111,283 | 16,265 | **95,018** |
| ar | 94,250 | 6,678 | **87,572** |
| id | 111,548 | 30,272 | **81,276** |
| de | 117,470 | 99,124 | **18,346** |
| | | | **495,451** |

**495,451 values — a third of the localised dictionary — exceed every total any
build recorded.** Some is likely later machine translation, which is harmless; but
it is not recorded, so it cannot be attributed. Combined with the fact that Hindi
has no recorded source at all, this means **the repository cannot currently
explain a third of its own dictionary.**

## Method, and why some figures are ranges

- **There is no per-row provenance in the database.** The schema has no source
  column, so no figure for a *mixed* column can be exact. Every mixed figure here
  is a ceiling.
- **The build records report column totals, not increments** ("#298 Russian
  124,268 = 99.4%" is 124,268/125,009, i.e. a total). Equality between a shipped
  count and a recorded total is therefore evidence that nothing else was added to
  that column — that is the test used above.
- Sources classed **A** (licence read, commercial use confirmed): CC-CEDICT,
  OpenWN-PT, WikDict, FreeDict, **and — verified 2026-09-27 — WordNet-JA (NICT
  licence), ItalWordNet (ODC-BY), Bahasa Wordnet (MIT), WordNet MCR (CC BY 3.0)
  and Arabic WordNet (CC BY-SA 3.0)**. **B** (unverified, plausibly licensable):
  CFDICT, OMW Thai, "Hán-Việt DB". **C** (unestablished or NonCommercial):
  Pleco, Big BKRS, **MUSE (CC BY-NC 4.0)**, **PanLex (CC BY-NC-SA 4.0)**,
  Liudmila HSK, and the unknown Hindi source.
- Cross-check: the `localized_definition_quality` table holds **1,369,632** rows,
  exactly the number of localised definition values measured. The two independent
  counts agree.

## What this means in practice

- **Not** 125,009 words at risk in *all* languages. English is clean, and so are
  127,892 values elsewhere.
- The affected unit is **(headword, language) pairs**: up to **1,241,740** of them.
- The user-visible impact is per language: a Russian reader would lose 99.4% of
  definitions, a Korean reader 77.4%, a Thai reader up to 60%.
- The **NonCommercial** problem is narrower than the rest: Thai only, 0–75,202
  values. Everything else is "licence not established", which may yet resolve.
