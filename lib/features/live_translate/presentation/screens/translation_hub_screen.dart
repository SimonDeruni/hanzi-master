import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/travel_interpreter_screen.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/whisper_earpiece_screen.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/translation_history_screen.dart';

class TranslationHubScreen extends StatelessWidget {
  const TranslationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translate"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TranslationHistoryScreen()));
            },
          )
        ],
      ),
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Live Translation Hub",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Powered by Gemini 3.5 Live Translate. Choose a mode to begin.",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF1A1A1B).withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildModeCard(
                      context: context,
                      title: "Travel Interpreter",
                      description: "Real-time split-screen conversation with a native speaker.",
                      icon: Icons.people_alt,
                      color: Colors.blue.shade100,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const TravelInterpreterScreen()));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildModeCard(
                      context: context,
                      title: "Whisper Earpiece",
                      description: "Listen to Chinese audio and get real-time English subtitles.",
                      icon: Icons.hearing,
                      color: Colors.purple.shade100,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const WhisperEarpieceScreen()));
                      },
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

  Widget _buildModeCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: Colors.black87),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}
