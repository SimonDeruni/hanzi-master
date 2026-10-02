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
| `strokeOrder` | animated stroke order, replay, count | replay / step | `strokePaths`, `medianPaths` | **exists** (`ScholarStrokeLesson`) |
| `characterAnatomy` | radical + components, each named and explained | tap a component → sheet | `hanzi_metadata` + `radicals.json` | new; reuses `_buildAnatomyCard` |
| `toneCurve` | the pitch contour, with the target shape over it | play / compare | `LocalToneGrader`, tone graphs | new; reuses `tone_graph_card` |
| `strokeHighlight` | one stroke isolated, with its direction | step / replay | stroke vectors | new (an argument of `strokeOrder`) |
| `contrastTable` | two items side by side with the *discriminating* examples | tap a row → dictionary | `dictionary.db`, sentences | new |
| `measureWordTable` | noun → 量词 pairs | tap → dictionary | dictionary | new |
| `characterMap` | "every character containing 氵, by frequency" | tap → card | `hanzi_metadata` radical index | new (the de-constructor, idea #16) |

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

| Type | Section | Auto-graded | Needs |
|---|---|---|---|
| `toneChoice` (which tone?) | listening | yes | TTS + tone data |
| `dictation` (hear → write) | listening | yes | TTS + stroke matcher / text |
| `quizSet` (hanzi ↔ meaning) | reading | yes | flashcards (**exists**) |
| `fillBlank` | reading | yes | sentences + dictionary |
| `orderTokens` | reading / writing | yes | sentences |
| `writePrompt` (draw it) | writing | yes | stroke matcher + strictness |
| `speakingPrompt` (say it) | speaking | yes, **on device** | tone / pronunciation graders |
| "find the error" | grammar | yes | corrected-sentence pairs |
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
2. **How much exam, how much drill?** Drills only (small, safe, quick) or a real
   mock-HSK flow with sections, timers and scores?
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
| Exam folder (Tier 2 / 2.5) | deck + quiz + canvas + tone grader | new, small→medium |
| Paper pack (Tier 3) | + blueprints, attempts, reports | new, large |
| Remedial lesson folder | radical lesson screen, error log | new, medium |
| Study plan | SRS + mastery; a "Today" surface | new, medium |
| Reading pack | the reader + comprehension items | new, medium |

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

### Deliberately not done yet

* **The provenance badge.** `TutorReply.fromModel` is carried and tested, but
  showing "answered without the model" needs one new localisation key.
* **Opening a created folder from the reply.** The confirm card shows the folder's
  name; navigating to it needs a deck route that takes an id.
* **CITE video and CITE book.** The parser already accepts and validates those ids
  (`allowedExternalIds`); nothing supplies them yet.
* **MAKE beyond `examFolder`.** One durable object, end to end, before three.
* **Any exam-taking surface.** The folder is created with the app's existing deck
  machinery; sitting an exam as a scored paper is §7's blueprints and Tier 2.5/3
  work.







