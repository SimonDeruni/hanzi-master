import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

class TodayInsightCard extends ConsumerWidget {
  const TodayInsightCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final todayWord = {
      'hanzi': '诚',
      'pinyin': 'chéng',
      'meaning': 'sincere; honest',
    };
    
    return BouncingButton(
      scaleFactor: 0.97,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CharacterDetailScreen(
              card: Flashcard(
                id: 'mock_cheng',
                hanzi: '诚',
                pinyin: 'chéng',
                definition: 'sincere; honest',
                hskLevel: 4,
                strokePaths: [],
                modeStats: {},
              ),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Subtle animated background or texture
              Positioned(
                right: -40,
                bottom: -40,
                child: Opacity(
                  opacity: 0.05,
                  child: Text(
                    todayWord['hanzi']!,
                    style: const TextStyle(
                      fontSize: 200,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSerifSC',
                      color: Colors.white24,
                      height: 1,
                      shadows: [Shadow(color: Colors.white30, blurRadius: 20)],
                    ),
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TODAY'S WORD",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFD4C4A8),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "HANZI: ",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              TextSpan(
                                text: "${todayWord['hanzi']} ",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NotoSerifSC',
                                  fontSize: 28,
                                ),
                              ),
                              TextSpan(
                                text: "(${todayWord['pinyin']})",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: const Color(0xFFD4C4A8),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => ref.read(audioServiceProvider).playCharacter(todayWord['hanzi']!),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.volume_up, size: 16, color: Color(0xFFD4C4A8)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      todayWord['meaning']!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFD4C4A8),
                        fontWeight: FontWeight.w600,
                      ),
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
