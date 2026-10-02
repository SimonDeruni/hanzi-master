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

