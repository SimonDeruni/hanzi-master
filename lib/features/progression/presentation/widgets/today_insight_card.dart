import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

class TodayInsightCard extends ConsumerWidget {
  const TodayInsightCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
    final todayWord = _pickDailyWord(cards);
    final card = todayWord['_card'] as Flashcard?;
    
    return BouncingButton(
      scaleFactor: 0.97,
      onPressed: () {
        if (card != null) {
          Navigator.push(context, SwipeBackPageRoute(builder: (_) => CharacterDetailScreen(card: card)));
        }
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
          border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1.5),
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
                      fontFamily: 'NotoSerifSC',
                      color: Colors.white,
                      height: 1,
                      shadows: [Shadow(color: Colors.white24, blurRadius: 20)],
                    ),
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 42.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "TODAY'S WORD",
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
                            fontFamily: 'NotoSerifSC',
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            fontSize: 72,
                            shadows: [
                              Shadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 12, offset: const Offset(0, 4)),
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
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: const Color(0xFFD4C4A8),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () => ref.read(audioServiceProvider).playCharacter(todayWord['hanzi']!),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.12),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.volume_up_rounded,
                                        size: 18,
                                        color: Colors.white.withValues(alpha: 0.9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                todayWord['meaning']!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
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

Map<String, dynamic> _pickDailyWord(List<Flashcard> cards) {
  if (cards.isEmpty) {
    return const {
      'hanzi': '诚',
      'pinyin': 'chéng',
      'meaning': 'sincere; honest',
    };
  }
  final daySeed = DateTime.now().millisecondsSinceEpoch ~/ 86400000;
  final card = cards[daySeed % cards.length];
  return {
    'hanzi': card.hanzi,
    'pinyin': card.pinyin,
    'meaning': card.definition,
    '_card': card,
  };
}
