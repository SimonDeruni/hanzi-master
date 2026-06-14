import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';

class RecallModeWidget extends ConsumerStatefulWidget {
  final Flashcard card;
  final int reviewedCount;
  final int dueCount;
  final int newCount;
  final int learningCount;

  const RecallModeWidget({
    super.key,
    required this.card,
    this.reviewedCount = 0,
    this.dueCount = 0,
    this.newCount = 0,
    this.learningCount = 0,
  });

  @override
  ConsumerState<RecallModeWidget> createState() => _RecallModeWidgetState();
}

class _RecallModeWidgetState extends ConsumerState<RecallModeWidget> {
  bool _isRevealed = false;

  void _checkAnswer() {
    setState(() {
      _isRevealed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: StudySessionAppBar(
        title: 'Recall Mode',
        dueCount: widget.dueCount,
        newCount: widget.newCount,
        learningCount: widget.learningCount,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // The Prompt
                    Text(
                      'Draw the character for:',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PinyinText(
                      text: widget.card.pinyin,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.card.definition,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Scratchpad or Answer
                    if (!_isRevealed) ...[
                      // Scratchpad Canvas
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(38),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: CalligraphyBackground(
                            child: DrawingCanvas(
                              // Passing empty strokes so it's just a blank canvas
                              strokePaths: const [],
                              medianPaths: const [],
                              showAnimation: false,
                              readOnly: false,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _checkAnswer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('REVEAL ANSWER', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ] else ...[
                      // Revealed Answer
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(38),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: CalligraphyBackground(
                            child: DrawingCanvas(
                              strokePaths: widget.card.strokePaths,
                              medianPaths: widget.card.medianPaths,
                              showAnimation: true,
                              readOnly: true,
                              isFlipped: widget.card.isFlipped,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Anki Grading Buttons
            if (_isRevealed)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Column(
                  children: [
                    const Text(
                      'How accurately did you draw it?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildGradeButton('Again', 0, Colors.red, 'Forgot completely'),
                        _buildGradeButton('Hard', 2, Colors.orange, 'Struggled or made mistakes'),
                        _buildGradeButton('Good', 4, Colors.green, 'Drew correctly'),
                        _buildGradeButton('Easy', 5, Colors.blue, 'Perfect recall'),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeButton(String label, int grade, MaterialColor color, String tooltip) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Tooltip(
          message: tooltip,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, grade);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color.shade100,
              foregroundColor: color.shade900,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: color.shade300, width: 1),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
