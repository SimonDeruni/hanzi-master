import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/travel_interpreter_screen.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/translation_history_screen.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/info_bulb.dart';

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
                InfoBulb(
                  id: 'translation_hub',
                  title: "Live Translate",
                  message: "Break down language barriers with real-time translation tools. Use the Travel Interpreter for split-screen conversations, or the Universal Scanner to translate text from your camera in real time.",
                ),
                IconButton(
                  icon: const Icon(Icons.history),
                  onPressed: () {
                    Navigator.push(context, SwipeBackPageRoute(builder: (_) => const TranslationHistoryScreen()));
                  },
                )
              ],
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Cards
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildMinimalCard(
                    context: context,
                    isDark: isDark,
                    title: l10n?.travelInterpreter ?? "Travel Interpreter",
                    description: l10n?.realTimeSplitScreen ?? "Real-time split-screen conversation with a native speaker. Breaks down language barriers instantly.",
                    icon: Icons.people_outline,
                    onTap: () {
                      HapticsManager.medium();
                      Navigator.push(context, SwipeBackPageRoute(builder: (_) => const TravelInterpreterScreen()));
                    },
                  ),

                  const SizedBox(height: 32),
                  _buildMinimalCard(
                    context: context,
                    isDark: isDark,
                    title: "Universal Scanner",
                    description: "Point your camera at real-world objects or text to instantly extract and translate Chinese characters.",
                    icon: Icons.document_scanner_outlined,
                    onTap: () {
                      HapticsManager.medium();
                      Navigator.push(context, SwipeBackPageRoute(builder: (_) => const UniversalScannerScreen(intent: CameraIntent.translationHub)));
                    },
                  ),
                  const SizedBox(height: 48),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimalCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.black.withValues(alpha: 0.03),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.03),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isDark ? Colors.white : Colors.black87, size: 28),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark ? Colors.white60 : Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
