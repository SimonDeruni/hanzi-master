import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  final Color color;
  final double barWidth;
  final double spacing;

  WaveformPainter({
    required this.amplitudes,
    required this.color,
    this.barWidth = 4.0,
    this.spacing = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (amplitudes.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barWidth;

    final centerY = size.height / 2;
    // We draw from right to left so new data appears on the right and pushes old data left
    double currentX = size.width;

    // Normalize amplitudes to fit the height. Assuming amplitudes are roughly 0 to 1.
    // Record package amplitude is in dBFS (-160 to 0). We need to map it.
    
    for (int i = amplitudes.length - 1; i >= 0; i--) {
      if (currentX < 0) break; // Off screen

      // Map dBFS (-60 to 0) to a linear 0.0 - 1.0 scale
      // Silence is usually around -40 to -60. Loud is 0.
      double db = amplitudes[i];
      double normalized = (db + 50) / 50; 
      normalized = normalized.clamp(0.05, 1.0); // min 5% height

      final barHeight = (size.height * normalized) / 2;

      canvas.drawLine(
        Offset(currentX, centerY - barHeight),
        Offset(currentX, centerY + barHeight),
        paint,
      );

      currentX -= (barWidth + spacing);
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return oldDelegate.amplitudes != amplitudes || oldDelegate.color != color;
  }
}
