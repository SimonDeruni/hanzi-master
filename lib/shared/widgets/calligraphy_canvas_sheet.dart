import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';

import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

void showCalligraphyCanvas(BuildContext context, Flashcard card) {
  showDialog(
    context: context,
    builder: (context) => CalligraphyCanvasDialog(card: card),
  );
}

class CalligraphyCanvasDialog extends ConsumerStatefulWidget {
  final Flashcard card;

  const CalligraphyCanvasDialog({super.key, required this.card});

  @override
  ConsumerState<CalligraphyCanvasDialog> createState() => _CalligraphyCanvasDialogState();
}

class _CalligraphyCanvasDialogState extends ConsumerState<CalligraphyCanvasDialog> {
  final ValueNotifier<List<ui.Offset?>> _scratchpadNotifier = ValueNotifier([]);
  Flashcard? _hydratedCard;
  bool _isLoading = false;
  int _currentStrokeIndex = 0;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    if (widget.card.strokePaths.isEmpty) {
      _isLoading = true;
      _hydrateStrokes();
    } else {
      _hydratedCard = widget.card;
    }
  }

  Future<void> _hydrateStrokes() async {
    final updatedCard = await ref.read(flashcardControllerProvider.notifier).loadStrokesFor(widget.card);
    if (mounted) {
      setState(() {
        _hydratedCard = updatedCard;
        _isLoading = false;
      });
    }
  }

  void _clear() {
    _scratchpadNotifier.value = [];
    setState(() {
      _currentStrokeIndex = 0;
      _isComplete = false;
    });
  }

  void _onStrokeComplete(int index, ui.Size canvasSize) {
    if (!mounted || _hydratedCard == null) return;
    final totalStrokes = _hydratedCard!.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').length;
    
    if (index < totalStrokes - 1) {
      setState(() {
        _currentStrokeIndex = index + 1;
      });
    } else {
      setState(() {
        _isComplete = true;
      });
    }
  }

  @override
  void dispose() {
    _scratchpadNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final textColor = isDark ? Colors.white : Colors.black87;
    final gridColor = isDark ? Colors.white12 : Colors.black12;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
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
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: gridColor, width: 2),
                      color: isDark ? Colors.black26 : Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CalligraphyBackground(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : DrawingCanvas(
                              strokePaths: _hydratedCard?.strokePaths ?? [],
                              medianPaths: _hydratedCard?.medianPaths ?? [],
                              showAnimation: false,
                              strokeByStrokeMode: true,
                              currentStrokeIndex: _currentStrokeIndex,
                              onStrokeComplete: _onStrokeComplete,
                              isFlipped: _hydratedCard?.isFlipped ?? false,
                              readOnly: _isComplete,
                              showControls: true,
                              showGrade: false,
                              showGuideLines: true,
                              showReference: true,
                              userPointsNotifier: _scratchpadNotifier,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
