import 'package:flutter/material.dart';
import '../../services/digital_ink_service.dart';

class HandwritingCanvas extends StatefulWidget {
  final void Function(CustomInk ink) onInkChanged;
  final Color strokeColor;
  final double strokeWidth;

  const HandwritingCanvas({
    super.key,
    required this.onInkChanged,
    this.strokeColor = Colors.black,
    this.strokeWidth = 4.0,
  });

  @override
  State<HandwritingCanvas> createState() => HandwritingCanvasState();
}

class HandwritingCanvasState extends State<HandwritingCanvas> {
  CustomInk _ink = CustomInk();
  List<CustomStroke> _strokes = [];
  List<CustomStrokePoint> _points = [];

  void clear() {
    setState(() {
      _ink = CustomInk();
      _strokes = [];
      _points = [];
    });
    widget.onInkChanged(_ink);
  }

  void _undo() {
    if (_strokes.isNotEmpty) {
      setState(() {
        _strokes.removeLast();
        _ink = CustomInk()..strokes.addAll(_strokes);
      });
      widget.onInkChanged(_ink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onPanStart: (DragStartDetails details) {
            _points = [];
            _points.add(CustomStrokePoint(
              x: details.localPosition.dx,
              y: details.localPosition.dy,
              t: DateTime.now().millisecondsSinceEpoch,
            ));
          },
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              _points.add(CustomStrokePoint(
                x: details.localPosition.dx,
                y: details.localPosition.dy,
                t: DateTime.now().millisecondsSinceEpoch,
              ));
            });
          },
          onPanEnd: (DragEndDetails details) {
            final stroke = CustomStroke()..points.addAll(_points);
            _strokes.add(stroke);
            _ink = CustomInk()..strokes.addAll(_strokes);
            widget.onInkChanged(_ink);
          },
          child: CustomPaint(
            painter: _DigitalInkPainter(
              strokes: _strokes,
              currentPoints: _points,
              strokeColor: widget.strokeColor,
              strokeWidth: widget.strokeWidth,
            ),
            size: Size.infinite,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.undo),
                onPressed: _strokes.isEmpty ? null : _undo,
                tooltip: "Undo",
              ),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _strokes.isEmpty ? null : clear,
                tooltip: "Clear",
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _DigitalInkPainter extends CustomPainter {
  final List<CustomStroke> strokes;
  final List<CustomStrokePoint> currentPoints;
  final Color strokeColor;
  final double strokeWidth;

  _DigitalInkPainter({
    required this.strokes,
    required this.currentPoints,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      if (stroke.points.isEmpty) continue;
      final path = Path();
      path.moveTo(stroke.points.first.x.toDouble(), stroke.points.first.y.toDouble());
      for (int i = 1; i < stroke.points.length; i++) {
        path.lineTo(stroke.points[i].x.toDouble(), stroke.points[i].y.toDouble());
      }
      canvas.drawPath(path, paint);
    }

    if (currentPoints.isNotEmpty) {
      final path = Path();
      path.moveTo(currentPoints.first.x.toDouble(), currentPoints.first.y.toDouble());
      for (int i = 1; i < currentPoints.length; i++) {
        path.lineTo(currentPoints[i].x.toDouble(), currentPoints[i].y.toDouble());
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DigitalInkPainter oldDelegate) {
    return true; // We always repaint when points change
  }
}
