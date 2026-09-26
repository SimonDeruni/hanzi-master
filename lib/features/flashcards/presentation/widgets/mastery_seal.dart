import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';

/// An authentic Chinese-style Red Ink Seal (Hanko) used to indicate mastery.
///
/// The seal **arrives**: it presses in with the vocabulary's one permitted
/// overshoot ([ZenMotion.arrival]) while its inner stroke draws itself up to
/// `progress`, instead of appearing fully formed. `docs/UI_UX_STANDARDS.md`
/// § Motion reserves an overshoot for reward moments, and a mastery seal is
/// exactly that.
///
/// Under the platform "Reduce Motion" setting both legs collapse to their end
/// state, so the seal is simply correct rather than animated.
class MasterySeal extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final bool isMastered;
  final double size;

  const MasterySeal({
    super.key,
    required this.progress,
    required this.isMastered,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    if (progress == 0 && !isMastered) return const SizedBox.shrink();

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: ZenMotion.of(context, ZenMotion.quick),
      curve: ZenMotion.arrival,
      // The stamp lands. A mastery seal is an achievement, so it gets the
      // milestone crescendo rather than the ordinary award tick - and because
      // Reduce Motion collapses this duration to zero, the impact still lands
      // even when the travel does not.
      onEnd: () => HapticsManager.milestone(),
      builder: (BuildContext context, double stamp, Widget? child) {
        // `arrival` overshoots past 1.0 on purpose, so the overshoot is spent on
        // the scale (a stamp pressing in - about 103% at its peak) and never on
        // the drawn progress, which is clamped inside the painter's own range.
        final double scale = 0.72 + 0.28 * stamp;
        return Transform.scale(
          scale: scale,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress),
            duration: ZenMotion.of(context, ZenMotion.quick),
            curve: ZenMotion.natural,
            builder: (BuildContext context, double drawn, Widget? _) =>
                CustomPaint(
              size: Size(size, size),
              painter: _SealPainter(
                progress: drawn.clamp(0.0, 1.0),
                isMastered: isMastered,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SealPainter extends CustomPainter {
  final double progress;
  final bool isMastered;

  _SealPainter({required this.progress, required this.isMastered});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final double padding = size.width * 0.1;
    final sealRect = rect.deflate(padding);

    // Traditional "Seal Red" (Cinnabar)
    final Color sealColor =
        const Color(0xFFB22222).withValues(alpha: isMastered ? 0.9 : 0.3);

    final paint = Paint()
      ..color = sealColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeJoin = StrokeJoin.miter
      ..isAntiAlias = true;

    // 1. Draw the Square Border (slightly wobbly/hand-carved look)
    final path = Path();
    path.moveTo(sealRect.left + (padding * 0.5), sealRect.top);
    path.lineTo(
        sealRect.right - (padding * 0.2), sealRect.top + (padding * 0.3));
    path.lineTo(sealRect.right, sealRect.bottom - (padding * 0.4));
    path.lineTo(sealRect.left + (padding * 0.2), sealRect.bottom);
    path.close();

    canvas.drawPath(path, paint);

    // 2. Draw internal "Seal Script" stylized lines based on progress
    if (isMastered) {
      paint.style = PaintingStyle.fill;
      // Mastery Fill: A small solid square in the middle or stylized cross
      final innerRect = sealRect.deflate(size.width * 0.2);
      canvas.drawRect(innerRect, paint);
    } else {
      // Partial progress: draw a stylized "L" shape inside
      final innerPath = Path();
      innerPath.moveTo(sealRect.left + (size.width * 0.2),
          sealRect.top + (size.height * 0.2));
      innerPath.lineTo(sealRect.left + (size.width * 0.2),
          sealRect.bottom - (size.height * 0.2));
      innerPath.lineTo(sealRect.right - (size.width * 0.2),
          sealRect.bottom - (size.height * 0.2));

      // We only draw a portion of the path based on progress
      final metrics = innerPath.computeMetrics().toList();
      if (metrics.isNotEmpty) {
        canvas.drawPath(
            metrics.first.extractPath(0, metrics.first.length * progress),
            paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SealPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isMastered != isMastered;
}
