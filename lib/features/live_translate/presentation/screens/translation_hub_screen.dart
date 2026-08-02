import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/travel_interpreter_screen.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
class TranslationHubScreen extends StatelessWidget {
  const TranslationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      body: CalligraphyBackground(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            GlobalSliverAppBar(
              title: l10n?.liveTranslate ?? "Live Translate",
              actions: [
              ],
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Cards
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildListActionCard(
                            context: context,
                            title: l10n?.travelInterpreter ?? "Travel Interpreter",
                            subtitle: "Real-time split-screen",
                            icon: Icons.people_outline,
                            gradientColors: const [Color(0xFF2E7D32), Color(0xFF4CAF50)], // Green gradient
                            onTap: () {
                              HapticsManager.medium();
                              Navigator.push(context, SwipeBackPageRoute(builder: (_) => const TravelInterpreterScreen()));
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildListActionCard(
                            context: context,
                            title: "Universal Scanner",
                            subtitle: "Extract & translate",
                            icon: Icons.document_scanner_outlined,
                            gradientColors: const [Color(0xFFE65100), Color(0xFFFF9800)], // Orange gradient
                            onTap: () {
                              HapticsManager.medium();
                              Navigator.push(context, SwipeBackPageRoute(builder: (_) => const UniversalScannerScreen(intent: CameraIntent.translationHub)));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    bool isNew = false,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // NEW badge
            if (isNew)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE27C5A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(icon, size: 36, color: Colors.white.withValues(alpha: 0.9)),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 12,
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
