import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/pitch_contour.dart';
import 'package:hanzi_master/core/utils/tone_evaluator.dart';
import 'package:hanzi_master/core/utils/tone_templates.dart';

/// A 0–1 control shape resampled to [n] points, built with `ToneTemplates.resample` so
/// the test shapes sit on the same footing as the references.
List<double> shape(List<double> control, {int n = 9}) =>
    ToneTemplates.resample(control, n);

/// A 0–1 shape as an F0 contour that is **linear in log-pitch**, so `toLog2` recovers
/// the shape exactly and the tests measure the comparison rather than the log curve.
/// Equal pitch steps are also the sensible model of someone moving their voice.
List<double?> f0(List<double> values, {double base = 150, double span = 8}) => [
      for (final value in values) base * math.pow(2, (value * span) / 12),
    ];

const _rising = [0.0, 1.0];
const _falling = [1.0, 0.0];
const _flat = [0.5, 0.5];
const _dipping = [0.35, 0.0, 0.65];
const _lowFalling = [0.3, 0.0];

void main() {
  group('ToneTemplates — Chao tone letters', () {
    test('levels 1-5 map onto the 0-1 scale', () {
      expect(ToneTemplates.levelToUnit(1), 0.0);
      expect(ToneTemplates.levelToUnit(3), 0.5);
      expect(ToneTemplates.levelToUnit(5), 1.0);
    });

    test('every gradable shape has the declared resolution', () {
      for (final tone in [1, 2, 3, 4]) {
        expect(ToneTemplates.reference(tone)!.length, ToneTemplates.resolution);
      }
    });

    test('the four tones have the directions Mandarin actually has', () {
      final t1 = ToneTemplates.reference(1)!;
      final t2 = ToneTemplates.reference(2)!;
      final t3 = ToneTemplates.reference(3)!;
      final t4 = ToneTemplates.reference(4)!;

      expect(t1.first, equals(t1.last), reason: '55 is level');
      expect(t2.last, greaterThan(t2.first), reason: '35 rises');
      expect(t4.last, lessThan(t4.first), reason: '51 falls');
      // 214: the dip is *interior*. Going down and then coming back up is the whole
      // character of a third tone, and what separates it from a fourth.
      final low = t3.reduce(math.min);
      final lowest = t3.indexOf(low);
      expect(lowest, greaterThan(0));
      expect(lowest, lessThan(t3.length - 1));
      expect(t3.last, greaterThan(low), reason: 'it comes back up');
    });

    test('the half-third is low and falling with no rise at all', () {
      // 半三声: 请坐, 美国. Demanding the dip here is how a matcher marks correct
      // Mandarin wrong — the failure audit 39 removed — so the non-final shape has to
      // genuinely differ from the full one.
      final half = ToneTemplates.reference(3, phraseFinal: false)!;
      for (int i = 1; i < half.length; i++) {
        expect(half[i], lessThanOrEqualTo(half[i - 1] + 1e-9),
            reason: 'monotone: never rises');
      }
      expect(half, isNot(equals(ToneTemplates.reference(3)!)));
    });

    test('neutral tone has no reference shape, so it is not gradable', () {
      expect(ToneTemplates.reference(5), isNull);
      expect(ToneTemplates.reference(0), isNull);
      expect(ToneTemplates.isGradable(5), isFalse);
      expect(ToneTemplates.isGradable(3), isTrue);
    });

    test('resample interpolates linearly and copes with a single point', () {
      expect(ToneTemplates.resample([0.0, 1.0], 5), [0.0, 0.25, 0.5, 0.75, 1.0]);
      expect(ToneTemplates.resample([0.4], 3), [0.4, 0.4, 0.4]);
      expect(ToneTemplates.resample([], 3), isEmpty);
    });
  });

  group('PitchContourMath', () {
    test('an octave is 12 semitones, in log-pitch', () {
      expect(PitchContourMath.spanSemitones([100, 200]), closeTo(12, 1e-9));
      expect(PitchContourMath.spanSemitones([200, 100]), closeTo(12, 1e-9));
      expect(PitchContourMath.spanSemitones([150, 150]), closeTo(0, 1e-9));
    });

    test('span ignores unvoiced frames instead of reading them as zero', () {
      expect(PitchContourMath.spanSemitones([null, 100, null, 200]),
          closeTo(12, 1e-9));
      expect(PitchContourMath.spanSemitones([null, null]), 0);
    });

    test('fillGaps interpolates interior gaps and holds the edge value', () {
      expect(PitchContourMath.fillGaps([100, null, 200])[1], closeTo(150, 1e-9));
      // No extrapolation: a leading gap takes the first real value rather than
      // inventing a trend backwards.
      expect(PitchContourMath.fillGaps([null, 100, 200])[0], 100);
      expect(PitchContourMath.fillGaps([100, 200, null])[2], 200);
      expect(PitchContourMath.fillGaps([null, null]), [null, null]);
    });

    test('normaliseShape puts the floor at 0 and the ceiling at 1', () {
      expect(PitchContourMath.normaliseShape([1.0, 2.0, 3.0]), [0.0, 0.5, 1.0]);
    });

    test('a flat contour normalises to 0.5 — it is not an error case', () {
      // A correct first tone *is* flat, so rejecting flatness would reject correct
      // Mandarin. 0.5 cannot pass as a rise or a fall, so nothing is lost.
      expect(PitchContourMath.normaliseShape([2.0, 2.0, 2.0]), [0.5, 0.5, 0.5]);
      expect(PitchContourMath.normaliseShape([]), isNull);
    });

    test('an octave jump is caught, a gentle move is not', () {
      expect(PitchContourMath.hasOctaveJump([0.0, 1.0]), isTrue);
      expect(PitchContourMath.hasOctaveJump([0.0, 0.4]), isFalse);
      // Unvoiced frames neither cause nor hide a jump.
      expect(PitchContourMath.hasOctaveJump([0.0, null, 1.0]), isFalse);
    });

    test('distance is 0 for identical curves and grows with disagreement', () {
      expect(PitchContourMath.distance([0.0, 1.0], [0.0, 1.0]), 0);
      expect(PitchContourMath.distance([0.0, 1.0], [1.0, 0.0]), 1.0);
      expect(PitchContourMath.distance([0.0], [0.0, 1.0]), double.infinity);
    });
  });

  group('ToneEvaluator — the verdict', () {
    test('a correct tone of each kind is measured as itself', () {
      expect(
        ToneEvaluator.evaluate(contour: f0(shape(_flat)), expectedTone: 1).actualTone,
        1,
      );
      expect(
        ToneEvaluator.evaluate(contour: f0(shape(_rising)), expectedTone: 2)
            .actualTone,
        2,
      );
      expect(
        ToneEvaluator.evaluate(contour: f0(shape(_falling)), expectedTone: 4)
            .actualTone,
        4,
      );
      expect(
        ToneEvaluator.evaluate(contour: f0(shape(_dipping, n: 7)), expectedTone: 3)
            .actualTone,
        3,
      );
    });

    test('the same shape gets the same verdict at any absolute pitch', () {
      // The test that justifies the whole normalisation. A man near 110 Hz and a woman
      // near 250 Hz saying the same rising tone: a raw-Hz comparison — which is what
      // `DtwAligner.alignPitch` still does — separates those by 140 Hz, and would call
      // one of them wrong for it.
      final man = ToneEvaluator.evaluate(
        contour: f0(shape(_rising), base: 110),
        expectedTone: 2,
      );
      final woman = ToneEvaluator.evaluate(
        contour: f0(shape(_rising), base: 250),
        expectedTone: 2,
      );
      expect(man.actualTone, 2);
      expect(woman.actualTone, 2);
      expect(man.matchesTarget, isTrue);
      expect(woman.matchesTarget, isTrue);
      expect(man.targetDistance, closeTo(woman.targetDistance!, 1e-9));

      // …and a falling contour at each of those pitches is wrong at both, so the test
      // above is not simply asserting that everything passes.
      expect(
        ToneEvaluator.evaluate(
          contour: f0(shape(_falling), base: 110),
          expectedTone: 2,
        ).actualTone,
        isNot(2),
      );
      expect(
        ToneEvaluator.evaluate(
          contour: f0(shape(_falling), base: 250),
          expectedTone: 2,
        ).actualTone,
        isNot(2),
      );
    });

    test('a dip in place of a rise is named as a third tone', () {
      // The 2↔3 pair decides whether local tone grading is credible, and audit 40 §6
      // names it. The verdict has to *name* the confusion rather than shrug.
      final assessment = ToneEvaluator.evaluate(
        contour: f0(shape(_dipping, n: 7)),
        expectedTone: 2,
      );
      expect(assessment.measured, isTrue);
      expect(assessment.actualTone, 3);
      expect(assessment.matchesTarget, isFalse);
      expect(assessment.nearestTone, 3);
    });

    test('a rise in place of a dip is named as a second tone', () {
      final assessment = ToneEvaluator.evaluate(
        contour: f0(shape(_rising)),
        expectedTone: 3,
      );
      expect(assessment.actualTone, 2);
      expect(assessment.matchesTarget, isFalse);
    });

    test('a fall in place of a third tone is named as a fourth, not shrugged off', () {
      // This is what the "nearest template" gate exists for. Judging the clarity of the
      // measurement by its distance to the *target* would call this unclear — but the
      // learner produced something perfectly identifiable, and the useful answer is
      // "that was a falling tone".
      final assessment = ToneEvaluator.evaluate(
        contour: f0(shape(_falling)),
        expectedTone: 3,
      );
      expect(assessment.verdict, ToneVerdict.measured);
      expect(assessment.actualTone, 4);
    });

    test('a non-final third tone is graded against the half-third shape', () {
      // 请坐 / 美国: low and falling, no dip. The same reading judged as phrase-final
      // lands somewhere else entirely — the bug the second template prevents.
      final low = f0(shape(_lowFalling));
      final nonFinal = ToneEvaluator.evaluate(
        contour: low,
        expectedTone: 3,
        phraseFinal: false,
      );
      expect(nonFinal.actualTone, 3);
      expect(nonFinal.matchesTarget, isTrue);

      final asFinal = ToneEvaluator.evaluate(contour: low, expectedTone: 3);
      expect(asFinal.actualTone, isNot(3));
    });

    test('silence and near-silence are never graded', () {
      final silent = ToneEvaluator.evaluate(
        contour: List<double?>.filled(9, null),
        expectedTone: 4,
      );
      expect(silent.verdict, ToneVerdict.unvoiced);
      expect(silent.measured, isFalse);
      expect(silent.actualTone, 0);

      // Mostly gaps: two voiced frames cannot show a shape.
      final sparse = ToneEvaluator.evaluate(
        contour: [null, null, 160, null, null, null, 220, null, null],
        expectedTone: 4,
      );
      expect(sparse.verdict, ToneVerdict.tooFewFrames);
      expect(sparse.actualTone, 0);
    });

    test('neutral tone is refused, because it has no fixed shape', () {
      final assessment = ToneEvaluator.evaluate(
        contour: f0(shape(_lowFalling)),
        expectedTone: 5,
      );
      expect(assessment.verdict, ToneVerdict.noFixedShape);
      expect(assessment.actualTone, 0);
    });

    test('an octave jump is a measurement failure, not a wrong tone', () {
      final assessment = ToneEvaluator.evaluate(
        contour: [150, 160, 300, 310, 160, 150],
        expectedTone: 1,
      );
      expect(assessment.verdict, ToneVerdict.octaveJump);
      expect(assessment.actualTone, 0);
    });

    test('a creak in the middle of a dip does not split it in two', () {
      // A third tone's dip descends into creaky voice, and YIN drops out exactly there.
      // The gap is bridged rather than read as two separate shapes — the single biggest
      // technical risk in the design, handled.
      final withCreak = <double?>[
        ...f0(shape([0.4, 0.0], n: 4)),
        null,
        null,
        ...f0(shape([0.0, 0.7], n: 3)),
      ];
      final assessment = ToneEvaluator.evaluate(
        contour: withCreak,
        expectedTone: 3,
      );
      expect(assessment.actualTone, 3);
    });

    test('the span reports how far the voice actually moved', () {
      final assessment = ToneEvaluator.evaluate(
        contour: f0(shape(_rising), span: 8),
        expectedTone: 2,
      );
      expect(assessment.spanSemitones, closeTo(8, 0.01));
    });

    test('actualTone is 0 whenever nothing was measured', () {
      // The invariant the rest of the app depends on: `CalligraphicPitchContour` and
      // `SpeakingFeedbackPanel` read 0 as "no claim", so it must never carry a tone.
      final contours = <List<double?>>[
        List<double?>.filled(6, null),
        [null, 150, null, null],
        [150, 200, 400, 150],
      ];
      for (final contour in contours) {
        for (final tone in [1, 2, 3, 4, 5]) {
          final assessment =
              ToneEvaluator.evaluate(contour: contour, expectedTone: tone);
          expect(assessment.measured, assessment.actualTone > 0);
          if (!assessment.measured) {
            expect(assessment.actualTone, 0);
          }
        }
      }
    });
  });
}
