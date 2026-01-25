import 'dart:math';
import 'package:flutter/material.dart';

/// A combined background widget that provides a traditional "Rice Paper" texture
/// and the "Mi Character Grid" (Rice Grid) guidelines.
class CalligraphyBackground extends StatelessWidget {
  final Widget? child;
  const CalligraphyBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6), // Warm off-white (Alabaster/Paper)
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // 1. Procedural Paper Texture
          Positioned.fill(
            child: CustomPaint(
              painter: _XuanPaperPainter(),
            ),
          ),
          // 2. Traditional Red Grid
          Positioned.fill(
            child: CustomPaint(
              painter: _RiceGridPainter(),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

/// Paints subtle organic noise and fibers to simulate handmade rice paper
class _XuanPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42); // Fixed seed for consistent texture
    final fiberPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.05)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw random 'fibers'
    for (int i = 0; i < 150; i++) {
      final start = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );
      final end = Offset(
        start.dx + (random.nextDouble() - 0.5) * 20,
        start.dy + (random.nextDouble() - 0.5) * 20,
      );
      canvas.drawLine(start, end, fiberPaint);
    }

    // Draw subtle grain/noise
    for (int i = 0; i < 1000; i++) {
      final pos = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );
      canvas.drawCircle(pos, random.nextDouble() * 1.5, fiberPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Paints the traditional red dashed guidelines
class _RiceGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Traditional Vermilion Red (Chinese Calligraphy Color)
    final Color vermilion = const Color(0xFFE64A19).withValues(alpha: 0.15);
    
    final borderPaint = Paint()
      ..color = vermilion
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final dashPaint = Paint()
      ..color = vermilion.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 1. Outer Border
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);

    // 2. Center Vertical & Horizontal
    _drawDashedLine(canvas, Offset(size.width / 2, 0), Offset(size.width / 2, size.height), dashPaint);
    _drawDashedLine(canvas, Offset(0, size.height / 2), Offset(size.width, size.height / 2), dashPaint);

    // 3. Diagonals
    _drawDashedLine(canvas, Offset.zero, Offset(size.width, size.height), dashPaint);
    _drawDashedLine(canvas, Offset(size.width, 0), Offset(0, size.height), dashPaint);
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dashWidth = 6.0;
    const double dashSpace = 4.0;
    
    double distance = (end - start).distance;
    double dx = (end.dx - start.dx) / distance;
    double dy = (end.dy - start.dy) / distance;
    
    double currentDist = 0;
    while (currentDist < distance) {
      final p1 = Offset(start.dx + dx * currentDist, start.dy + dy * currentDist);
      final p2 = Offset(
        start.dx + dx * min(currentDist + dashWidth, distance),
        start.dy + dy * min(currentDist + dashWidth, distance),
      );
      canvas.drawLine(p1, p2, paint);
      currentDist += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
