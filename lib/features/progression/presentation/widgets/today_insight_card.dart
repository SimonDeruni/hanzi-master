import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/personal/her_content.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';

import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/widget_service.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class TodayInsightCard extends ConsumerStatefulWidget {
  const TodayInsightCard({super.key});

  @override
  ConsumerState<TodayInsightCard> createState() => _TodayInsightCardState();
}

class _TodayInsightCardState extends ConsumerState<TodayInsightCard> {
  late DateTime _now;
  Timer? _midnightTimer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _scheduleMidnightRefresh();
  }

  void _scheduleMidnightRefresh() {
    final now = DateTime.now();
    final nextDay = DateTime(now.year, now.month, now.day + 1);
    _midnightTimer = Timer(nextDay.difference(now), () {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
      unawaited(ref.read(widgetServiceProvider).updateWordOfTheDay(
        now: _now,
        word: HerContent.wordOfTheDayForAccount(
          email: ref.read(currentUserProvider)?.email,
          date: _now,
        ),
      ));
      _scheduleMidnightRefresh();
    });
  }

  @override
  void dispose() {
    _midnightTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
    final todayWord = _pickDailyWord(
      cards,
      _now,
      ref.watch(currentUserProvider)?.email,
    );
    final word = todayWord['_word'] as WordOfTheDay;
    final card = todayWord['_card'] as Flashcard? ?? _dailyWordCard(word);

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          SwipeBackPageRoute(
            builder: (_) => CharacterDetailScreen(card: card),
            settings: RouteSettings(arguments: card),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A2D34), Color(0xFF121212)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: Colors.white.withValues(alpha: 0.08), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 24,
              offset: const Offset(0, 12),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Subtle animated background or texture
              Positioned(
                right: -20,
                bottom: -35,
                child: Opacity(
                  opacity: 0.04,
                  child: Text(
                    todayWord['hanzi']!,
                    style: const TextStyle(
                      fontSize: 160,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1,
                      shadows: [Shadow(color: Colors.white24, blurRadius: 20)],
                    ),
                  ),
                ),
              ),
// Content
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28.0, vertical: 42.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.todaysWord,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFD4C4A8),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.8,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          todayWord['hanzi']!,
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            fontSize: 72,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    todayWord['pinyin']!,
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      color: const Color(0xFFD4C4A8),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () => ref
                                        .read(audioServiceProvider)
                                        .playCharacter(todayWord['hanzi']!),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withValues(alpha: 0.12),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.volume_up_rounded,
                                        size: 18,
                                        color:
                                            Colors.white.withValues(alpha: 0.9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TranslatedDefinition(
                                definition: todayWord['meaning']!,
                                hanzi: todayWord['hanzi']!,
                                bundledTranslations: word.localizedDefinitions,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                originalStyle:
                                    theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontWeight: FontWeight.w400,
                                  height: 1.35,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [email] decides *whose* word this is: one account gets the word it asked for, every
/// other account gets `wordOfTheDayFor`. See `HerContent.wordOfTheDayForAccount`.
Map<String, dynamic> _pickDailyWord(
  List<Flashcard> cards,
  DateTime now,
  String? email,
) {
  final word = HerContent.wordOfTheDayForAccount(email: email, date: now);
  Flashcard? matchingCard;
  for (final card in cards) {
    if (card.hanzi == word.hanzi) {
      matchingCard = card;
      break;
    }
  }

  return {
    'hanzi': word.hanzi,
    'pinyin': word.pinyin,
    'meaning': word.definition,
    '_word': word,
    '_card': matchingCard,
  };
}

Flashcard _dailyWordCard(WordOfTheDay word) => Flashcard(
      id: 'word-of-the-day:${word.hanzi}',
      hanzi: word.hanzi,
      pinyin: word.pinyin,
      definition: word.definition,
      definitionLanguage: 'English',
      hskLevel: 0,
      strokePaths: const [],
      modeStats: const {},
    );
