import 'package:flutter/material.dart';

class RiceGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withValues(alpha: 0.3) // Faint red color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 1. Draw the Outer Box (Square)
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 2. Prepare Dashed Line Paint
    final dashedPaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 3. Draw Vertical Center Line
    _drawDashedLine(canvas, Offset(size.width / 2, 0), Offset(size.width / 2, size.height), dashedPaint);

    // 4. Draw Horizontal Center Line
    _drawDashedLine(canvas, Offset(0, size.height / 2), Offset(size.width, size.height / 2), dashedPaint);

    // 5. Draw Diagonal Lines (The "X")
    _drawDashedLine(canvas, const Offset(0, 0), Offset(size.width, size.height), dashedPaint);
    _drawDashedLine(canvas, Offset(size.width, 0), Offset(0, size.height), dashedPaint);
  }

  // Helper to draw dashed lines manually
  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const int dashWidth = 5;
    const int dashSpace = 5;
    double distance = (end - start).distance;
    double dx = (end.dx - start.dx) / distance;
    double dy = (end.dy - start.dy) / distance;
    
    double currentDistance = 0;
    while (currentDistance < distance) {
      canvas.drawLine(
        Offset(start.dx + dx * currentDistance, start.dy + dy * currentDistance),
        Offset(start.dx + dx * (currentDistance + dashWidth), start.dy + dy * (currentDistance + dashWidth)),
        paint,
      );
      currentDistance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant RiceGridPainter oldDelegate) => false;
}