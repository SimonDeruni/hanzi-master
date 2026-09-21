import 'package:flutter/material.dart';

class ToneGraphPainter extends CustomPainter {
  final List<double?> idealPitch;
  final List<double?> userPitch;
  final bool isLive;
  final double traceProgress;
  
  /// Highlights a specific portion of the graph (e.g., when a character is tapped)
  /// Values are percentages (0.0 to 1.0) of the total graph width.
  final double? highlightStart;
  final double? highlightEnd;

  ToneGraphPainter({
    required this.idealPitch,
    required this.userPitch,
    this.isLive = false,
    this.traceProgress = 1.0,
    this.highlightStart,
    this.highlightEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (idealPitch.isEmpty && userPitch.isEmpty) return;

    // Draw Highlight Background if active
    if (highlightStart != null && highlightEnd != null) {
      final paint = Paint()
        ..color = Colors.amber.withValues(alpha: 0.15)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTRB(
            highlightStart! * size.width, 0, highlightEnd! * size.width, size.height),
        paint,
      );
    }

    // Dynamically calculate min and max pitch from valid data points
    final allPitches = [...idealPitch, ...userPitch].whereType<double>().toList();
    final double minPitch = allPitches.isEmpty
        ? 50.0
        : (allPitches.reduce((a, b) => a < b ? a : b) - 20).clamp(50.0, 1000.0);
    final double maxPitch = allPitches.isEmpty
        ? 800.0
        : (allPitches.reduce((a, b) => a > b ? a : b) + 20).clamp(50.0, 1000.0);
    final double range = maxPitch - minPitch <= 0 ? 1 : maxPitch - minPitch;

    // Function to draw a calligraphic pitch curve
    void drawCurve(
      List<double?> pitchData,
      Color color,
      double strokeWidth,
      bool isDashed,
      double progress,
    ) {
      if (pitchData.isEmpty || !pitchData.any((p) => p != null)) return;

      final points = <Offset>[];
      for (int i = 0; i < pitchData.length; i++) {
        if (pitchData[i] == null || pitchData[i]! <= 0) continue;
        final double x = (i / (pitchData.length - 1)) * size.width;
        final double y = size.height - (((pitchData[i]! - minPitch) / range) * size.height);
        points.add(Offset(x, y));
      }

      if (points.isEmpty) return;

      // Construct smoothed calligraphic path
      final path = Path();
      path.moveTo(points[0].dx, points[0].dy);

      for (int i = 0; i < points.length - 1; i++) {
        final p0 = points[i];
        final p1 = points[i + 1];
        final controlPoint = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
        path.quadraticBezierTo(p0.dx, p0.dy, controlPoint.dx, controlPoint.dy);
      }
      path.lineTo(points.last.dx, points.last.dy);

      // Extract progressive calligraphic path
      for (final metric in path.computeMetrics()) {
        final subPath = metric.extractPath(0.0, metric.length * progress.clamp(0.0, 1.0));

        final paint = Paint()
          ..color = isDashed ? color.withValues(alpha: 0.45) : color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

        // Subtle ambient calligraphic glow for solid traces
        if (!isDashed) {
          final glowPaint = Paint()
            ..color = color.withValues(alpha: 0.22)
            ..strokeWidth = strokeWidth + 3.0
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round;
          canvas.drawPath(subPath, glowPaint);
        }

        canvas.drawPath(subPath, paint);
      }
    }

    // Draw Ideal Pitch (Grey / Xuan Ink wash)
    if (!isLive) {
      drawCurve(idealPitch, Colors.grey.shade400, 4.0, true, 1.0);
    }

    // Draw User Pitch with progressive calligraphic trace
    drawCurve(userPitch, Colors.blue.shade600, 3.5, false, traceProgress);
  }

  @override
  bool shouldRepaint(covariant ToneGraphPainter oldDelegate) {
    return oldDelegate.isLive != isLive ||
        oldDelegate.userPitch != userPitch ||
        oldDelegate.idealPitch != idealPitch ||
        oldDelegate.traceProgress != traceProgress ||
        oldDelegate.highlightStart != highlightStart ||
        oldDelegate.highlightEnd != highlightEnd;
  }
}
