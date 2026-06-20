import 'package:flutter/material.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as mlkit;

class HandwritingCanvas extends StatefulWidget {
  final void Function(mlkit.Ink ink) onInkChanged;
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
  mlkit.Ink _ink = mlkit.Ink();
  List<mlkit.Stroke> _strokes = [];
  List<mlkit.StrokePoint> _points = [];

  void clear() {
    setState(() {
      _ink = mlkit.Ink();
      _strokes = [];
      _points = [];
    });
    widget.onInkChanged(_ink);
  }

  void _undo() {
    if (_strokes.isNotEmpty) {
      setState(() {
        _strokes.removeLast();
        _ink = mlkit.Ink()..strokes.addAll(_strokes);
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
            _points.add(mlkit.StrokePoint(
              x: details.localPosition.dx,
              y: details.localPosition.dy,
              t: DateTime.now().millisecondsSinceEpoch,
            ));
          },
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              _points.add(mlkit.StrokePoint(
                x: details.localPosition.dx,
                y: details.localPosition.dy,
                t: DateTime.now().millisecondsSinceEpoch,
              ));
            });
          },
          onPanEnd: (DragEndDetails details) {
            final stroke = mlkit.Stroke()..points = _points.toList();
            _strokes.add(stroke);
            _ink = mlkit.Ink()..strokes.addAll(_strokes);
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
  final List<mlkit.Stroke> strokes;
  final List<mlkit.StrokePoint> currentPoints;
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
