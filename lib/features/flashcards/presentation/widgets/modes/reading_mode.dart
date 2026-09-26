import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/shared/widgets/swipe_to_grade_hint.dart';

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

  /// The study card, in the app's card vocabulary.
  ///
  /// The radius stays 32 because [ZenFlipCard] paints its paper-shimmer
  /// highlight at 32: any other corner here would let the highlight's corners
  /// show through the card mid-flip.
  Widget _buildCardContainer({required Widget child}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.cardBgOf(context),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
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
      // The canonical surface, so the transparent app bar and the body read as
      // the same sheet of Xuan paper rather than two stacked panels.
      backgroundColor: AppTheme.surfaceOf(context),
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
                                        ? AppTheme.carbonInkDark
                                        : AppTheme.carbonInkLight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              // Scales down rather than overflowing when a
                              // longer locale wraps this onto two lines.
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  AppLocalizations.of(context)!.tapToReveal,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.4,
                                    color: isDark
                                        ? AppTheme.carbonInkDark
                                            .withValues(alpha: 0.55)
                                        : AppTheme.carbonInkLight
                                            .withValues(alpha: 0.55),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: _buildCardContainer(
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
                                        ? AppTheme.carbonInkDark
                                        : AppTheme.carbonInkLight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // The Emperor's Gold hairline the rest of the app
                          // rules its cards with.
                          Divider(
                            height: 32,
                            color:
                                const Color(0xFFD4AF37).withValues(alpha: 0.45),
                          ),
                          Expanded(
                            flex: 2,
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                // The hanzi above owns half the card, and a long
                                // definition can want more than the other half.
                                // Rather than overflow a 320x568 screen, the
                                // answer block wraps at the card's width and
                                // scales down to whatever share it gets.
                                return FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: SizedBox(
                                    width: constraints.maxWidth,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
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
                                          originalStyle: TextStyle(
                                            fontSize: 20,
                                            color: isDark
                                                ? AppTheme.carbonInkDark
                                                : AppTheme.carbonInkLight,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Swipe hint: the four grades as Hanko seals, the same vocabulary
            // the swipe itself stamps on the card.
            if (_isRevealed)
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: SwipeToGradeHint(),
              ),
          ],
        ),
      ),
    );
  }
}
