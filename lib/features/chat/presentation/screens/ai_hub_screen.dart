import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/chat/presentation/screens/echo_hall_screen.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/reading_room_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';

class AiHubScreen extends ConsumerWidget {
  const AiHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI HUB"),
      ),
      body: CalligraphyBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Art & Intellect",
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 3,
                    width: 60,
                    color: theme.colorScheme.onSurface,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Harness the power of the Digital Scholar to refine your brush and voice.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              _buildAiFeatureCard(
                context,
                title: "THE ECHO HALL",
                description: "Conversational practice with distinct scholarly personas.",
                icon: Icons.chat_bubble_outline_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EchoHallScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildAiFeatureCard(
                context,
                title: "CULTURAL READING ROOM",
                description: "Graded AI-generated stories on Chinese history and life.",
                icon: Icons.menu_book,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReadingRoomScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildAiFeatureCard(
                context,
                title: "PRONUNCIATION",
                description: "Digital critique of your spoken tones and clarity.",
                icon: Icons.mic_none_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScenarioSelectionScreen()),
                  );
                },
                isComingSoon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAiFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    bool isComingSoon = false,
  }) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return InkWell(
      onTap: isComingSoon ? null : onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isComingSoon ? onSurface.withValues(alpha: 0.05) : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isComingSoon ? onSurface.withValues(alpha: 0.1) : onSurface.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: isComingSoon ? null : [
            BoxShadow(
              color: onSurface.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isComingSoon ? onSurface.withValues(alpha: 0.1) : theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon, 
                color: isComingSoon ? onSurface.withValues(alpha: 0.4) : theme.colorScheme.onPrimary, 
                size: 24
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: isComingSoon ? onSurface.withValues(alpha: 0.4) : onSurface,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isComingSoon ? onSurface.withValues(alpha: 0.3) : onSurface.withValues(alpha: 0.7),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (!isComingSoon)
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: onSurface.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}
