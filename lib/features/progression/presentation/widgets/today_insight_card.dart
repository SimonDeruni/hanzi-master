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
                right: -30,
                bottom: -50,
                child: Opacity(
                  opacity: 0.04,
                  child: Text(
                    todayWord['hanzi']!,
                    style: const TextStyle(
                      fontSize: 220,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSerifSC',
                      color: Colors.white,
                      height: 1,
                      shadows: [Shadow(color: Colors.white24, blurRadius: 30)],
                    ),
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TODAY'S WORD",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFD4C4A8),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          todayWord['hanzi']!,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontFamily: 'NotoSerifSC',
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            shadows: [
                              Shadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    todayWord['pinyin']!,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: const Color(0xFFD4C4A8),
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () => ref.read(audioServiceProvider).playCharacter(todayWord['hanzi']!),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.1),
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
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
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
