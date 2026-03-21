import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/stroke_matcher.dart';

void main() {
  group('StrokeMatcher Isolate Tests', () {
    test('matchStrokeAsync should work without crashing', () async {
      final userStroke = [const Offset(0, 0), const Offset(100, 100)];
      final refStroke = [const Offset(0, 0), const Offset(100, 100)];
      
      try {
        final result = await StrokeMatcher.matchStrokeAsync(userStroke, refStroke);
        expect(result.isMatch, isTrue);
        expect(result.score, closeTo(1.0, 0.001));
      } catch (e) {
        fail('matchStrokeAsync failed: $e');
      }
    });
  });
}
