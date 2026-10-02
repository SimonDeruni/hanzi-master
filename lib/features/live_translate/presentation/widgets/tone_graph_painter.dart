import 'package:flutter/material.dart';

import 'calligraphic_pitch_contour.dart';

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

    // Function to draw a calligraphic pitch curve inside a vertical band.
    //
    // [bandTop] and [bandHeight] are the pixel range the stroke may use, so the
    // target and the learner's voice can live in separate lanes.
    void drawCurve(
      List<double?> pitchData,
      Color color,
      double strokeWidth,
      bool isDashed,
      double progress,
      double bandTop,
      double bandHeight,
    ) {
      if (pitchData.isEmpty || !pitchData.any((p) => p != null)) return;

      final points = <Offset>[];
      // Map the *voiced* span across the whole width, so a trace that began after
      // a moment of silence has no leading gap. Before this every point used its
      // raw index (`i / (length - 1)`), so a recording with any unvoiced lead-in
      // drew its line starting a third of the way in and stopping short of the
      // edge — which reads as "your voice was late and shorter", a timing claim
      // the data never made. The target series carries no nulls, so its mapping is
      // unchanged.
      final voicedIndices = <int>[
        for (int i = 0; i < pitchData.length; i++)
          if (pitchData[i] != null && pitchData[i]! > 0) i,
      ];
      if (voicedIndices.isEmpty) return;
      final int spanStart = voicedIndices.first;
      final int spanEnd = voicedIndices.last;
      final int span = spanEnd > spanStart ? spanEnd - spanStart : 1;
      for (final int i in voicedIndices) {
        final double x = ((i - spanStart) / span) * size.width;
        final double y = bandTop +
            bandHeight -
            (((pitchData[i]! - minPitch) / range) * bandHeight);
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
          ..color = isDashed ? color.withValues(alpha: 0.85) : color
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

    bool hasPoints(List<double?> data) =>
        data.any((p) => p != null && p > 0);

    // Two lanes, not one overlay.
    //
    // The target is laid out as one equal slot per tone — a *plan*, with no time
    // meaning — while the learner's voice is real elapsed time. Drawn over one
    // another they read as a single time-aligned signal, and a crossing point
    // reads as "there, I was off" — but the two x-axes mean different things, so
    // that crossing is an accident of layout. Separate lanes keep the comparison
    // (same width, same shared pitch scale) without making a claim about *when*
    // that the data cannot support. The legend beneath names each lane by colour.
    final bool bothLanes = hasPoints(userPitch) && hasPoints(idealPitch);
    const double gap = 12.0;
    final double laneHeight = bothLanes ? (size.height - gap) / 2 : size.height;
    const double userTop = 0;
    final double targetTop = bothLanes ? laneHeight + gap : 0;

    // A hairline between the lanes, so they read as two rows rather than one.
    if (bothLanes) {
      final divider = Paint()
        ..color = Colors.grey.withValues(alpha: 0.25)
        ..strokeWidth = 1.0;
      final double y = laneHeight + gap / 2;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), divider);
    }

    // Target lane (grey ink wash, dashed reference) — drawn first.
    if (!isLive && hasPoints(idealPitch)) {
      drawCurve(idealPitch, PitchGraphPalette.target, 3.5, true, 1.0,
          targetTop, laneHeight);
    }

    // The learner's own lane (solid blue), with the progressive calligraphic trace.
    drawCurve(userPitch, PitchGraphPalette.userVoice, 3.5, false, traceProgress,
        userTop, laneHeight);
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
