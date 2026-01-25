import 'dart:ui';
import 'dart:math';
import '../core/geometry_utils.dart';

/// Represents the result of a stroke matching operation.
class StrokeMatchResult {
  final bool isMatch;
  final double score; // A score indicating how good the match is (e.g., inverse of distance)
  final String feedback; // e.g., "Correct stroke direction", "Path too far off"
  final List<Offset> normalizedUserStroke; // The normalized user stroke for visualization
  final List<Offset> normalizedReferenceStroke; // The normalized reference stroke for visualization

  StrokeMatchResult({
    required this.isMatch,
    this.score = 0.0,
    this.feedback = '',
    this.normalizedUserStroke = const [],
    this.normalizedReferenceStroke = const [],
  });
}

/// Provides functionality to match user-drawn strokes against reference strokes.
class StrokeMatcher {


  /// Compares a user-drawn stroke against a reference stroke.
  ///
  /// [userStroke] is a list of Offset points representing the user's drawing.
  /// [referenceStroke] is a list of Offset points representing the correct stroke.
  /// [startPointThreshold] is the maximum distance allowed between start points
  ///   for the directionality check.
  /// [pathBufferZone] is the maximum allowed distance for intermediate points
  ///   from the reference path for the path shape check.
  static StrokeMatchResult matchStroke(
    List<Offset> userStroke,
    List<Offset> referenceStroke, {
    double startPointThreshold = 50.0,
    double pathBufferZone = 50.0,
  }) {
    if (userStroke.isEmpty || referenceStroke.isEmpty) {
      return StrokeMatchResult(
        isMatch: false,
        feedback: 'Strokes cannot be empty.',
      );
    }

    // 1. Directionality Check: Compare start points using original (un-normalized) coordinates
    final startDistance = GeometryUtils.distance(
      userStroke.first.dx,
      userStroke.first.dy,
      referenceStroke.first.dx,
      referenceStroke.first.dy,
    );

    if (startDistance > startPointThreshold) {
      return StrokeMatchResult(
        isMatch: false,
        feedback: 'Start point too far off from the expected stroke start.',
      );
    }

    // 2. Coordinate Normalization for path shape comparison
    final normalizedUserStroke = GeometryUtils.normalizePoints(userStroke);
    final normalizedReferenceStroke = GeometryUtils.normalizePoints(referenceStroke);

    // 3. Path Shape Check (Simplified Hausdorff / Buffer Zone)
    double maxDistanceToReference = 0.0;
    for (final userPoint in normalizedUserStroke) {
      double minDistanceToRefSegment = double.infinity;
      // Iterate through segments of the normalizedReferenceStroke
      for (int i = 0; i < normalizedReferenceStroke.length - 1; i++) {
        final refSegmentStart = normalizedReferenceStroke[i];
        final refSegmentEnd = normalizedReferenceStroke[i + 1];
        final dist = GeometryUtils.distanceToLineSegment(
          userPoint,
          refSegmentStart,
          refSegmentEnd,
        );
        if (dist < minDistanceToRefSegment) {
          minDistanceToRefSegment = dist;
        }
      }
      // Handle the case of a single-point reference stroke or if only one point in reference stroke
      if (normalizedReferenceStroke.length == 1) {
        final dist = GeometryUtils.distance(
          userPoint.dx, userPoint.dy,
          normalizedReferenceStroke.first.dx, normalizedReferenceStroke.first.dy,
        );
         if (dist < minDistanceToRefSegment) {
          minDistanceToRefSegment = dist;
        }
      }

      if (minDistanceToRefSegment > maxDistanceToReference) {
        maxDistanceToReference = minDistanceToRefSegment;
      }
    }

    if (maxDistanceToReference > pathBufferZone) {
      return StrokeMatchResult(
        isMatch: false,
        feedback: 'Path went outside the allowed buffer zone.',
        normalizedUserStroke: normalizedUserStroke,
        normalizedReferenceStroke: normalizedReferenceStroke,
      );
    }

    // Calculate a score based on maxDistanceToReference
    // The maximum possible distance in a 1000x1000 square is sqrt(1000^2 + 1000^2) = 1000 * sqrt(2)
    final double maxPossibleDistance = 1000 * sqrt(2);
    // Ensure score is not negative if maxDistanceToReference somehow exceeds maxPossibleDistance
    final double score = 1.0 - (maxDistanceToReference / maxPossibleDistance).clamp(0.0, 1.0);


    return StrokeMatchResult(
      isMatch: true,
      score: score,
      feedback: 'Stroke matched successfully!',
      normalizedUserStroke: normalizedUserStroke,
      normalizedReferenceStroke: normalizedReferenceStroke,
    );
  }
}