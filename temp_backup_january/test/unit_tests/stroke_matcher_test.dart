import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/stroke_matcher.dart';
// Import GeometryUtils

void main() {
  group('StrokeMatcher', () {
    // Tests for normalizePoints are now in geometry_utils_test.dart
    // Removed the normalization tests from here.

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

      test('returns false if start points are too far apart', () {
        final userStroke = [const Offset(0, 0), const Offset(100, 100)];
        final refStroke = [const Offset(500, 500), const Offset(600, 600)]; // Far start point
        final result = StrokeMatcher.matchStroke(
          userStroke,
          refStroke,
          startPointThreshold: 10, // Small threshold
        );
        expect(result.isMatch, isFalse);
        expect(result.feedback, 'Start point too far off from the expected stroke start.');
      });

      test('returns false if path goes outside buffer zone', () {
        final refStroke = [const Offset(0, 0), const Offset(100, 0)]; // Straight line
        // User draws a line that deviates too much
        final userStroke = [
          const Offset(0, 0),
          const Offset(50, 60), // Outside buffer
          const Offset(100, 0),
        ];
        final result = StrokeMatcher.matchStroke(
          userStroke,
          refStroke,
          startPointThreshold: 100, // Allow start point
          pathBufferZone: 50, // Small buffer
        );
        expect(result.isMatch, isFalse);
        expect(result.feedback, 'Path went outside the allowed buffer zone.');
      });

      test('returns true for a perfect match', () {
        final stroke = [const Offset(0, 0), const Offset(100, 100)];
        final result = StrokeMatcher.matchStroke(stroke, stroke,
            startPointThreshold: 10, pathBufferZone: 10);
        expect(result.isMatch, isTrue);
        expect(result.feedback, 'Stroke matched successfully!');
        expect(result.score, closeTo(1.0, 0.001));
      });

      test('returns true for a near-perfect match within thresholds', () {
        final refStroke = [const Offset(0, 0), const Offset(100, 100)];
        final userStroke = [
          const Offset(5, 5),
          const Offset(95, 95)
        ]; // Slightly off but within buffer
        final result = StrokeMatcher.matchStroke(
          userStroke,
          refStroke,
          startPointThreshold: 50,
          pathBufferZone: 50,
        );
        expect(result.isMatch, isTrue);
        expect(result.feedback, 'Stroke matched successfully!');
        expect(result.score, greaterThan(0.8)); // Should have a good score
      });

      test('returns a lower score for less accurate but still valid strokes', () {
        final refStroke = [const Offset(0, 0), const Offset(100, 0)];
        final userStroke = [
          const Offset(0, 0),
          const Offset(50, 20),
          const Offset(100, 0)
        ]; // Within buffer but not perfect
        final result = StrokeMatcher.matchStroke(
          userStroke,
          refStroke,
          startPointThreshold: 50,
          pathBufferZone: 250, // Increased buffer zone to allow for normalized deviation
        );
        expect(result.isMatch, isTrue);
        expect(result.feedback, 'Stroke matched successfully!');
        expect(result.score, lessThan(1.0));
        expect(result.score, greaterThan(0.0));
      });
    });
  });
}