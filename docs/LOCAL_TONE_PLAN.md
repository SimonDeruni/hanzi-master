# Local tone assessment — design plan

**Status:** plan, nothing built. Supersedes the Tencent SOE route (`audit/audit_40`
§1 records the reversal; `functions/tencent-soe.js` stays as a tested but unwired record).

## The idea in one paragraph

Azure already grades **sounds**. What is missing is **tones** — and a tone is nothing
but a *pitch shape*. Your phone can measure pitch directly. So: ask Azure where each
syllable sits and whether the sounds were right, measure the pitch inside those
windows on-device, compare the shape to the tone you already know was intended, and
you have a tone verdict — with no vendor, no network, no per-call cost, no
cross-border transfer, and no law to read.

## Why this is now realistic

Three facts, all verified in this repo:

| | |
|---|---|
| **The expected tone is known** | The pinyin is authored in the app, and audit 39's fix made the surface reading win (`百战不殆` → `bǎi zhàn bú dài`). So sandhi is **already solved** — the code never has to *detect* it, only match against it. |
| **The pitch detector exists** | `pitch_detector_dart ^0.0.7` is a real dependency; `PitchDetectorService.extractPitchContour` is written and WAV-aware. |
| **The output contract exists** | `words[].actualTone` already means "the tone that was heard, or 0 for not measured". A local measurement drops straight into it, so the tone card, the coaching strings in `PinyinUtils`, and `SpeakingFeedbackPanel` all light up with **no changes to any of them**. |

The one thing still to confirm is **syllable timing from Azure** — see Stage 1.

---

## Stage 1 — Where is each syllable?

Three options, best first:

1. **Azure's own timings.** Azure's pronunciation response carries `Offset` and
   `Duration` per word and per syllable (ticks, 100 ns). Your grader **already
   receives them and throws them away** — `gemini_service.dart` reads only the scores.
   *Unverified:* I could not confirm the fields from the docs (the page truncated) and
   your test payloads don't include them. **One live response settles it**, and if they
   are there, sentence-level tone works with no extra machinery.
2. **Single-syllable drills.** One character per recording. No segmentation needed at
   all. This is the guaranteed fallback and it is where tone practice actually matters
   most.
3. **Energy/voicing segmentation.** Estimating boundaries from the waveform. Genuinely
   hard and I would not start here.

**Recommendation:** build for (2) unconditionally, add (1) the moment it is confirmed.

## Stage 2 — Measure the pitch

`extractPitchContour` with **`chunkSize: 512`** (32 ms hop at 16 kHz). Not 1024 —
A syllable is 150–300 ms, so 64 ms gives you 3–5 points, which is too few to see a
dip. 512 gives 5–9. Do not go to 256: at 16 kHz that is 16 ms, and a low male voice at
75 Hz has a 13 ms period, so the detector cannot see even two cycles.

⚠️ **Bug found while planning:** `PitchDetectorService` builds its detector with
`PitchDetector(bufferSize: 1024)` and then **zero-pads or truncates every chunk to
that 1024**, regardless of the `chunkSize` argument. So passing `chunkSize: 512` — the
advice in audit 40 §9 — pads each 512-sample window with 512 zeros and analyses half
silence. The detector's `bufferSize` must be tied to the chunk size. **This makes the
existing recommendation wrong as written**, and it is the first thing to fix.

## Stage 3 — The reference shapes

Do not invent them. Mandarin tone is standardised on **Chao's five-level scale**, and
mapping it to the speaker's own range (0 = their low, 1 = their high) gives the
templates directly:

| Tone | Chao | Shape (normalised) |
|---|---|---|
| 1 high level | 55 | flat, high — `1.0` throughout |
| 2 rising | 35 | `0.5 → 1.0`, convex |
| 3 dipping (full) | 214 | `0.25 → 0.0 → 0.5` |
| 3 half-third | 21 | `0.25 → 0.0` — **no rise** |
| 4 falling | 51 | `1.0 → 0.0`, steep |
| neutral | context | **no fixed shape** — see below |

Each template is ~20 control points. That is the entire reference data set — no
recording session, no assets, and it is what `CalligraphicPitchContour` already draws
by hand, so the picture and the maths finally agree.

**Rejected alternatives:** extracting contours from your own TTS (the `tone_v4` cache
deliberately widens pitch by 18%, so you would be grading against an exaggeration), and
precomputing native exemplars (best quality, needs a recording session — worth
revisiting later, not for v1).

## Stage 4 — Normalise. This is the one thing that must be right

The comparison code cannot be used as written. `DtwAligner.alignPitch`, line 31:

```dart
double cost = (refValid[i - 1].value - userValid[j - 1].value).abs();
```

Raw Hz. A woman at 220 Hz and a man at 110 Hz can be saying a **perfect** tone 1 and
still differ from each other — and from every template — by 110 Hz. The cost would be
dominated by *who is speaking*, not by whether the tone was right. Roughly half of
users would fail on day one.

Fix it in two layers:

1. **Work in log₂ Hz, not Hz.** Pitch is perceived logarithmically — an octave is a
   doubling — so comparing Hz makes high voices look "more wrong" for the same
   relative error.
2. **Centre and scale per speaker.** Subtract the speaker's median log-pitch, divide by
   a robust spread (half the p10–p90 range). The Stage 3 templates then live on the
   same 0–1 scale.

Two ways to get the speaker's statistics, and they differ in *when* they work:

- **From this recording** — fine for a phrase of several syllables, useless for one,
  because the speaker's range is exactly what you are trying to measure.
- **A persisted per-user profile** — accumulate median and spread across takes. Gets
  better with use, and it is the standard approach. Costs one new stored value.

**For v1 with single syllables, use a hybrid:** min-max the syllable's own contour to
get a shift-and-scale-invariant **shape** (which is what "shape" means), and separately
record the **span in semitones** as an independent second signal. Two honest outputs:

- *shape* — did the contour move the right way?
- *span* — did it move **enough**? A tone 4 that falls 0.3 semitones is not a tone 4,
  and min-max normalisation would hide that entirely.

That second signal is what stops a flat mumble scoring as a good tone.

## Stage 5 — Compare, and decide

Resample template and measurement to a common length (20 points), then:

- **DTW is overkill for the score.** On 5–9 measured points, warping adds noise rather
  than removing it. Use plain per-point distance after resampling. Keep DTW for the
  **display** alignment — that is genuinely what it is good at, and it is what
  `ToneGraphPainter` shows.
- **Do not build a 4-way classifier.** Ask two questions instead:
  1. *Does this match the tone we asked for?* — distance to that one template.
  2. *If not, which template is it nearest?* — argmin over all of them.
  You then say "close to the target" or "that looked more like a rising tone" — never
  "you scored 62%".
- **The features that actually separate 2 from 3** — the pair that decides whether this
  is credible at all:
  - **where the minimum sits**: early ⇒ tone 3; late or absent ⇒ tone 2
  - **first-third vs last-third slope**: 3 is negative-then-positive, 2 rises throughout
  - **how low the minimum goes**: tone 3 reaches the speaker's floor, tone 2 does not
  - duration is a weak hint (3 runs longer in careful speech) — tiebreak only

## Stage 6 — The honesty gate (audit 39's rule, applied to a picture)

Return **"not measured"** rather than a guess when any of these hold:

- fewer than ~4 voiced frames in the window — too short or too broken to show a shape
- the span is under ~1.5 semitones **and** the target is not tone 1 — a flat line cannot
  be told apart from certain tones
- the overall voicing ratio is too low (whisper, background noise)
- the **best** template distance is above a *lax* threshold ⇒ **"unclear, try again"**,
  deliberately a wider band than the "wrong tone" threshold

⚠️ **The biggest technical risk lives right here.** Tone 3's dip descends into **creaky
voice** for many speakers, and YIN drops out exactly there — so the detector fails
precisely on the tone that is hardest to see. Mitigations: tolerate gaps *within* the
window instead of rejecting the whole window, and interpolate across short dropouts
before testing for the dip.

## Stage 7 — 半三声, sandhi, neutral tone — the cases that make or break credibility

These are where a naive matcher marks **correct** speech wrong. All three are cheap
here, because the expected tone is **known** rather than detected:

- **半三声 (half third).** A tone 3 that is *not* phrase-final has **no dip** — it is low
  and flat (请坐 qǐng zuò, 美国 měiguó). Matching that against the full 214 template marks
  a native-like reading as wrong. Fix: select the 21 template when the syllable is
  non-final. Phrase-finality is a rule, not a guess — "is there another syllable after
  this one?" is something you already know.
- **Sandhi.** 你好 → ní hǎo, 一起 → yì qǐ, 不是 → bú shì. **There is nothing to detect.**
  The authored pinyin already carries the surface tone, and audit 39 made that the
  precedence. This is the single biggest advantage over a vendor: sandhi is a *data*
  problem locally, not a *recognition* problem. (The app now ships `百战不殆` as
  `bǎi zhàn bú dài` precisely so this holds.)
- **Neutral tone (轻声).** No fixed shape — it takes its pitch from the *preceding* tone
  (after tone 1 it sits mid, after tone 4 it sits low). **Recommendation: do not grade
  it.** Show the shape, say "neutral tone has no fixed shape — it follows the syllable
  before it", and let that be the teaching moment instead of a fake verdict.

## Stage 8 — Where it plugs in

The local pass produces the **same `actualTone` contract** the app already consumes, so
nothing downstream changes:

```
recording ─┬─> Azure ──> segments, fluency, completeness, syllable windows  (existing)
           │
           └─> local ──> contour ──> normalise ──> compare ──> actualTone   (new)
                                                                 │
             words[].actualTone ──> tone card / the lightbulb / SpeakingFeedbackPanel
                                 └──> PinyinUtils tone-coaching strings
```

`PinyinUtils` already holds the coaching copy — *"You dropped sharply without rising
(4th tone). Allow your pitch to bounce gently back up (3rd tone)"* — and it takes
`expectedTone` + `actualTone`. Feed it a measured `actualTone` and the whole coaching
layer lights up with **no new copy**.

**When to run it:** after Azure returns, over the same `audioBytes`, in an **isolate** so
the UI thread is untouched. Cost is milliseconds of CPU.

## Stage 9 — Offline-first

Once this exists, tone grading needs no network at all, which gives three modes the app
can choose between per situation:

| Mode | Segments | Tone | Needs network |
|---|---|---|---|
| Full | Azure | local | yes |
| **Single-character tone drill** | — | local | **no** |
| Fallback (Azure unreachable) | — | local | no |

The middle row is the interesting one: a single-character tone drill needs *nothing* from
Azure, because there is nothing to segment and nothing to score but the pitch. That is a
genuinely offline feature — and it is the exercise where tone practice matters most.

---

## Validation — how we find out whether it is actually good

Do not trust this design; measure it. **`audit/audit_40` §4 already contains the exact
stimulus set**, so reuse it rather than inventing a new one:

- **Tier A (§4.1)** — 妈麻马骂 / 八拔把爸 / 汤糖躺烫 / 师十使是 / 衣移椅易: five syllables ×
  four tones, which *is* the confusion matrix
- **The deliberate-error set (§4.6)** — a native speaker producing each *wrong* tone on a
  clean syllable. This is what makes **false positives** measurable, and without it every
  result flatters the system
- **Half-third items** — 请坐, 美国
- **Sandhi items** — 你好, 一起, 不是, 百战不殆

Metrics straight from §6: **M1** the correct-tone false-negative rate (the headline —
telling a learner they are wrong when they are right is the failure audit 39 removed),
**M2** wrong-tone detection, **M3** 4-way accuracy, **M4** the confusion pairs with
**2↔3 named explicitly**, and the **"not measured" rate** — which should be *low*: a
system that refuses to grade everything is as useless as one that guesses.

## Risks, honestly

| Risk | Severity | Mitigation |
|---|---|---|
| Azure gives no syllable timing | medium | single-character drills always work; confirm with one call |
| **Tone 3 creak kills the dip** | **high** | tolerate in-window gaps, interpolate, be willing to say "unclear" |
| **2 vs 3 accuracy is poor** | **high** | the Stage 5 features; measure it *before* shipping a verdict |
| `pitch_detector_dart` is `0.0.7` | medium | measure on real takes — the author's own `probability > 0.7` gate hints at noise |
| Octave errors on high or breathy voices | medium | the 50–800 Hz gate helps; a contour jumping a full octave mid-syllable is detector failure, not a tone error — detect and reject |
| A user's voice falls outside the templates | medium | the span signal + the per-user profile |

## Effort

| Item | Size |
|---|---|
| Fix the `bufferSize` / `chunkSize` mismatch | small — **do first** |
| log₂ normalisation + the span signal | ~60 lines |
| Chao templates (5 shapes × 20 points) | ~50 lines of data |
| Comparison, nearest-template, confidence gate | ~120 lines |
| Wire into `gradeAudio` + isolate | ~60 lines |
| Tests (templates, normalisation, gate, the 2-vs-3 cases) | as much again |
| Validation recordings + harness | the real work — reuse §4 |

**A focused day or two of code, plus the recording session.** No vendor, no cost, no
network, no transfer, no policy page to change.

## The one thing to check before any of it

**Does Azure return `Offset`/`Duration` in your actual responses?** If yes, sentence-level
tone is on the table. If no, scope to single characters — which is still a real feature,
and arguably the one that teaches tone best. Either way, **Stage 2's bug fix and Stage 4's
normalisation are required, and both are small.**

---

## Implementation status — 2026-09-27

**Stages 1–7 are built and tested. Stage 8 (wiring) is deliberately not done**, so nothing
user-visible has changed: `words[].actualTone` still comes from the Azure path's honest
"not measured", exactly as audit 39 left it.

| | |
|---|---|
| `lib/core/utils/tone_templates.dart` (new) | the Chao reference shapes, including the half-third |
| `lib/core/utils/pitch_contour.dart` (new) | log-pitch normalisation, span, gap filling, octave detection |
| `lib/core/utils/tone_evaluator.dart` (new) | the verdict, the two ways to match, the honesty gate |
| `lib/core/services/pitch_detector_service.dart` | **the window/buffer bug fixed** — `windowSize` now *is* the detector's buffer, so 512 means 512 |
| `test/core/utils/tone_evaluator_test.dart` (new, **25 tests**) | every branch, on hand-written contours |
| `test/core/services/pitch_detector_service_test.dart` (new, **6 tests**) | **synthetic PCM through the real detector**, end to end |

### Two design flaws, both found by writing tests rather than by reading this plan

1. **A level tone was being turned into noise.** A correct first tone is a steady note with
   natural jitter, and min–max normalisation amplified that jitter into a random
   full-scale shape — so a *level* reading could match anything. `flatSpanSemitones` (1.5)
   now short-circuits anything that steady to a level line. The **end-to-end audio test
   caught this**, not the unit tests.
2. **The half-third was being reported as a fourth tone.** A non-final third tone *is* a
   low fall — and a low fall is also what a fourth tone looks like — so "is the target the
   nearest template?" picked tone 4 and would have told a learner they were wrong when they
   had said precisely what the reference asked for. **Two independent ways to be right are
   now required:** the target can be the nearest template, *or* it can be a near-exact
   match. That is the false-negative failure audit 39 removed, reproduced in the new code
   and then fixed.

Both are worth recording because they are the *shape* of the risk here: not that the maths
is hard, but that it is easy to be confidently wrong in a way that punishes correct speech.

**Probed by reverting:** removing the min–max normalisation from `normaliseShape` fails the
"same shape at any absolute pitch" test — the assertion that justifies the whole approach,
since a raw-Hz comparison (what `DtwAligner.alignPitch` still does) separates a 110 Hz
voice from a 250 Hz one by 140 Hz and would call one of them wrong for it.

### Why the wiring is not done

`gradeAudio` feeds **four** consumers — the shadowing studio, the live call, Echo Hall
roleplay and the flashcards speaking mode — and every one of them reads `actualTone` as "a
tone was measured". Wiring in a source whose behaviour on *real* audio is untested would put
four features at risk to satisfy none of them. It wants its own change, with its own tests
on real takes.

### What still needs doing

- **Wire stage 8**, for single-character references first (`docs/LOCAL_TONE_PLAN.md` §9's
  offline mode), where segmentation is not needed at all.
- ~~**Calibrate**~~ **Done 2026-09-27** — `test/core/utils/tone_calibration_test.dart`
  measures them, and moved both: `matchThreshold` **0.15 → 0.10** (the same 4.4%
  false-negative rate, but wrong-acceptance halved from 14.1% to 6.7%) and
  `maxTemplateDistance` **0.38 → 0.20**. The second is the one that mattered, and not
  for the reason anyone was looking at: the false-negative rate was **4.4% at every
  value tested**, so the gate never affected accuracy — but it refused only **15% of
  white-noise contours**, i.e. pitch containing no tone at all was being confidently
  named. At 0.20 that is **90%**. Re-run the harness on real recordings before trusting
  either number.
- ~~**Stage 8, the wiring**~~ **Done 2026-09-27** — `local_tone_grader.dart`, called from
  `gradeAudio`. One Hanzi only; everything else is deliberately left alone. See
  `CHANGELOG.md` for the reasoning.
- ~~**Re-enable the pitch graph**~~ **Done 2026-09-27** — `tone_graph_card.dart`, with a
  legend, a lightbulb carrying a phrase-specific note, and an empty state that separates
  "not measured" from "wrong". It was never the one-line uncomment it looked like: the
  hidden block referenced `_userPitch`/`_idealPitch`/`_highlightStart`/`_highlightEnd`,
  all of which had been deleted, so it no longer compiled.
- **Confirm Azure's syllable timings**, which is the difference between single characters
  and whole sentences. Still the highest-value unknown: it is the only thing standing
  between the current narrow win and tone feedback on every phrase the shadowing studio
  and Echo Hall show. It is also what would let the graph's two strokes be **time-aligned**
  instead of merely comparable, which is the one caveat the graph's own note has to admit.
- ~~**The panel's copy, and its thirteen translations**~~ **Done 2026-09-29** — the
  lightbulb opened a single 590-character paragraph (880 with the shadowing studio's
  phrase note) and it was **English in every locale**, because the seven `toneGraph*` keys
  existed only in `app_en.arb` and `gen-l10n` copies the template into any locale that
  lacks them. It is four bullets now, plus two for the phrase note, hand-written in all 14
  locales (10,158 → 7,399 characters); the shape is pinned per locale in
  `test/unit_tests/l10n_arb_parity_test.dart` and the rule lives in
  `docs/LOCALIZATION_PIPELINE.md` §5b. What the note *admits* — the two strokes are not
  time-aligned — is unchanged, and so is the sentence the panel exists for: one stroke
  never means you were wrong.


