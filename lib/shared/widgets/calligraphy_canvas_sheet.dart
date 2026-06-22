import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

void showCalligraphyCanvas(BuildContext context, String hanzi) {
  GlobalBlurredBottomSheet.show(
    context,
    child: CalligraphyCanvasSheet(hanzi: hanzi),
  );
}

class CalligraphyCanvasSheet extends StatefulWidget {
  final String hanzi;

  const CalligraphyCanvasSheet({super.key, required this.hanzi});

  @override
  State<CalligraphyCanvasSheet> createState() => _CalligraphyCanvasSheetState();
}

class _CalligraphyCanvasSheetState extends State<CalligraphyCanvasSheet> {
  List<List<Offset>> _lines = [];
  List<Offset> _currentLine = [];

  void _clear() {
    setState(() {
      _lines = [];
      _currentLine = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final textColor = isDark ? Colors.white : Colors.black87;
    final gridColor = isDark ? Colors.white12 : Colors.black12;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: textColor),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Trace Character',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: textColor),
                  onPressed: _clear,
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: gridColor, width: 2),
                    color: isDark ? Colors.black26 : Colors.white,
                  ),
                  child: Stack(
                    children: [
                      // Grid Background
                      CustomPaint(
                        size: Size.infinite,
                        painter: _GridPainter(gridColor),
                      ),
                      
                      // Faint Character
                      Center(
                        child: Text(
                          widget.hanzi,
                          style: TextStyle(
                            fontSize: 200,
                            height: 1.1,
                            color: isDark ? Colors.white12 : Colors.black12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      
                      // Drawing Layer
                      GestureDetector(
                        onPanStart: (details) {
                          setState(() {
                            _currentLine = [details.localPosition];
                            _lines.add(_currentLine);
                          });
                        },
                        onPanUpdate: (details) {
                          setState(() {
                            _currentLine.add(details.localPosition);
                          });
                        },
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: _StrokePainter(
                            lines: _lines,
                            strokeColor: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;

  _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Outer border (handled by container, but drawing diagonals)
    final path = Path();
    
    // Diagonals
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height);
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    
    // Cross
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height);
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 2);

    // Draw dashed effect
    const dashWidth = 8.0;
    const dashSpace = 4.0;
    
    for (var metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StrokePainter extends CustomPainter {
  final List<List<Offset>> lines;
  final Color strokeColor;

  _StrokePainter({required this.lines, required this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final line in lines) {
      if (line.isEmpty) continue;
      
      final path = Path();
      path.moveTo(line.first.dx, line.first.dy);
      
      for (int i = 1; i < line.length; i++) {
        path.lineTo(line[i].dx, line[i].dy);
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StrokePainter oldDelegate) {
    return true; // Simple approach
  }
}
