import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/travel_interpreter_screen.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/translation_history_screen.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';

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
                IconButton(
                  icon: const Icon(Icons.history),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TranslationHistoryScreen()));
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
                  _buildPremiumCard(
                    context: context,
                    title: l10n?.travelInterpreter ?? "Travel Interpreter",
                    description: l10n?.realTimeSplitScreen ?? "Real-time split-screen conversation with a native speaker. Breaks down language barriers instantly.",
                    icon: Icons.people_alt,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TravelInterpreterScreen()));
                    },
                  ),

                  const SizedBox(height: 24),
                  _buildPremiumCard(
                    context: context,
                    title: "Universal Scanner",
                    description: "Point your camera at real-world objects or text to instantly extract and translate Chinese characters.",
                    icon: Icons.document_scanner,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const UniversalScannerScreen()));
                    },
                  ),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.last.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
