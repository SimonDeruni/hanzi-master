import 'package:flutter/material.dart';

class ToneGraphPainter extends CustomPainter {
  final List<double?> idealPitch;
  final List<double?> userPitch;
  final bool isLive;
  
  /// Highlights a specific portion of the graph (e.g., when a character is tapped)
  /// Values are percentages (0.0 to 1.0) of the total graph width.
  final double? highlightStart;
  final double? highlightEnd;

  ToneGraphPainter({
    required this.idealPitch,
    required this.userPitch,
    this.isLive = false,
    this.highlightStart,
    this.highlightEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (idealPitch.isEmpty && userPitch.isEmpty) return;

    // Draw Highlight Background if active
    if (highlightStart != null && highlightEnd != null) {
      final paint = Paint()..color = Colors.amber.withValues(alpha: 0.15)..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTRB(highlightStart! * size.width, 0, highlightEnd! * size.width, size.height),
        paint,
      );
    }

    // Dynamically calculate min and max pitch from valid data points
    final allPitches = [...idealPitch, ...userPitch].whereType<double>().toList();
    final double minPitch = allPitches.isEmpty ? 50.0 : (allPitches.reduce((a, b) => a < b ? a : b) - 20).clamp(50.0, 1000.0);
    final double maxPitch = allPitches.isEmpty ? 800.0 : (allPitches.reduce((a, b) => a > b ? a : b) + 20).clamp(50.0, 1000.0);
    final double range = maxPitch - minPitch <= 0 ? 1 : maxPitch - minPitch;

    // Function to draw a pitch curve
    void drawCurve(List<double?> pitchData, Color color, double strokeWidth, bool isDashed) {
      if (pitchData.isEmpty || !pitchData.any((p) => p != null)) return;
      
      final paint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final path = Path();
      bool isFirst = true;

      for (int i = 0; i < pitchData.length; i++) {
        if (pitchData[i] == null || pitchData[i]! <= 0) {
          // Do not set isFirst = true. We want to connect across gaps 
          // so sparse pitch data forms a continuous contour.
          continue;
        }
        
        final double x = (i / (pitchData.length - 1)) * size.width;
        // Invert Y axis so higher pitch is higher on screen
        final double y = size.height - (((pitchData[i]! - minPitch) / range) * size.height);

        if (isFirst) {
          path.moveTo(x, y);
          isFirst = false;
        } else {
          path.lineTo(x, y);
        }
      }

      if (isDashed) {
        canvas.drawPath(path, paint..color = color.withValues(alpha: 0.4));
      } else {
        canvas.drawPath(path, paint);
      }
    }

    // Draw Ideal Pitch (Grey Background)
    if (!isLive) {
      drawCurve(idealPitch, Colors.grey.shade400, 4.0, true);
    }

    // Draw User Pitch (Color-coded based on distance from ideal)
    // For simplicity, we draw the user pitch as a single path right now.
    // In a full implementation, we could color-code line segments red/green based on distance.
    drawCurve(userPitch, Colors.blue.shade600, 3.0, false);
  }

  @override
  bool shouldRepaint(covariant ToneGraphPainter oldDelegate) {
    return oldDelegate.isLive != isLive || 
           oldDelegate.userPitch != userPitch || 
           oldDelegate.idealPitch != idealPitch ||
           oldDelegate.highlightStart != highlightStart ||
           oldDelegate.highlightEnd != highlightEnd;
  }
}
