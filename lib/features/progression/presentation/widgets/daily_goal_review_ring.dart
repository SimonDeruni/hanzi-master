import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

/// A Zen & Ink circular daily review ring that animates from 0% to current completion
/// over [ZenMotion.page] using [ZenMotion.enter], snapping straight to the
/// final value when the platform asks for reduced motion.
class DailyGoalReviewRing extends StatelessWidget {
  final double progress; // 0.0 to 1.0+
  final int todayCards;
  final int goalCards;
  final double size;
  final Duration duration;

  const DailyGoalReviewRing({
    super.key,
    required this.progress,
    required this.todayCards,
    required this.goalCards,
    this.size = 76.0,
    this.duration = ZenMotion.page,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);

    final targetProgress = progress.clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: targetProgress),
      duration: ZenMotion.of(context, duration),
      curve: ZenMotion.enter,
      builder: (context, animatedValue, _) {
        final percent = (animatedValue * 100).round();
        final isComplete = animatedValue >= 1.0;

        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _ArcPainter(
                  progress: animatedValue,
                  trackColor: trackColor,
                  arcColor: isComplete
                      ? const Color(0xFF10B981) // Jade Emerald when complete
                      : const Color(0xFFD4AF37), // Emperor's Gold
                  strokeWidth: 6.5,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$percent%',
                    style: TextStyle(
                      fontSize: size * 0.22,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'NotoSerifSC',
                      color: isComplete
                          ? (isDark
                              ? const Color(0xFF34D399)
                              : const Color(0xFF059669))
                          : (isDark
                              ? const Color(0xFFFBBF24)
                              : const Color(0xFFB45309)),
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isComplete ? '完成' : '$todayCards/$goalCards',
                    style: TextStyle(
                      fontSize: size * 0.13,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white54 : Colors.black45,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color arcColor;
  final double strokeWidth;

  _ArcPainter({
    required this.progress,
    required this.trackColor,
    required this.arcColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Active Arc
    final arcPaint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.arcColor != arcColor ||
        oldDelegate.trackColor != trackColor;
  }
}
