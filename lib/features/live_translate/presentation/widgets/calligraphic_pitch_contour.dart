import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// A Zen & Ink calligraphic pitch contour canvas.
///
/// The target tone contour is laid down left-to-right like an authentic Chinese
/// brush stroke over [ZenMotion.quick] with [ZenMotion.enter] rather than
/// popping in complete, and the student's tone pitch is overlaid to show
/// acoustic divergence.
///
/// Only a genuinely new contour replays the stroke — a parent that streams the
/// same contour back leaves the running trace alone. See
/// [_CalligraphicPitchContourState._shouldReplay] for the exact rule.
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
    this.duration = ZenMotion.quick,
  });

  @override
  State<CalligraphicPitchContour> createState() =>
      _CalligraphicPitchContourState();
}

class _CalligraphicPitchContourState extends State<CalligraphicPitchContour>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  /// The student's divergent tone currently inked, or null while the painter
  /// draws no comparison curve. Tracked so "the student's curve appeared" can be
  /// told apart from "the student's curve is still streaming".
  int? _studentCurve;

  @override
  void initState() {
    super.initState();
    _studentCurve = _divergentStudentCurve(widget);
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      // 0.0 = no ink yet, 1.0 = the finished contour. The ticker is *not*
      // started here: `initState` has no usable `MediaQuery`, so Reduce Motion
      // cannot be honoured yet. `didChangeDependencies` starts or snaps it.
      value: widget.autoAnimate ? 0.0 : 1.0,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: ZenMotion.enter,
    );
  }

  /// [widget]'s actual tone, but only when the painter inks a comparison curve.
  ///
  /// Mirrors the painter's own condition: a dashed student trace is drawn only
  /// when the student's tone exists in Mandarin (1-4) and differs from the
  /// target. Null therefore means "this contour carries no second curve".
  static int? _divergentStudentCurve(CalligraphicPitchContour widget) {
    final int? actual = widget.actualTone;
    if (actual == null || actual <= 0 || actual == widget.expectedTone) {
      return null;
    }
    return actual;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Motion is resolved here, never in `initState`: a controller may only read
    // the platform preference once its inherited dependencies are wired up.
    // Under Reduce Motion this snaps the reveal to the finished contour and
    // stops the ticker, so the stroke is complete on the very first frame with
    // nothing animating; otherwise it starts the one-shot trace.
    MotionResolution.resolve(
      context,
      controller: _controller,
      staticValue: 1.0,
    ).apply();
  }

  /// Whether [widget] carries a genuinely *new* contour that must be re-traced.
  ///
  /// This widget is rebuilt by parents that stream a contour in — the tone
  /// comparison sheet re-renders while a grade lands, and the compact tone
  /// badges rebuild as playback state changes. Restarting the reveal on every
  /// such rebuild would reset it to 0 mid-stroke and make the line strobe, so
  /// the rule keys on the *identity* of the ink, not on the rebuild:
  ///
  /// * a different [CalligraphicPitchContour.expectedTone] is new ink — replay;
  /// * a divergent student curve appearing where the previous contour was empty
  ///   (no [CalligraphicPitchContour.actualTone], the same tone as the target,
  ///   or a neutral 0/5) is new ink — replay;
  /// * [CalligraphicPitchContour.autoAnimate] rising false -> true is the
  ///   caller explicitly asking to audition the tone again — replay.
  ///
  /// Everything else — the same contour arriving again, a student curve that
  /// merely *shifts* between two divergent tones, and updates that land while
  /// the stroke is still in flight — leaves the running animation untouched.
  bool _shouldReplay(CalligraphicPitchContour oldWidget, int? studentCurve) {
    if (widget.expectedTone != oldWidget.expectedTone) return true;
    if (_studentCurve == null && studentCurve != null) return true;
    if (widget.autoAnimate && !oldWidget.autoAnimate) return true;
    return false;
  }

  @override
  void didUpdateWidget(covariant CalligraphicPitchContour oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    final int? studentCurve = _divergentStudentCurve(widget);
    final bool replay = _shouldReplay(oldWidget, studentCurve);
    _studentCurve = studentCurve;

    if (!replay) return;

    // Reduced motion: present the finished contour instead of tracing it.
    if (context.reduceMotion) {
      _controller.value = 1.0;
    } else {
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
    // Reduced motion: snap to the finished contour.
    if (context.reduceMotion) {
      _controller.value = 1.0;
      return;
    }
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
            reveal: _animation.value,
            isDark: isDark,
            isCompact: widget.isCompact,
          ),
        );
      },
    );
  }
}

class _PitchContourPainter extends CustomPainter {
  /// Arc-length samples taken along one contour for the reveal sweep.
  ///
  /// Dense enough that the interpolated brush head never reads as a corner,
  /// cheap enough to walk twice per frame.
  static const int _revealSamples = 96;

  final int expectedTone;
  final int? actualTone;

  /// How much of the contour is inked: 0 = nothing, 1 = complete.
  final double reveal;

  final bool isDark;
  final bool isCompact;

  _PitchContourPainter({
    required this.expectedTone,
    this.actualTone,
    this.reveal = 1.0,
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
        reveal: math.min(1.0, reveal * 1.1),
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
      reveal: reveal,
      color: targetColor,
      isDashed: false,
      baseStrokeWidth: isCompact ? 3.0 : 4.5,
      drawBrushTip: !isCompact && reveal > 0.02 && reveal < 0.98,
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
  ///
  /// Only the first [reveal] fraction of [path]'s arc length is inked, ending on
  /// a point interpolated between the two samples that straddle the cut-off, so
  /// the head of the line travels smoothly along the curve instead of snapping
  /// sample to sample.
  void _drawCalligraphicTrace({
    required Canvas canvas,
    required Path path,
    required double reveal,
    required Color color,
    required bool isDashed,
    required double baseStrokeWidth,
    bool drawBrushTip = false,
  }) {
    final double inked = reveal.clamp(0.0, 1.0);
    if (inked <= 0.0) return;

    for (final metric in path.computeMetrics()) {
      final List<Offset> samples = _revealedSamples(metric, inked);
      if (samples.length < 2) continue;

      final subPath = Path()..moveTo(samples.first.dx, samples.first.dy);
      for (int i = 1; i < samples.length; i++) {
        subPath.lineTo(samples[i].dx, samples[i].dy);
      }

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
          final tipPaint = Paint()
            ..color = color
            ..style = PaintingStyle.fill;
          canvas.drawCircle(
            samples.last,
            baseStrokeWidth * 0.75,
            tipPaint,
          );
        }
      }
    }
  }

  /// The inked polyline of [metric]: whole samples up to [reveal], plus a head
  /// interpolated across the cut-off.
  ///
  /// Samples sit at even arc-length stations, so the walk is a
  /// left-to-right brush stroke for a pitch contour (its x advances
  /// monotonically). When the cut-off falls between two stations — which it
  /// almost always does — the head is `lerp`-ed between them; stopping at the
  /// last whole sample instead would visibly step the tip forward once per
  /// sample.
  List<Offset> _revealedSamples(ui.PathMetric metric, double reveal) {
    final double length = metric.length;
    if (length <= 0) return const <Offset>[];

    final double step = length / _revealSamples;
    final double reach = length * reveal;
    final List<Offset> samples = <Offset>[];

    for (int i = 0; i < _revealSamples; i++) {
      final double from = step * i;
      final Offset? fromPoint = metric.getTangentForOffset(from)?.position;
      if (fromPoint == null) break;

      if (from + step <= reach) {
        samples.add(fromPoint);
        continue;
      }

      // The cut-off lands inside this segment: interpolate between the two
      // samples that straddle it so the head is a true point on the curve.
      final Offset? toPoint =
          metric.getTangentForOffset(from + step)?.position;
      if (toPoint == null) break;
      samples.add(
        Offset.lerp(fromPoint, toPoint, (reach - from) / step) ?? fromPoint,
      );
      return samples;
    }

    // A complete reveal closes on the real end of the contour.
    if (reach >= length) {
      final Offset? end = metric.getTangentForOffset(length)?.position;
      if (end != null) samples.add(end);
    }
    return samples;
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
    return oldDelegate.reveal != reveal ||
        oldDelegate.expectedTone != expectedTone ||
        oldDelegate.actualTone != actualTone ||
        oldDelegate.isDark != isDark ||
        oldDelegate.isCompact != isCompact;
  }
}
