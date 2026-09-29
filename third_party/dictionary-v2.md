# Dictionary v2 — sources per language, and how it compares with the shipped file

`scratch/build_dictionary_v2.py` → `scratch/dictionary_v2.db` (32.2 MB, 125,132 headwords).

Every source listed here has had its licence **read at source** and confirmed to
permit commercial redistribution. Nothing on the rejected list (Pleco, Big BKRS,
Facebook MUSE, PanLex, `LiudmilaLV/json_hsk`, CFDICT, "Hán-Việt DB") is used.

## Where the current dictionary lives

| Location | What | Contract |
|---|---|---|
| `assets/data/dictionary.db` | bundled SQLite asset (186 MB), declared in `pubspec.yaml` | `words` + `dictionary_metadata` |
| Firestore, project `hanzi-master-bcef9` | `dictionarySources` (doc id = `wordId`), `dictionaryScoreEligibility` (doc id = `<wordId>_<lang>`) | imported by `functions/scripts/import-dictionary-sources.js <file.sqlite>` |

**The app's acceptance gate** (`lib/features/flashcards/data/repositories/global_dictionary_repository.dart`):
`words` must contain `definition` **and all 13** `definition_<lang>` columns, and
`dictionary_metadata.dictionary_schema_version` must equal `'2'`. Otherwise
`needsRefresh = true` and the file is discarded for the bundled one.

> The previous `scratch/dictionary_accepted.db` **failed both**: it had no
> `definition_hi/ko/vi` and its `dictionary_schema_version` was `accepted-1`.
> It could never have shipped. v2 fixes both.
>
> `SUPPORTED_LANGUAGES` (`functions/dictionary-expansion.js`) = `ar de es fr hi id
> it ja ko pt ru th vi`. That is 13 languages, and there is **no `nl`** — the
> accepted build's Dutch column was out of scope.

## Dictionaries usable for each language (English excluded)

Sizes are the upstream payload; "covered" = CC-CEDICT headwords that receive a
value, measured with the synset bridge `Chinese Open Wordnet → synset → target`.

| Language | Sources (license) | Endpoint | Size |
|---|---|---|---|
| **ar** Arabic | Arabic WordNet AWN v2 (CC BY-SA 3.0) · Wiktionary Arabic (CC BY-SA 3.0) | `wns/arb/wn-data-arb.tab`, `wns/wikt/wn-wikt-arb.tab` | 311 KB (wikt) |
| **de** German | **HanDeDict** (CC BY-SA 2.0) · WikDict zh–de (CC BY-SA 3.0) · Wiktionary German (CC BY-SA 3.0) | `handedict.u8`, `zho-deu.tei`, `wn-wikt-deu.tab` | 61.6 MB / 5 MB |
| **es** Spanish | WordNet MCR (CC BY 3.0) · WikDict zh–es (CC BY-SA 3.0) · Wiktionary Spanish (CC BY-SA 3.0) | `wns/mcr/wn-data-spa.tab`, `zho-spa.tei`, `wn-wikt-spa.tab` | 5 MB |
| **fr** French | **WOLF** (CeCILL-C) · WikDict zh–fr (CC BY-SA 3.0) · Wiktionary French (CC BY-SA 3.0) | `wns/fra/wn-data-fra.tab`, `zho-fra.tei`, `wn-wikt-fra.tab` | 5 MB |
| **hi** Hindi | Wiktionary Hindi (CC BY-SA 3.0) | `wns/wikt/wn-wikt-hin.tab` | 182 KB |
| **id** Indonesian | Wordnet Bahasa (MIT) · FreeDict/WikDict zh–id (CC BY-SA 3.0) · Wiktionary Indonesian (CC BY-SA 3.0) | `wns/msa/wn-data-ind.tab`, `wn-wikt-ind.tab` | — |
| **it** Italian | ItalWordNet (ODC-BY) · **MultiWordNet** (CC BY 3.0) · WikDict zh–it (CC BY-SA 3.0) · Wiktionary Italian (CC BY-SA 3.0) | `wns/iwn/…`, `wns/ita/wn-data-ita.tab`, `zho-ita.tei` | 4 MB |
| **ja** Japanese | Japanese WordNet (NICT) · WikDict zh–ja (CC BY-SA 3.0) · Wiktionary Japanese (CC BY-SA 3.0) | `wns/jpn/wn-data-jpn.tab`, `zho-jpn.tei` | 5 MB |
| **ko** Korean | Wiktionary Korean (CC BY-SA 3.0) · *(character level)* Unihan `kHangul`/`kKorean` (Unicode License v3, permissive) | `wns/wikt/wn-wikt-kor.tab`, `Unihan.zip` | 282 KB / 8 MB |
| **pt** Portuguese | OpenWN-PT (CC BY-SA) · WikDict zh–pt (CC BY-SA 3.0) · Wiktionary Portuguese (CC BY-SA 3.0) | `wns/por/wn-data-por.tab`, `zho-por.tei` | 4 MB |
| **ru** Russian | WikDict zh–ru (CC BY-SA 3.0) · Wiktionary Russian (CC BY-SA 3.0) · DBnary (CC BY-SA 3.0) | `zho-rus.tei`, `wn-wikt-rus.tab` | 5 MB / 1.3 MB |
| **th** Thai | **Thai WordNet, NECTEC (NICT licence — commercial permitted)** · Wiktionary Thai (CC BY-SA 3.0) | `wns/tha/wn-data-tha.tab`, `wn-wikt-tha.tab` | 5.1 MB |
| **vi** Vietnamese | Wiktionary Vietnamese (CC BY-SA 3.0) · *(character level)* Unihan `kVietnamese` (Unicode License v3) | `wns/wikt/wn-wikt-vie.tab`, `Unihan.zip` | 177 KB / 8 MB |

Base URL for the OMW files: `https://raw.githubusercontent.com/omwn/omw-data/main/`.
WikDict TEI: `https://download.wikdict.com/dictionaries/tei/recommended/`.
CC-CEDICT (headwords, pinyin, English): `https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf8_mdbg.txt.gz`.
Unihan: `https://www.unicode.org/Public/UCD/latest/ucd/Unihan.zip`.

### Deliberately rejected for each language

| Language | Rejected source | Reason |
|---|---|---|
| th | Facebook MUSE | CC BY-NC 4.0 — NonCommercial |
| th | PanLex | CC BY-NC-SA 4.0 — NonCommercial |
| fr | CFDICT | licence never stated by its own project |
| vi | "Hán-Việt DB" | source not identified at all — use Unihan `kVietnamese` |
| ru | BKRS, `LiudmilaLV/json_hsk` | no licence |
| ru/de/fr/es/ja/ar | "Multilingual Pleco Database" | commercial product, no licence |


## Word count per language: shipped vs v2

Reproduced by `python scratch/build_dictionary_v2.py` (the script prints this table).

| lang | shipped `dictionary.db` | **v2 + Wikidata** | vs shipped |
|---|---|---|---|
| ar | 94,250 | **26,424** | 0.28× |
| de | 117,470 | **73,529** | 0.63× |
| es | 96,976 | **36,570** | 0.38× |
| fr | 102,057 | **37,597** | 0.37× |
| hi | 117,992 | **14,033** | 0.12× |
| id | 111,548 | **44,612** | 0.40× |
| it | 110,917 | **34,418** | 0.31× |
| ja | 97,256 | **34,147** | 0.35× |
| ko | 96,777 | **28,539** | 0.29× |
| pt | 111,283 | **27,828** | 0.25× |
| ru | 124,268 | **57,257** | 0.46× |
| th | 89,754 | **25,005** | 0.28× |
| vi | 99,084 | **24,613** | 0.25× |
| **headwords** | 125,009 | **125,132** | fresh CC-CEDICT |

### How to read it

- **The shipped numbers are not comparable "coverage".** Its localised columns
  were largely filled by machine translation (`scripts/translate_dictionary.py`,
  `googletrans` with `src='en'`) and by unlicensed ingests, so a high count is
  not evidence of a licensed dictionary. v2 counts only *sourced* values.
- **`de` loses least (−44%)** because HanDeDict is a genuine German dictionary.
  **`ru` loses least of the machine-translated ones (−67%)** thanks to WikDict.
- **`th` went 0 → 14,642**: the accepted build's Thai was 0 because
  `parse_wn_tab` required the key `<lang>:lemma` while the Thai file writes a bare
  `lemma`. Accepting both is the entire fix.
- **`hi`/`ko`/`vi` had no licensed source at all** before this; they now have
  one, at 3,525 / 5,584 / 3,845.
- Coverage is capped by the bridge: Chinese Open Wordnet has only 61,525 Chinese
  lemmas / 42,300 synsets, so no synset-joined layer can exceed it.

## Verified

- `PRAGMA table_info(words)` contains **all 13** required `definition_*` columns ✅
- `dictionary_schema_version = '2'` ✅ — the app's gate now passes
- Spot check, `水`: de `Wasser`, fr `eau`, es `agua`, ru `вода`, it `acqua`,
  pt `água`, ja `お水; みず`, ko `물; 수`, vi `nước`, id `air`, ar `ماء`,
  hi `आब; जल; पानी`, th `ชล; น้ำ`
- `电脑`: hi `कंप्यूटर; संगणक`, ko `電子計算機; 전자계산기; 컴퓨터`,
  vi `máy tính; máy vi tính; máy điện toán`

## Making it live

1. **Bundle**: declare `assets/data/dictionary_v2.db` in `pubspec.yaml`, copy it
   over `assets/data/dictionary.db`, and bump any download-checksum the app uses.
2. **Quality table** (needed by the expansion pipeline's `--eligible-only`):
   `python scripts/score_dictionary_quality.py --db scratch/dictionary_v2.db`
3. **Firestore** (project `hanzi-master-bcef9`):
   `node functions/scripts/import-dictionary-sources.js scratch/dictionary_v2.db`
   — add `--dry-run` first. `SUPPORTED_LANGUAGES` is applied by the importer, so
   the absent Dutch column is irrelevant.

## Known limits

- `朋友` has no `hi`/`ko`/`vi` value — the bridge simply has no synset for it.
  Raising these three needs a **direct** Chinese↔target pair, not another
  wordnet: `kaikki.org` Wiktextract `zh-extract` (Chinese Wiktionary `翻译`
  tables, CC BY-SA 3.0 + GFDL, 222 MB gz) or DBnary (CC BY-SA 3.0).
- WordNet-derived values are the **synonyms wordnet lists for the concept**, not
  translations of the CC-CEDICT gloss. Recorded in `dictionary_provenance_note`.
- Share-alike obligations now cover CC-CEDICT, HanDeDict, WikDict, OMW Wiktionary,
  OpenWN-PT, Arabic WN, Bahasa, WOLF (CeCILL-C); only ItalWordNet, MultiWordNet
  and Japanese WN are attribution-only.



---

# Additional legally usable sources (licence read at source)

Everything below was checked by fetching the licence itself, not by trusting a
summary. "Verified" here means the licence text itself was read.

## Usable — no permission needed

| Source | Licence | Content | Adds |
|---|---|---|---|
| **FreeDict / WikDict Chinese–Indonesian** `download.freedict.org/generated/zho-ind/zho-ind.tei` (33 MB) | **CC BY-SA 3.0** (TEI `<availability>`) | 82,903 headwords | ✅ **+17,967 Indonesian** (now wired into v2) |
| **FreeDict Chinese–Russian** `zho-rus.tei` (82 MB, 156,590 headwords) | CC BY-SA 3.0 | 156,574 headwords | ⚠️ **duplicate** — its TEI header says *"Automatic creation … by WikDict"*; measured **0 net new**, it republishes the WikDict file the build already ingests |
| **JMdict + KANJIDIC2** (EDRDG) `edrdg.org` | **CC BY-SA 4.0** | Japanese↔multilingual; KANJIDIC2 adds kanji **pinyin** and **Korean readings** | Japanese + kanji readings. **Obligation: "there must be a procedure for regular updating … at least once a month"** — a licence condition, not advice |
| **Wikidata Lexemes** `wikidata.org` | **CC0** | words/forms/senses, multilingual | Best licence available — **no attribution, no share-alike**. Coverage is thin today |
| **ConceptNet 5** `conceptnet.io` | **CC BY-SA 4.0** (data) / Apache-2.0 (code) | 13M+ multilingual edges | Chinese↔many languages; some upstream sources in `DATA-CREDITS` have stricter terms — check before mining |
| **OpenHowNet** `github.com/thunlp/OpenHowNet` | **MIT** | Chinese words, sememes, definitions; BabelNet-linked layer | ⚠️ **use the HowNet core only** — its BabelNet layer inherits **CC BY-NC-SA** |
| **ECDICT** `github.com/skywind3000/ECDICT` | **MIT** | 760k+ **English→Chinese** entries | ⚠️ wrong direction for the localised columns; not usable here |
| **Tatoeba** `tatoeba.org/downloads` | **CC BY 2.0 FR**, part **CC0 1.0** | parallel sentences | Example sentences, not definitions |
| **CC-Canto** `cantonese.org` | **CC BY-SA 3.0** | Cantonese readings for CC-CEDICT | Cantonese only |
| **DBnary** `kaiko.getalp.org` | **CC BY-SA 3.0** | Chinese + Russian translations (disambiguated) | Deepening ru; no ko/hi/vi/th extractors exist |
| **kaikki.org / Wiktextract** | **CC BY-SA 3.0 + GFDL** | per-language Wiktionary extracts; `zh-extract` 222 MB gz has the Chinese Wiktionary `翻译` tables | **Best lever for hi / ko / vi**, which the synset bridge caps |
| **Unihan** `unicode.org/Public/UCD/latest/ucd/Unihan.zip` (8 MB) | **Unicode License v3** (permissive) | `kHangul`/`kKorean`, `kVietnamese`, `kJapanese`, `kMandarin`, `kDefinition` | Character-level ko/vi/ja readings; replaces the unidentified "Hán-Việt DB" |
| **OMW Wiktionary layers** `wns/wikt/wn-wikt-*.tab` | CC BY-SA 3.0 (+GFDL) | 150+ languages | Already wired |

## Rejected after verification — do NOT use

| Source | Finding |
|---|---|
| **Hindi WordNet / IndoWordNet** (IIT Bombay, `cfilt.iitb.ac.in/wordnet/webhwn`) | 🔴 "released under **GNU GPL 3.0** and the lexicon under GNU FDL" **but** "**For commercial use, please write to** Prof. Pushpak Bhattacharyya". Commercial use needs **written permission** → rejected. Use the Wiktionary Hindi layer instead |
| **RuWordNet** (`ruwordnet.ru/en`) | 🔴 **self-contradictory**: "distributed for **non-commercial use**. To obtain xml-files … write to Natalia Loukachevitch" *and* "available under a **CC BY-SA 4.0** licence". Cannot be relied on |
| **Taiwan MOE 重編國語辭典修訂本** (`dict.revised.moe.edu.tw`) | 🔴 published via the MOE 辭典公眾授權網 under **CC BY-ND** — **NoDerivatives** forbids merging/re-modifying it into a dataset |
| **BabelNet** | 🔴 CC BY-NC-SA — NonCommercial (also taints OpenHowNet's BabelNet layer) |
| **FreeDict generally** | ⚠️ docs say "the majority of our dictionaries is licenced under **GPL**" — **always read each file's TEI `<availability>` block**; the Chinese ones are CC BY-SA, not GPL |
| Pleco · "Big BKRS" · Facebook MUSE (CC BY-NC) · PanLex (CC BY-NC-SA) · `LiudmilaLV/json_hsk` (no LICENSE) · CFDICT (never stated) · "Hán-Việt DB" (unidentified) | as already recorded in `third_party/dictionary-sources.md` |

## Top unverified lead — worth chasing

**NIKL 한국어기초사전 / Korean Learners' Dictionary** (`krdict.korean.go.kr`) publishes
Korean↔**Chinese, Japanese, Thai, Vietnamese, Russian, Arabic, Indonesian, French,
Spanish** with an **Open API**. That is nine of our thirteen languages, including the
four weakest (ko, vi, th, ar) — potentially the single highest-value addition left.
Its copyright-policy page returned 404 to automated fetches (the site is
JS-driven), so **the licence is not yet established**. NIKL normally publishes under
공공누리 (KOGL) Type 1 = attribution + commercial use + derivatives allowed. **Verify
before use.**



---

# Where the search actually stands (measured, not assumed)

## Covered so far

OMW curated wordnets (28) and OMW Wiktionary layers (150+ languages) ·
WikDict TEI · FreeDict (hand-written **and** generated — where it turned out to be a
WikDict republication) · CC-CEDICT · HanDeDict · CFDICT · CC-Canto · DBnary ·
kaikki.org / Wiktextract (index level) · EDRDG JMdict + KANJIDIC2 · ConceptNet ·
OpenHowNet · ECDICT · Tatoeba · Unihan · Hindi WordNet · RuWordNet · Taiwan MOE ·
BabelNet · NIKL krdict (found, licence unverified).

That is **not** every open source. It is the "published bilingual dictionary" class.
Three much larger classes had not been looked at at all.

## Class 1 — Wikidata / Wikipedia (CC0). Measured 2026-09-28.

Potentially the **best-licensed source in the whole project**: Wikidata structured data
is **CC0** ("No rights reserved") — no attribution, no share-alike. 120M+ items, 1.3M+ lexemes.

Sample: 200 random CC-CEDICT headwords → zh.wikipedia article exists for **44%**; the
Wikidata item for each then carries labels in the target language:

| lang | langlinks | **Wikidata labels** | projected for 125,132 headwords | currently in v2 |
|---|---|---|---|---|
| ko | 15.5% | **30.5%** | **~38,000** | 5,584 |
| hi | 8.0% | **17.0%** | **~21,000** | 3,525 |
| vi | 13.5% | **30.5%** | **~38,000** | 3,845 |
| th | 11.5% | **21.5%** | **~27,000** | 14,642 |
| ar | 13.5% | **29.5%** | **~37,000** | 8,970 |
| ja / fr / de / es / ru / it / pt / id | 12–17% | 28–36% | 35,000–44,000 | 8k–65k |

Real pairs pulled: `摩天大樓` → ko `마천루`, hi `गगनचुम्बी इमारत`, vi `Nhà chọc trời`,
th `ตึกระฟ้า`, ar `ناطحة سحاب`; `文献` → ko `문서`, hi `दस्तावेज़`, vi `văn kiện`,
th `เอกสาร`, ar `وثيقة`.

**Honest limits — this is not a gloss replacement:**
- These are **article titles / concept labels**, not dictionary senses. `神` → th
  `เทวภาพ` ("divinity"), ar `إله أو إلهة` ("god or goddess") — encyclopaedic, not the
  everyday word.
- Noise is real: `乳糖` → vi `Lactose` (an untranslated English word).
- Biased to notable nouns; thin on function words, particles, colloquial verbs.
- n=200, so ±~10% relative on the small figures.

Best use: a **supplement** for exactly the languages that are weak (hi, ko, vi, th, ar),
clearly labelled by provenance, never as the primary gloss.

## Class 2 — parallel corpora (OPUS). Found, not yet measured.

**1,214 corpora · 102,878,590,853 sentence pairs · 1,038 languages.**
OpenSubtitles 27.2B · NLLB 22.7B · CCMatrix 17.1B · ParaCrawl 4.6B · GNOME 1.7B ·
LinguaTools-WikiTitles 1.5B · UNPC 543.9M · MultiUN 255.9M · TED2020 153.1M ·
wikimedia 119.1M · Tatoeba 24.2M. Licences are **per corpus** (many CC).
Translations are mined by word alignment, not published as a dictionary — heavier, noisier,
but it reaches languages no wordnet touches.

## Class 3 — the pipeline that already exists in this repo.

`functions/dictionary-expansion.js` (Gemini) and `scripts/translate_dictionary.py`
(googletrans) **are** translation sources, and they are what actually filled the shipped
file's 94k–124k localised columns. Any strategy that treats only "published dictionaries"
as legitimate will never reach those counts. If the goal is coverage, the honest choice is
**licensed dictionary first, AI/MT second, with the provenance recorded per row** — which
is what `dictionary_provenance_note` is for.

## Also untouched

- kaikki's **per-language** extracts (only the index was checked, never parsed)
- **zh.wiktionary raw dumps** (the `翻译` tables, unmediated by kaikki)
- **Leipzig / Wortschatz** — the server blocked automated fetches (Anubis); unverified
- Chinese datasets on HuggingFace/GitHub
- CC web-crawl corpora (HPLT, MaCoCu, ParaCrawl, CCMatrix)
- LEXITRON (Thai) · Vietnamese and Hindi national corpora · OpenStreetMap names (ODbL)
- **NIKL krdict** — Korean ↔ Chinese/Japanese/Thai/Vietnamese/Russian/Arabic/Indonesian/French/Spanish, licence still unverified

**Verdict: not stuck.** The published-dictionary well is nearly dry for hi/ko/vi/th/ar, but
Wikidata (CC0), OPUS, and the repo's own AI pipeline are all unexploited and together they
cover the gap.



---

# The Wikidata / Wikipedia importer (CC0) — built and run

Scripts (all in `scratch/`):

| Script | What it does |
|---|---|
| `download_zhwiki_dumps.py` | resumable download of the three zh.wikipedia dump tables (~594 MB) |
| `parse_zhwiki_dumps.py` | streams the dumps → `%TEMP%\wikidata_cache\zhwiki_resolved.jsonl` |
| `import_wikidata_translations.py` | `--crawl-only` / `--labels-only` / `--skip-api`, resumable, writes the table and gap-fills |

**Why dumps and not the API for phase 1:** an API crawl needs ~3,955 requests for
197,713 headword forms and Wikimedia returns **HTTP 429** well before that. The dumps
have no rate limit — 594 MB downloaded in ~2 minutes, parsed in **0.9 minutes**.

**Why the API for phase 2:** Wikidata labels are not in a small dump. 710 requests at
0.2 s delay completed in ~8 minutes. **The 429s were caused by a User-Agent without
contact information** — Wikimedia throttles those. With a descriptive UA the same
calls returned in 0.6 s.

## What was extracted

| Step | Result |
|---|---|
| headword forms (simplified ∪ traditional) | 198,213 |
| zh.wikipedia articles matching a headword | **76,348** |
| …of those, with a Wikidata item | **35,488** |
| …with ≥1 target-language article (langlinks) | **30,481** |
| label rows fetched (all 35,488 items × 13 languages) | 35,488 |

## Provenance stored per row

A `wikidata_translations` table holds every pair: `(word_id, language_code, title,
qid, layer)` — **290,371 rows** (262,198 `langlinks`, 28,173 `wikidata_label`).
Columns not already sourced are **gap-filled only**; no sourced gloss is ever
overwritten.

`dictionary_schema_version = 2` and all 13 columns are present — the app gate passes.

## Effect on coverage

| lang | v2 before Wikidata | **v2 + Wikidata** | gain |
|---|---|---|---|
| hi | 3,525 | **14,033** | **4.0×** |
| ko | 5,584 | **28,539** | **5.1×** |
| vi | 3,845 | **24,613** | **6.4×** |
| it | 16,289 | **34,418** | 2.1× |
| fr | 18,051 | **37,597** | 2.1× |
| es | 18,452 | **36,570** | 2.0× |
| ja | 18,179 | **34,147** | 1.9× |
| th | 14,642 | **25,005** | 1.7× |
| id | 30,471 | **44,612** | 1.5× |
| ru | 41,331 | **57,257** | 1.4× |
| pt | 11,997 | **27,828** | 2.3× |
| ar | 8,970 | **26,424** | 2.9× |
| de | 65,446 | **73,529** | 1.1× |

Spot-checked output: `意大利` → ko `이탈리아`, hi `इटली`, vi `Ý`, th `ประเทศอิตาลี`,
ar `إيطاليا`; `自由` → ko `자유`, hi `स्वाधीनता`, vi `Tự do`, th `เสรีภาพ`, ar `حُرِّيّة`;
`科学家` → ko `과학자`, hi `वैज्ञानिक`, vi `nhà khoa học`, th `นักวิทยาศาสตร์`, ar `عالِم`.

**Quality caveat, restated:** these are article titles / concept labels, not glosses.
`神` → th `เทวภาพ` ("divinity") is encyclopaedic. `乳糖` → vi `Lactose` is an
untranslated English word. Quality has **not** been scored here;
`scripts/score_dictionary_quality.py` should be run before shipping.

## Re-running

```
python scratch/download_zhwiki_dumps.py            # only if the dumps are gone
python scratch/parse_zhwiki_dumps.py               # ~1 min
python scratch/import_wikidata_translations.py --labels-only --seconds 3600
python scratch/import_wikidata_translations.py --skip-api
```



---

# Can the caveats actually be fixed? (tested, not asserted)

`scratch/clean_wikidata_translations.py` — fetches P31 (instance-of) for every QID via
WDQS (POST; GET returns **414 URI Too Long**), then reviews all 290,371 pairs and
records a verdict + reason per row. It only clears a column when the stored value *is*
the rejected value, and it is **idempotent** (re-running restores accepted values and
re-applies the rules), so an over-aggressive pass is always recoverable.

## What the rules reject

| Rule | Basis | Rejected | Reliable? |
|---|---|---|---|
| **V1** bracket-disambiguator | value contains `X (…)` | **22,999** | ✅ precise |
| **V2** latin-binomial | value is a bare 2-word ASCII binomial **and** P31 = taxon | 8,798 | ⚠️ still drops real names like "Sterne caugek" |
| **I** disambiguation page | P31 = Q4167410 etc. | 8,329 | ✅ precise |
| **I** creative works | film / series / album / single / song / game / book | ~2,000 | ✅ precise |
| **V3** same-as-english | value == first CEDICT sense, **non-Latin targets only** | 242 | ✅ (see below) |
| **H1** ascii-headword | headword is pure ASCII (`A`, `110`, `88`) | 85 | ✅ precise |
| **V4** too-long | > 80 chars or contains newline | 9 | ✅ precise |
| | **TOTAL** | **42,863 of 290,371 (14.8%)** | |

## Verified effect

```
removed:   A, 110, 88, 11区, 血战 ("Blood+"), 完美无瑕 (Ed Sheeran single), 鳤 (Latin binomial)
restored:  里昂 -> Lyon            (was a false positive of V3)
           布城 -> Putrajaya       (was a false positive of V3)
           接发 -> Extension capillaire,  白嘴端凤头燕鸥 -> Sterne caugek
                                    (false positives of the unconditional V2 regex)
kept:      乐观主义 -> optimisme,  流体动力学 -> Dynamique des fluides,
           中国工程院 -> Académie chinoise d'ingénierie
untouched: 水 -> eau; eau minérale,  自由 -> liberté,  电脑 -> ordinateur; calculateur
```

The first run rejected 68,069 pairs; restricting V2 to real taxa and V3 to non-Latin
targets cut that to **42,863**, restoring the legitimate values.

## The two caveats that rules CANNOT fix

1. **Wrong sense where the item has no discriminating class.** `胡姆斯` (hummus) still
   returns `Khoms` (a Libyan city); `猛涨` returned `fusée; roquette`; `帧` returned
   `Trame (informatique)`. Their P31 values are ordinary classes (settlement, …), so no
   rule separates them from a correct match. **This needs semantic verification** — the
   repo already has the machinery: `functions/dictionary-expansion.js` calls Gemini
   with the canonical record and a strict output schema. A yes/no "does <value>
   translate <headword> in this sense?" pass over the 42,863 survivors is the realistic
   fix.
2. **English/French identity is not an error.** `Heptathlon`, `Ku Klux Klan` are
   correctly spelled in French too; `Lyon`, `Putrajaya` are the French names. No lexical
   rule can separate "untranslated English" from "French happens to agree" — which is
   why V3 is restricted to non-Latin targets (`ar hi ja ko th ru`), where a Latin-script
   value is unambiguously wrong.

So: **6 of the 8 caveats are now handled mechanically; 2 (wrong-sense homographs,
register) need an LLM pass; 1 (coverage bias) is inherent to the source.**

| ru/de | "Big BKRS" | scraped site, no licence |
