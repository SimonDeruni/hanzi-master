import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/geometry_utils.dart';
import 'dart:math';

void main() {
  group('GeometryUtils', () {
    test('distance calculates correct Euclidean distance', () {
      // Test case 1: Same point
      expect(GeometryUtils.distance(0, 0, 0, 0), 0.0);

      // Test case 2: Horizontal distance
      expect(GeometryUtils.distance(0, 0, 5, 0), 5.0);

      // Test case 3: Vertical distance
      expect(GeometryUtils.distance(0, 0, 0, 5), 5.0);

      // Test case 4: Diagonal distance (3-4-5 triangle)
      expect(GeometryUtils.distance(0, 0, 3, 4), 5.0);

      // Test case 5: Negative coordinates
      expect(GeometryUtils.distance(-1, -1, 2, 3), 5.0);

      // Test case 6: Decimal values
      expect(GeometryUtils.distance(0.0, 0.0, 1.0, 1.0), closeTo(sqrt(2), 0.001));
    });

    group('normalizePoints', () {
      test('handles empty list', () {
        final normalized = GeometryUtils.normalizePoints([]);
        expect(normalized, isEmpty);
      });

      test('handles single point', () {
        final points = [const Offset(10, 20)];
        final normalized = GeometryUtils.normalizePoints(points);
        expect(normalized.length, 1);
        expect(normalized.first.dx, closeTo(0, 0.001));
        expect(normalized.first.dy, closeTo(0, 0.001));
      });

      test('scales and translates correctly for square-like strokes', () {
        final points = [const Offset(0, 0), const Offset(100, 100)];
        final normalized = GeometryUtils.normalizePoints(points);
        expect(normalized.length, 2);
        expect(normalized.first.dx, closeTo(0, 0.001));
        expect(normalized.first.dy, closeTo(0, 0.001));
        expect(normalized.last.dx, closeTo(1000, 0.001));
        expect(normalized.last.dy, closeTo(1000, 0.001));

        final points2 = [const Offset(50, 50), const Offset(150, 150)];
        final normalized2 = GeometryUtils.normalizePoints(points2);
        expect(normalized2.length, 2);
        expect(normalized2.first.dx, closeTo(0, 0.001));
        expect(normalized2.first.dy, closeTo(0, 0.001));
        expect(normalized2.last.dx, closeTo(1000, 0.001));
        expect(normalized2.last.dy, closeTo(1000, 0.001));
      });

      test('scales and translates correctly for rectangular strokes (height > width)', () {
        final points = [const Offset(0, 0), const Offset(50, 100)]; // Uneven aspect ratio (height is twice width)
        final normalized = GeometryUtils.normalizePoints(points);
        expect(normalized.length, 2);
        expect(normalized.first.dx, closeTo(0, 0.001));
        expect(normalized.first.dy, closeTo(0, 0.001));
        // Original width is 50, height is 100.
        // Scale factor will be based on height: 1000/100 = 10.
        // So, x will be 50 * 10 = 500, y will be 100 * 10 = 1000.
        expect(normalized.last.dx, closeTo(500, 0.001));
        expect(normalized.last.dy, closeTo(1000, 0.001));
      });

      test('scales and translates correctly for rectangular strokes (width > height)', () {
        final points = [const Offset(0, 0), const Offset(100, 50)]; // Uneven aspect ratio (width is twice height)
        final normalized = GeometryUtils.normalizePoints(points);
        expect(normalized.length, 2);
        expect(normalized.first.dx, closeTo(0, 0.001));
        expect(normalized.first.dy, closeTo(0, 0.001));
        // Original width is 100, height is 50.
        // Scale factor will be based on width: 1000/100 = 10.
        // So, x will be 100 * 10 = 1000, y will be 50 * 10 = 500.
        expect(normalized.last.dx, closeTo(1000, 0.001));
        expect(normalized.last.dy, closeTo(500, 0.001));
      });

      test('handles negative coordinates correctly', () {
        final points = [const Offset(-100, -100), const Offset(0, 0)];
        final normalized = GeometryUtils.normalizePoints(points);
        expect(normalized.length, 2);
        expect(normalized.first.dx, closeTo(0, 0.001));
        expect(normalized.first.dy, closeTo(0, 0.001));
        expect(normalized.last.dx, closeTo(1000, 0.001));
        expect(normalized.last.dy, closeTo(1000, 0.001));
      });
    });
    group('distanceToLineSegment', () {
      test('point on the line segment', () {
        const p = Offset(5, 5);
        const p1 = Offset(0, 0);
        const p2 = Offset(10, 10);
        expect(GeometryUtils.distanceToLineSegment(p, p1, p2), closeTo(0.0, 0.001));
      });

      test('point perpendicular to the line segment', () {
        const p = Offset(5, 0);
        const p1 = Offset(0, 0);
        const p2 = Offset(10, 0);
        expect(GeometryUtils.distanceToLineSegment(p, p1, p2), closeTo(0.0, 0.001));
      });

      test('point away from the line segment (perpendicular projection within segment)', () {
        const p = Offset(5, 5);
        const p1 = Offset(0, 0);
        const p2 = Offset(10, 0);
        expect(GeometryUtils.distanceToLineSegment(p, p1, p2), closeTo(5.0, 0.001));
      });

      test('point projects before p1', () {
        const p = Offset(-5, 0);
        const p1 = Offset(0, 0);
        const p2 = Offset(10, 0);
        expect(GeometryUtils.distanceToLineSegment(p, p1, p2), closeTo(5.0, 0.001));
      });

      test('point projects after p2', () {
        const p = Offset(15, 0);
        const p1 = Offset(0, 0);
        const p2 = Offset(10, 0);
        expect(GeometryUtils.distanceToLineSegment(p, p1, p2), closeTo(5.0, 0.001));
      });

      test('line segment is a point', () {
        const p = Offset(5, 5);
        const p1 = Offset(0, 0);
        const p2 = Offset(0, 0);
        expect(GeometryUtils.distanceToLineSegment(p, p1, p2), closeTo(sqrt(50), 0.001));
      });

      test('diagonal line, point away', () {
        const p = Offset(0, 10);
        const p1 = Offset(0, 0);
        const p2 = Offset(10, 10);
        // Perpendicular distance from (0,10) to y=x is (0-10)/sqrt(2) = -10/sqrt(2), abs = 7.07
        // More precisely, point (0,10) and line y=x.
        // Closest point on line y=x to (0,10) is (5,5). Distance is sqrt(5^2 + 5^2) = sqrt(50) = 7.071
        expect(GeometryUtils.distanceToLineSegment(p, p1, p2), closeTo(sqrt(50), 0.001));
      });
    });
  });
}