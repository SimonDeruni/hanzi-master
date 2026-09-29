# Translation Strategy — how the 13-language dictionary columns are filled

Status: **draft, evidence-based.** Every number in this document was measured on this
machine. Where something is an estimate or an assumption it says so explicitly.

Companion documents: `third_party/dictionary-sources.md` (source inventory),
`third_party/dictionary-exposure-audit.md` (the licence exposure that started this),
`third_party/dictionary-v2.md` (the v2 build and its comparison).

---

## 1. The problem

The app shows a Chinese headword and its meaning in 13 languages:

```
ar  de  es  fr  hi  id  it  ja  ko  pt  ru  th  vi
```

125,132 headwords × 13 languages = **1,626,716 cells** must be filled.

The shipped `assets/data/dictionary.db` fills most of them — but an audit found that a
large share came from sources with no right to distribute them (Pleco, Big BKRS,
Facebook MUSE which is NonCommercial, PanLex which is NonCommercial, a Hindi source
nobody recorded, and an unidentified "Hán-Việt DB"). It also records **no per-row
provenance**, so the tainted rows cannot be identified, let alone removed.

Therefore the dataset had to be **rebuilt from sources whose licences were read**, and
the gaps that leaves must be filled by means that are honest about what they are.

---

## 2. Current state (measured)

| language | filled | gap | filled % |
|---|---|---|---|
| de | 71,409 | 53,723 | 57% |
| ru | 54,254 | 70,878 | 43% |
| id | 42,819 | 82,313 | 34% |
| fr | 33,840 | 91,292 | 27% |
| ko | 32,462 | 92,670 | 26% |
| es | 32,449 | 92,683 | 26% |
| ja | 32,297 | 92,835 | 26% |
| it | 30,333 | 94,799 | 24% |
| vi | 26,184 | 98,948 | 21% |
| pt | 25,005 | 100,127 | 20% |
| th | 24,496 | 100,636 | 20% |
| ar | 24,313 | 100,819 | 19% |
| hi | 13,488 | 111,644 | 11% |
| **total** | **443,349** | **1,183,367** | **27%** |

Gloss properties, also measured:

- full CC-CEDICT definition averages **41.2 characters**
- after the production cleaner, a gloss averages **19.0 characters / 2.98 words**
- **89,088 distinct cleaned glosses** exist for 115,552 usable entries → **23% dedup**
- 9,580 of 125,132 headwords (7.7%) clean down to nothing or still contain CJK and must
  be **skipped** — mostly cross-reference-only entries and surname stubs (§9.4)


---

## 2b. What is NOT in scope (and why)

The dictionary UI shows more than the 13 gloss columns — example sentences,
explanations, "similar words", ghost characters. **None of them need translating**, and
this was verified in the code rather than assumed:

| feature | where it comes from | is it stored? | needs translating? |
|---|---|---|---|
| definition / gloss per language | `words.definition_*` | **yes** — the 13 columns | **yes** — this is the whole job |
| explanation + usage notes + **example sentences** | `functions/dictionary-expansion.js` | cached per `(wordId, languageCode, sourceDefinitionHash)` | **no** — generated in the user's language |
| **similar words** | a chat chip (`character_chat_sheet.dart:71`) | no — live answer | **no** — answered live in the user's language |
| ghost characters (visually similar) | `gemini_service.dart:889` | no — live answer | **no** |

Evidence for the expansion path — the prompt itself:

```
"Return a pedagogical Chinese dictionary expansion in ${LANGUAGE_NAMES[languageCode]}."
"Examples must illustrate only supported senses. All prose and translations must use the
 requested language."
```

and the validated output shape is `{definition, explanation, usageNotes, examples[]}`
where each example is `{chinese, pinyin, translation}` — **the `translation` field is
already in the target language**, because the model was asked for it.

**Consequences:**

1. **There is no separate example-sentence translation job.** Sentences are ~10–20×
   longer than glosses; translating them would have multiplied the workload several-fold
   for no benefit.
2. **No example-sentence table exists in either database** — confirmed by dumping the
   schema of both `assets/data/dictionary.db` and `scratch/dictionary_v2.db`. There is
   nothing to migrate.
3. **The English `definition` column is the fallback, and the app labels it as such.**
   Verified in `global_dictionary_repository.dart`:

   ```dart
   final hasLocalizedDefinition =
       localizedDef != null && localizedDef.trim().isNotEmpty;
   final chosenDef = hasLocalizedDefinition ? localizedDef.trim() : defEn;
   ...
   hasLocalizedDefinition ? targetLanguage!.trim() : 'English',
   ```

   So a **missing** gloss degrades to correct English, explicitly marked `English` —
   which is exactly §3.1 ("an empty cell beats a wrong cell") already implemented in the
   app. **This is why shipping a partially-filled v2 is safe**: 73% of cells would show
   labelled English rather than a broken or blank entry, and machine translation is
   strictly an improvement on that.

4. **The only translatable content is the 13 `definition_*` columns.** That is the scope,
   and it is already 27% done from licensed sources.

---

## 3. The governing principles


These are not preferences; each came from a failure observed in testing.

### 3.1 An empty cell beats a wrong cell

A blank French column lets the app fall back to English and show the user something
correct. A **wrong** French column is silent, confident, and indistinguishable from a
right one. The pipeline must therefore be willing to leave cells empty.

### 3.2 Never overwrite a more authoritative tier with a less authoritative one

Licensed dictionary data is human-curated, multi-sense and part-of-speech tagged.
Machine output is single-sense and flat. Filling a licensed gap is progress; replacing
a licensed value is a downgrade.

### 3.3 Translate the meaning, not the character

Measured: for the same 78 single-character headwords, translating the **Chinese
character** succeeded 28.2% of the time; translating the **English gloss** succeeded
**82.1%**. A rare Chinese character has almost no training data; "dried food" →
"aliments déshydratés" is a well-covered English→French translation.

**The English gloss is the bridge.** We already have it for all 125,132 words.

### 3.4 Machine output is a fallback, not a source

Measured agreement between gloss-MT and licensed dictionary values: **Google 52.5%,
Azure 49.2%.** It is good enough to fill gaps and not good enough to replace curated
data. Label it as machine-translated wherever it is shown.

### 3.5 Record provenance per row

Every value records which tier produced it. Without this, this whole exercise repeats.

---

## 4. The tier architecture

```
Tier 0   App-side LLM expansion        depth on demand, not base coverage
Tier 1   Licensed dictionaries         authority          ✅ built
Tier 2   Wikidata / Wikipedia          bulk               ✅ built
Tier 3   English gloss → cloud MT      coverage           ← the main gap-filler
Tier 3b  English gloss + POS → LLM     polish the residual
Tier 4   Confidence scoring + QA       verification       ← gates everything
```

Fill order is strict: 1 → 2 → 3 → 3b. Nothing ever overwrites a lower number.

---

## 5. Tier 1 — Licensed dictionaries

### What it is

| source | language(s) | licence |
|---|---|---|
| CC-CEDICT | English (base: headword, pinyin, gloss) | CC BY-SA 4.0 |
| HanDeDict | German | CC BY-SA 2.0 |
| WikDict TEI (zh→*) | de, fr, nl, ru, it, pt, es, ja | CC BY-SA 3.0 |
| WOLF | French | CeCILL-C |
| MultiWordNet | Italian | CC BY 3.0 |
| ItalWordNet | Italian | ODC-BY |
| OMW curated wordnets | ja (NICT), es (MCR CC BY 3.0), id (MIT), ar (CC BY-SA 3.0), pt (OpenWN-PT CC BY-SA), th (NECTEC — commercial permitted) | per-source |
| OMW Wiktionary layers | ar, de, es, fr, hi, id, it, ja, ko, pt, ru, th, vi | CC BY-SA 3.0 |
| FreeDict/WikDict `zho-ind` | Indonesian | CC BY-SA 3.0 |
| kengdic | Korean — **matched on the hanja column**, so `見地 → 견지` is a direct match with no English hop | MPL 2.0 **or** LGPL 2.0+ |
| Unihan `kVietnamese` | Vietnamese Hán-Việt readings for single characters | Unicode License v3 |

**Wire-in status:** all of the above are in `scratch/dictionary_v2.db`
(`scratch/build_dictionary_v2.py`, `scratch/import_korean_and_unihan.py`).

### Quality

The only tier with human curation. Multi-sense (`eau; eau minérale`), gendered
(`Wasser (S)`), part-of-speech tagged (`versteigern (V)`). **This is the tier users
should see.**

### Rules

1. **Never overwrite.** `build_dictionary_v2.py` uses
   `CASE WHEN x IS NULL OR TRIM(x)='' THEN ? ELSE x END`, so tier 3 can only fill gaps.
2. **Grade it.** `scripts/score_dictionary_quality.py` scores every localised value
   0–100 on sense coverage, length ratio, English leakage, placeholders, script and
   repetition. Threshold 55. Run it after every rebuild.
3. **Fix the residual wrong-sense cases.** kengdic's own README calls its data
   "quite dirty"; some licensed values are simply wrong. There is no rule for this —
   it needs the Tier 4 QA pass.
4. **Watch the Vietnamese caveat.** Unihan `kVietnamese` gives the *Sino-Vietnamese
   reading* (`水 → thuỷ`), not the everyday word (`nước`). It is recorded as such in
   `dictionary_metadata.vietnamese_source`. Do not present readings as translations.

### Rejected, with reasons (do not revisit without new evidence)

| source | why |
|---|---|
| Pleco "Multilingual Pleco Database" | commercial product, no licence — presumed not redistributable |
| Big BKRS (bkrs.info) | scraped site, states no licence |
| Facebook MUSE | **CC BY-NC 4.0** — NonCommercial, incompatible with selling the app |
| PanLex | **CC BY-NC-SA 4.0** — NonCommercial (was wrongly recorded as CC0) |
| `LiudmilaLV/json_hsk` | **no LICENSE file at all**; ships `pars_bkrs.py` (scrapes BKRS) |
| CFDICT | licence never stated by its own project |
| "Hán-Việt DB" | source not identified at all |
| Hindi WordNet (IIT Bombay) | GPL3/FDL **but "for commercial use, write to Prof. Bhattacharyya"** |
| RuWordNet | self-contradictory: "non-commercial" *and* "CC BY-SA 4.0" |
| Taiwan MOE 重編國語辭典 | CC BY-**ND** — NoDerivatives forbids merging into a dataset |
| `0reveur0/WenZi` | advertised as CC BY-SA 4.0 Chinese–Vietnamese; **its `vietnamese` field is English** (0.0% contain Vietnamese letters, 49% plainly English) and its `hanviet` holds one character's reading of the word. It is Unihan + CC-CEDICT, both of which we already have properly. |

**Licence-laundering warning.** `uhh-lt/hindi-wordnet-extension` is tagged MIT and its
README says "Hindi WordNet data" — but the underlying data is IIT Bombay's, which
requires permission for commercial use. **A third party cannot relicense what it does
not own.** `binjang/NIKL-korean-english-dictionary` on HuggingFace is tagged `mit` for
the same reason; NIKL's own terms have not been verified. Treat third-party licence
tags as claims, not facts.

---

## 6. Tier 2 — Wikidata labels and Wikipedia langlinks

**Status:** built — `scratch/import_wikidata_translations.py`,
`scratch/clean_wikidata_translations.py`, `scratch/download_zhwiki_dumps.py`,
`scratch/parse_zhwiki_dumps.py`.

### How the hop works

Neither source contains Chinese→French. Both are reached through a shared **Q-id**:

```
Chinese headword ──> Q-id ──┬──> Wikidata label in fr       (CC0)
                            └──> frwiki article title       (CC BY-SA 4.0)
```

**Coverage measured:** Wikidata labels only cover ~2% of our 125,132 headwords. The
langlink route covers more, which is why the zhwiki sitelink dumps were parsed.

### The 90% proviso — get this right

| route | rows | licence |
|---|---|---|
| Wikidata label | ~29,000 (10%) | **CC0** — no obligation |
| Wikipedia langlink | ~261,000 (90%) | **CC BY-SA 4.0** — share-alike |

**90% of tier 2 carries share-alike.** This does not change anything operationally —
CC-CEDICT already imposes CC BY-SA on the whole dataset — but it must not be described
as "CC0 bulk data". The attribution file must name Wikipedia.

### Cleaning

Raw Wikidata labels are article titles, not dictionary entries, and many name the
wrong kind of thing. `clean_wikidata_translations.py` filters on **P31 (instance of)**:

```
reject  disambiguation page · Wikimedia category/template/list · family name · given name
        taxon without a common name · toponym matching the Chinese name · year/date
reject  does not contain Latin letters (for Latin-script targets)
reject  identical to the English gloss · over 40 chars · no target-script characters
```

**Result: 42,863 of 290,371 rows rejected before import.**

### Quality

Roughly 40% agreement with tier 1 where both exist. Acceptable for gap-filling,
noticeably weaker than tier 1. Never overwrite tier 1 with it.

---

## 7. Tier 3 — English gloss → cloud machine translation

**This is the workhorse: it closes 1,183,367 cells.**

### 7.1 Why gloss and not character — the central measurement

78 single-character headwords, same tool, same metric, same run:

| input sent to the translator | round-trip success |
|---|---|
| the Chinese character (`楦`) | **28.2%** |
| the English gloss (`(wooden) shoe last`) | **82.1%** |
| | **+53.8 points** |

```
楦 (char)  → "Durable"             ✗ wrong
楦 (gloss) → "forme de chaussure"  ✓ correct
```

Rare Chinese characters are almost absent from MT training data; "shoe last" →
"forme de chaussure" is ordinary, well-covered English→French. **Every headword in
the database already has an English gloss, so this bridge is always available.**

### 7.2 Provider selection

Measured, 100 words × 6 languages × 2 tools, 1,200 translations, zero errors:

| provider | 1,200 translations | CJK leaked into output | notes |
|---|---|---|---|
| **Azure Translator** | 275 s | **0.0%** | invents romanisations (`Zhi`, `Huang`), 2.0% sentence fragments |
| **Google Cloud Translation v3** | 187 s | **3.0%** (15.4% on single characters) | fails by returning the Chinese unchanged |
| Amazon Translate | untested | — | no AWS credentials available |

**Decision: Azure is primary, Google is the fallback and the cross-check.**

Rationale: returning the input unchanged (Google's failure mode) is the more dangerous
failure, because it silently puts Chinese into a French column and is easy to miss.
Azure's romanisation failure is caught by a script check.

### 7.3 Cost — measured, not estimated

- gap = **1,183,367 slots**
- cleaned gloss = **19.0 chars / 2.98 words**, 89,088 unique after 23% dedup

| scope | characters | words | Azure F0 | Azure paid |
|---|---|---|---|---|
| all 13 languages | 19.39M | 3,088,465 | **$0 in 9.7 months** | ~$194 |
| `hi ko vi th` only | 6.50M | 1,032,731 | **$0 in 3.25 months** | ~$65 |

**Azure Translator F0 includes 2,000,000 characters per month, free, recurring, with no
expiry** — verified against our own resource (§12.1b). It resets on the 1st. So the four
weakest languages cost nothing; the entire dataset costs nothing if you are willing to
spread it over about ten months.

Per month, the free tier translates roughly **105,000 gloss strings / 314,000 words**.


### 7.4 Implementation route

1. `clean_gloss()` — see §9.
2. Dedup by cleaned gloss → 89,088 unique strings corpus-wide (fewer per language).
3. Batch (Azure accepts up to 100 strings / 50,000 chars per request).
4. Translate to all 13 targets.
5. Fan back out to headwords.
6. Write with `tier = 'mt-gloss'`, only where the cell is empty.

### 7.5 Expected result — set expectations honestly

Measured agreement with licensed dictionary values: **Google 52.5%, Azure 49.2%**
(by language: Google fr 55.0 / de 50.0; Azure fr 53.3 / de 45.0).

That sounds low, and partly it is: machine translation returns **one** sense, dictionaries
list **several**. `摆渡 → "Ferry"` against truth `"bac; bateau; ferry"` is a correct
answer scored as a partial match; `毛病 → "faute"` against `"défaut; dégât; faute"`
likewise. The disagreements skew toward *different valid sense* more than *wrong*.

**Conclusion: ~50% agreement means tier 3 is a legitimate gap-filler and not a
replacement for tier 1.** Both facts are now quantified rather than assumed.

---

## 8. Tier 3b — LLM polish, and Tier 0

### Tier 3b

For cells tier 3 scored badly (§10) and that are still wanted. The LLM receives the
gloss, the part of speech, and optionally the licensed value in a language we *do*
trust, and produces the missing language. It is a *second opinion*, never the first.

**Judge status: never completed.** `gemini-3.6-flash` — the model the app hardcodes —
is retired and returns 404. The availability sweep found:

| model | status |
|---|---|
| `gemini-3-flash-preview` | ✅ 1.5 s |
| `gemini-3.1-flash-lite` | ✅ 5.3 s |
| `gemini-3.5-flash-lite` | ✅ 10.3 s |
| `gemini-3.7`, `gemini-3.8` | ❌ 503 |
| `gemini-3.1-pro` | ❌ 429 |

Two runs died on sustained 503s. The harness
(`scratch/final_translation_test.py --judge-only`) checkpoints every 25 rows and is
resumable. OpenRouter `:free` models are the fallback judge if Gemini stays down.

**This is not only a dictionary problem.** The app hardcodes `gemini-3.6-flash`, and the
confirmed rate limits show what that costs:

```
model                    RPM    TPM       RPD
gemini-3.6-flash  (used)   5    250K       20     <- what the app asks for
gemini-3.1-flash-lite      15    250K      500    <- what it should ask for
```

**RPD 20 means the app can make twenty requests per day, total, for the whole app.** Any
moderate usage exhausts it and every subsequent call fails — which is exactly the live P1
already logged in the repo (429/503 with no backoff), now explained with a number rather
than a symptom. Switching the model string alone is a **25× increase in daily capacity**,
and it is independent of everything else in this document.


### Tier 0

`functions/dictionary-expansion.js` already generates deeper English content for a word
on demand and **caches it**. It is depth-on-demand, not base coverage.

**Do not point it at 125,132 words to fill a language column.** It is a per-request path
with a cache; sweeping it is a cost incident and it is not written for batch use. If
tier 3b is wanted at scale, use a batch-capable endpoint, not this.

---

## 9. Gloss preparation — the cleaner

CC-CEDICT is written for humans reading a dictionary, not for machine translation.
Feeding it raw produces confidently wrong output in 13 languages. This step is not
optional and is the highest-leverage 40 lines in the pipeline.

### 9.1 What has to go

```text
CL:把[ba3]        classifier notation — meaningless in French
(Tw) (lit.) (fig.) (old) (dialect) (slang) (onomatopoeia)
surname Wang      the entry is about a surname, not a meaning
abbr. for 北京    a cross-reference, not a definition
variant of 掛     a cross-reference, not a definition
see 挂[gua4]      a cross-reference, not a definition
used in 萬俟[Mo4 qi2]      ← the one that bit us (§9.3)
to run            verb infinitive marker — some targets want the bare verb
second; third     only the first sense should be translated
```

### 9.2 The order that works

```python
def clean_gloss(text):
    out = re.split(r"[;,/]", text or "")[0]   # 1. FIRST SENSE ONLY
    for pattern, repl in CLEAN:               # 2. strip notation
        out = pattern.sub(repl, out)
    out = out.strip(" .;,-")                  # 3. tidy edges
    if out.lower().startswith("to "):         # 4. drop infinitive marker
        out = out[3:]
    return out.strip()
```

**Step 1 must come first.** Splitting on `;` before stripping `CL:` means the classifier
notation is discarded along with senses 2..n, and the stripper has less to do. Doing it
in the other order leaves fragments.

### 9.3 The bug this design shipped with

Measured, from `scratch/confidence_experiment.json`:

```
万  →  French  "utilisé dans 万俟[Mo4 qi2]"
```

Chinese survived into the French output. Cause: CC-CEDICT writes entries like
`used in 万俟[Mo4 qi2]`, and the cleaner's pattern list covered `see`, `variant of` and
`abbr. for` but **not `used in`**. The translator dutifully translated "used in" and
passed the Chinese through.

**Fix required before any bulk run:**

```python
(re.compile(r"\bused in\b.*", re.I), " "),
(re.compile(r"\bCL:.*", re.I), " "),
(re.compile(r"\bsee also\b.*", re.I), " "),
```

The general lesson: **the cleaner's pattern list must be derived from the source's
actual notation vocabulary, and the output must be re-checked for CJK after
translation** — because a cleaner gap is invisible until you read the output.

### 9.4 Verification of the cleaner itself

Run before every bulk translation:

1. **CJK residue check** — no cleaned gloss may contain a CJK codepoint. This is the
   check that would have caught §9.3 before it cost anything.
2. **Empty check** — count how many glosses clean down to nothing (cross-reference-only
   entries). They must be *skipped*, not sent as empty strings.
3. **Length check** — p01/p50/p99 of cleaned length. Anything over ~60 chars is a
   sentence, not a gloss, and should be re-examined.
4. **Sample review** — print 30 cleaned glosses and read them. Cheap, and catches
   whole categories of nothing.

---

## 10. Tier 4 — The confidence score

The score answers one question: **given a machine-generated value, should we ship it or
leave the cell empty?**

### 10.1 The experiment that measured it

`scratch/confidence_experiment.py` and `scratch/confidence_followup.py`.

Method: take 120 headwords that **already have** a licensed value in `fr`/`de` (so we
have ground truth). Machine-translate the gloss with Google and Azure. Then ask whether
the score predicts agreement with the licensed value.

### 10.2 Gate vs signal — the lesson from v1's failure

The first design used eight weighted signals. It failed, and the failure is instructive:
**a signal that is almost always true cannot discriminate.**

| signal | fired | verdict |
|---|---|---|
| S1 output contains no CJK | 98% | ❌ near-constant |
| S2 output is not a fragment | **100%** | ❌ **zero information** |
| S3 output is not the input copy | 94% | ❌ little |
| S4 output length is sane | 98% | ❌ little |
| **S5 round-trip agrees** | **42%** | ✅ **discriminates** |
| **S6 reverse pivot** | **1%** | 🔴 **broken** |
| **S7 cross-tool consensus** | **83%** | ✅ **discriminates** |
| S8 output looks like a lemma | **100%** | ❌ zero |

Consequence: 201 of 240 rows landed in the top band and the top band was only 55.2%
accurate — the extra signals had added a constant floor, not information.

**Therefore split them by role:**

```
GATES  (near-constant in practice; failure => instant reject, no score involved)
    output contains CJK             catches Google give-ups + cleaner leaks (§9.3)
    output is a sentence fragment   catches Azure's clause failure
    output equals the English input catches untranslated passthrough
    output is empty                 nothing to ship

SIGNALS (carry information; these are the score)
    +3  cross-tool consensus        strongest single signal
    +3  round-trip agrees
    +2  reverse pivot (once fixed)
```

### 10.3 What the signals are worth — measured

```
cross-tool consensus    agree 55.0%   vs   disagree 40.0%   (+15 points)
round-trip             pass  54.5%   vs   fail     42.1%   (+12 points)
reverse pivot          1% fired     =>  useless as built (§10.5)
```

### 10.4 The score, and the gradient it produces

Scored on the discriminating signals only, 0–3:

| signals passed | n | agreement with licensed truth |
|---|---|---|
| **0** | 27 | **29.6%** |
| **1** | 125 | **52.0%** |
| **2** | 85 | **57.6%** |
| 3 | 3 | 0.0% (n too small to read) |

**A 2× gradient.** Low confidence genuinely means wrong more often. This is the score
working, and it is the justification for the whole tier-4 design.

Baseline for comparison — the raw numbers with no scoring at all:
Google **52.5%**, Azure **49.2%**.

### 10.5 The broken signal, and why it matters

The reverse pivot takes the machine's output, translates it back to Chinese, and checks
whether the original headword reappears. It fired on **3 of 240** rows — useless.

```python
rec["pivot_ok"] = any(c in (piv or "") for c in rec["hanzi"])   # too strict
```

For `摆渡 → "Ferry" → 渡轮`, the meaning is right but the characters are not the same.
Exact-character matching rejects correct answers.

**Replacement design** — three levels, cheapest first:

1. **Shared-character test** — the pivot contains any character of the headword.
   `摆渡` vs `渡轮` shares `渡` → pass. Cheap and much broader.
2. **Synonym-set test** — compare the pivot against a CC-CEDICT-derived synonym set for
   the headword (buildable from shared English glosses, which we already have).
3. **Disable and rely on consensus** — consensus measured better than the pivot anyway.
   A broken signal contributes noise, not information; deleting it is a valid fix.

**Until it is fixed, the pivot must not be scored.** It is currently in the code path
and would reward the 1% of rows it happens to fire on.

### 10.6 Bands and routing

From the measurement above:

| signals | agreement | action |
|---|---|---|
| **0** | 29.6% | **discard** — leave the cell empty |
| **1** | 52.0% | **ship**, tagged `medium` |
| **2+** | 57.6% | **ship** |
| any gate failed | — | **discard**, unconditionally |

Optional refinement: route band-0 rows to tier 3b (the LLM second opinion) rather than
discarding outright, if a language is important enough to justify the cost.

### 10.7 Honest limitations

1. **The reference is noisy.** `不恭` scored **21 (top band) yet "disagreed"** — because
   the licensed value was `"courtoisie; injure"` for a word meaning *disrespectful*.
   The machine may have been right and the dictionary wrong. **Agreement scores are
   limited by the quality of the ground truth, not only by the MT.** A cleaner
   experiment would use several licensed sources and treat majority agreement as truth.
2. **Sample size is 120 rows.** The bands are directionally right; the exact percentages
   are not yet stable enough to hard-code as thresholds.
3. **Single-sense vs multi-sense.** §7.5 — some "disagreement" is a valid alternative
   sense. The true error rate is lower than the agreement rate suggests.
4. **The score has not been tested on the languages it matters most for.** `fr`/`de` are
   the best-resourced. `hi`, `th`, `vi`, `ko`, `ar` are where tier 3 will be used and
   have not been calibrated.
5. **`safer` is not `correct`.** A high score means "no detected defect", not "verified".
   No purely automatic signal can confirm meaning.

---

## 11. Failure modes catalogue

Every entry here was observed on real output, not hypothesised. The guard column is
what the pipeline must do about it.

### 11.1 Observed failure modes

| # | failure | evidence | frequency | guard |
|---|---|---|---|---|
| F1 | **Input echoed unchanged** (Chinese in the French column) | Google returns the Chinese untouched | 3.0% overall, **15.4% on single characters** | **gate**: CJK codepoint in output → reject |
| F2 | **Invented romanisation** | Azure returns `Zhi`, `Huang` instead of a translation | ~2% | gate: output is a lone capitalised Latin word with no target-language letters, or matches pinyin syllable regex |
| F3 | **Sentence fragment / clause** | Azure returns a subordinate clause beginning with a conjunction | 2.0% | gate: leading conjunction (`and`, `that`, `which`, `um zu`, `à savoir`) or trailing `…` |
| F4 | **Cleaner leak** — notation never stripped, so Chinese rides along | `万 → "utilisé dans 万俟[Mo4 qi2]"` (§9.3) | present in sample | gate: CJK check *after* translation, plus cleaner unit test |
| F5 | **Wrong sense chosen** | `楦 (char) → "Durable"` | common on rare characters | avoided by design — translate the **gloss**, not the character (§7.1) |
| F6 | **English passthrough** | output normalises equal to input | measured, low | gate: normalised equality with the English gloss |
| F7 | **Notation translated literally** | `CL:` and `(Tw)` become words in the target language | avoided by the cleaner (§9) | fixed in preparation, gate as backstop |
| F8 | **Wiki article title instead of a word** | tier 2 raw labels name people, taxa, places | 42,863 of 290,371 rejected | P31 filter (§6) |
| F9 | **Source is lying about its licence** | WenZi's `vietnamese` field is 49% English under a CC BY-SA 4.0 claim | — | verify field contents before trusting any source (§5, §14) |

### 11.2 Why F1 is the failure that matters most

A wrong translation looks like a translation. `"Durable"` in a French column is
unremarkable — a user will assume it is French for something and move on.

But **Chinese in a French column is not merely wrong, it is a visible defect**, and it
is the one failure mode that any automated check can catch with total reliability.
Detecting CJK in a non-CJK target column is a one-line test with no false positives and
no false negatives.

**This is why Azure is primary despite being slower** (275 s vs 187 s per 1,200):
Azure's failure is a 2% romanisation that script-checks catch; Google's failure is a
3–15% echo that is worse where it hurts most — single characters, which is exactly the
rare-character case tier 3 exists to serve.

### 11.3 Guard implementation rules

1. **Gates run before scoring, always.** A gated row is discarded; it never gets a score.
2. **Gates are cheap; run them on the cleaned gloss *and* the output.**
3. **Every gate must be tested against known-bad rows.** The experiment JSON contains
   real F1/F3 examples — use them as fixtures.
4. **Log every rejection with its reason.** The rejection histogram is the fastest way
   to find a new failure mode: a gate firing 40% of the time on one language is a bug,
   not a filter.

---

## 12. Cost model

All figures derived from the measured gap and the measured 1,200-translation run.

### 12.1 The arithmetic

Measured from `scratch/dictionary_v2.db` with the production cleaner
(`scratch/free_tier_capacity.py`):

```
headwords with a usable cleaned gloss   115,552  (92.3% of 125,132)
unique cleaned first-sense glosses       89,088  (dedup saves 23%)
avg cleaned gloss                        19.0 chars  /  2.98 words
p50 / p90 length                         15 / 38 chars
```

Per-language cost, after dedup and after skipping CJK-tainted glosses:

```
lang    gap      unique   chars     words     months @2M/mo
ar     91,866   73,507   1,611,899   257,140   0.81
de     50,018   44,742   1,064,039   169,963   0.53
es     84,015   67,933   1,542,915   245,701   0.77
fr     82,701   66,435   1,474,650   236,701   0.74
hi    102,431   80,620   1,773,512   280,477   0.89
id     74,340   61,634   1,359,192   213,684   0.68
it     86,092   69,417   1,578,029   251,213   0.79
ja     84,211   67,990   1,488,431   239,231   0.74
ko     84,027   67,070   1,499,626   239,229   0.75
pt     91,246   72,877   1,597,184   255,085   0.80
ru     63,201   52,632   1,172,695   187,016   0.59
th     91,792   74,158   1,645,901   260,823   0.82
vi     90,905   72,134   1,581,208   252,202   0.79
------------------------------------------------------------
ALL                      19,389,281  3,088,465   9.69
  of which `hi ko vi th`  6,500,247  1,032,731   3.25
```

**Roughly one language per month on the free tier.**

### 12.1b Capacity: how much the free tier actually buys

Verified against our own resource via the Azure management API:

```
resource   1344252   Microsoft.CognitiveServices/accounts    TextTranslation
sku        F0        resource group SinoSpark   location westus
limit      2,000,000 characters
current    21,047    (the 1,200-translation benchmark run)
resets     2026-10-01T00:00:00Z      -> monthly, on the 1st
status     Included                  -> free, not billed
```

**2,000,000 characters per month, free, every month, indefinitely.** There is also a
per-hour rate limit of 2M chars/hour, so the monthly quota can be consumed in a single
burst — consuming it "evenly" avoids out-of-quota errors.

What that buys, at our measured 19.0 chars / 2.98 words per gloss:

```
per month      ~105,000 gloss strings
               ~314,000 words
                2,000,000 characters

per year       ~1,260,000 gloss strings
               ~3,760,000 words
               24,000,000 characters
```

So the entire 13-language gap (89,088 unique glosses per language × 13) fits inside
**one year of the free tier**, with headroom for verification. The four weakest
languages fit in **3.25 months**.

### 12.1c What actually gets billed

Microsoft's FAQ is explicit about three things that change how this must be built:

1. **Repeated translations are re-billed.** "A repeated translation, even if you
   previously translated the same text." There is **no server-side dedup** — so
   client-side dedup and a persistent cache are not optimisations, they are mandatory.
   Re-running a rebuild without a cache re-bills the whole corpus.
2. **Detect and BreakSentence are not counted.** Free. Useful for the script/language
   gates in §11.
3. **Characters are Unicode code points**, and spaces and markup count. A space is a
   character. `zh→` translations still bill even when the content comes back unchanged —
   which means Google's echo failure mode (§11.1 F1) is *billed* as well as wrong.

Attribution is not required, but Microsoft recommends informing users that content is
machine-translated — which §14.1 already mandates via `translation_is_machine`.

### 12.1d Verification multiplies the volume

Each verification method re-sends the same text, so it multiplies rather than adds:

```
translate only              x1   19.4M   -> 9.7 months free
+ round-trip to English     x2   38.8M   -> 19.4 months free
+ cross-tool consensus      x3   58.2M   -> 29.0 months free
```

**Verification, not translation, is the real cost driver.** On a paid S1 tier at $10 per
million characters that is $194 / $388 / $582 respectively; on F0 it is simply time.

Dedup and first-sense-only are what keep it tractable at all: raw, the gap is
1,183,367 slots × 41.2 chars ≈ **48.8M characters for a single pass** — 2.5× the deduped
first-sense job, and 2.5× the time.


### 12.2 Scoped options

Basis: Azure Translator **F0 = 2,000,000 characters/month free, recurring monthly**
(verified on our own resource, §12.1b); **S1 = $10 per million characters**.

| scope | translate only | + round-trip | + consensus |
|---|---|---|---|
| `hi ko vi th` (6.50M) | **$0 in 3.25 months** / $65 | **$0 in 6.5 months** / $130 | **$0 in 9.75 months** / $195 |
| all 13 (19.39M) | **$0 in 9.7 months** / $194 | ~19.4 months / $388 | ~29 months / $582 |

**Recommendation: start with `hi ko vi th`.** They are the four weakest columns
(11–26% filled), they are where tier 3 adds the most, and translation plus full
round-trip *and* consensus verification is **free within ten months on F0** — or $195 if
you want it this week.

### 12.3 The free tier is permanent, and that changes the plan

F0 gives 2,000,000 characters per month indefinitely, at no cost, with the quota
resetting on the 1st of every month. **There is no reason to pay for the first pass.**

Two consequences worth stating plainly:

- **The whole job fits in the free tier.** Every language, every gap, with full
  verification, inside about two and a half years — or ten months if you accept
  translation plus a single verification pass. Paying $194 buys speed, not capability.
- **The quota is a pacing problem, not a budget problem.** Which means the pipeline
  should be built to be *runnable in monthly instalments* from the start: checkpointed,
  resumable, cache-backed. A batch job that must complete in one sitting is the wrong
  shape for this constraint (§12.1c — re-runs are re-billed, so resumability is not just
  convenient, it is what stops the quota being wasted).


### 12.4 Other providers

| provider | measured | notes |
|---|---|---|
| Google Cloud v3 | 187 s / 1,200 | ~$20 per million chars |
| Azure | 275 s / 1,200 | **$0 on F0**; primary |
| Amazon Translate | not tested | no credentials available |
| Gemini | unavailable | 404 on the hardcoded model, 503s on the rest (§8) |

---

## 13. Verification and QA

### 13.1 The verification ladder

Cheapest and strongest first. Each rung is independent; agreement accumulates.

| # | method | strength | cost | catches |
|---|---|---|---|---|
| 1 | **Script check** — no CJK in a non-CJK column | ★★★★★ (zero false positives) | free | F1, F4, F7 |
| 2 | **Gate checks** — fragment, passthrough, empty | ★★★★ | free | F3, F6 |
| 3 | **Cross-tool consensus** — Azure and Google agree | ★★★★ (+15 pts, measured) | ×2 | broad |
| 4 | **Round-trip** — output → English ≈ input gloss | ★★★ (+12 pts, measured) | ×2 | sense drift |
| 5 | **Reverse pivot** — output → Chinese ≈ headword | ★★ **currently broken** | ×2 | meaning |
| 6 | **Cross-language consistency** — the 13 outputs for one gloss should agree with each other | ★★★ | free (already have the 13) | outliers |
| 7 | **Licensed agreement** — where tier 1 exists, compare | ★★★★★ | free | everything |
| 8 | **LLM judge** — semantic equivalence | ★★★★★ | slow, currently unavailable | nuance |
| 9 | **Human spot-check** — 200 random rows per language, read | ★★★★★ | manual | everything |

**Rung 6 is free and underused.** If `fr` and `de` and `ru` all say "ferry" but `vi`
says something unrelated, the `vi` value is the outlier. We already hold all 13 outputs
for every gloss, so this needs no API calls at all.

**Rung 7 is the strongest available test.** Where a licensed value exists we can measure
the machine directly — that is exactly the experiment in §10.1. Where it does not,
there is no ground truth and the score can only measure *absence of defects*.

### 13.2 Calibration procedure

Run before and after every bulk job:

1. **Build a ground-truth set.** 300 headwords per language that **do** have a licensed
   value, sampled with `ORDER BY RANDOM()` and excluded from tier-2 provenance.
2. **Machine-translate them** with the production pipeline, unchanged.
3. **Measure agreement** per signal band. Compare against the §10.4 baseline.
4. **Tune thresholds**, or accept the default bands.
5. **Freeze the thresholds** and record them in the build script. Re-tuning per run
   without recording makes results incomparable between runs.

### 13.3 Regression fixtures

Keep a small JSON of known-bad rows and assert the pipeline rejects them:

```
F1 fixture  a row where the provider returned the Chinese unchanged
F2 fixture  a row where the provider returned a romanisation ("Zhi")
F3 fixture  a row where the provider returned a clause fragment
F4 fixture  万 → "utilisé dans 万俟[Mo4 qi2]"
```

These four rows are cheap and they guard the four gates. Without them a cleaner or
weighting change silently regresses and nobody notices until a user does.

### 13.4 The acceptance gate

The app discards any database that is missing a `definition_*` column or lacks
`dictionary_schema_version = '2'`. An earlier `dictionary_accepted.db` failed both
(no `hi`/`ko`/`vi`, version `accepted-1`). **Every rebuild must be run through the same
gate the app uses**, not a proxy for it.

### 13.5 Monthly health check

```
rows per tier, per language      (is any column still 0%?)
gate rejection histogram         (a gate firing 40% is a bug, not a filter)
score band distribution          (a shift means the provider changed)
licensed-vs-mt agreement         (drift in the providers' quality)
```

---

## 14. Provenance, licence and obligations

### 14.1 What must be recorded

`dictionary_v2.db` already has a `dictionary_metadata (key, value)` table using the same
convention as `tooling/add_dictionary_attribution.py`. Existing keys include
`dictionary_schema_version = '2'`, `dictionary_content_version = 'accepted-sources-v2'`,
`headwords_source`, `dictionary_sources_new_v2`, `dictionary_sources_excluded`,
`omw_attribution`, and per-language `language_<lang>_word_count` /
`language_<lang>_added_v2`.

**Tier 3 and 4 add these keys:**

```
translation_method            "cloud MT (Azure Translator primary, Google fallback)"
translation_source_language   "en"
translation_input             "CC-CEDICT first-sense gloss, cleaned"
translation_is_machine        "1"
translation_date              "<ISO date of the run>"
translation_coverage_<lang>   "<n> rows machine-translated"
translation_verification      "gates + consensus + round-trip; score bands <n>"
translation_confidence_bands  "<recorded thresholds, frozen>"
translation_exclusions        "rows discarded by gate or by score band <n>"
```

**`translation_is_machine` is not optional.** The app must be able to tell a user, and
ideally label it in the UI, which values are machine-generated. That is both an honesty
requirement and, for CC BY-SA share-alike, part of recording modifications.

### 14.2 Licence status of each tier

| tier | source | licence | obligation |
|---|---|---|---|
| 1 | CC-CEDICT | CC BY-SA 4.0 | attribute, share-alike |
| 1 | HanDeDict | CC BY-SA 2.0 | attribute, share-alike |
| 1 | WikDict TEI | CC BY-SA 3.0 | attribute |
| 1 | WOLF | CeCILL-C | attribute, licence text |
| 1 | MultiWordNet / ItalWordNet | CC BY 3.0 / ODC-BY | attribute |
| 1 | OMW layers | CC BY-SA 3.0 + GFDL | attribute, share-alike |
| 1 | Thai WordNet | NECTEC, commercial permitted | attribute |
| 1 | kengdic | MPL 2.0 **or** LGPL 2.0+ | attribute |
| 1 | Unihan | Unicode License v3 | attribute |
| 2 | Wikidata labels | **CC0** | none |
| 2 | Wikipedia langlinks | **CC BY-SA 4.0** | **attribute, share-alike** |
| 3 | Azure output | Microsoft terms | attribute not required; **disclose machine translation** |
| 3 | Google output | Google terms | same |

### 14.3 The honest summary of the whole dataset

```
The shipped dataset is a derived work.
CC BY-SA already applies to it (CC-CEDICT is the headword spine), so share-alike
is not a new constraint introduced by any single source — but it IS a constraint,
and Wikipedia's CC BY-SA 4.0 contributes to it.
90% of the tier-2 rows carry share-alike. Do not describe the dataset as CC0.
Machine-translated values are marked so they can be labelled in the UI.
Per-row provenance is recorded in this dataset. That is the single most important
difference from the shipped v1 -- it is what makes the next audit a query
rather than an archaeology project.
```

### 14.4 What not to do

- **Do not ship a value from a NonCommercial source.** MUSE and PanLex are out
  permanently; no amount of cleaning fixes a licence.
- **Do not trust a third party's licence tag over the upstream source's terms.**
  §5, licence laundering.
- **Do not overwrite, or silently blend, licensed values with machine values.** Both
  the licence trail and the quality signal depend on being able to tell them apart.
- **Do not remove the attribution keys during a rebuild.** They live in the database
  deliberately, so the licence travels with the data.

---

## 15. Open questions and known gaps

Stated plainly, because a strategy document that hides its gaps is a liability.

| # | gap | impact | path forward |
|---|---|---|---|
| 1 | **Thresholds are provisional.** Bands come from 120 `fr`/`de` rows. | Bands may be wrong for the languages they matter most for | calibrate on 300 rows × `hi ko vi th` |
| 2 | **The reverse pivot is broken** (1% fired, §10.5) | A scored signal contributes noise | shared-character or synonym test; or delete it |
| 3 | **The cleaner has a known gap** (`used in`, `CL:`, §9.3) | Chinese leaks into output | fix before any bulk run; add CJK-residue test |
| 4 | **The score is uncalibrated for `ar hi ko th vi`** | These are the target languages | run the §13.2 calibration per language |
| 5 | **The LLM judge never ran** (404 + 503s) | Tier 3b is unbuilt | retry Gemini, or OpenRouter `:free` |
| 6 | **Amazon Translate untested** | A third opinion is unavailable | no credentials |
| 7 | **Ground truth is single-source and noisy** (§10.7) | Agreement figures are pessimistic and fuzzy | multi-source majority as truth |
| 8 | **Agreement metric is strict on multi-sense values** (§7.5) | Understates true quality | credit partial/sense overlap |
| 9 | **The app hardcodes a low-quota model** (`gemini-3.6-flash`, **RPD 20**) — it is not retired, it is available and simply capped at 20 requests/day | Live P1: 20 requests/day for the whole app, which is why it 429s constantly | swap to `gemini-3.1-flash-lite` (**RPD 500**) + retry/backoff |
| 10 | **Tier 3b cost is unmeasured** | Scaling is unknown | measure once the judge works |

**Resolved since this document was started:**

- ✅ **The free-tier RPD** (previously unknown and load-bearing): **500/day** for the
  Flash-Lite models, 20/day for Flash, 14,400/day for Gemma 4 31B; TPM 250K, RPM 15.
  Source: AI Studio, which is the only place these are published (§12.6).
- ✅ **Gemma as a translator**: tested and rejected on measurement (§12.7).
- ✅ **Whether example sentences need translating**: they do not (§2b).

### The single most useful next experiment


**Gloss-MT over words that already have a licensed value, at 300 rows per target
language, across `hi ko th vi ar`.** That one run would tell us whether the §10.4 bands
hold outside `fr`/`de`, and whether the score is a safe universal gate or only a
fallback discriminator. Everything else is engineering; this is the open question.

---

## 16. Implementation plan

### Phase 0 — fix what is known broken (no cost, do first)

```
[ ] add `used in`, `CL:`, `see also` to the gloss cleaner          (§9.3)
[ ] add the CJK-residue unit test on cleaned glosses               (§9.4)
[ ] stop scoring the reverse pivot; rework or delete it            (§10.5)
[ ] build the four regression fixtures                             (§13.3)
[ ] rebalance: gates vs signals, per §10.2
```

### Phase 1 — the four weakest languages, free on F0

```
[ ] wire tier 3 into build_dictionary_v2.py, writing only into empty cells
[ ] per-row tier tag: 'mt-gloss', plus the score and band
[ ] dedup by cleaned gloss; cache by (gloss, lang)
[ ] Azure primary, Google for consensus; run over hi/ko/vi/th
[ ] gates first, then score; 0 signals -> discard
[ ] record dictionary_metadata keys                              (§14.1)
```

### Phase 2 — calibrate, then decide

```
[ ] run the 300-row-per-language ground-truth calibration        (§13.2)
[ ] freeze thresholds into the build script, and record them
[ ] decide: is the score good enough to gate the other 9 languages?
[ ] if yes, extend; if no, keep tier 3 to hi/ko/vi/th
```

### Phase 3 — the residual and the app

```
[ ] fix gemini-3.6-flash + retry/backoff + model chain            (live P1)
[ ] retry the LLM judge; wire tier 3b for band-0 rows
[ ] label machine-translated values in the UI
[ ] update the attribution file and third_party/dictionary-v2.md
[ ] re-run scripts/score_dictionary_quality.py, threshold 55
[ ] run the app's acceptance gate on the result                   (§13.4)
```

### Phase 4 — ongoing

```
[ ] monthly health check                                          (§13.5)
[ ] re-run licensed-vs-mt agreement as providers change
[ ] human spot-check, 200 rows per language
```

---

## 17. The one-paragraph version

We cannot legally ship most of what is in the current dictionary, and we cannot tell
which rows are which. So the dataset is rebuilt from sources whose licences were
actually read: licensed dictionaries first (the authority), Wikidata and Wikipedia
second (the bulk), and English-gloss machine translation third (the gaps — 1,183,367
cells). Machine translation is used on the **English gloss, never the Chinese
character**, which lifts success from 28% to 82%; the best of it agrees with curated
dictionaries about half the time, so it is a gap-filler and not a replacement. Every
machine value passes four cheap gates and is then scored on the two signals that
actually discriminate — cross-tool consensus and round-trip — and a low score means the
cell is left **empty**, because a blank column shows the user correct English while a
wrong column shows them confident nonsense. Doing the four weakest languages costs
nothing on Azure's permanent free tier. And every row records which tier produced it,
so the next person can audit this with a query instead of a week of archaeology.





### 12.5 Cost rules

1. **Dedup before translating.** 23% saving, trivially available, and mandatory because
   Azure re-bills repeated text — it does no server-side dedup (§12.1c).
2. **First sense only.** 41.2 → 19.0 chars, a ~54% saving, and the extra senses are
   exactly the ones that make output rambling.
3. **Skip empty cleans.** Cross-reference-only entries cost money for nothing.
4. **Cache by (cleaned gloss, target language).** Rebuilds must not re-bill.
5. **Never re-translate a cell that already has a licensed value.**

### 12.6 Gemini as an alternative engine — measured

An LLM API bills **per token and per request**, not per character, so it competes with
Azure on a different axis: batching many glosses into one request collapses the cost.
Measured on our own key (`scratch/gemini_capacity.py`, `scratch/gemini_time_estimate.py`):

```
model                    gemini-3.1-flash-lite
free-tier RPM            15          <- read from the 429 payload, not assumed
tokens per gloss         9.0 - 9.8   (flat across batch sizes)
alignment                25/25, 120/120, 186/186 lines  - exact

  glosses/request   latency   tokens   tok/gloss
        25           2.69s      246      9.84
       120           3.90s     1153      9.61
       186          14.11s     1673      9.00
```

Batching is nearly free up to ~120 glosses, then latency grows with output length.

**Workload and time.** Deduped, the job is **768,735 translation items** (not
1,183,367 cells) and **7.3M tokens** total.

**The free-tier limits, confirmed from AI Studio** (the authoritative per-project source;
the public docs deliberately publish none of these):

```
model                    RPM    TPM       RPD
Gemini 3.5 Flash Lite     15    250K      500
Gemini 3.1 Flash Lite     15    250K      500
Gemini 3.6 Flash           5    250K       20
Gemini 3.5 Flash           5    250K       20
Gemini 3 Flash             5    250K       20
Gemma 4 31B               30     16K   14,400
```

Using **RPD 500 / RPM 15 / TPM 250K** for the Flash-Lite models:

```
batch   requests   days at RPD 500   TPM at 15 RPM
  50     15,381       30.8           7K/min    OK
 120      6,412       12.8          17K/min    OK
 200      3,849        7.7          28K/min    OK
 300      2,568        5.1          43K/min    OK
 500      1,544        3.1          71K/min    OK
```

**RPD is the binding constraint, and it binds hard — by 43×.** At 15 RPM alone the job
would finish in 0.3 days (21,600 requests/day); the 500/day cap is what stretches it to
days. **TPM never binds** at any batch size (71K/min at batch 500 against a 250K limit),
which is why batching is the only lever that matters: going from batch 120 to batch 500
cuts the job from 12.8 days to 3.1 days without approaching any token limit.

**Consequences for the plan:**

- **Batch as large as alignment allows.** Request count is the currency, not tokens.
  The alignment gate (§12.6 caveat 2) is what makes large batches unsafe, so it must be
  built before batch size is increased.
- **Never use a `-flash` model for this.** They carry **RPD 20** — a 25× smaller daily
  budget than Flash-Lite for no benefit here.
- **Gemma's quota is the most generous** (RPM 30, RPD 14,400 — 28× the daily budget of
  Flash-Lite) and it is still the wrong choice, because it fails the alignment gate and
  runs ~340× slower (§12.7). Generous limits do not compensate for unusable output.


Against Azure F0 (13.6M chars → **6.8 months**), Gemini is roughly **30× faster** in
wall-clock terms. Tokens are not a constraint: 15 req/min × 120 glosses × 9.5 ≈
17,100 tokens/min, far below any free-tier TPM.

**Three caveats, all observed.**

1. **Sustained use is unstable.** Pacing at ~14 requests/min — inside the RPM limit — the
   API returned repeated `503 "experiencing high demand"` responses and then hung on a
   request past its 90 s timeout. A word-by-word translator does not throw 503s; an
   overloaded LLM endpoint does. **Any plan must assume retry/backoff and expect the
   effective rate to be well below the nominal one in practice.**
2. **Batched output can misalign silently.** If a response returns 119 lines for 120
   glosses, every subsequent translation lands on the wrong headword. Alignment was
   perfect in every test here, but this needs an explicit gate — count the lines, and
   reject the whole batch on a mismatch (§11.3). This failure is worse than a blank cell
   because it is invisible.
3. **Quality as a translator is untested.** Nothing here says Gemini's French is better
   than Azure's. The §10 baseline — gloss-MT agreeing with licensed dictionaries ~50% of
   the time — still applies until measured. Run the §13.2 calibration on Gemini output
   before trusting it.

**Cost.** Token-based, so it depends on which Flash variant. 7.3M tokens total
(≈4.2M in, ≈3.1M out) is the measured figure. At Flash-Lite-class rates this is a few
dollars; at full Flash output rates it is several times more, because output tokens
dominate. **Verify current text pricing before budgeting** — the published text input
rates are materially higher than they were a year ago.

**The bonus.** Gemini can serve as the tier-3b **judge** as well as a translator — which
is exactly the verification role (§8) whose original run never completed.

### 12.7 Gemma — tested and rejected as an API translator

Both Gemma models are reachable on our key (`gemma-4-31b-it`, `gemma-4-26b-a4b-it`),
so this was measured rather than assumed. Same 60-gloss French task, same harness:

| | gemini-3.1-flash-lite | gemma-4-31b-it |
|---|---|---|
| glosses in the request | **120** | 5 |
| latency | **3.53 s** | **38.05 s** |
| tokens | 1,105 | 416 |
| tokens per gloss | **9.21** | **83.20** (9× worse) |
| throughput | **34.0 glosses/sec** | 0.1 glosses/sec (**~340× slower**) |
| alignment gate | **PASS 120/120** | **FAIL — 25 lines for 5 glosses** |
| CJK leaked | 0 | n/a (rejected) |
| at 60 glosses | fine | **HTTP 500 Internal error** |

**Three disqualifying findings:**

1. **It fails the alignment gate.** Asked for 5 translations, `gemma-4-31b-it` returned
   25 lines — it appended commentary. §12.6's gate correctly rejected the batch. This is
   the worst possible failure for batched translation, and it happened on the *smallest*
   batch tested.
2. **~340× slower and 9× more tokens per gloss.** 38 s for 5 glosses, where Flash-Lite did
   120 in 3.5 s. `gemma-4-26b-a4b-it` did not return *five* glosses within four minutes.
3. **No quota advantage.** It sits on the same free tier as Gemini, so it is slower *and*
   no cheaper.

**Where Gemma would still make sense.** It is **open-weights** — the only option here that
can run **locally**, with no API key, no rate limit, no per-token cost and no data leaving
the machine. For ~7.3M tokens that is roughly a couple of days of continuous GPU time on
a consumer card, so it is not absurd. But it would be slower than the free API it is
meant to replace, the alignment behaviour above is a real quality risk, and the
instruction-following is weaker on exactly the task we need (rigid one-line-per-input
output). **Revisit only if offline/privacy becomes a hard requirement.**

**Conclusion: use `gemini-3.1-flash-lite` for translation.** It finished a 120-gloss
French batch in 3.53 s at 9.21 tokens/gloss with perfect alignment and no Chinese
leakage — a bigger model is both unnecessary and measurably worse here.










