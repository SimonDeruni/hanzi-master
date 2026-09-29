# Dictionary data sources — inventory and status

`assets/data/dictionary.db` (186 MB, 125,009 headwords, 19 columns) is **not** a
copy of one dictionary. It is a **merge of many dictionaries**, some of which are
open-source CEDICT/WordNet-family projects and some of which are
**not known to be redistributable at all**. This file records what is in there,
where it came from, and what still has to be established.

> This is an engineering inventory compiled from the repository's own build
> records (`CHANGELOG.md` builds #296–#298, `SESSION_STATE.md`) and from the
> shipped database itself. It is **not legal advice**. Where the phrase
> "unverified" appears, nobody has yet confirmed the answer.

## How this was established

The per-language row counts in the **shipped** database match the counts recorded
in `CHANGELOG.md` at build #298 digit for digit, which is what proves the ingested
data is what ships — this is not history that was later replaced:

| Column | Shipped DB | Changelog (#298) |
|---|---|---|
| `definition_ru` | 124,268 | 124,268 |
| `definition_fr` | 102,057 | 102,057 |
| `definition_vi` | 99,084 | 99,084 |
| `definition_ja` | 97,256 | 97,256 |
| `definition_es` | 96,976 | 96,976 |
| `definition_ko` | 96,777 | 96,777 |

## The sources

### Tier 1 — start here: not known to be licensed for redistribution

| Source | Recorded as | Why it is first |
|---|---|---|
| **Facebook MUSE bilingual lexicon** | used for Thai (#301) | **VERIFIED 2026-09-27 by fetching the licence: it is `Attribution-NonCommercial 4.0 International` (CC BY-NC 4.0)** — the repo's own LICENSE file opens with exactly that string. **Non-commercial is incompatible with selling the app**, and it is incompatible with CC BY-SA. This is the most concrete problem in the file, because unlike Pleco and BKRS it does not depend on an inference about provenance: the build record names MUSE and the licence is non-commercial on its face. |
| **Multilingual Pleco Database** | 286,898 words (#298) | **Pleco is a commercial product — VERIFIED on pleco.com 2026-09-27**, which advertises "licensed dictionary databases, including titles from Oxford, Brill, FLTRP, and many other major publishers" behind a "Buy now". Data of this size labelled *Pleco* points at extracted commercial data. **Licence: unverified; presumed not redistributable.** |
| **Big BKRS** | 300,000 words (#298) | **bkrs.info is a dictionary website — VERIFIED:** the domain serves a page titled **大БКРС**, i.e. "Big BKRS", matching the build record's own name for it. The page states **no licence**, and scraped website dictionaries normally carry no redistribution grant. **Licence: unverified.** |
| **PanLex** | used for Thai (#301) | 🔴 **VERIFIED 2026-09-27: `CC BY-NC-SA 4.0` — NonCommercial.** https://panlex.org/license/ states the database is provided "under the Creative Commons **Attribution-NonCommercial-ShareAlike** 4.0 International License", and that "Commercial use of these materials is permitted **only by obtaining written permission from PanLex**". This file previously assumed PanLex was CC0, so **the Thai column has TWO NonCommercial sources in it, not one** — which turns the Thai exposure from "0 to 75,202 values" into "the whole 75,202-value build #301 expansion is NC-tainted unless OMW alone accounts for it, and the split is not recorded anywhere". |

These are a different class of problem from CEDICT's copyleft: copyleft means
"you may use it, but share alike". These mean **"you may not distribute this at
all"** — and the NonCommercial terms additionally rule out the *commercial* use
the app depends on. **No licence notice can fix any of the four.** If they cannot
be licensed, the affected columns have to be replaced or removed.

### Tier 2 — CEDICT-family: CC BY-SA (attribution + share-alike)

| Source | Recorded as | Licence |
|---|---|---|
| **CC-CEDICT** | base English definitions, 6 verbatim columns | CC BY-SA — **version discrepancy: the CC-CEDICT wiki says 3.0, while the MDBG export this repo actually downloads states 4.0 International. The export is what was used, so 4.0 is the operative one, but confirm.** |
| **CFDICT** (Chinese–French) | 73,557 / 79,936 headwords | **UNCONFIRMED 2026-09-27** — the CC-CEDICT wiki states CC-CEDICT's *own* licence but does **not** state CFDICT's, so "CC BY-SA (CEDICT-family)" is an assumption in this file rather than a verified fact. Confirm at source. |
| **HanDeDict** (Chinese–German) | recorded as 99,124 / 262,548 headwords — **CORRECTED 2026-09-27: the current upstream `handedict.u8` has 160,706 lines / 159,031 distinct simplified forms, so 262,548 is not reproducible**; overlap with CC-CEDICT is **60,131** headword forms | **VERIFIED 2026-09-27: CC BY-SA 2.0** — its repository README states "Lizenziert unter CC BY-SA 2.0" (https://github.com/gugray/HanDeDict). Note the version is **2.0**, not 3.0/4.0 as had been assumed. |

### Tier 3 — WordNet-family and other open corpora: VERIFIED 2026-09-27

| Source | Language | Recorded as | Licence |
|---|---|---|---|
| WordNet-JA (Japanese WordNet) | Japanese | 14,508 | **VERIFIED 2026-09-27: NICT licence (Princeton-WordNet family).** Its own `docs/license.txt` grants "Permission to use, copy, modify and distribute this software and database … for any purpose and without fee or royalty", requiring the copyright notice and disclaimer on all copies, and forbidding use of NICT's name in endorsement. **Commercial use permitted**; attribution required. |
| OpenWN-PT | Portuguese | 13,054 | **VERIFIED 2026-09-27: CC BY-SA (unversioned)**, per OMW's own `index.toml` (`omw-pt`). Commercial use permitted; attribution **and share-alike**. |
| ItalWordNet | Italian | 12,594 | **VERIFIED 2026-09-27: ODC-BY** (Open Data Commons Attribution), per OMW's `index.toml` (`omw-iwn`). **Better than this file assumed** — attribution only, no share-alike. Commercial use permitted. |
| Bahasa Wordnet (Indonesian) | Indonesian | 12,341 | **VERIFIED 2026-09-27: MIT**, per OMW's `index.toml` (`omw-id`). Fully permissive — commercial use permitted, attribution only. (Its Malaysian sibling `omw-zsm` is also MIT.) |
| WordNet MCR (Multilingual Central Repository) | Spanish | 10,561 | **VERIFIED 2026-09-27: CC BY 3.0**, per OMW's `index.toml` (`omw-es`; the Catalan, Basque and Galician MCR packages carry the same licence). Commercial use permitted; attribution required. |
| Arabic WordNet (AWN v2) | Arabic | 6,678 | **VERIFIED 2026-09-27: CC BY-SA 3.0**, per OMW's `index.toml` (`omw-arb`). Commercial use permitted; attribution **and share-alike**. |
| "Hán-Việt DB" | Vietnamese | 12,250 | 🔴 **CANNOT BE VERIFIED — the source is not even identified.** No URL, project name or author is recorded anywhere in the repository, and "Hán-Việt DB" is not a named, licensed dataset. This is unlike the others: it is not "licence unknown", it is **"which file this is, is unknown"**. Treat as **P1** — replace with an identified source or drop. |
| BKRS / Liudmila HSK | Russian | 5,293 | 🔴 **NO LICENCE — see Tier 4.** `LiudmilaLV/json_hsk` has no LICENSE file at all, and scrapes BKRS itself |
| **FreeDict + WikDict TEI** | Indonesian, Italian, Portuguese | #299 (82,903 / zho-ita / zho-por) | FreeDict and WikDict are separate projects with separate terms — **verify both** |
| **Open Multilingual WordNet — Thai Wordnet (NECTEC)** | Thai | #301 | **VERIFIED 2026-09-27: redistribution permitted, Princeton-WordNet-family terms.** OMW records `omw-th`'s licence as `wordnet` (shorthand for the Princeton WordNet licence), and states at the top level: "Please consult the LICENSE files included with the individual wordnets. **Note that all permit redistribution.**" ⚠️ Because "wordnet" is shorthand, read the Thai wordnet's own LICENSE before shipping. |
| **PanLex** | Thai | #301 | 🔴 **REJECTED 2026-09-27: CC BY-NC-SA 4.0 — NON-COMMERCIAL.** https://panlex.org/license/ states the database is provided "under the Creative Commons **Attribution-NonCommercial-ShareAlike** 4.0 International License", and that "Commercial use of these materials is permitted **only by obtaining written permission from PanLex**". The previous note in this file ("PanLex is generally released CC0") was **wrong**, and it mattered: it concealed a **second NonCommercial source inside the Thai column**. |

**Outcome of the verification pass (2026-09-27).** Every row above was checked at
its source. The WordNet family came out **better than assumed**: Japanese WordNet
is NICT-licensed, ItalWordNet is **ODC-BY** (attribution only, no share-alike),
Bahasa Wordnet is **MIT**, MCR Spanish is **CC BY 3.0** and Arabic WordNet is
CC BY-SA 3.0 — all five permit commercial use, so the only work they needed was
credit, not removal. Two rows came out **worse**: **PanLex is NonCommercial**
(CC BY-NC-SA 4.0), which this file had wrongly recorded as CC0, and **"Hán-Việt
DB" cannot be verified at all because nothing identifies it**. The WordNet family
still carries **per-source attribution** obligations that differ from each other,
and four of them (OpenWN-PT, Arabic, plus the CEDICT family) are **share-alike**.

### A source nobody has named

**`definition_hi` holds 117,992 rows and no build record mentions Hindi at all.**
Every other populated column can be traced to an ingest above; Hindi cannot. So
the inventory is still incomplete, and at least one more source exists that is not
recorded anywhere in the repository.

### Tier 4 — bundled alongside the dictionary, separate licences

| Source | File | Licence |
|---|---|---|
| LiudmilaLV HSK (5,000 words, en + ru) | `assets/data/raw_hsk/liudmila_hsk.json`; also feeds `assets/data/hsk{2..6}_bundle.json` | 🔴 **NO LICENCE — VERIFIED 2026-09-27.** The repository (https://github.com/LiudmilaLV/json_hsk) has **no LICENSE file at all**, so it is all-rights-reserved by default; and it contains a script named **`pars_bkrs.py`**, i.e. its Russian translations were **scraped from BKRS**. This is **P1, not "verify"**: it feeds the HSK 2-6 bundles via `tools/fetch_hsk_bundles.dart` and 5,293 values of `definition_ru`. |
| AnimCJK | `assets/data/hsk1_animcjk.json`, `tooling/fetch_animcjk.dart` | **VERIFIED 2026-09-27: Arphic Public License** (its per-character SVG files) / **LGPL v3 or later** (all other files, none of which are bundled). Commercial use permitted; the licence file must be retained unaltered. Notice: `third_party/animcjk-LICENSE`; licence: `third_party/ARPHICPL.TXT`. |
| HanziVG | `assets/data/hsk1_hanzivg.json`, `tooling/fetch_hanzivg.dart` | **VERIFIED 2026-09-27: CC BY-SA 3.0**, stated in its README. It builds on KanjiVG (also CC BY-SA 3.0) and AnimHanzi. Notice: `third_party/hanzivg-LICENSE`. |
| Stroke + median data | `assets/data/hsk1_strokes.json` — from `hanzi-writer-data@2.0` on the jsDelivr CDN, `tooling/download_hsk1_strokes.dart` | **VERIFIED 2026-09-27: Arphic Public License.** `hanzi-writer-data`'s README: the data comes from Make Me a Hanzi, "extracted ... from fonts by Arphic Technology", and is redistributable under the Arphic Public License. Notice: `third_party/hanzi-writer-data-LICENSE`. |
| `hanzi_metadata.json`, `radicals.json` | `assets/data/`, generated by `tooling/generate_hsk1_metadata.dart` | **verify** — check whether any field is third-party rather than derived from CC-CEDICT / Unihan. |

**Resolved in this pass (2026-09-27):** AnimCJK, HanziVG and the Make Me a Hanzi
stroke data are all commercial-use-OK, but each requires attribution that the app
did not provide — and the two Arphic-licensed datasets additionally require the
licence file itself to ship. That is now done: `third_party/ARPHICPL.TXT`
(retained unaltered, as its section 1 demands), per-source notices, registration
on the in-app licences screen via `hanziStrokeDataPackageName`, and asset
declarations so the text travels with the build. This is the part of the
dictionary question that was **fixable without touching any data**.

These are character/stroke datasets rather than the dictionary, but they are
third-party data bundled in the app and have the same attribution question.

## Clean rebuild (2026-09-27) — `scratch/build_clean_dictionary.py`

Because this file records **no per-row provenance**, the only way to produce a
defensible dictionary is to *re-ingest from the sources themselves* rather than
to filter the shipped one. A first clean build now exists, containing **only the
two sources whose licences have been read and confirmed**:

| Source | Licence | Contributes | Rows |
|---|---|---|---|
| CC-CEDICT | CC BY-SA 4.0 | headword, pinyin, English gloss | 125,127 |
| HanDeDict | CC BY-SA 2.0 | German gloss | 63,573 |

Measured output — `scratch/dictionary_clean.db`, 36.7 MB:

- **125,127 entries**, **121,362 distinct simplified** headwords, 122,548
  distinct traditional forms.
- Fresh CC-CEDICT has **125,127** entries, exactly **118 more** than the 125,009
  in the shipped file — the bundled snapshot is simply older.
- HanDeDict supplies German to 63,573 rows, covering **60,131** of CC-CEDICT's
  121,362 distinct simplified forms.
- **HanDeDict knows 98,900 simplified forms that CC-CEDICT does not have.** They
  are deliberately *not* in this build, so the headword list stays a drop-in
  candidate for the app; adding them would grow it to **220,262 distinct
  simplified forms**. That is a decision, not a default.
- Excluded, and recorded inside the file's own `dictionary_metadata`: Pleco,
  "Big BKRS", Facebook MUSE (CC BY-NC), the unnamed Hindi source,
  LiudmilaLV/json_hsk, CFDICT, and the WordNet / OMW / PanLex corpora.

The shipped `assets/data/dictionary.db` is opened **read-only** and is verified
byte-identical before and after every run
(sha256 `A5375CA2C67CD8728EED2D388C2EB1E1D551C9A4CAC2CBC4606FA4D0461B443B`).

## What is verifiable today

- **The 6 verbatim columns** (`id`, `traditional`, `simplified`, `pinyin`,
  `pinyin_no_tones`, `definition`) come from CC-CEDICT, parsed from its
  `/def1/def2/` field with only `/` → `; ` replaced.
- **The 13 localised columns** are a **mixture** — CFDICT/HanDeDict/WordNet/
  Pleco/BKRS ingests plus machine translation (`scripts/translate_dictionary.py`
  uses `googletrans` with `src='en'`). Which entry came from which has **not been
  established**, and the database does not record per-row provenance.
- **There is no per-row source attribution anywhere in the file.** The
  `dictionary_metadata` rows added on 2026-09-27 record the CC-CEDICT notice and
  flag that the file is modified; they do **not** yet enumerate the other sources.

## Recommended order of work

1. **Establish the Pleco and BKRS provenance before anything else.** If they
   cannot be licensed, the fix is not a notice — those columns have to be
   replaced or removed, and the sooner that is known the better.
2. Confirm the CEDICT-family versions (CFDICT, HanDeDict) and credit them.
3. ~~Check each WordNet-family licence and credit it.~~ **DONE 2026-09-27** — all
   eight checked at source; see Tier 3. Five permit commercial use and only need
   credit (Japanese = NICT; ItalWordNet = ODC-BY; Bahasa = MIT; MCR = CC BY 3.0;
   Arabic = CC BY-SA 3.0). Two went the other way: **PanLex is NonCommercial**
   and has been moved into Tier 1, and **"Hán-Việt DB" cannot be verified because
   nothing identifies it**.
4. ~~Check the Tier 4 character datasets.~~ **DONE 2026-09-27** — AnimCJK, HanziVG
   and the `hanzi-writer-data` stroke/median data are confirmed and now credited
   in the app and in `third_party/` (see Tier 4). Two things remain open there:
   the fields in `hanzi_metadata.json` / `radicals.json`, and the **LiudmilaLV HSK
   source, which has no licence at all** and is now tracked as P1 rather than
   "verify".
5. Only then finalise the user-facing notice, so it lists what the data
   actually is instead of naming one source.
6. Consider recording **per-row provenance** when the file is next rebuilt, so
   this question is answerable from the data rather than from the changelog.
