# The AI Tutor — concept design

**Status:** concept, for review (nothing here is built yet)
**Date:** 2026-10-02
**Supersedes nothing.** Extends what already ships: the character chat's
`ScholarArtefact`, the Echo Hall roleplay, the quiz, the SRS, the tone grader.

---

## 1. The one-line concept

> **The tutor is the app's second interface.** The first is the *curriculum* —
> decks, lessons, SRS, exams, all pre-authored. The second is the *interlocutor*:
> a tutor you can ask anything, whose answer is not a paragraph about Chinese but
> **a thing you can use** — a drill, a diagram, a diagnosis, a paper.

Asked "why does 好 have a 女 and a 子?", a chatbot writes three sentences. A tutor
opens the character's anatomy, marks the 子, and offers two ways to practise it.

### Positioning, stated plainly

* **Not** a general chatbot with a Chinese prompt. It has no opinions about
  anything outside the learner's Chinese.
* **Not** a replacement for the curriculum. It is the layer that *prescribes*
  from it, *explains* it, and *examines* it.
* **Its unfair advantage** is the data the app already owns: 9574 characters with
  radicals and decompositions, stroke vectors with 1000×1000 coordinates, a
  266 MB dictionary, per-character mastery and SRS state, on-device tone grading,
  and the learner's own error history. A generic chat model has none of it.

---

## 2. The three jobs (what makes it a tutor)

| Job | Question it answers | Evidence it uses | Output |
|---|---|---|---|
| **Explain** | "What is this / why is it like this?" | the context the learner is in (this character, this sentence, this mistake) + dictionary/metadata | prose **plus** artefacts that show the thing |
| **Prescribe** | "What should I do next?" | SRS due queue, stroke-match failures, tone errors, mastery levels, exam history, time available | a plan: an ordered set of drills, a remedial lesson, a review slot |
| **Examine** | "Am I actually able to do this?" | blueprints + the app's own vocabulary | a paper, timed and scored, with a report that feeds SRS |

Everything it can do is one of those three. Anything that is not is out of scope
by design.

---

## 3. The capability catalogue

Capabilities are verbs; §4 lists the widgets they render with; §5 covers exams.

| # | Capability | In | Out | Reuses | New |
|---|---|---|---|---|---|
| 1 | Explain a character in context | character, learner level | prose + `characterAnatomy` + `strokeOrder` | `hanzi_metadata`, stroke vectors | envelope (§4.1) |
| 2 | Explain a word in context | word, sentence | prose + `vocabularyCard` + `contrastTable` | `dictionary.db`, `TranslatedDefinition` | artefact pair |
| 3 | Explain a grammar point | sentence + the learner's error | prose + `orderTokens` + `fillBlank` | `hsk*_sentences.json` | grammar blueprints |
| 4 | Decompose a character | character | `characterAnatomy` (radical + components + their meanings) | the radical fix (metadata-first) | reuse `_buildAnatomyCard` |
| 5 | Disambiguate confusables | two words ("知道 vs 认识") | `contrastTable` with discriminating examples | dictionary + sentences | artefact |
| 6 | Diagnose a failure | the failed attempt (stroke path diff, tone curve, wrong option) | prose explanation + the *specific* artefact for the error | stroke matcher, tone grader, quiz state | error log (§6) |
| 7 | Build a remedial lesson | a systemic error (same radical wrong in N words) | a `remediationPlan` → a generated lesson | `radical_lesson_screen`, mastery seals | triage rule (`killer_feature_ideas.md` #14) |
| 8 | Drill one feature | a feature (tones / 量词 / finals) | `drillSet` | TTS cache, quiz widgets | drill artefacts |
| 9 | Examine | a blueprint (§5) | `examPaper` + report | quiz, canvas, tone grader, SRS | blueprint model |
| 10 | Grade production | a drawing / a recording / free text | a grade + rubrics + the fix | `StrokeMatcher`, `LocalToneGrader`, `PronunciationGrade` | rubric display |
| 11 | Plan time | minutes today, due counts, weak areas | `studyPlan` | SRS, mastery | planner artefact |
| 12 | Report progress | a period | `masteryReport` + `errorHeatmap` | SRS stats, stroke history | report artefacts |
| 13 | Curate external material | a topic + level | a *justified* pick from the Tutorials shelf | the compliant tutorials repository | shelf hand-off |
| 14 | Role-play | a scenario | the Echo Hall conversation | Echo Hall | — |

---

## 4. The artefact system — the heart of it

### 4.0 Where we are, and why that is not enough

Today the character chat has:

```dart
enum ScholarArtefact { strokeOrder }                     // one artefact
ScholarArtefact? _detectArtefact(String text, l10n)      // keyword matching, "no NLU here"
ScholarArtefact? _attachArtefact(a) => a == … && widget.strokePaths.isNotEmpty ? a : null;
```

Three good ideas are already in there, and all three should be generalised: the
reply may **carry a widget**, a widget is **only attached when the data exists
locally**, and the widget is **rendered by a typed branch** rather than parsed out
of prose. What is missing is a *protocol*: keyword detection cannot express "give
me the anatomy, not the stroke order", cannot pass arguments, and cannot grow to
fifteen artefacts without becoming a pile of `if (q.contains(…))`.

### 4.1 The envelope (what the model must return)

The tutor returns **structure, not prose we interpret**:

```json
{
  "say": "好 = 女 (woman) + 子 (child). The 子 is the one you know from 孩子.",
  "artefacts": [
    { "type": "characterAnatomy", "args": { "hanzi": "好" } },
    { "type": "strokeOrder",      "args": { "hanzi": "好", "stroke": 3 } },
    { "type": "quizSet",          "args": { "kind": "hanziToEnglish", "hanzi": ["好","女","子"], "items": 6 } }
  ],
  "cites": [
    { "source": "book", "bookId": "sunzi-01", "sentence": 42, "quote": "…" },
    { "source": "deck", "deckId": "hsk3",       "note": "9 of these 24 words are due today" },
    { "source": "video", "videoId": "abc123",    "why": "slowed-down tones, captions on" }
  ],
  "make": [
    { "kind": "examFolder", "deckId": "hsk3", "items": 20, "scope": "hsk3" }
  ],
  "ask": null
}
```

`cites` must resolve to something the app already holds (a book it has downloaded,
a deck, a video id); `make` is always a **proposal** (§4.4); `ask` is how the tutor
requests a missing parameter instead of guessing. §12 explains the block model.


Rules that make this safe to ship:

1. **`say` and `artefacts` are both optional, both empty is an error** — a blank
   bubble must never be possible.
2. **Every `type` must exist in the registry.** An unknown type is dropped and
   logged, and the prose still renders: forward-compatible by construction.
3. **Every `args` object is validated by its own parser** — one typed model per
   artefact. Malformed args drop that single artefact and leave the rest. No
   exceptions reach the UI and no `dynamic` reaches a widget.
4. **The envelope is requested in the system prompt and repaired once** (strip
   fences, trim, retry once) before falling back to "prose only".
5. **Read-only artefacts never mutate anything**; mutating ones are proposals
   (§4.4).
6. **Streaming stops at the envelope.** Artefacts render when the reply is
   complete — a half-parsed array is how you ship a broken widget.

### 4.2 The artefact catalogue

Grouped by the learning job they serve. *Data* names the app-owned source its
builder may read — and nothing else.

#### A. Notice — make the learner see it

| Artefact | Shows | Interactive | Data | Status |
|---|---|---|---|---|
| `strokeOrder` | animated stroke order, replay, count | replay / step | the learner's card, **or** `hsk1_strokes.json` | **exists** (`ScholarStrokeLesson`), and now covers every HSK 1 character, not only the ones in the learner's deck |
| `characterAnatomy` | radical + components, each named and explained | tap a component → sheet | `hanzi_metadata` + `radicals.json` | **exists** |
| `exampleSet` | the character in the sentences the learner has already met, spelled by the app | — | the card's `sourceSentence`/`sourceContext` + `hanzi_metadata` readings | **exists** — deliberately not a generated example |
| `contrastTable` | two items side by side with the *discriminating* examples | — | the model's two sides and rows, **checked** against `describableHanzi` and **spelled** from `hanzi_metadata` | **exists** — the explanation is the model's, the table is the app's |
| `toneCurve` | the pitch contour, with the target shape over it | play / compare | `LocalToneGrader`, tone graphs | **not built, on purpose**: `ToneGraphCard` draws a *measured* recording against a target, so there is nothing honest to draw for a character a learner has not spoken |
| `strokeHighlight` | one stroke isolated, with its direction | step / replay | stroke vectors | new (an argument of `strokeOrder`) |
| `measureWordTable` | noun → 量词 pairs | tap → dictionary | dictionary | new |
| `characterMap` | "every character containing 氵, by frequency" | tap → card | `hanzi_metadata` radical index | new (the de-constructor, idea #16) |

Four of these are now wired end to end, and the two rules that keep them honest are the
same two the rest of the tutor runs on: **the parser checks before the learner sees it**
(a table whose examples use characters this build cannot describe loses that row, or the
whole table; a widget type the build does not have never reaches the view), and **a
builder returns `null` rather than a half-widget** (no strokes, no examples, no table —
the block simply is not there). `exampleSet` and `contrastTable` also demonstrate the
division of labour the catalogue is built on: the *explanation* — which two things to
compare, and what the difference is — is the model's, like every other sentence it
writes; the *structure, the examples and the pronunciation* are the app's.


#### B. Drill — make the learner produce it

| Artefact | Task | Graded by | Data | Status |
|---|---|---|---|---|
| `writePrompt` | draw this character | `StrokeMatcher` (+ strictness) | stroke vectors | new widget, existing engine |
| `toneChoice` | which tone did you hear / does this have? | compare | TTS cache, tone data | new |
| `fillBlank` | complete the sentence | option match | `hsk*_sentences.json`, dictionary | new |
| `orderTokens` | arrange tokens into a sentence | exact / loose match | sentences | new |
| `dictation` | listen, then write what you heard | `StrokeMatcher` / text | TTS cache | new |
| `radicalHunt` | which of these contain 亻? | set match | metadata | new |
| `quizSet` | 4-option MCQ, either direction | `QuizType` | flashcards | **exists** (`QuizQuestion`, `quiz_step`) |

#### C. Assess — prove it under conditions

| Artefact | Shows | Data | Status |
|---|---|---|---|
| `examPaper` | a timed, sectional paper + score report (§5) | blueprints + app data | new |
| `speakingPrompt` | a prompt with a rubric; records and grades | tone / pronunciation graders | new |
| `readingPassage` | a short passage + comprehension items | the app's own reading content | new; reuse the reader |

#### D. Plan — decide what happens next

| Artefact | Shows | Data | Status |
|---|---|---|---|
| `studyPlan` | "12 min: 6 due reviews → this tone drill → 4 new cards" | SRS due queue, mastery, weak features | new |
| `remediationPlan` | a targeted fix for one systemic error, and when | error log (§6) | new (idea #14) |
| `reviewPreview` | when this comes back if you rate it 3 vs 5 | `SrsLogic`, `ReviewScheduler` | new, cheap |

#### E. Report — show the shape of progress

| Artefact | Shows | Data | Status |
|---|---|---|---|
| `masteryReport` | mastery by deck/topic, trends | `ReviewStats` | new |
| `errorHeatmap` | the radical grid coloured by *your* stroke accuracy (idea #19) | stroke history | new |
| `sessionSummary` | what just happened, what to fix | session + SRS delta | new |

### 4.3 The rule that makes it trustworthy: **the model chooses, the app builds**

> **An artefact may only be built from data the app already owns.**
> The tutor selects *which* widget and *with what arguments*; it never supplies
> content. Every hanzi in an artefact must exist in `dictionary.db` or
> `hanzi_metadata.json`; every pinyin, definition and radical comes from those
> files; every stroke from the vector data.

That single rule is what turns "the AI generated a lesson" from a liability into
a feature. It is also **testable**: hand a builder a hanzi that is not in the
dictionary and it must refuse — the generalised form of today's `_attachArtefact`.

Consequences worth stating out loud:

* A hallucinated character, pinyin, definition or radical is **impossible**, not
  merely unlikely.
* If the data is missing (no strokes loaded, no radicals), the artefact is
  dropped and the prose explains instead — never a broken widget, never a fake.
* The model's job is still genuinely valuable: picking the right widget for the
  question, choosing the examples that discriminate, ordering the plan.

### 4.4 The interaction contract

| Class | Examples | Behaviour |
|---|---|---|
| **Read-only** | every Notice artefact, all Reports | render inline, nothing is written anywhere |
| **Practice** | every Drill artefact, `quizSet` | graded in place, the result is *shown*; the SRS write is a proposal |
| **Mutating (proposal)** | "add these 12 words to review", "schedule this drill tomorrow", "start a mock HSK 3" | rendered as a **confirm card**: the tutor proposes, the learner commits in one tap |

No silent writes. A tutor that quietly edits your SRS queue is one you cannot
trust with your study history, and it turns every bug into a data-loss bug.

### 4.5 The plumbing (so this stays maintainable)

```
ScholarReply      { say, artefacts: List<ArtefactSpec> }          // parsed & validated
ArtefactSpec      { type: ArtefactType, args: ArtefactArgs }       // sealed per type
ArtefactType      enum (strokeOrder, characterAnatomy, …)
ArtefactRegistry  Map<ArtefactType, ArtefactBuilder>
ArtefactBuilder   (BuildContext, ArtefactArgs) -> Widget?          // null = drop
ArtefactValidator args parser per type; rejects, never throws
```

* **One file per family** (`artefacts/notice/*.dart`), one builder per artefact.
* **Adding an artefact = enum + args model + builder + registry entry + a test.**
  No other file changes — exactly what the current `if (q.contains(…))` chain
  cannot do.
* **Builders are pure** given args + repositories, which makes them
  unit-testable without a model and widget-testable from a fixture.

---

## 5. Exams — what it can create

### 5.1 Two layers, deliberately different

| Layer | Where | Shape | Timing | Grading |
|---|---|---|---|---|
| **Drill set** | in the chat, as an artefact | 4-10 items, adaptive, immediate feedback | untimed | per item, instantly |
| **Paper** | a dedicated flow | sections × items, no hints, no answers | sectional timer | at the end, then a report |

Drills build the skill; papers *prove* it. Conflating them is how an app ends up
with "quizzes" that teach nothing and exams nobody respects.

### 5.2 The blueprint — the constraint that keeps exams honest

An exam is **not** conjured from a prompt. It is assembled from a **blueprint**
that lives in the repo, versioned, with an allowed vocabulary set:

```json
{
  "id": "hsk3-mock-v1",
  "level": 3,
  "allowedVocabulary": "hsk3-decks+lower",
  "sections": [
    { "kind": "listening", "items": 4, "types": ["toneChoice","dictation"], "minutes": 4 },
    { "kind": "reading",   "items": 5, "types": ["fillBlank","quizSet"],    "minutes": 6 },
    { "kind": "writing",   "items": 2, "types": ["writePrompt"],            "minutes": 5 }
  ],
  "passMark": 0.8
}
```

* The model **fills** the blueprint (which allowed words, which stems, which
  distractors); the app **validates** every item against the vocabulary set and
  **derives the answer key locally**.
* So "mock HSK 3" means the same thing on Tuesday as on Monday: the blueprint is
  versioned, which is what makes two attempts comparable at all.
* Out-of-scope vocabulary fails **the item**, not the learner.

### 5.3 Item types it can build

| Type | Section | Built | Needs |
|---|---|---|---|
| `toneChoice` (which tone?) | listening | **yes** — minimal pair from the word's own syllable | TTS + `PinyinUtils` |
| `dictation` (hear → type the pinyin) | writing | **yes** | TTS + pinyin folding |
| `audioToCharacter` (hear → pick the character) | listening | **yes** | TTS |
| `characterToMeaning` / `characterToPinyin` | reading | **yes** | the source's own data |
| `fillBlank` | reading | **yes** | sentences + the source's vocabulary |
| `passageFill` (a gap in a passage) | reading | **yes** — from text the app already had | a passage, or the source's own sentences |
| `orderTokens` | writing | **yes** — the sentence's own words, its own order | sentences + a segmenter |
| `grammarError` (find the error) | reading | **yes** — the app doubles 很 / 不 / 的 in one of four sentences | sentences + declared rules |
| `writePrompt` (draw it) | writing | not yet — needs drawn geometry through the answer model | stroke matcher (**exists**) |
| picture items | listening / reading | **no** — the app ships no vocabulary images | vocabulary images |
| `speakingPrompt` (say it) | speaking | **no, and not just "not yet"** — needs on-device recognition to key it; the app's tone grader is fed by a *cloud* transcript | on-device ASR |
| free production ("explain …") | writing | **AI, with a rubric, disputable** | rubric + a second pass |

### 5.4 Grading and integrity rules

1. **The answer key is never in the prompt that generated the items.** Two calls:
   items first, keys derived locally from the app's own data.
2. **No answers before submission** — no "show me" during a paper.
3. **Timers are app-side**, and a backgrounded paper is *paused*, not silently
   lost.
4. **AI grading only for open answers**, always with its rubric on screen, and
   always disputable (a second pass with the rubric restated). Closed items are
   never AI-graded: the app already knows the answer.
5. **Speaking is graded on device** (`LocalToneGrader`), so it works offline and
   uploads nothing.
6. **A report always ends in a teaching action** — failed items become SRS entries
   and/or a `remediationPlan`. An exam that does not change what you study next is
   entertainment.
7. **What it must never claim**: native authenticity, official HSK certification,
   or a score that implies one.

---

## 6. What the tutor knows about you (the memory that makes it a tutor)

A generic chat starts from zero every time. This one starts from **evidence the
app already recorded**, assembled into a small local profile — a "learner card"
put in front of every request:

| Signal | Already recorded by | What the tutor does with it |
|---|---|---|
| Stroke accuracy per radical/character | `StrokeMatcher` history | diagnose the *specific* mistake, build the remedial lesson (#14) |
| Tone error profile | `LocalToneGrader` | choose tone drills, order the examples |
| Wrong options chosen | quiz state | build `contrastTable`s for the pairs you confuse |
| SRS state (due, lapses, ease) | `SrsLogic`, `ReviewStats` | `studyPlan`, `reviewPreview` |
| Mastery by deck | flashcards | scope explanations to what you know |
| Target level + exam history | profile, exam reports | pick blueprint difficulty, keep attempts comparable |

Stored locally (Hive), like the rest of the learner's data: the tutor's context is
assembled per request and never becomes a server-side profile.

**One new table underpins most of it**: an `error log` — one row per failure
`{kind: stroke|tone|option|order, target, expected, actual, at, source}`. It is
what turns "you got a few wrong" into "you draw 氵's second dot short, in four
different characters, and that is why these three are shaky".

---

## 7. Guardrails (this repo's reality, not a wish list)

* **Tier the calls.** A small/cheap model classifies the request and fills
  blueprints; a stronger one writes the explanation. One call per turn, artefacts
  batched into it — never one call per widget.
* **Cache like the app already caches AI** (`docs/AI_CACHING_ROADMAP.md`): key on
  (learner card hash + normalised question), and reuse the existing proxy/caching
  path. Explanations are stable; they should cost once.
* **Degrade, never break.** No key or offline: locally-buildable artefacts still
  work (`strokeOrder`, `characterAnatomy` come from bundled data with a static
  caption), and new *papers* are unavailable rather than half-valid.
* **Localised in, localised out.** Labels from ARB; content from the app's own
  localised sources; the model answers in the interface language (the locale
  plumbing already exists).
* **Honest about its own confidence.** It grades what it can measure, declines
  what it cannot ("I can't assess your handwriting on paper"), and shows the data
  behind a claim.
* **Testable without a model.** The envelope parser, every validator, and every
  builder are pure; the registry is unit-tested, the widgets fixture-tested, and
  one test enforces the §4.3 rule (no invented content) across all artefacts.

---

## 8. Where it appears

The tutor should be **in-context, not a destination**. Recommended entry points:

| Entry | Trigger | Likely artefacts |
|---|---|---|
| Character chat (exists — "Bureau du savant") | tap a character, ask | anatomy, stroke order, drills |
| Word / dictionary sheet | look up a word | `vocabularyCard`, `contrastTable`, `measureWordTable` |
| After a failure | wrong stroke, wrong option, bad tone | explanation + the artefact for *that* error |
| Review summary | end of a review session | `sessionSummary`, `remediationPlan` |
| Exam flow | "build me a paper", "review my last paper" | `examPaper`, `masteryReport` |
| Today / plan surface | open the app | `studyPlan` — the one place the tutor talks first |

That last row is the honest answer to "should there be a Tutor tab": the tab that
earns its place is not a chat box, it is **the day's plan**, which happens to be
generated by the tutor and links into the drills.

---

## 9. Build order

| Phase | Scope | Ships |
|---|---|---|
| **P0 — exists** | keyword-detected `strokeOrder` artefact; Echo Hall roleplay; MCQ quiz; SRS; tone grading | today |
| **P1 — the envelope** | `ScholarReply` + registry + validators; migrate `strokeOrder`; add `characterAnatomy`, `characterMap` (pure local data — reuses the metadata-first radical work) | the tutor can *choose* a widget, and unknown types can no longer break a bubble |
| **P2 — drills** | `quizSet` (reuse `QuizQuestion`), `fillBlank`, `toneChoice`; practice outcomes start the error log | the tutor can make you produce, not just read |
| **P3 — diagnosis** | error log; `remediationPlan`; `errorHeatmap` | "triage": the tutor fixes causes, not symptoms |
| **P4 — exams** | blueprint model + assembler + timers + report; writing and speaking sections | real papers, comparable across attempts |
| **P5 — planning & curation** | `studyPlan`, `reviewPreview`, Tutorials hand-off | the tutor decides what happens next |

Each phase is independently shippable, and each artefact must arrive with its
validator test and a "no invented content" test.

---

## 10. Open decisions (the questions this design needs you to answer)

1. **Who decides what?** My recommendation: the model picks from a *menu* of
   app-owned widgets and fills blueprints; the app validates and renders. The
   alternative (free-form generation) cannot satisfy §4.3.
2. **How much exam, how much drill?** ~~Drills only (small, safe, quick) or a real
   mock-HSK flow with sections, timers and scores?~~ **Answered 2026-02-10: a real
   paper.** "An exam should really be an exam, like an HSK exam" — so §13 now ships
   the timed paper (Tier 2.5/3-lite): sections, a clock, a frozen key, local
   grading and a report. The folder path stays, for drilling the learner's own
   cards.
3. **May the tutor write?** Read-only artefacts plus explicit one-tap commits
   (recommended), or may it edit decks and the SRS queue directly?
4. **Where does it live?** In-context only, or also a "Today" surface that leads
   with the `studyPlan`?
5. **Open-ended grading?** Auto-graded only, or AI-graded free production with a
   rubric and a dispute path?

---

## 11. Durable objects: can the tutor create something that lives in the app?

"Can it make me a folder that *is* an exam I can actually do?" — yes, and the
mechanism already ships for one object type.

### 11.1 The precedent that already exists

`AiDeckGeneratorSheet` + `GeminiService.generateDeckCards` +
`DeckController.createDeck`:

```
AI invents N words for a topic  →  deckController.createDeck(topic, description: "Generated by AI")
                                →  Hive (`_box.put(id, deck)`)
                                →  a folder in the library, openable, studiable via review/quiz/SRS
```

So "the AI authors a durable folder in my app that I can then actually do" is
**shipped behaviour for decks**. The same pattern also exists for role-plays
(`custom_scenario_dialog` → `SavedScenariosNotifier` → the Echo Hall shelf).

### 11.2 What an exam would have to be, in three tiers

| Tier | What the learner gets | Exists | Work |
|---|---|---|---|
| **1. Chat artefact** | a widget inside one reply (today's stroke lesson) | ✅ | — |
| **2. Generated folder** | a folder in the library of cards, doable through review/quiz, tracked by SRS | ✅ mechanism; ❌ exam semantics (no timer, no single attempt, no score) | small |
| **2.5 Test mode over a generated folder** | the folder, plus "Test me": timed, no flip-back, answers auto-graded, one score at the end | ❌ | medium |
| **3. Paper pack** | a folder of *papers* with sections, timers, frozen keys, attempts, comparable scores | ❌ | large |

* **Tier 2** needs no new objects at all: an exam folder is a `Deck` whose cards
  are question cards.
* **Tier 2.5** reuses `QuizQuestion`/`quiz_step`, `DrawingCanvas` and the tone
  grader, and adds a runner + a score summary + a frozen answer key.
* **Tier 3** adds `ExamPack(folder) → ExamPaper → ExamSection → ExamItem` plus an
  attempt record, and the blueprints from §5.

### 11.3 The gate that decides whether it is any good

Two rules, and one of them is a live gap in the existing generator:

1. **Items reference the library, they do not invent it.** The item stores a
   *dictionary id* + an item type; the stem is built from the app's own data at
   attempt time. Then SRS, mastery and localisation keep working, and an item can
   be re-rendered in any locale.
2. **The answer key is derived locally and frozen.** Computed from the dictionary
   when the paper is generated, stored with it, and frozen when the attempt starts
   — so a retake is comparable and a regeneration cannot silently change answers.
3. **Every item is validated, and invalid ones are dropped and counted**: in-scope
   vocabulary, exactly one defensible answer, distinct options. The learner sees
   "18 items, 3 dropped" rather than a silently thinner exam.
4. **A per-item "report this question" path**, because no validator catches a
   badly written stem.
5. **Difficulty is declared, not claimed.** "HSK 3 scope" is honest; a calibrated
   "HSK score" is not — that needs item-response statistics the app does not have.

> **Live gap.** `generateDeckCards` asks the model to *invent* the vocabulary
> ("provide exactly N words that fit this criteria") and
> `AiDeckGeneratorSheet` writes `cardMap['hanzi']` into Hive with **no dictionary
> check**. A hallucinated character, pinyin or definition therefore becomes study
> material *with a schedule attached*. For cards that is bad; for an exam it is
> worse, because a wrong key fails a learner who answered correctly. The exam
> folder must not repeat the pattern — and the existing generator is worth
> hardening for the same reason.

### 11.4 The full list of durable objects the tutor could author

| Object | Reuses | Status |
|---|---|---|
| Vocabulary deck / folder | `Deck`, `createDeck`, review+quiz+SRS | **exists** |
| Custom role-play scenario | `SavedScenariosNotifier`, Echo Hall | **exists** |
| Exam folder (Tier 2 / 2.5) | deck + quiz + canvas + tone grader | **exists** |
| Paper pack (Tier 3) | + blueprints, attempts, reports | **exists**, with "your papers" and a paper built from the mistakes |
| Reading pack | the reader's story cache + the exam's passage machinery | **exists** — a story at a level, its own words as questions, and the paper's passage |
| Study plan | SRS + mastery; a "Today" surface | **exists, as a review sprint** — the cards that are due, gathered into one folder |
| Handwriting worksheet | `WritingBenchScreen` + the learner's stroke data | **exists as a screen**; the tutor does not *make* one, because a sheet is a study action, not a durable object |
| Remedial lesson folder | radical lesson screen, error log | new, medium |

---

## 12. Answer blocks, references and grounding — the shape of a reply

The tutor's answer is never just text. It is a **stack of blocks**, and the model
*chooses* blocks while the app *builds* them (§4.3). Five kinds, and nothing else:

| Block | What it is | Built by | Example |
|---|---|---|---|
| **SAY** | prose in the interface language | the model | "的 marks possession; 了 marks completion — different jobs." |
| **SHOW** | a widget from the artefact catalogue (§4.2) | the app, from app data | stroke order, anatomy, tone curve, contrast table |
| **CITE** | a pointer to something the learner *already has*, or an external one | the app, verified | chapter 3, sentence 42 of a downloaded book · "9 of your HSK 3 words are due" · a teaching video |
| **MAKE** | a durable object, as a **proposal** | the app, after validation | an exam folder on your 好-weak deck |
| **ASK** | a clarifying question with tappable answers | the model | "Which deck — HSK 3 (24 words) or Tones (12)?" |

Every request the learner can make lands in that space:

| The learner says… | Reply |
|---|---|
| "make me a 20-question exam on my HSK 3 deck" | SAY (what it did) → **MAKE** exam folder bound to that deck → ASK only if the shape is ambiguous |
| "explain 的 vs 得" | SAY → SHOW `contrastTable` → SHOW `fillBlank` drill → CITE the two sentences in a book you have |
| "what does this book mean here?" | SAY → **CITE** book, chapter+sentence → SHOW `vocabularyCard` for the hard word |
| "explain the word 方便" | SAY → SHOW `vocabularyCard` → SHOW `contrastTable` (方便 vs 便利) → CITE a video |
| "I keep failing 氵" | SAY (the diagnosis) → SHOW `strokeHighlight` → **MAKE** a remedial lesson folder |

### 12.1 References: the learner points at things they own

Grounding has to start from the *user's* side, not the model's. So a message can
carry explicit references, chosen with a picker rather than typed:

| Reference | Resolves to | Resolution cost |
|---|---|---|
| `@deck:<id>` | that deck's real cards (and its due counts) | local |
| `@book:<id>#<chapter>:<sentence>` | a downloaded book's stored text, at sentence granularity | local |
| `@character:<hanzi>` / `@word:<id>` | dictionary + metadata + stroke vectors | local |
| `@rule:<point>` | a grammar point, and the sentences that use it | local |
| `@exam:<id>` | a generated exam folder and its results | local |

This is why the sentence-level reader structure matters: a citation can be
**actionable** — "chapter 3, sentence 42" is a tap that opens the book exactly
there and highlights it, not a dead footnote.

### 12.2 The loop: retrieve locally, compose, then resolve back

```
learner's message + @references
   → app gathers a context bundle: deck summary, retrieved book excerpts (with ids),
     dictionary entries, the error log slice, available artefact types, video candidates
   → model returns the envelope: say + artefacts + cites + make + ask
   → app validates: every cited id must have been IN the bundle, every artefact must
     build from local data, every `make` must pass its blueprint
   → blocks render; unverifiable ones are dropped
```

Two rules do the heavy lifting:

* **The model may only cite ids it was handed.** An id it invents cannot resolve,
  so a fabricated citation is *structurally* impossible — the same trick as §4.3.
* **Retrieval is local and bounded.** Excerpts are retrieved from text the app
  already stores (books, articles, deck cards, dictionary), never fetched per
  question, so cost stays flat and the corpus stays the learner's own library.

### 12.3 The video block, stated honestly

A model cannot watch a video. So the video block may state **title, channel,
duration, and why it matched the query** — never what the video says. Concretely:

* the app runs the search through the compliant Tutorials path
  (`videos.list`/`search.list`, `videoEmbeddable`, `safeSearch`, captions), so the
  candidate is playable, attributed and embeddable;
* the model picks one and writes a *matching rationale*, which is a claim about
  the title, not about the content;
* playback and attribution follow the rules already pinned by
  `tutorials_compliance_test.dart` — official player, channel credit, watch-page
  link, nothing downloaded, not behind a paywall.

### 12.4 The book block, stated honestly

The app has shipped copyrighted-text removals before
(`docs/BOOK_COPYRIGHT_REMOVALS.md`), so the rules are already load-bearing:

* quote only from books the app legitimately ships or the learner downloaded,
* keep quotes short and always cited (chapter + sentence), never long passages,
* never present a paraphrase as a quotation, and never attribute a claim to a
  book the bundle did not contain.

### 12.5 When it cannot ground something

Fixed degradation order, so the answer is never a dead end and never a bluff:

1. answer with what the bundle *does* support (SAY + SHOW are always available);
2. offer the nearest thing it actually has ("no video for 的 vs 得 — here is a
   contrast table and two sentences from the book you have open");
3. name the gap in one line ("I don't have a video shelf for that yet");
4. **ASK** for the missing parameter rather than inventing one.

### 12.6 What this changes in the UI

* A reply is a **vertical stack** in a fixed order: SAY → SHOW → CITE → MAKE. The
  stack collapses to the first block with a "3 more" affordance once it grows.
* **Keep this** — any SHOW block can be pinned into the library (the general form
  of "save this artefact"), which is how a good explanation becomes something you
  study tomorrow.
* **MAKE renders as a confirm card** with what it will create, what it will touch
  and a single commit action (§4.4).
* **ASK renders as parameter chips** (deck / item count / level), because a
  clarifying question that needs typing has failed at its one job.


---

## 13. First draft — what exists now

The envelope, the validator and the two things that make the tutor honest are
built. §1–§12 describe the whole idea; this is the honest line between what runs
today and what is still a plan.

### Built (`lib/features/tutor/`)

| Piece | File | What it does |
| --- | --- | --- |
| Envelope | `domain/entities/tutor_reply.dart` | `say / artefacts / cites / make / ask`, plus `fromModel` so the UI can say where an answer came from |
| Grounding | `domain/entities/tutor_context.dart` | reference kinds, deck summaries (counts + samples, never a corpus), the focused-deck rule |
| Validator | `data/tutor_envelope_parser.dart` | the §4.3 and §12.2 rules, enforced: unknown widget dropped, character outside the allowed set dropped, invented citation dropped, `make` clamped to a real deck |
| Prompt | `data/tutor_prompt.dart` | the contract as a system prompt, plus the allowed-id lists |
| Service | `data/tutor_service.dart` | ask → AI → validate → **fall back to local** on any failure |
| Local answer | `domain/logic/local_tutor.dart` | keyword → block, no model: exam proposal, anatomy + stroke order for a character, or "here is what I can do" |
| SHOW | `presentation/widgets/tutor_artefacts.dart` | registry + `characterAnatomy` and `strokeOrder`; a builder that cannot build returns `null` and the block is dropped |
| Blocks | `presentation/widgets/tutor_reply_view.dart` | SAY → SHOW → CITE → MAKE → ASK, plus the confirm card |
| Surface | `presentation/screens/tutor_screen.dart` | deck reference strip, transcript, composer; assembles the bundle and owns the only write path |
| MAKE | `data/exam_folder_builder.dart` | copies cards out of the referenced deck into a new folder; refuses (as a result, not an exception) when the deck is too small |

Reached as the third segment of `AiHubScreen` (label: `l10n.askTutor`), so no new
navigation destination and no new localisation keys.

### Notable decisions taken while building

* **The exam folder is a copy, not a move.** Cards are re-created with new ids in
  the new deck, so the source deck the learner studies is untouched. Every field
  that makes a card work offline travels with it. `addFlashcard` de-duplicates by
  `hanzi`, so the builder writes through the repository instead — a folder that
  silently merged into the source deck would have been a real bug.
* **Nothing is fetched to build a block.** Strokes come from the learner's own
  hydrated cards, anatomy from bundled metadata. That is why `describableHanzi`
  exists: the parser is handed exactly the set the app can render.
* **`strokeOrder` is the first artefact because it was already built.** It reuses
  `ScholarStrokeLesson`, so the tutor's SHOW block is the same widget the
  character sheet uses — no second implementation to drift.
* **Anatomy follows the radical rule fixed in audit 41**: `hanzi_metadata.json`
  assigns, the curated catalogue only enriches. `componentsOf()` is the same rule
  as the character sheet, in a form the tutor can call.

### House rules, and what they caught

The first draft looked right in English and in light mode. It was not yet an app
citizen: six strings were English-only, and three of the repository's design
ratchets failed the moment they were pointed at it. Both are fixed, and both are
now enforced rather than remembered.

**Six new strings, in all fourteen locales** (`app_*.arb`). Every one is a
sentence, because a sentence is what translation is for:

| Key | Why it had to exist |
| --- | --- |
| `tutorChooseDeck` | The ASK block's question. `selectDeck` ("Select Deck") is a label, not a question. |
| `tutorQuizProposal` | The offline proposal: an ICU plural over `{count}` plus the `{deck}` name. |
| `tutorCharacterIntro` | "Here is how 好 is built, and how it is written." — `{hanzi}` survives translation. |
| `tutorFallbackIntro` | What the tutor can do. The one answer a learner with no API key ever sees. |
| `tutorComponentCount` | "3 building blocks" was assembled in Dart by concatenating an `s`. |
| `tutorQuizFolderName` | The folder's name: `{deck} — Quiz`. |

**Reused rather than invented** — the app already had the words:
`deckItemsCount` (the item count — the deck picker's own string),
`notEnoughCardsFor` (the refusal, exactly the sentence a quiz start shows),
`radical` (the anatomy badge), `practiceQuiz` (which is also now a *recognition*
word, so an Indonesian learner typing "kuis" is understood), plus `deck`,
`create`, `done`, `askTutor`, `typeYourMessage` and `generatedByAi`.

**The vocabulary is the app's.** The user-facing word is **quiz**, not "exam":
`practiceQuiz`, `quizComplete` and `notEnoughCardsFor` already say so, and no
string in the app said "exam". The concept keeps the name *exam folder* for the
durable object (§8), but the learner reads "quiz" — the same object under the
name the rest of the app uses.

**Three ratchets failed, and were the point of them:**

* `a fixed-width box around Text declares how the text degrades` — the 26px
  component column. A glyph tile may be fixed, but the `Text` inside must say
  what happens when it does not fit: `FittedBox(fit: BoxFit.scaleDown)`.
* `an action Row keeps every localized child flexible` — **baseline 0**. The
  confirm card wrapped one button in a `Row`; with one action there is no row, so
  it is a `Wrap` (which also survives a second action later).
* `a width-capped container around text declares how the text degrades` — the
  question bubble was `maxWidth: 280`, a pixel width fixed at English size. It is
  now the fraction the app's other chat bubbles use
  (`MediaQuery.sizeOf(context).width * 0.78`).

Three more things the standards caught that no test would have:

* **`.toLowerCase()` on a translated string.** The refusal read
  `'${poolSize} ${l10n.deck.toLowerCase()}'` → *"3 deck"*, and lowercasing a
  German noun is wrong. Deleted, not translated.
* **A raw ISO date as a folder name** (`2026-02-10`) — user-visible text that no
  ARB ever saw. The folder is now named in the learner's language.
* **`Text('RADICAL')`** — an English literal in a widget, which also nudged the
  untranslated-literal ratchet. It is `l10n.radical`.

**Aligned with the house style, deliberately:** the SAY bubble's colours are the
same pair the app's other AI bubbles use (`0xFF252525` / `0xFFFFF8EE`); the
anatomy accent comes from `AppTheme.accentLight`/`accentDark` rather than a
second copy of the hex; the reply is wrapped in `ZenFadeIn` because it replaces a
`ZenLoader`; the reference picker is `ZenFilterPill`, the commit action is
`BouncingButton`, the surface sits on `CalligraphyBackground`.

**The offline composer now takes `AppLocalizations`.** That is a domain file
importing generated l10n, which the repository already does
(`flashcards/domain/entities/deck.dart` localises its own name). The alternative
— returning English and letting the screen fix it — would have put the sentences
and the logic that chooses them in different layers.

**Enforced by:** `test/features/tutor/tutor_localization_test.dart` (sentences
differ from English in every locale, the deck name and the character survive
translation, the app's own word for the feature is recognised, and the reply view
renders the localised labels in all 14), `l10n_arb_parity_test.dart` (the five
sentence keys can never ship untranslated), and the three layout ratchets above.
### Memory that does not grow

A tutor with no memory is a search box; a tutor that replays its transcript is a
bill that doubles every turn. The way out is to stop treating "memory" as "text":
the app keeps the transcript, and the model is given a **bounded residue**.

`TutorMemory.from` (`domain/entities/tutor_memory.dart`) carries exactly three
things, each capped:

| Carried | Cap | Why this and not more |
| --- | --- | --- |
| The learner's own asks | 3, 120 characters each | A learner types "and how is it written?" — short by nature, and it is the one part that cannot be reconstructed from anything else |
| The **first sentence** of the last answer | 1, 160 characters | Enough for a follow-up to have an antecedent; the rest of a paragraph is the single fastest-growing cost, and it is the part the model least needs back |
| The artefacts already shown | 6, `type(hanzi)` | So it does not show 好's stroke order twice — structure, not prose, which also happens to be what the rule "do not repeat yourself" needs |

Nothing else travels. Not the model's earlier prose, not the learner's long
messages, not the transcript. `TutorMemory.from` walks the transcript **newest
first and stops as soon as it has its three**, so a 500-turn session costs the
same to summarise as a 3-turn one.

**The guarantee is a test, not an intention.**
`test/features/tutor/tutor_prompt_budget_test.dart` builds the prompt for a
3-turn and a 50-turn conversation and asserts the two are **the same length** —
turn 50 cannot cost more than turn 3, whatever happens inside it.

**The other half of the budget was a bug.** The parser's character whitelist is
the app's real inventory: `hanzi_metadata.json` alone holds **9,574** characters,
and the screen was handing that same set to the prompt as a suggestion list —
~10k tokens per request, on every request, for a list the model could not use.
The two sets are now separate things with separate jobs:

* `TutorArtefactData.describableHanzi` — the **validator's** set: what the app can
  actually build a widget for. Thousands of characters, and free, because the
  check happens on the device.
* `TutorPrompt.shortlist(...)` — the **prompt's** set, capped at 24: the deck in
  focus's samples plus whatever the learner typed. A shortlist, not an inventory.
  If a question needs a character that is not on it, the contract says to answer
  in `say` without an artefact rather than name it.

Deck listings are budgeted the same way: six in full detail (the focused one
first), twenty listed in total, then a count — so an unlisted deck is a *stated*
limit the model can speak to, not a silent one.

**What it costs now:** a request is ~2.6k characters, and essentially all of it is
the contract itself. That is the fixed cost, and the next thing worth attacking
(shorten the rules, or move them to a system message) — but it no longer grows
with the conversation, which was the failure that mattered.

**Stated limits.** The model cannot quote its own earlier answers (one sentence
survives), and a follow-up referring to something older than the residue will not
resolve. Both are the price of the bound, and both are recoverable if a real need
appears — but the fix then is a **character budget** (newest turns win, evict
older ones until it fits), not "send the transcript", because a fixed turn count
is only bounded if every turn is.

The offline composer gets the same residue (`LocalTutor.compose(memory: ...)`), so
"and how is it written?" after 好 still answers about 好 with no model at all —
gated on the message naming nothing else and staying under 48 characters, so a
real question is never hijacked by the follow-up path.

### Where a created folder lives

There is no separate "exams" store, and that is deliberate: an exam folder **is a
deck**, so it inherits everything the app already does with decks — study modes,
spaced repetition, rename, delete, and the same encrypted Hive box.

* **The folder:** the Hive box **`decks`** (`Box<DeckModel>`), keyed by the deck's
  UUID. `DeckRepositoryImpl.createDeck(name, description:)` writes
  `{id, name, description, createdAt, dailyNewCardsLimit, dailyReviewLimit}`. The
  box is opened in `main.dart` and is **AES-encrypted** whenever the app has a
  cipher. The name is `tutorQuizFolderName(deck)` ("HSK 3 — Quiz") and the
  description is `generatedByAi`, the same marker the AI deck generator uses.
* **Its cards:** the Hive box **`flashcards`** (`Box<FlashcardModel>`), one entry
  per copied card, each with a **fresh UUID** and `deckId` pointing at the new
  folder. Written through `FlashcardRepository.saveFlashcard` — *not*
  `addFlashcard`, which de-duplicates by hanzi and would have merged the folder
  into the source deck instead of copying from it.
* **In the UI:** the Deck Library (`l10n.deckLibraryTitle`, `HerDeckLibrary`),
  because it is a deck like any other. The reply's confirm card is the shortcut to
  it: once the folder exists the card becomes a link ("Open quiz" → resolves the id
  → `SwipeBackPageRoute` → `DeckDetailScreen`) with the location stated beneath it,
  so a learner who just made a folder never has to hunt for it.

### A real paper, not a folder of cards

A folder of the learner's own cards is a drill with a schedule; it is not an exam.
§5 described the shape, and this is what exists now (`lib/features/exam/`):

| Piece | What it does |
| --- | --- |
| `ExamBlueprint` | The paper's definition, versioned per level (`hsk3-practise-v1`): sections, item counts, minutes, pass mark 0.6 — HSK's own threshold. HSK 1 opens with a **listening** section, like the real thing |
| `ExamBuilder` | Assembles items from the **bundled HSK vocabulary**, derives every answer key locally, and counts what it could not build |
| `ExamPaper` / `ExamItem` | The paper and its **frozen key**, JSON round-trippable so a stored paper can be sat again |
| `ExamGrader` | On-device grading — a blank is wrong, and the report lists what was missed |
| `ExamScreen` | Intro → timed sitting → report, with the missed items one tap from becoming study material |
| `ExamStore` | Papers and attempts as JSON in `Box<String>` (`exams`, `exam_attempts`) |

**Nine item types, all auto-gradable, none generated:** `audioToCharacter` (the
app's own TTS says the word — `audioServiceProvider.playCharacter`),
`characterToMeaning`, `characterToPinyin`, `fillBlank` from the bundles;
`toneChoice`, `orderTokens`, `dictation`, `grammarError` and `passageFill` from the
same material, each derived rather than written. Every distractor is another word
from the same source, and a distractor that would be *a second correct answer* (the
other reading of the same character — HSK lists 只 as both zhī and zhǐ) is excluded
rather than hoped against.

**What each of the newer five does, and what makes it keyable:**

| Kind | The item | Why the key cannot be argued with |
|---|---|---|
| `toneChoice` | The app says a **single-syllable** word; the learner picks the pinyin | The four options are `base+1…base+4` built from the word's own syllable with `PinyinUtils`, so they are a minimal pair: the app chooses neither the syllable nor the tone |
| `orderTokens` | Jumbled words to put back in order | The tokens are the sentence's *own* words, segmented against the source's vocabulary, and the key is the order the author wrote — the app shuffles, never rewrites |
| `dictation` | The app says the word; the learner types the pinyin | The key is the word's authored pinyin, compared after folding tone marks and tone numbers to one form — so `hao3` and `hǎo` both pass and a missing tone does not |
| `grammarError` | Four sentences, one broken | Three are sentences the source authored and the app left alone; the fourth is one of them with a **doubled 很 / 不 / 的**, which is never right |
| `passageFill` | A passage with one gap | The passage is text the app already had (the caller's, or the source's own sentences) and the key is the word the app removed |

Two types are **absent on purpose**, and not for lack of time: **picture items**
(HSK 1-3 match a picture, and the app ships no vocabulary images, so the stem cannot
be built) and **speaking** (grading a read-aloud needs a per-word reading from the
learner's audio, and the app's only tone grader is fed by a *cloud* transcript —
`gemini_service` → `LocalToneGrader.apply`). Without on-device recognition the key
could not be verified locally, and an unverifiable key does not belong in an exam.
This is a correction to §5.3's earlier claim that speaking was cheap: it is not
cheap, it is currently impossible offline.


**What the sitting enforces**, straight from §5.4: no feedback during the paper
(the item view cannot turn an option green), no answer accessible before
submission, a per-section clock that stops when the app is backgrounded instead of
counting down behind the learner's back, and a report that ends in a **teaching
action** — the missed items become a deck, borrowing stroke data from the learner's
own card for that character when they have one.

**Honesty, on the first screen.** `examNotOfficial` says what the paper is: a
practise paper in HSK scope, not an official HSK test and not an HSK score. The
item counts are deliberately smaller than a real paper's (an app paper you can sit
in twenty minutes beats one nobody starts), and §11.3.5 still holds — "HSK 3 scope"
is honest, a calibrated "HSK score" would not be.

**A paper is built from a *source*, and the source is the choice.** Two exist, and
they are the same exam:

* the **bundled HSK vocabulary** for a level 1-6 (what "HSK 3 practise test" means);
* **any deck the learner has** — their own cards are the vocabulary, which is what
  makes "create an exam from any deck" true rather than a copy of the cards.

The abstraction is one value type: `ExamWord` is either a bundle entry or
`ExamWord.fromCard(card)`, so the builder, the blueprint and the grader are the same
code for both. What changes is only what a paper may claim, and how big it is:

* **Sized to the deck.** `ExamBlueprint.forDeck(vocabularySize:)` scales the
  sections and the clock to the cards the deck actually holds, so a twelve-card
  deck is a short exam rather than a full paper with two thirds of its slots
  dropped. Below five usable cards there is no paper at all — the app answers with
  its existing "not enough cards" message, because four words are not an exam.
* **Nothing comes from outside the deck.** Every distractor is another card in that
  deck (there is a test that walks every item and every option and fails if one is
  vocabulary the deck never taught), and cards that cannot carry a key are left out
  *before* sizing, so a half-finished deck does not produce a paper full of holes.
* **It says what it is.** The honesty line switches from "HSK {level} scope" to
  `examFromDeck` — *"A practise paper built from your {deck} deck"* — because a deck
  called "Tones" makes no claim about HSK scope, and the report's review deck is
  named after the source rather than a level number.
* **A deck id must resolve.** The parser only accepts a deck that exists in the
  context it was given, so an invented one cannot become a paper — the same rule
  that makes citations verifiable.

The source is also what splits the two `make` kinds, and the split is the app's own
vocabulary: *"an exam on this deck"* builds a paper from the deck, while *"quiz me
on this deck"* still builds the drill folder of the learner's cards. Both are the
learner's own material; one is a sitting and one is practice.

**The tutor may propose a paper; it may not write one.** `make` gained
`{"kind":"examPaper","level":N}` **or** `{"kind":"examPaper","deckId":"<id>"}`, and
the parser accepts **only the source**: items and keys offered by a reply are
ignored, because the app builds both. Locally, "give me an HSK 3 exam" is
understood with no model at all, "an exam on this deck" builds the paper from that
deck, "an HSK test" with no level **asks** for the level (chips 1-4, each sending a
message that will be understood), and a learner with no decks still gets an exam
from the bundled vocabulary rather than a dead end. When the paper exists, the
reply's card becomes a link to it, exactly as the folder's does.

**Writing from HSK 3, as in the real paper — and only where the source can carry
it.** The blueprint plans a writing section (`orderTokens`, `dictation`) from level
3, and a deck paper plans one too. Whether a *paper* contains it is the builder's
answer, not the blueprint's: a section whose kinds the source cannot carry at all is
simply absent (a level with no sentences has no word-order section), while a section
that was buildable but thinner than asked for is counted in `dropped` and shown. A
missing section is truer than a shortfall of items the paper never had.

**Four more `make` kinds, each with a different author.** The tutor now also
*chooses a level for a **reading pack***, *notices that a learner wants a **review
sprint***, and the exam gained two actions of its own:

* **A reading pack** is a graded story at the chosen level plus questions about it.
  It is the first `make` that needs the model to **write**, so the division is
  sharpest here: the topic comes from the app's own story catalogue (never from the
  reply), the story is written once and cached under the reading library's own id
  scheme, and every question is derived from the text that was saved — the pool is
  the bundled vocabulary for that level *filtered to the words the story actually
  uses*, and the story itself is the passage its gap-fill items are asked about. A
  story whose words the app cannot key still makes a pack; it just makes one with no
  questions.
* **A paper's passage** stops being example sentences stitched together: when a
  paper is built for a level the learner already has a story for, that story's text
  becomes the paper's passage. No story, no passage — and a paper without passage
  items, exactly as before.
* **A review sprint** takes **no arguments at all**: what is due is a fact the app
  owns, so the model can only notice that a learner wants one. The cards come from
  the SRS state, newest-due first, and nothing about the proposal can influence what
  ends up in the folder. "Nothing due" is its own answer, worded as the good news it
  is.
* **Your papers, and a paper built from your mistakes.** The exam store has held
  every paper and attempt since the first one was saved, so a "your papers" list on
  the intro is a surface rather than a feature — and the report's second teaching
  action asks the learner to *answer* the words they got wrong, assembled by the same
  builder from `ExamWord.fromItem`, so a retake is a real short paper with a real key
  rather than a second look at questions whose answers are already known. The
  report's third action opens the same **writing bench** a deck opens, for the missed
  characters the learner's own cards carry stroke data for — which is why the tutor
  does not `make` a worksheet: a sheet is a thing you do, not a thing you keep.

**Still deferred, and deliberately:** speaking and free production items, `writePrompt`
(draw the character: the stroke matcher exists, but the item needs drawn geometry
plumbed through the answer model, which is its own slice), picture items, a calibrated
score, the remedial-lesson folder, and the per-item "report this question" path.




### Deliberately not done yet

* **CITE book and CITE dictionary.** The parser validates those id sets and the
  prompt has their lines, but nothing supplies them (`bookIds` is never passed, and
  the screen's allow-map has no dictionary entry), so both chip kinds are
  unreachable. (CITE **video** is wired: ≤6 candidates per turn, their ids passed,
  and `onOpenVideo` opens the app's own player.)
* **MAKE beyond the two.** A folder and a paper exist end to end. The rest of
  §11.4 — study plan, reading pack, remedial lesson — does not.
* **Pin/Keep and the "3 more" collapse** (§12.6): a long reply just grows, and a
  SHOW block cannot yet be saved into the library.
* **Transcript persistence, clear, retry.** The conversation lives in the screen's
  state: it survives a tab switch (`IndexedStack`) and not an app restart. There is
  no cancel and no regenerate.
* **An artefact catalogue of two, of twenty-one** (§4.2). The registry is built for
  more — enum + args parser + builder + test — and the app already owns most of the
  widgets it would need.
* **The exam's remaining sections** — writing, speaking, free production — and a
  "my tests" list. See *A real paper, not a folder of cards* above.







