import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';

enum DrawingStepMode { guided, ghost, anchors, recall }

class DrawingStep extends ConsumerStatefulWidget {
  final Flashcard card;
  final DrawingStepMode mode;
  final Function(double) onComplete;

  const DrawingStep({
    super.key,
    required this.card,
    required this.mode,
    required this.onComplete,
  });

  @override
  ConsumerState<DrawingStep> createState() => _DrawingStepState();
}

class _DrawingStepState extends ConsumerState<DrawingStep> {
  final ValueNotifier<List<ui.Offset?>> _userPointsNotifier = ValueNotifier([]);
  int _currentStrokeIndex = 0;

  void _onStrokeComplete(int strokeIndex, Size size) {
    HapticsManager.light();
    
    // Determine total VALID strokes (ignoring separators for simplicity in MVP)
    // Note: If multi-char, this simple logic might need enhancement, but works for single chars.
    final totalValidStrokes = widget.card.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').length;
    
    if (_currentStrokeIndex + 1 < totalValidStrokes) {
       Future.delayed(const Duration(milliseconds: 150), () {
         if (mounted) {
           setState(() {
             _currentStrokeIndex++;
             _userPointsNotifier.value = [];
           });
         }
       });
    } else {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
           _gradeAndFinish();
        }
      });
    }
  }

  void _gradeAndFinish() {
    HapticsManager.success();
    ref.read(audioServiceProvider).playCharacter(widget.card.hanzi);
    widget.onComplete(100.0);
  }


  @override
  Widget build(BuildContext context) {
    // Logic mapping
    final bool showReference = widget.mode != DrawingStepMode.recall;
    final bool showGuideLines = widget.mode == DrawingStepMode.guided || widget.mode == DrawingStepMode.ghost;
    const bool showAnimation = false; // Disable distracting animation loop in lesson mode
    final Color referenceColor = widget.mode == DrawingStepMode.ghost ? Colors.grey : Colors.blue;
    final bool strictGrading = widget.mode != DrawingStepMode.recall;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            _getInstruction(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: SizedBox(
                width: 300, // Reduced size to prevent "allongé" feel
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.indigo.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 8))
                      ],
                    ),
                    child: DrawingCanvas(
                      strokePaths: widget.card.strokePaths,
                      medianPaths: widget.card.medianPaths,
                      showAnimation: showAnimation,
                      showReference: showReference,
                      showGuideLines: showGuideLines,
                      referenceColor: referenceColor,
                      strictGrading: strictGrading,
                      userPointsNotifier: _userPointsNotifier,
                      strokeByStrokeMode: true,
                      currentStrokeIndex: _currentStrokeIndex,
                      onStrokeComplete: _onStrokeComplete,
                      showGrade: true,
                      autoCenter: false, // Use original coordinates for perfect alignment
                      masteryLevel: widget.card.masteryLevel,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getInstruction() {
    switch (widget.mode) {
      case DrawingStepMode.guided: return "Trace with the Guide";
      case DrawingStepMode.ghost: return "Trace the Ghost";
      case DrawingStepMode.anchors: return "Connect the Dots";
      case DrawingStepMode.recall: return "Draw from Memory";
    }
  }
}
