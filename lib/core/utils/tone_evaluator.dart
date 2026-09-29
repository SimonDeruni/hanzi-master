import 'package:hanzi_master/core/utils/pitch_contour.dart';
import 'package:hanzi_master/core/utils/tone_templates.dart';

/// Why a tone did, or did not, get a verdict.
enum ToneVerdict {
  /// A tone was identified.
  measured,

  /// Too few voiced frames inside the window to show a shape at all.
  tooFewFrames,

  /// Nothing usable was voiced — silence, a whisper, or too much noise.
  unvoiced,

  /// The tone has no fixed shape to match. Neutral tone (轻声) always lands here: it
  /// takes its pitch from the syllable before it, so there is no curve to grade.
  noFixedShape,

  /// The contour jumped more than an octave between frames: the detector locked onto
  /// a harmonic. This is a **measurement failure, not a wrong tone**.
  octaveJump,

  /// Far enough from every template that naming one would be a guess.
  unclear,
}

/// The outcome of comparing one syllable's pitch against a tone.
class ToneAssessment {
  /// **1–4 when measured, and 0 for "not measured"** — the convention
  /// `CalligraphicPitchContour` and `SpeakingFeedbackPanel` already read, and the
  /// value that goes into `words[].actualTone`.
  final int actualTone;

  final ToneVerdict verdict;

  /// The tone the reference asked for.
  final int expectedTone;

  /// The closest template, whether or not it was the target. Null when no comparison
  /// could be made at all.
  final int? nearestTone;

  /// Mean-absolute shape distance to the *target* template: 0 is identical, ~0.5 is
  /// an opposite shape. Null when no comparison was possible.
  final double? targetDistance;

  /// How far the voice moved, in semitones. Carried separately because shape
  /// normalisation deliberately discards magnitude.
  final double spanSemitones;

  const ToneAssessment({
    required this.actualTone,
    required this.verdict,
    required this.expectedTone,
    this.nearestTone,
    this.targetDistance,
    this.spanSemitones = 0,
  });

  const ToneAssessment.notMeasured(
    ToneVerdict reason, {
    required this.expectedTone,
    this.nearestTone,
    this.targetDistance,
    this.spanSemitones = 0,
  })  : actualTone = 0,
        verdict = reason;

  bool get measured => actualTone > 0;

  /// True when a tone was measured **and** it was the one the reference asked for.
  bool get matchesTarget => measured && actualTone == expectedTone;
}

/// Turns a pitch contour into a tone verdict, locally.
///
/// This is the piece that replaces a vendor. It answers *"does this match the tone we
/// asked for?"* and, when it does not, *"which tone did it look like?"* — never "how
/// good was that out of 100", because a percentage on a five-frame contour would be a
/// number pretending to a precision it does not have.
///
/// The rules come from `docs/LOCAL_TONE_PLAN.md` and `audit/audit_39`: **when the
/// measurement cannot support a verdict, say so.** Being told a correct tone was wrong
/// is the failure audit 39 removed, and it is worse than saying nothing.
class ToneEvaluator {
  /// Fewer voiced frames than this cannot show a shape — a syllable yields 5–9 at the
  /// 32 ms hop, so four is the floor below which noise dominates.
  static const int minVoicedFrames = 4;

  /// Below this fraction of voiced frames, the window is mostly silence or noise.
  static const double minVoicedRatio = 0.35;

  /// At or under this distance from the **target**, the contour is that tone, whatever
  /// the other templates think.
  ///
  /// This exists for the half-third, and it took a failing test to find. A non-final
  /// third tone is a low fall — and a low fall is also exactly what a fourth tone looks
  /// like — so `nearest` picks tone 4 and a learner who said precisely what the
  /// reference asked for gets told they said a falling tone. **Two independent ways to
  /// be right are therefore required:** the target can be the nearest template, *or*
  /// the target can be a near-exact match.
  ///
  /// **Measured, not guessed.** `test/core/utils/tone_calibration_test.dart` sweeps it:
  /// at `0.15` the false-negative rate was 4.4% but **14.1% of wrong tones were
  /// accepted**; at **`0.10` the false-negative rate is the same 4.4% and
  /// wrong-acceptance more than halves, to 6.7%**. At `0.0` false negatives double to
  /// 20% — that is the half-third case above, which is what the near-exact-match path is
  /// for. So 0.10 is the knee, and it was found by measurement rather than reasoning.
  static const double matchThreshold = 0.10;

  /// How far the **nearest** template may sit before naming a tone stops being honest.
  ///
  /// Mean absolute shape distance on a 0–1 scale, where 0 is identical and ~0.5 is an
  /// opposite shape. Measured as the nearest template's distance — **not the target's** —
  /// because a learner who says a clearly different tone is far from the target by
  /// definition, and that is a diagnosis to report rather than a reason to shrug.
  ///
  /// ⚠️ **This was the single most important knob, and the calibration harness moved it
  /// from `0.38` to `0.20` on its first run.** The number that forced the change was not
  /// the false-negative rate — which is **4.4% at every value tested** — but what the gate
  /// did with pitch that follows no tone at all. Twenty white-noise contours were refused
  /// only **15% of the time at 0.38**: a contour with no tone in it was being confidently
  /// named. The measured trade-off:
  ///
  /// | max | false negatives | not measured | shapeless refused |
  /// |---|---|---|---|
  /// | 0.38 | 4.4% | 0% | **15%** |
  /// | 0.25 | 4.4% | 0% | 40% |
  /// | **0.20** | **4.4%** | **2.2%** | **90%** |
  /// | 0.15 | 4.4% | 11.1% | 95% |
  ///
  /// `0.20` is the knee: it costs 2.2% of takes being declined and buys a sixfold
  /// improvement in refusing noise.
  static const double maxTemplateDistance = 0.20;

  /// Compare [contour] against [expectedTone].
  ///
  /// [phraseFinal] selects the reference shape: a third tone that is *not* the last
  /// syllable of its phrase is realised low and falling with **no dip** (半三声), and
  /// matching it against the full dipping shape marks correct Mandarin as wrong.
  ///
  /// [matchThreshold] and [maxTemplateDistance] are exposed so they can be **swept**
  /// rather than trusted — see `test/core/utils/tone_calibration_test.dart`, which
  /// measures the false-negative rate across a synthetic corpus and is written to be
  /// re-pointed at real recordings. Nothing in the app should pass them.
  static ToneAssessment evaluate({
    required List<double?> contour,
    required int expectedTone,
    bool phraseFinal = true,
    double matchThreshold = ToneEvaluator.matchThreshold,
    double maxTemplateDistance = ToneEvaluator.maxTemplateDistance,
  }) {
    final frames = contour.length;
    final voiced = PitchContourMath.voicedCount(contour);
    final span = PitchContourMath.spanSemitones(contour);

    if (frames == 0 || voiced == 0) {
      return ToneAssessment.notMeasured(
        ToneVerdict.unvoiced,
        expectedTone: expectedTone,
        spanSemitones: span,
      );
    }

    if (voiced < minVoicedFrames || voiced / frames < minVoicedRatio) {
      return ToneAssessment.notMeasured(
        ToneVerdict.tooFewFrames,
        expectedTone: expectedTone,
        spanSemitones: span,
      );
    }

    // Neutral tone is not a shape, so there is nothing to be right or wrong about.
    if (ToneTemplates.reference(expectedTone, phraseFinal: phraseFinal) == null) {
      return ToneAssessment.notMeasured(
        ToneVerdict.noFixedShape,
        expectedTone: expectedTone,
        spanSemitones: span,
      );
    }

    final filled = PitchContourMath.fillGaps(contour);
    final log = PitchContourMath.toLog2(filled);

    if (PitchContourMath.hasOctaveJump(log)) {
      return ToneAssessment.notMeasured(
        ToneVerdict.octaveJump,
        expectedTone: expectedTone,
        spanSemitones: span,
      );
    }

    final shape = PitchContourMath.normaliseShape(log);
    final measured =
        shape == null ? const <double>[] : shape.whereType<double>().toList();
    if (measured.isEmpty) {
      return ToneAssessment.notMeasured(
        ToneVerdict.unvoiced,
        expectedTone: expectedTone,
        spanSemitones: span,
      );
    }

    final measuredResampled =
        ToneTemplates.resample(measured, ToneTemplates.resolution);
    final target =
        _shapeOf(ToneTemplates.reference(expectedTone, phraseFinal: phraseFinal)!);
    final targetDistance = PitchContourMath.distance(measuredResampled, target);

    // "Which tone did it look like?" always compares against the **full** third tone:
    // the half-third is a realisation of a third tone, not a tone of its own, so it
    // must never be reported as a different answer.
    var nearest = expectedTone;
    var bestDistance = double.infinity;
    for (final tone in const [1, 2, 3, 4]) {
      final distance = PitchContourMath.distance(
        measuredResampled,
        _shapeOf(ToneTemplates.reference(tone)!),
      );
      if (distance < bestDistance) {
        bestDistance = distance;
        nearest = tone;
      }
    }

    // Naming a tone is only honest when *some* template fits. `bestDistance` is the
    // distance to the nearest one — **not to the target** — because a learner who said
    // a clearly different tone has a large target distance by definition, and that is a
    // diagnosis to report, not an excuse to shrug. Using the target distance here would
    // have turned "you said a falling tone" into "unclear".
    if (bestDistance >= maxTemplateDistance) {
      return ToneAssessment.notMeasured(
        ToneVerdict.unclear,
        expectedTone: expectedTone,
        nearestTone: nearest,
        targetDistance: targetDistance,
        spanSemitones: span,
      );
    }

    // The verdict is now "the nearest template", with two independent ways to be right.
    //
    // `nearest == expectedTone` handles a *sloppy but correct* tone: an ideal linear rise
    // scores ~0.17 against the real second-tone curve, so any threshold tight enough to
    // demand near-identity would reject honest speech.
    //
    // `targetDistance <= matchThreshold` handles the half-third, which is a low fall —
    // and a low fall is also what a fourth tone looks like, so `nearest` alone would
    // report a *correct* non-final third tone as tone 4.
    if (targetDistance <= matchThreshold || nearest == expectedTone) {
      return ToneAssessment(
        actualTone: expectedTone,
        verdict: ToneVerdict.measured,
        expectedTone: expectedTone,
        nearestTone: nearest,
        targetDistance: targetDistance,
        spanSemitones: span,
      );
    }

    return ToneAssessment(
      actualTone: nearest,
      verdict: ToneVerdict.measured,
      expectedTone: expectedTone,
      nearestTone: nearest,
      targetDistance: targetDistance,
      spanSemitones: span,
    );
  }

  /// A template, normalised by the **same** function that normalises a recording.
  ///
  /// Both sides must go through the identical transformation or the comparison means
  /// nothing — and doing it this way is what makes a flat contour self-consistent: a
  /// correct first tone and the first-tone template both normalise to the same flat
  /// line.
  static List<double> _shapeOf(List<double> raw) {
    final normalised = PitchContourMath.normaliseShape(raw);
    final values = normalised?.whereType<double>().toList() ?? const <double>[];
    return values.length == raw.length ? values : raw;
  }
}
