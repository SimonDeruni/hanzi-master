import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class AncientAtlasPainter extends CustomPainter {
  final int index;
  final bool isDark;
  final String themeName;

  AncientAtlasPainter({
    required this.index, 
    required this.isDark,
    this.themeName = 'Misc',
  });

  // THEMATIC PALETTES
  // Returns: [Base, Accent, Mist, Deep]
  List<Color> _getThemePalette() {
    if (isDark) {
      // Dark Mode Palettes (Deep & Neon)
      switch (themeName) {
        case 'Origin': return [const Color(0xFF263238), const Color(0xFFCFD8DC), const Color(0xFF37474F), const Color(0xFF102027)]; // Grey/Neutral
        case 'Elements': return [const Color(0xFF004D40), const Color(0xFF64FFDA), const Color(0xFF00695C), const Color(0xFF00251A)]; // Green/Teal
        case 'Humanity': return [const Color(0xFF3E2723), const Color(0xFFFFAB91), const Color(0xFF4E342E), const Color(0xFF210F0B)]; // Warm Brown
        case 'Village': return [const Color(0xFF33691E), const Color(0xFFCCFF90), const Color(0xFF558B2F), const Color(0xFF1B5E20)]; // Lime/Field
        case 'Journey': return [const Color(0xFF0D47A1), const Color(0xFF448AFF), const Color(0xFF1565C0), const Color(0xFF002171)]; // Blue/Sky
        case 'City': return [const Color(0xFF311B92), const Color(0xFFE040FB), const Color(0xFF4527A0), const Color(0xFF12005E)]; // Purple/Royal
        default: return [const Color(0xFF263238), const Color(0xFFB0BEC5), const Color(0xFF37474F), const Color(0xFF102027)];
      }
    } else {
      // Light Mode Palettes (Pastel & Vibrant)
      switch (themeName) {
        case 'Origin': return [const Color(0xFFECEFF1), const Color(0xFF607D8B), const Color(0xFFCFD8DC), const Color(0xFFB0BEC5)];
        case 'Elements': return [const Color(0xFFE0F2F1), const Color(0xFF009688), const Color(0xFF80CBC4), const Color(0xFFB2DFDB)];
        case 'Humanity': return [const Color(0xFFFFF3E0), const Color(0xFFFF9800), const Color(0xFFFFCC80), const Color(0xFFFFE0B2)];
        case 'Village': return [const Color(0xFFF1F8E9), const Color(0xFF8BC34A), const Color(0xFFC5E1A5), const Color(0xFFDCEDC8)];
        case 'Journey': return [const Color(0xFFE3F2FD), const Color(0xFF2196F3), const Color(0xFF90CAF9), const Color(0xFFBBDEFB)];
        case 'City': return [const Color(0xFFF3E5F5), const Color(0xFF9C27B0), const Color(0xFFCE93D8), const Color(0xFFE1BEE7)];
        default: return [const Color(0xFFECEFF1), const Color(0xFF607D8B), const Color(0xFFCFD8DC), const Color(0xFFCFD8DC)];
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final palette = _getThemePalette();
    final Color baseBg = palette[0];
    final Color mist = palette[2];

    final random = Random(index + 200);

    // 1. FILL BACKGROUND
    canvas.drawColor(baseBg, BlendMode.src);

    // 2. MIST (Opacity Only - Efficient)
    final mistPaint = Paint()..color = mist.withValues(alpha: 0.05)..style = PaintingStyle.fill;
    for (int i = 0; i < 2; i++) {
      // Draw varied ovals for organic feel
      final w = size.width + 100;
      final h = 100.0 + random.nextDouble() * 100.0;
      const x = -50.0;
      final y = random.nextDouble() * size.height;
      canvas.drawOval(Rect.fromLTWH(x, y, w, h), mistPaint);
    }

    // 3. REGIONAL ART (Tinted)
    // Tinted simplified art
    if (themeName == 'Elements') {
      _drawSumieMountains(canvas, size, palette[1]);
    } else if (themeName == 'Origin') {
      _drawUrokoWaves(canvas, size, palette[1]);
    } else if (themeName == 'Humanity') {
      _drawInkPines(canvas, size, palette[1]);
    } else if (themeName == 'Journey') {
      _drawLoopyDragon(canvas, size, palette[1]);
    } else if (themeName == 'Village') {
      _drawAncientRiver(canvas, size, palette[1]);
    } else if (themeName == 'City') {
      _drawUrokoWaves(canvas, size, palette[1]);
    } else {
      _drawSumieMountains(canvas, size, palette[1]);
    }
  }

  void _drawSumieMountains(Canvas canvas, Size size, Color color) {
    final midX = size.width / 2;
    for (int i = 0; i < 3; i++) {
      final h = 60.0 + (i * 40);
      final path = Path()
        ..moveTo(midX - 250, size.height)
        ..quadraticBezierTo(midX - 120, size.height - h - 50, midX - 20, size.height - 30)
        ..quadraticBezierTo(midX + 80, size.height - h + 20, midX + 250, size.height);
      canvas.drawPath(path, Paint()..color = color.withValues(alpha: 0.03)..style = PaintingStyle.fill);
    }
  }

  void _drawUrokoWaves(Canvas canvas, Size size, Color color) {
    final paint = Paint()..color = color.withValues(alpha: 0.3)..style = PaintingStyle.stroke..strokeWidth = 2;
    for (int row = 0; row < 8; row++) {
      for (int i = -4; i <= 4; i++) {
        final x = (size.width / 2) + (i * 45.0) + (row % 2 == 0 ? 0 : 22.5);
        final y = 100.0 + (row * 40.0);
        final wave = Path()..moveTo(x, y)..quadraticBezierTo(x + 15, y - 15, x + 30, y);
        canvas.drawPath(wave, paint);
      }
    }
  }

  void _drawInkPines(Canvas canvas, Size size, Color color) {
    final stroke = Paint()..color = color.withValues(alpha: 0.2)..strokeWidth = 2..style = PaintingStyle.stroke;
    for (int i = -3; i <= 3; i++) {
      final x = (size.width / 2) + (i * 60) + (i.abs() * 10);
      final h = 70.0 + (Random(i).nextDouble() * 50);
      final tree = Path();
      tree.moveTo(x, size.height);
      tree.lineTo(x, size.height - h);
      for (int b = 1; b < 5; b++) {
        final bh = size.height - (h * (b / 5));
        tree.moveTo(x, bh);
        tree.lineTo(x - 20, bh + 10);
        tree.moveTo(x, bh);
        tree.lineTo(x + 20, bh + 10);
      }
      canvas.drawPath(tree, stroke);
    }
  }

  void _drawLoopyDragon(Canvas canvas, Size size, Color color) {
    final midX = size.width / 2;
    final paint = Paint()..color = color.withValues(alpha: 0.1)..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final dragon = Path()..moveTo(midX - 180, 200)..cubicTo(midX - 100, -50, midX, 300, midX + 180, 100);
    canvas.drawPath(dragon, paint);
  }

  void _drawAncientRiver(Canvas canvas, Size size, Color color) {
    final midX = size.width / 2;
    final paint = Paint()..color = color.withValues(alpha: 0.2)..strokeWidth = 2..style = PaintingStyle.stroke;
    final river = Path()
      ..moveTo(midX - 150, 0)..quadraticBezierTo(midX - 250, size.height / 2, midX - 130, size.height)
      ..moveTo(midX - 120, 0)..quadraticBezierTo(midX - 220, size.height / 2, midX - 100, size.height);
    canvas.drawPath(river, paint);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GalaxyPainter extends CustomPainter {
  final List<Offset> offsets;
  final bool isDark;
  final bool isFirst;
  
  GalaxyPainter({
    required this.offsets, 
    required this.isDark,
    this.isFirst = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // OPTIMIZED GALAXY PAINTER
    final orbitPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.brown).withValues(alpha: 0.1) 
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final rayPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.brown).withValues(alpha: 0.15) 
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    final pathPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.brown).withValues(alpha: 0.25) 
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    // 1. Draw Orbit Rings (Simple Circles)
    canvas.drawCircle(center, size.width * 0.25, orbitPaint); 
    canvas.drawCircle(center, size.width * 0.45, orbitPaint);

    // 2. Draw Connection Rays from center (Sun) to planets
    for (var offset in offsets) {
      if (offset == Offset.zero) continue; // Skip Sun itself
      final target = Offset(center.dx + offset.dx, center.dy + offset.dy);
      canvas.drawLine(center, target, rayPaint);
    }

    // 3. Draw Interstellar Path (Vertical lines)
    if (!isFirst) {
      final topPath = Path()
        ..moveTo(center.dx, 0)
        ..lineTo(center.dx, center.dy - 50); 
      _drawDashedPath(canvas, topPath, pathPaint);
    }

    final bottomPath = Path()
      ..moveTo(center.dx, center.dy + 50)
      ..lineTo(center.dx, size.height);
    _drawDashedPath(canvas, bottomPath, pathPaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const double dashWidth = 6.0;
    const double dashSpace = 6.0;
    for (ui.PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
