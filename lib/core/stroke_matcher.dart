import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:hanzi_master/core/geometry_utils.dart';

/// Represents the result of a stroke matching operation.
class StrokeMatchResult {
  final bool isMatch;
  final double score; // 0.0 to 1.0
  final String feedback;
  final List<Offset> normalizedUserStroke;
  final List<Offset> normalizedReferenceStroke;

  StrokeMatchResult({
    required this.isMatch,
    this.score = 0.0,
    this.feedback = '',
    this.normalizedUserStroke = const [],
    this.normalizedReferenceStroke = const [],
  });
}

/// Helper for passing multiple arguments to the background compute function.
class _MatchStrokeParams {
  final List<Offset> userStroke;
  final List<Offset> referenceMedian;
  final double masteryLevel;
  final bool strictEndpoints;

  _MatchStrokeParams({
    required this.userStroke,
    required this.referenceMedian,
    required this.masteryLevel,
    required this.strictEndpoints,
  });
}

/// Top-level worker function for background stroke matching.
StrokeMatchResult _matchStrokeWorker(_MatchStrokeParams params) {
  return StrokeMatcher.matchStroke(
    params.userStroke,
    params.referenceMedian,
    masteryLevel: params.masteryLevel,
    strictEndpoints: params.strictEndpoints,
  );
}

/// Provides functionality to match user-drawn strokes against reference strokes (Medians).
class StrokeMatcher {
  /// Compares a user-drawn stroke against a reference median stroke asynchronously in a background isolate.
  static Future<StrokeMatchResult> matchStrokeAsync(
    List<Offset> userStroke,
    List<Offset> referenceMedian, {
    double masteryLevel = 0.0,
    bool strictEndpoints = true,
  }) async {
    return compute(
      _matchStrokeWorker,
      _MatchStrokeParams(
        userStroke: userStroke,
        referenceMedian: referenceMedian,
        masteryLevel: masteryLevel,
        strictEndpoints: strictEndpoints,
      ),
    );
  }

  /// Compares a user-drawn stroke against a reference median stroke.
  static StrokeMatchResult matchStroke(
    List<Offset> userStroke,
    List<Offset> referenceMedian, {
    double masteryLevel = 0.0, // 0.0 to 1.0
    bool strictEndpoints = true,
  }) {
    if (userStroke.isEmpty || referenceMedian.isEmpty) {
      return StrokeMatchResult(isMatch: false, feedback: 'Strokes cannot be empty.');
    }

    final double refLength = _calculatePathLength(referenceMedian);
    // Relative scale for thresholds (shorter strokes require more precision)
    // We cap it so it doesn't get ridiculously small or large.
    final double lengthFactor = (refLength / 500.0).clamp(0.4, 1.2);

    // --- 1. Directionality Check ---
    final startDist = (userStroke.first - referenceMedian.first).distance;
    final baseThreshold = (200.0 - (masteryLevel * 50.0)) * lengthFactor;
    // Audit Logic: Ensure thresholds don't get impossibly small for tiny strokes (min 35 screen px -> ~150 logic px)
    final minThreshold = 150.0 - (masteryLevel * 20.0);
    final startThreshold = (strictEndpoints ? baseThreshold : baseThreshold * 2.5).clamp(minThreshold, 350.0);
    
    if (startDist > startThreshold) {
      // Check if they drew it backwards
      final endDist = (userStroke.first - referenceMedian.last).distance;
      if (endDist < startThreshold) {
        return StrokeMatchResult(
          isMatch: false,
          score: 0.0,
          feedback: 'Draw in the other direction ➔',
        );
      }
      return StrokeMatchResult(
        isMatch: false,
        score: 0.0,
        feedback: 'Wrong start point.',
      );
    }

    // --- 1.5. Centroid Check ---
    final userCentroid = _calculateCentroid(userStroke);
    final refCentroid = _calculateCentroid(referenceMedian);
    final centroidDist = (userCentroid - refCentroid).distance;
    final centroidThreshold = ((250.0 - (masteryLevel * 80.0)) * lengthFactor).clamp(minThreshold * 1.5, 500.0);

    if (centroidDist > centroidThreshold) {
      return StrokeMatchResult(
        isMatch: false,
        score: 0.0,
        feedback: 'Right shape, but wrong place!',
      );
    }

    // --- 2. Path Matching (Raw coordinates, no normalization to prevent warping) ---
    final normalizedUser = userStroke;
    final normalizedRef = referenceMedian;

    // --- 3. Path Shape Check ---
    double totalDistance = 0.0;
    for (final uPoint in normalizedUser) {
      double minToRef = double.infinity;
      for (int i = 0; i < normalizedRef.length - 1; i++) {
        final dist = GeometryUtils.distanceToLineSegment(uPoint, normalizedRef[i], normalizedRef[i+1]);
        if (dist < minToRef) minToRef = dist;
      }
      totalDistance += minToRef;
    }
    final averageDistance = totalDistance / normalizedUser.length;

    // --- 4. Endpoint Accuracy ---
    final endDist = (normalizedUser.last - normalizedRef.last).distance;
    final endpointPenalty = (startDist + endDist) / 4.0;

    // Total Error Score & Matching Logic
    final shapeWeight = strictEndpoints ? 0.7 : 0.9;
    final endWeight = strictEndpoints ? 0.3 : 0.1;
    final combinedError = (averageDistance * shapeWeight) + (endpointPenalty * endWeight);

    final baseBuffer = ((150.0 - (masteryLevel * 50.0)) * lengthFactor).clamp(minThreshold, 350.0);
    final bufferZone = strictEndpoints ? baseBuffer : baseBuffer * 2.0;
    
    final bool isMatch = combinedError <= bufferZone;
    final double score = (1.0 - (combinedError / (bufferZone * 2.0))).clamp(0.0, 1.0);

    // --- 5. Qualitative Feedback (Linearity & Speed) ---
    final double userPathLength = _calculatePathLength(normalizedUser);
    final double refPathLength = _calculatePathLength(normalizedRef);
    final double directDist = (normalizedUser.first - normalizedUser.last).distance;
    
    final double refDirectDist = (normalizedRef.first - normalizedRef.last).distance;
    final bool isStraightRef = refPathLength < refDirectDist * 1.15;
    final double linearityRatio = userPathLength / (directDist > 0 ? directDist : 1.0);
    final double pointDensity = userStroke.length / (userPathLength > 0 ? userPathLength : 1.0);

    String qualityFeedback = isMatch ? (score > 0.85 ? 'Fast & Clean!' : 'Good!') : 'Follow the flow.';
    
    if (isMatch) {
      if (isStraightRef && linearityRatio > 1.25) {
        qualityFeedback = 'A bit shaky!';
      } else if (pointDensity > 0.5) {
        qualityFeedback = 'A bit hesitant...';
      } else if (score > 0.95) {
        qualityFeedback = 'Masterful!';
      }
    } else {
      if (averageDistance > bufferZone * 1.5) {
        qualityFeedback = 'Shape is off.';
      } else if (endDist > bufferZone) {
        qualityFeedback = 'Missing the hook/end.';
      }
    }

    return StrokeMatchResult(
      isMatch: isMatch,
      score: score,
      feedback: qualityFeedback,
      normalizedUserStroke: normalizedUser,
      normalizedReferenceStroke: normalizedRef,
    );
  }

  static double _calculatePathLength(List<Offset> points) {
    double length = 0;
    for (int i = 0; i < points.length - 1; i++) {
      length += (points[i+1] - points[i]).distance;
    }
    return length;
  }

  static Offset _calculateCentroid(List<Offset> points) {
    if (points.isEmpty) return Offset.zero;
    double sumX = 0;
    double sumY = 0;
    for (final p in points) {
      sumX += p.dx;
      sumY += p.dy;
    }
    return Offset(sumX / points.length, sumY / points.length);
  }
}
