import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';

import 'package:hanzi_master/shared/widgets/zen_flip_card.dart';

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
    HapticsManager.light();
  }

  Widget _buildCardContainer({
    required bool isDark,
    required Widget child,
  }) {
    return Container(
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
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: StudySessionAppBar(
        title: AppLocalizations.of(context)?.readingMode ?? 'Reading Mode',
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
                child: SwipeableFlashcard(
                  isSwipeEnabled: _isRevealed,
                  onSwiped: (grade) => Navigator.pop(context, grade),
                  child: ZenFlipCard(
                    isFlipped: _isRevealed,
                    onTap: !_isRevealed ? _revealAnswer : null,
                    front: _buildCardContainer(
                      isDark: isDark,
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
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                AppLocalizations.of(context)!.tapToReveal,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: _buildCardContainer(
                      isDark: isDark,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.card.hanzi,
                                  style: TextStyle(
                                    fontSize: 84,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(height: 32),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PinyinText(
                                  text: widget.card.pinyin,
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                TranslatedDefinition(
                                  definition: widget.card.definition,
                                  hanzi: widget.card.hanzi,
                                  definitionLanguage:
                                      widget.card.definitionLanguage,
                                  originalStyle:
                                      const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Swipe Hint
            if (_isRevealed)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Column(
                  children: [
                    Text(
                      "Swipe to Grade:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "⬅️ Again    ➡️ Good    ⬆️ Easy    ⬇️ Hard",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
