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
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background calligraphy
            Positioned(
              right: -30,
              top: -10,
              child: Opacity(
                opacity: 0.25,
                child: const Text(
                  "诚",
                  style: TextStyle(
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
                              text: "诚 ",
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSerifSC',
                                fontSize: 28,
                              ),
                            ),
                            TextSpan(
                              text: "(Chéng)",
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
                        onTap: () => ref.read(audioServiceProvider).playCharacter('诚'),
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
                    "诚实 - Sincerity / Honest",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFD4C4A8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AI Breakdown | 2 mins",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.0,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFD4C4A8)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "1 word a day = 365 characters a year",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white54,
                      fontStyle: FontStyle.italic,
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
