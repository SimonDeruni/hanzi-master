import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/travel_interpreter_screen.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
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
                child: Row(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: _buildListActionCard(
                          context: context,
                          isDark: isDark,
                          title: l10n?.travelInterpreter ?? "Travel Interpreter",
                          subtitle: "Real-time split-screen",
                          icon: Icons.people_outline,
                          accentColor: const Color(0xFF4CAF50), // Green
                          onTap: () {
                            HapticsManager.medium();
                            Navigator.push(context, SwipeBackPageRoute(builder: (_) => const TravelInterpreterScreen()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: _buildListActionCard(
                          context: context,
                          isDark: isDark,
                          title: "Universal Scanner",
                          subtitle: "Extract & translate",
                          icon: Icons.document_scanner_outlined,
                          accentColor: const Color(0xFFFF9800), // Orange
                          onTap: () {
                            HapticsManager.medium();
                            Navigator.push(context, SwipeBackPageRoute(builder: (_) => const UniversalScannerScreen(intent: CameraIntent.translationHub)));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }

  Widget _buildListActionCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String subtitle,
    required IconData icon,
    bool isNew = false,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1B) : Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: accentColor.withValues(alpha: isDark ? 0.3 : 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: isDark ? 0.15 : 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              // Faded watermark background icon
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  icon,
                  size: 140,
                  color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.03),
                ),
              ),
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
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(icon, size: 42, color: accentColor),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white.withValues(alpha: 0.75) : Colors.black54,
                          fontSize: 12,
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
    );
  }
}
