import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/stroke_matcher.dart';

void main() {
  group('StrokeMatcher', () {
    group('matchStroke', () {
      test('returns false for empty user stroke', () {
        final result = StrokeMatcher.matchStroke([], [const Offset(0, 0)]);
        expect(result.isMatch, isFalse);
        expect(result.feedback, 'Strokes cannot be empty.');
      });

      test('returns false for empty reference stroke', () {
        final result = StrokeMatcher.matchStroke([const Offset(0, 0)], []);
        expect(result.isMatch, isFalse);
        expect(result.feedback, 'Strokes cannot be empty.');
      });

      test('returns false if start points are too far apart (Wrong Start Point)', () {
        // We use normalized coordinates (0-1000)
        final userStroke = [const Offset(0, 0), const Offset(100, 100)];
        final refStroke = [const Offset(500, 500), const Offset(600, 600)];
        
        final result = StrokeMatcher.matchStroke(
          userStroke,
          refStroke,
          masteryLevel: 1.0, 
        );
        expect(result.isMatch, isFalse);
        expect(result.feedback, contains('Wrong start point.'));
      });

      test('returns false if path goes outside buffer zone', () {
        final refStroke = [const Offset(0, 0), const Offset(1000, 0)];
        final userStroke = [
          const Offset(0, 0),
          const Offset(500, 600), // VERY far outside the buffer
          const Offset(1000, 0),
        ];
        // Buffer = 100 * 1.2 = 120.
        // avgDist = 600/3 = 200.
        // combinedError = 200 * 0.7 = 140. 140 > 120.
        final result = StrokeMatcher.matchStroke(
          userStroke,
          refStroke,
          masteryLevel: 0.0, 
        );
        expect(result.isMatch, isFalse);
        expect(result.feedback, contains('Shape is off.'));
      });

      test('returns true for a perfect match', () {
        final stroke = [const Offset(0, 0), const Offset(500, 500), const Offset(1000, 1000)];
        final result = StrokeMatcher.matchStroke(stroke, stroke);
        expect(result.isMatch, isTrue);
        expect(result.feedback, 'Masterful!');
        expect(result.score, closeTo(1.0, 0.001));
      });

      test('returns true for a near-perfect match within thresholds', () {
        final refStroke = [const Offset(0, 0), const Offset(1000, 1000)];
        final userStroke = [
          const Offset(10, 10), // Small start offset
          const Offset(990, 990)
        ];
        final result = StrokeMatcher.matchStroke(
          userStroke,
          refStroke,
          masteryLevel: 0.0,
        );
        expect(result.isMatch, isTrue);
        expect(result.score, greaterThan(0.9));
      });

      test('dynamic difficulty: master level is stricter than easy level', () {
        final refStroke = [const Offset(0, 0), const Offset(1000, 0)];
        final userStroke = [
          const Offset(0, 0),
          const Offset(500, 300), // Average distance is ~300/3 = 100. combinedError = 70.
          const Offset(1000, 0)
        ];

        // Easy level (Buffer = 100 * lengthFactor(1.2) = 120). 70 < 120 -> Match.
        final easyResult = StrokeMatcher.matchStroke(userStroke, refStroke, masteryLevel: 0.0);
        expect(easyResult.isMatch, isTrue, reason: '70 < 120 (easy)');

        // Master level (Buffer = 50 * lengthFactor(1.2) = 60). 70 > 60 -> No match.
        final masterResult = StrokeMatcher.matchStroke(userStroke, refStroke, masteryLevel: 1.0);
        expect(masterResult.isMatch, isFalse, reason: '70 > 60 (master)');
      });
    });
  });
}
