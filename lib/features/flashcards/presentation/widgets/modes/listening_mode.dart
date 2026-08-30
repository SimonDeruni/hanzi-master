import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';

class ListeningModeWidget extends ConsumerStatefulWidget {
  final Flashcard card;
  final int reviewedCount;
  final int dueCount;
  final int newCount;
  final int learningCount;

  const ListeningModeWidget({
    super.key,
    required this.card,
    this.reviewedCount = 0,
    this.dueCount = 0,
    this.newCount = 0,
    this.learningCount = 0,
  });

  @override
  ConsumerState<ListeningModeWidget> createState() =>
      _ListeningModeWidgetState();
}

class _ListeningModeWidgetState extends ConsumerState<ListeningModeWidget> {
  bool _isRevealed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playAudio();
    });
  }

  void _playAudio() {
    ref.read(audioServiceProvider).playCharacter(widget.card.hanzi);
  }

  void _revealAnswer() {
    setState(() {
      _isRevealed = true;
    });
    HapticsManager.light();
  }

  Widget _buildColoredHanzi(String hanzi, String pinyin, bool isDark) {
    final tokens = PinyinUtils.tokenize(pinyin);
    final syllableTokens = tokens
        .where((t) =>
            RegExp(r'[a-zA-ZüÜāēīōūǖáéíóúǘǎěǐǒǔǚàèìòùǜ]').hasMatch(t['text']))
        .toList();

    final hanziChars = hanzi.characters.toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(hanziChars.length, (index) {
        final char = hanziChars[index];
        Color color = isDark ? Colors.white : Colors.black87;
        if (index < syllableTokens.length) {
          final tone = syllableTokens[index]['tone'] as int;
          color = PinyinUtils.toneColors[tone] ?? color;
        }

        return Text(
          char,
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            color: color,
            shadows: [
              Shadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: StudySessionAppBar(
        title: 'Listening Mode',
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
                  child: GestureDetector(
                    onTap: !_isRevealed ? _revealAnswer : null,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color:
                            isDark ? Colors.white.withAlpha(12) : Colors.white,
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: _playAudio,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 16),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: isDark
                                              ? [
                                                  Colors.purple.shade700,
                                                  Colors.deepPurple.shade900
                                                ]
                                              : [
                                                  Colors.purple.shade300,
                                                  Colors.purple.shade600
                                                ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(32),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purple
                                                .withAlpha(isDark ? 80 : 120),
                                            blurRadius: 16,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.volume_up_rounded,
                                              color: Colors.white, size: 28),
                                          SizedBox(width: 12),
                                          Text(
                                            'Tap to listen again',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (!_isRevealed)
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  AppLocalizations.of(context)!.tapCardToReveal,
                                  style: const TextStyle(
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
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: _buildColoredHanzi(widget.card.hanzi,
                                        widget.card.pinyin, isDark),
                                  ),
                                  const SizedBox(height: 8),
                                  PinyinText(
                                    text: widget.card.pinyin,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: TranslatedDefinition(
                                        definition: widget.card.definition,
                                        originalStyle:
                                            const TextStyle(fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    )
                        .animate()
                        .fade(duration: 500.ms, curve: Curves.easeOutCubic)
                        .slideY(
                            begin: 0.1,
                            end: 0,
                            duration: 500.ms,
                            curve: Curves.easeOutCubic),
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
