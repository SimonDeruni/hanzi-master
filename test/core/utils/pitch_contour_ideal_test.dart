import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/pitch_contour.dart';

/// The dashed **target** stroke of the shadowing graph.
///
/// `idealForTones` is the one piece of the graph that is not a measurement, so it is the
/// one that can lie quietly: a shape drawn in the wrong unit, or a syllable that shifts
/// its neighbours, would look entirely plausible on screen. These are the properties that
/// keep it honest.
void main() {
  group('PitchContourMath.idealForTones', () {
    test('is empty when there is nothing to draw', () {
      expect(PitchContourMath.idealForTones(const []), isEmpty);
    });

    test('gives every tone an equal slot, so syllables stay in phrase order', () {
      final contour =
          PitchContourMath.idealForTones(const [1, 2, 3], resolution: 10);
      expect(contour.length, 30);
      expect(contour.every((p) => p != null), isTrue);
    });

    test('a neutral tone keeps its slot width without pretending to have a shape', () {
      // Tone 5 has no fixed contour, so its slot stays empty — but it must still occupy
      // width, or every syllable after it slides left and the graph silently misreports
      // which part of the phrase it is showing.
      final contour =
          PitchContourMath.idealForTones(const [1, 5, 1], resolution: 6);
      expect(contour.length, 18);
      expect(contour.sublist(0, 6).every((p) => p != null), isTrue);
      expect(contour.sublist(6, 12).every((p) => p == null), isTrue);
      expect(contour.sublist(12).every((p) => p != null), isTrue);
    });

    test('it returns Hz, not a 0-1 shape, so it can share a graph with a real trace', () {
      // `ToneGraphPainter` scales both series by their shared min/max. A unit-scale
      // target drawn beside a 150 Hz trace would collapse to a flat line along the
      // bottom of the graph — plausible-looking and completely wrong.
      final contour = PitchContourMath.idealForTones(const [1, 2, 4], resolution: 8)
          .whereType<double>()
          .toList();
      expect(contour, isNotEmpty);
      expect(contour.every((hz) => hz > 50 && hz < 800), isTrue,
          reason: 'must land inside the painter clamp and the voiced-band filter');
    });

    test('baseHz moves the shape without changing it', () {
      final low = PitchContourMath.idealForTones(const [2],
              resolution: 5, baseHz: 120)
          .whereType<double>()
          .toList();
      final high = PitchContourMath.idealForTones(const [2],
              resolution: 5, baseHz: 240)
          .whereType<double>()
          .toList();
      for (int i = 0; i < low.length; i++) {
        expect(high[i] / low[i], closeTo(2.0, 0.01));
      }
    });

    test('the shapes are the ones the evaluator compares against', () {
      double span(List<double?> contour) {
        final voiced = contour.whereType<double>().toList();
        return voiced.last - voiced.first;
      }

      // Tone 2 rises, tone 4 falls, tone 1 stays level — read off the reference the
      // evaluator itself uses, so the drawn target cannot drift from the graded one.
      expect(span(PitchContourMath.idealForTones(const [2], resolution: 20)),
          greaterThan(4));
      expect(span(PitchContourMath.idealForTones(const [4], resolution: 20)),
          lessThan(-4));
      expect(
          span(PitchContourMath.idealForTones(const [1], resolution: 20)).abs(),
          lessThan(0.5));
    });

    test('only the last syllable is drawn phrase-final', () {
      // A non-final third tone is a low fall, not a full dip. Drawing the dip would show
      // a target the phrase never asked for — the same false negative audit 39 was about.
      final nonFinal = PitchContourMath.idealForTones(const [3, 1], resolution: 20);
      final phraseFinal = PitchContourMath.idealForTones(const [1, 3], resolution: 20);

      double dip(List<double?> c) {
        final voiced = c.whereType<double>().toList();
        final first = voiced.first;
        final last = voiced.last;
        final lowest = voiced.reduce((a, b) => a < b ? a : b);
        return (first - lowest) + (last - lowest);
      }

      // A full dip (tone 3 in final position) travels further from its own ends than a
      // half-third does.
      expect(dip(phraseFinal), greaterThan(dip(nonFinal)));
    });

    test('a resolution below two cannot draw a line', () {
      expect(PitchContourMath.idealForTones(const [1], resolution: 1), isEmpty);
    });
  });
}
