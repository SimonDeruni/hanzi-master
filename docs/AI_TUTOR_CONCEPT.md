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
  ]
}
```

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




