import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class ReadingModeWidget extends ConsumerStatefulWidget {
  final Flashcard card;
  final int reviewedCount;
  final int dueCount;
  final int newCount;
  final int learningCount;

  const ReadingModeWidget({
    super.key,
    required this.card,
    this.reviewedCount = 0,
    this.dueCount = 0,
    this.newCount = 0,
    this.learningCount = 0,
  });

  @override
  ConsumerState<ReadingModeWidget> createState() => _ReadingModeWidgetState();
}

class _ReadingModeWidgetState extends ConsumerState<ReadingModeWidget> {
  bool _isRevealed = false;

  void _revealAnswer() {
    setState(() {
      _isRevealed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: StudySessionAppBar(
        title: 'Reading Mode',
        dueCount: widget.dueCount,
        newCount: widget.newCount,
        learningCount: widget.learningCount,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GestureDetector(
                  onTap: !_isRevealed ? _revealAnswer : null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withAlpha(12) : Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: isDark ? Colors.white12 : Colors.black12,
                      ),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withAlpha(12),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.card.hanzi,
                                style: TextStyle(
                                  fontSize: 120,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (!_isRevealed)
                          const Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Tap to Reveal",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        if (_isRevealed) ...[
                          const Divider(height: 48),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PinyinText(
                                  text: widget.card.pinyin,
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  widget.card.definition,
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ).animate()
                   .fade(duration: 500.ms, curve: Curves.easeOutCubic)
                   .slideY(begin: 0.1, end: 0, duration: 500.ms, curve: Curves.easeOutCubic),
                ),
              ),
            ),

            // Anki Grading Buttons
            if (_isRevealed)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.howDidYouDo,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildGradeButton(AppLocalizations.of(context)!.again, 0, Colors.red, AppLocalizations.of(context)!.missedItEntirely),
                        _buildGradeButton(AppLocalizations.of(context)!.hard, 2, Colors.orange, AppLocalizations.of(context)!.gotItButStruggled),
                        _buildGradeButton(AppLocalizations.of(context)!.good, 4, Colors.green, AppLocalizations.of(context)!.gotItClearly),
                        _buildGradeButton(AppLocalizations.of(context)!.easy, 5, Colors.blue, AppLocalizations.of(context)!.perfectAndImmediate),
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
          child: BouncingButton(
            onPressed: () {
              Navigator.pop(context, grade);
            },
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: color.shade100,
                foregroundColor: color.shade900,
                disabledBackgroundColor: color.shade100,
                disabledForegroundColor: color.shade900,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: color.shade300, width: 1),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
