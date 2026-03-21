import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/character_loader.dart';

void main() {
  group('CharacterLoader Isolate Tests', () {
    test('samplePointsAsync should work without crashing (if it handles sendability)', () async {
      final path = Path();
      path.moveTo(0, 0);
      path.lineTo(100, 100);
      
      try {
        final points = await CharacterLoader.samplePointsAsync(path);
        expect(points, isNotEmpty);
        expect(points.first, const Offset(0, 0));
        expect(points.last, const Offset(100, 100));
      } catch (e) {
        fail('samplePointsAsync failed: $e');
      }
    });
  });
}
