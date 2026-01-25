import 'dart:ui';
import 'package:hanzi_master/core/character_loader.dart';

/// Grades a user's stroke drawing against correct reference strokes.
/// Conceptually updated to handle 'Outline' data vs 'Centerline' drawing.
class StrokeGrader {
  static Map<String, dynamic> _lastGradingDetails = {};
  
  /// Grade user strokes against reference paths
  /// Returns a score from 0-100
  static double gradeStrokes({
    required List<Path> referencePaths,
    required List<Offset?> userPoints,
    Size? canvasSize,
  }) {
    _lastGradingDetails = {};
    if (referencePaths.isEmpty || userPoints.isEmpty) return 0.0;

    try {
      final normalizedUserPoints = _normalizeUserPoints(userPoints, canvasSize);
      final userStrokes = _splitIntoStrokes(normalizedUserPoints);
      
      if (userStrokes.isEmpty) return 0.0;

      // In Guided Mode (1 ref stroke), we grade that specific stroke.
      if (referencePaths.length == 1 && userStrokes.length == 1) {
        return _gradeSingleStroke(referencePaths[0], userStrokes[0]);
      }

      // Multi-stroke matching (Free Mode)
      double totalScore = 0;
      int matches = 0;
      
      for (int i = 0; i < referencePaths.length; i++) {
        if (i < userStrokes.length) {
          totalScore += _gradeSingleStroke(referencePaths[i], userStrokes[i]);
          matches++;
        }
      }

      // Penalty for wrong stroke count
      double countPenalty = (referencePaths.length == userStrokes.length) ? 1.0 : 0.7;
      return (matches > 0 ? (totalScore / referencePaths.length) : 0.0) * countPenalty;
    } catch (e) {
      return 0.0;
    }
  }

  /// Grades a single user stroke against a single reference outline.
  static double _gradeSingleStroke(Path refPath, List<Offset> userStroke) {
    if (userStroke.isEmpty) return 0.0;

    final refMetrics = refPath.computeMetrics().toList();
    if (refMetrics.isEmpty) return 0.0;
    final metric = refMetrics.first;

    // 1. Find physical tips of the reference outline
    List<Offset> samples = [];
    for (double i = 0; i <= 1.0; i += 0.05) {
      samples.add(metric.getTangentForOffset(metric.length * i)!.position);
    }

    double maxDistSq = -1;
    Offset tipA = samples.first;
    Offset tipB = samples.last;
    for (int i = 0; i < samples.length; i++) {
      for (int j = i + 1; j < samples.length; j++) {
        double d = (samples[i] - samples[j]).distanceSquared;
        if (d > maxDistSq) {
          maxDistSq = d;
          tipA = samples[i];
          tipB = samples[j];
        }
      }
    }

    // 2. Identify Logical Endpoints using Calligraphy Score (Y*1.5 + X)
    Offset refStart, refEnd;
    if ((tipA.dy * 1.5 + tipA.dx) < (tipB.dy * 1.5 + tipB.dx)) {
      refStart = tipA; refEnd = tipB;
    } else {
      refStart = tipB; refEnd = tipA;
    }

    // 3. User Endpoints
    final userStart = userStroke.first;
    final userEnd = userStroke.last;

    // 3. Distance Scores (how close to start/end)
    // Stricter threshold: ~120 units in 1000x1000 space
    double startScore = (1.0 - (userStart - refStart).distance / 120.0).clamp(0.0, 1.0);
    double endScore = (1.0 - (userEnd - refEnd).distance / 120.0).clamp(0.0, 1.0);

    // 4. Path Proximity Score (Are we actually drawing ON the blue line?)
    // Sample points along the reference path
    List<Offset> refPoints = [];
    for (double i = 0; i <= 1.0; i += 0.05) {
      refPoints.add(metric.getTangentForOffset(metric.length * i)!.position);
    }

    int onPathCount = 0;
    double totalDistance = 0;
    
    for (final p in userStroke) {
      // Find distance to the nearest point on the reference path
      double minStrokeDist = double.infinity;
      for (final refP in refPoints) {
        final dist = (p - refP).distance;
        if (dist < minStrokeDist) minStrokeDist = dist;
      }
      
      // Stricter corridor: 60 units (6% of canvas)
      if (minStrokeDist < 60.0) {
        onPathCount++;
      }
      totalDistance += minStrokeDist;
    }
    
    double proximityScore = onPathCount / userStroke.length;
    double avgDistScore = (1.0 - (totalDistance / userStroke.length) / 300.0).clamp(0.0, 1.0);
    double overlapScore = (proximityScore * 0.7 + avgDistScore * 0.3);

    // 5. Direction check
    final refVec = refEnd - refStart;
    final userVec = userEnd - userStart;
    double directionScore = 0.0;
    if (refVec.distance > 5 && userVec.distance > 5) {
      final dot = (refVec.dx * userVec.dx + refVec.dy * userVec.dy) / (refVec.distance * userVec.distance);
      // Dot product > 0.7 means within 45 degrees
      directionScore = dot > 0.7 ? 1.0 : (dot > 0 ? 0.4 : 0.0);
    } else {
      directionScore = 1.0; 
    }

    // Weighted Final Score: Heavily favoring actually tracing the path
    return (startScore * 0.15 + endScore * 0.15 + overlapScore * 0.5 + directionScore * 0.2) * 100.0;
  }

  static List<Offset?> _normalizeUserPoints(List<Offset?> points, Size? canvasSize) {
    if (canvasSize == null || canvasSize.width == 0 || canvasSize.height == 0) return points;
    final double scaleX = 1000.0 / canvasSize.width;
    final double scaleY = 1000.0 / canvasSize.height;
    return points.map((p) => p == null ? null : Offset(p.dx * scaleX, p.dy * scaleY)).toList();
  }

  static List<List<Offset>> _splitIntoStrokes(List<Offset?> userPoints) {
    List<List<Offset>> strokes = [];
    List<Offset> currentStroke = [];
    for (final point in userPoints) {
      if (point == null) {
        if (currentStroke.isNotEmpty) {
          strokes.add(List.from(currentStroke));
          currentStroke.clear();
        }
      } else {
        currentStroke.add(point);
      }
    }
    if (currentStroke.isNotEmpty) strokes.add(currentStroke);
    return strokes;
  }

  static String getFeedback(double score) {
    if (score >= 90) return "Perfect!";
    if (score >= 70) return "Great work!";
    if (score >= 50) return "Good attempt";
    return "Try drawing from green to red";
  }
}