import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A Zen & Ink calligraphic pitch contour canvas.
///
/// Draws the target tone contour curve progressively like an authentic
/// Chinese brush stroke over 750ms with [Curves.easeInOutQuart], and
/// overlays the student's tone pitch to show acoustic divergence.
class CalligraphicPitchContour extends StatefulWidget {
  final int expectedTone; // 1, 2, 3, 4 (or 0/5 for neutral)
  final int? actualTone;
  final double height;
  final bool isCompact;
  final bool autoAnimate;
  final Duration duration;

  const CalligraphicPitchContour({
    super.key,
    required this.expectedTone,
    this.actualTone,
    this.height = 130,
    this.isCompact = false,
    this.autoAnimate = true,
    this.duration = const Duration(milliseconds: 750),
  });

  @override
  State<CalligraphicPitchContour> createState() =>
      _CalligraphicPitchContourState();
}

class _CalligraphicPitchContourState extends State<CalligraphicPitchContour>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.autoAnimate ? 0.0 : 1.0,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart,
    );

    if (widget.autoAnimate) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant CalligraphicPitchContour oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expectedTone != oldWidget.expectedTone ||
        widget.actualTone != oldWidget.actualTone) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Triggers a re-trace animation (e.g. when auditioning tone audio)
  void retrace() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return CustomPaint(
          size: Size(double.infinity, widget.height),
          painter: _PitchContourPainter(
            expectedTone: widget.expectedTone,
            actualTone: widget.actualTone,
            progress: _animation.value,
            isDark: isDark,
            isCompact: widget.isCompact,
          ),
        );
      },
    );
  }
}

class _PitchContourPainter extends CustomPainter {
  final int expectedTone;
  final int? actualTone;
  final double progress;
  final bool isDark;
  final bool isCompact;

  _PitchContourPainter({
    required this.expectedTone,
    this.actualTone,
    required this.progress,
    required this.isDark,
    required this.isCompact,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final leftMargin = isCompact ? 4.0 : 38.0;
    final rightMargin = isCompact ? 4.0 : 20.0;
    final topMargin = isCompact ? 4.0 : 16.0;
    final bottomMargin = isCompact ? 4.0 : 16.0;

    final plotWidth = size.width - leftMargin - rightMargin;
    final plotHeight = size.height - topMargin - bottomMargin;

    // 1. Draw Chao 5-Level Pitch Grid (Only in full mode)
    if (!isCompact) {
      final gridColor = isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.06);
      final gridTextPaint = TextStyle(
        fontSize: 9.5,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white38 : Colors.black38,
      );

      final linePaint = Paint()
        ..color = gridColor
        ..strokeWidth = 1.0;

      for (int level = 1; level <= 5; level++) {
        // level 5 is top (0.0), level 1 is bottom (1.0)
        final y = topMargin + plotHeight * (1.0 - (level - 1) / 4.0);

        // Dashed horizontal line
        _drawDashedLine(
          canvas,
          Offset(leftMargin, y),
          Offset(leftMargin + plotWidth, y),
          linePaint,
        );

        // Pitch scale label (5 = High, 1 = Low)
        final textSpan = TextSpan(text: '$level', style: gridTextPaint);
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(leftMargin - 18, y - (textPainter.height / 2)),
        );
      }
    }

    // 2. If student tone exists and differs, draw student contour first (Amber/Red dashed)
    if (actualTone != null && actualTone != expectedTone && actualTone! > 0) {
      const studentColor = Color(0xFFF59E0B); // Amber warning
      final studentPath = _generateTonePath(
        tone: actualTone!,
        left: leftMargin,
        top: topMargin,
        width: plotWidth,
        height: plotHeight,
      );
      _drawCalligraphicTrace(
        canvas: canvas,
        path: studentPath,
        progress: math.min(1.0, progress * 1.1),
        color: studentColor,
        isDashed: true,
        baseStrokeWidth: isCompact ? 2.5 : 3.5,
      );
    }

    // 3. Draw Target Tone Contour (Authentic Calligraphic Brush Stroke)
    final targetColor = (actualTone == expectedTone && actualTone != null)
        ? const Color(0xFF10B981) // Jade Emerald on match
        : const Color(0xFF3B82F6); // Scholar Azure / Royal Blue
    final targetPath = _generateTonePath(
      tone: expectedTone,
      left: leftMargin,
      top: topMargin,
      width: plotWidth,
      height: plotHeight,
    );

    _drawCalligraphicTrace(
      canvas: canvas,
      path: targetPath,
      progress: progress,
      color: targetColor,
      isDashed: false,
      baseStrokeWidth: isCompact ? 3.0 : 4.5,
      drawBrushTip: !isCompact && progress > 0.02 && progress < 0.98,
    );
  }

  /// Generates the standard Chao 5-Level tone path:
  /// Tone 1: 55 (high horizontal)
  /// Tone 2: 35 (rising)
  /// Tone 3: 214 (dipping)
  /// Tone 4: 51 (falling)
  Path _generateTonePath({
    required int tone,
    required double left,
    required double top,
    required double width,
    required double height,
  }) {
    final path = Path();
    // Helper to map Chao level (1.0 to 5.0) to canvas Y
    double yForLevel(double level) =>
        top + height * (1.0 - (level - 1.0) / 4.0);

    switch (tone) {
      case 1: // 55: High Level
        final y5 = yForLevel(5.0);
        path.moveTo(left, y5);
        path.lineTo(left + width, y5);
        break;

      case 2: // 35: Rising (Mid -> High)
        final y3 = yForLevel(3.0);
        final y5 = yForLevel(5.0);
        path.moveTo(left, y3);
        path.quadraticBezierTo(
          left + width * 0.45,
          y3 + (y5 - y3) * 0.2,
          left + width,
          y5,
        );
        break;

      case 3: // 214: Dipping (Mid-Low -> Low -> Mid-High)
        final y2 = yForLevel(2.2);
        final y1 = yForLevel(1.0);
        final y4 = yForLevel(4.0);
        path.moveTo(left, y2);
        path.cubicTo(
          left + width * 0.25,
          y1 + 4,
          left + width * 0.55,
          y1,
          left + width,
          y4,
        );
        break;

      case 4: // 51: Falling (High -> Low)
        final y5 = yForLevel(5.0);
        final y1 = yForLevel(1.0);
        path.moveTo(left, y5);
        path.quadraticBezierTo(
          left + width * 0.55,
          y5 + (y1 - y5) * 0.35,
          left + width,
          y1,
        );
        break;

      default: // Neutral: soft short dot at mid
        final y3 = yForLevel(3.0);
        path.moveTo(left + width * 0.35, y3);
        path.lineTo(left + width * 0.65, y3);
        break;
    }

    return path;
  }

  /// Draws a progressive calligraphic brush stroke along the path.
  void _drawCalligraphicTrace({
    required Canvas canvas,
    required Path path,
    required double progress,
    required Color color,
    required bool isDashed,
    required double baseStrokeWidth,
    bool drawBrushTip = false,
  }) {
    if (progress <= 0.0) return;

    for (final metric in path.computeMetrics()) {
      final currentLength = metric.length * progress.clamp(0.0, 1.0);
      final subPath = metric.extractPath(0.0, currentLength);

      final strokePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = baseStrokeWidth;

      if (isDashed) {
        // Dashed student line
        final dashPath = _dashPath(subPath, dashArray: [6, 4]);
        canvas.drawPath(dashPath, strokePaint..color = color.withValues(alpha: 0.85));
      } else {
        // Subtle ambient calligraphic ink glow
        final glowPaint = Paint()
          ..color = color.withValues(alpha: isDark ? 0.30 : 0.20)
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = baseStrokeWidth + 4.0
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
        canvas.drawPath(subPath, glowPaint);

        // Core ink stroke
        canvas.drawPath(subPath, strokePaint);

        // Draw brush tip droplet at the moving front
        if (drawBrushTip) {
          final tangent = metric.getTangentForOffset(currentLength);
          if (tangent != null) {
            final tipPaint = Paint()
              ..color = color
              ..style = PaintingStyle.fill;
            canvas.drawCircle(
              tangent.position,
              baseStrokeWidth * 0.75,
              tipPaint,
            );
          }
        }
      }
    }
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset p1,
    Offset p2,
    Paint paint, {
    double dashLength = 4.0,
    double spaceLength = 4.0,
  }) {
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;
    final count = (math.sqrt(dx * dx + dy * dy) / (dashLength + spaceLength)).floor();

    for (int i = 0; i < count; i++) {
      final startX = p1.dx + (i * (dashLength + spaceLength));
      canvas.drawLine(
        Offset(startX, p1.dy),
        Offset(startX + dashLength, p1.dy),
        paint,
      );
    }
  }

  Path _dashPath(Path source, {required List<double> dashArray}) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      int index = 0;
      bool draw = true;
      while (distance < metric.length) {
        final length = dashArray[index % dashArray.length];
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
        index++;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant _PitchContourPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.expectedTone != expectedTone ||
        oldDelegate.actualTone != actualTone ||
        oldDelegate.isDark != isDark ||
        oldDelegate.isCompact != isCompact;
  }
}
