import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Timer? _dismissTimer;

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
    _dismissTimer?.cancel();
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
      _dismissTimer = Timer(const Duration(milliseconds: 1500), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  Widget _buildSuccessState(Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, size: 64, color: Colors.green.shade400),
        const SizedBox(height: 16),
        Text(
          'Trace Complete!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
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
        height: MediaQuery.of(context).orientation == Orientation.landscape 
            ? MediaQuery.of(context).size.height * 0.95 
            : MediaQuery.of(context).size.height * 0.7,
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
                child: _isComplete
                    ? _buildSuccessState(textColor)
                    : AspectRatio(
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
