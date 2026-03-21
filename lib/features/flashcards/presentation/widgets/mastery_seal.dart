import 'package:flutter/material.dart';

/// An authentic Chinese-style Red Ink Seal (Hanko) used to indicate mastery.
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

    return CustomPaint(
      size: Size(size, size),
      painter: _SealPainter(
        progress: progress,
        isMastered: isMastered,
      ),
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
    final Color sealColor = const Color(0xFFB22222).withValues(alpha: isMastered ? 0.9 : 0.3);

    final paint = Paint()
      ..color = sealColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeJoin = StrokeJoin.miter
      ..isAntiAlias = true;

    // 1. Draw the Square Border (slightly wobbly/hand-carved look)
    final path = Path();
    path.moveTo(sealRect.left + (padding * 0.5), sealRect.top);
    path.lineTo(sealRect.right - (padding * 0.2), sealRect.top + (padding * 0.3));
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
      innerPath.moveTo(sealRect.left + (size.width * 0.2), sealRect.top + (size.height * 0.2));
      innerPath.lineTo(sealRect.left + (size.width * 0.2), sealRect.bottom - (size.height * 0.2));
      innerPath.lineTo(sealRect.right - (size.width * 0.2), sealRect.bottom - (size.height * 0.2));
      
      // We only draw a portion of the path based on progress
      final metrics = innerPath.computeMetrics().toList();
      if (metrics.isNotEmpty) {
        canvas.drawPath(metrics.first.extractPath(0, metrics.first.length * progress), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SealPainter oldDelegate) => 
      oldDelegate.progress != progress || oldDelegate.isMastered != isMastered;
}
