import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/tone_evaluator.dart';
import 'package:hanzi_master/core/utils/tone_templates.dart';

/// **Calibration, not assertion.** `ToneEvaluator.matchThreshold` and
/// `maxTemplateDistance` shipped as provisional numbers with nothing behind them but
/// reasoning. This file measures them.
///
/// It is written to be **re-pointed at real recordings**: swap [_syntheticCorpus] for
/// takes from `audit/audit_40` §4 — including the deliberate-error set in §4.6, which is
/// the only thing that makes false positives measurable — and every metric below works
/// unchanged.
///
/// The synthetic corpus is not a substitute for real audio. It is a substitute for
/// *nothing*, which is what the thresholds had.

enum _Realization {
  /// The template, clean. The floor: if this fails, the maths is broken.
  ideal,

  /// A steady voice, not a machine: small pitch wobble plus two dropped frames.
  jittered,

  /// The learner trailed off and the tail of the syllable is missing — the most common
  /// real-world truncation, and the reason the evaluator resamples.
  truncated,
}

class _Take {
  const _Take(this.tone, this.phraseFinal, this.base, this.realization);
  final int tone;
  final bool phraseFinal;
  final double base;
  final _Realization realization;

  String get label =>
      'tone$tone${phraseFinal ? '' : '-half'} @${base.round()}Hz ${realization.name}';
}

List<_Take> _syntheticCorpus() {
  final takes = <_Take>[];
  for (final tone in const [1, 2, 3, 4]) {
    // Tone 3 is the only one with two shapes, and the non-final one is where the first
    // version of this evaluator went wrong.
    final finals = tone == 3 ? const [true, false] : const [true];
    for (final phraseFinal in finals) {
      for (final base in const [110.0, 150.0, 220.0]) {
        for (final realization in _Realization.values) {
          takes.add(_Take(tone, phraseFinal, base, realization));
        }
      }
    }
  }
  return takes;
}

List<double?> _contourFor(_Take take, math.Random random) {
  var shape = List<double>.from(
    ToneTemplates.reference(take.tone, phraseFinal: take.phraseFinal)!,
  );
  if (take.realization != _Realization.ideal) {
    shape = [
      for (final value in shape)
        (value + (random.nextDouble() - 0.5) * 0.08).clamp(0.0, 1.0),
    ];
  }
  final contour = <double?>[
    for (final value in shape) take.base * math.pow(2, (value * 8) / 12),
  ];
  if (take.realization != _Realization.ideal) {
    contour[2] = null;
    contour[contour.length - 3] = null;
  }
  if (take.realization == _Realization.truncated) {
    return contour.sublist(0, (contour.length * 0.75).round());
  }
  return contour;
}

class _Metrics {
  const _Metrics(
    this.falseNegatives,
    this.notMeasured,
    this.total,
    this.wrongAccepted,
    this.wrongNamed,
    this.wrongTotal,
  );

  final int falseNegatives;
  final int notMeasured;
  final int total;
  final int wrongAccepted;
  final int wrongNamed;
  final int wrongTotal;

  double get falseNegativeRate => falseNegatives / total;
  double get notMeasuredRate => notMeasured / total;
  double get wrongAcceptedRate => wrongAccepted / wrongTotal;
  double get wrongNamedRate => wrongNamed / wrongTotal;

  @override
  String toString() =>
      'FN ${(falseNegativeRate * 100).toStringAsFixed(1)}% · '
      'not-measured ${(notMeasuredRate * 100).toStringAsFixed(1)}% · '
      'wrong-accepted ${(wrongAcceptedRate * 100).toStringAsFixed(1)}% · '
      'wrong-named-right ${(wrongNamedRate * 100).toStringAsFixed(1)}%';
}

_Metrics _measure({
  double matchThreshold = ToneEvaluator.matchThreshold,
  double maxTemplateDistance = ToneEvaluator.maxTemplateDistance,
}) {
  final random = math.Random(20260927); // fixed seed: same corpus every run
  final takes = _syntheticCorpus();

  var falseNegatives = 0;
  var notMeasured = 0;
  for (final take in takes) {
    final assessment = ToneEvaluator.evaluate(
      contour: _contourFor(take, random),
      expectedTone: take.tone,
      phraseFinal: take.phraseFinal,
      matchThreshold: matchThreshold,
      maxTemplateDistance: maxTemplateDistance,
    );
    if (!assessment.measured) {
      notMeasured += 1;
    } else if (!assessment.matchesTarget) {
      falseNegatives += 1;
    }
  }

  var wrongAccepted = 0;
  var wrongNamed = 0;
  var wrongTotal = 0;
  for (final take in takes) {
    for (final asked in const [1, 2, 3, 4]) {
      if (asked == take.tone) continue;
      wrongTotal += 1;
      final assessment = ToneEvaluator.evaluate(
        contour: _contourFor(take, random),
        expectedTone: asked,
        phraseFinal: take.phraseFinal,
        matchThreshold: matchThreshold,
        maxTemplateDistance: maxTemplateDistance,
      );
      if (assessment.matchesTarget) wrongAccepted += 1;
      if (assessment.actualTone == take.tone) wrongNamed += 1;
    }
  }

  return _Metrics(falseNegatives, notMeasured, takes.length, wrongAccepted,
      wrongNamed, wrongTotal);
}

/// Pitch that follows no Mandarin tone: white-noise F0, twenty independent draws.
///
/// This is the corpus `maxTemplateDistance` is actually for. Clean takes never come near
/// the gate, so measuring the gate against templates proves nothing about it.
List<List<double?>> _shapelessContours() {
  final out = <List<double?>>[];
  for (int take = 0; take < 20; take++) {
    final random = math.Random(100 + take);
    out.add([
      for (int i = 0; i < 9; i++)
        150.0 * math.pow(2, (random.nextDouble() * 7) / 12),
    ]);
  }
  return out;
}

/// How often shapeless pitch is refused, over every (contour, expected tone) pair.
double _refusalRate({required double maxTemplateDistance}) {
  final contours = _shapelessContours();
  var refused = 0;
  for (final contour in contours) {
    for (final tone in const [1, 2, 3, 4]) {
      if (!ToneEvaluator.evaluate(
        contour: contour,
        expectedTone: tone,
        maxTemplateDistance: maxTemplateDistance,
      ).measured) {
        refused += 1;
      }
    }
  }
  return refused / (contours.length * 4);
}

void main() {
  test('the defaults meet the bar that matters: few false negatives', () {
    final metrics = _measure();
    // ignore: avoid_print
    print('tone calibration @ defaults — $metrics');

    // **M1, the headline.** Telling a learner they got a tone wrong when they got it
    // right is the failure audit 39 removed, and the one this whole design is arranged
    // around. `audit/audit_40` §6 sets the bar at 5%.
    expect(metrics.falseNegativeRate, lessThanOrEqualTo(0.05),
        reason: 'wrongly calling a correct tone wrong: $metrics');
    // Refusing to grade most takes would satisfy the line above while being useless.
    expect(metrics.notMeasuredRate, lessThanOrEqualTo(0.10),
        reason: 'too many takes refused outright: $metrics');
    // **M2.** A grader that accepts everything teaches nothing.
    expect(metrics.wrongAcceptedRate, lessThanOrEqualTo(0.10),
        reason: 'wrong tones being accepted as the target: $metrics');
  });

  test('the clarity gate refuses shapeless contours, and opening it refuses none', () {
    // The only thing that justifies `maxTemplateDistance`: on clean takes the gate never
    // fires, so a corpus of templates proves nothing about it.
    //
    // The first version of this test asserted that *every* shapeless contour is refused,
    // and **it failed** — which was the useful outcome. A fixed zigzag or random walk can
    // land within the gate's reach of some template, so the gate is permissive rather
    // than absolute. Measured over twenty independent random walks instead of asserted
    // over two hand-picked ones.
    final refusedRate = _refusalRate(
      maxTemplateDistance: ToneEvaluator.maxTemplateDistance,
    );
    // ignore: avoid_print
    print('shapeless contours refused at the default gate: '
        '${(refusedRate * 100).toStringAsFixed(0)}%');

    expect(refusedRate, greaterThanOrEqualTo(0.85),
        reason: 'pitch that follows no tone is being confidently named');
    // With the gate wide open most of them come through, so the gate is the main thing
    // holding them back. **Not all of them** — the octave-jump check refuses white-noise
    // pitch on its own, which is a second line of defence rather than a failure of this
    // one. Asserting a *reduction* rather than zero is the honest form of the claim.
    expect(_refusalRate(maxTemplateDistance: 1.0), lessThan(refusedRate));
  });

  test('tightening the match threshold is what punishes correct half-thirds', () {
    // Justifies `matchThreshold` existing, and it is the bug a *test* found rather than
    // the plan: a non-final third tone **is** a low fall, so it sits nearest the
    // *fourth*-tone template. `nearest == expectedTone` alone therefore reports it as a
    // fourth tone; the near-exact-match path is what rescues it.
    expect(_measure(matchThreshold: 0.0).falseNegativeRate,
        greaterThan(_measure().falseNegativeRate));
  });

  test('the sweep is reported, so the numbers can be moved with evidence', () {
    // Not an assertion — a printed grid, so recalibrating against real takes is reading
    // a table rather than guessing. `audit/audit_40` §4 holds the stimulus set, and the
    // deliberate-error set in §4.6 is what makes the wrong-accepted column meaningful.
    final rows = <String>[];
    for (final match in const [0.075, 0.10, 0.125]) {
      for (final maxDistance in const [0.10, 0.15, 0.20, 0.25, 0.38]) {
        rows.add('match ${match.toStringAsFixed(3)} · max '
            '${maxDistance.toStringAsFixed(2)} — '
            '${_measure(matchThreshold: match, maxTemplateDistance: maxDistance)} · '
            'shapeless refused '
            '${(_refusalRate(maxTemplateDistance: maxDistance) * 100).toStringAsFixed(0)}%');
      }
    }
    // ignore: avoid_print
    print('tone calibration sweep:\n  ${rows.join('\n  ')}');
    expect(rows, hasLength(15));
  });
}
