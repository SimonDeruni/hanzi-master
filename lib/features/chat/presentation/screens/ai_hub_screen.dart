import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_library_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_hub_screen.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';

class AiHubScreen extends ConsumerWidget {
  const AiHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: CalligraphyBackground(
        child: CustomScrollView(
          slivers: [
            // --- STANDARD HEADER ---
            GlobalSliverAppBar(
              title: l10n?.aiHubTitle ?? "AI Hub",
            ),

            // Feature Rows
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Row 1: AI Scenarios & Web Explorer
                    Row(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: _buildListActionCard(
                              context: context,
                              isDark: isDark,
                              title: "Roleplay",
                              subtitle: "AI avatars",
                              icon: Icons.auto_awesome,
                              accentColor: const Color(0xFF9C27B0), // Purple
                              onTap: () {
                                HapticsManager.medium();
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    SwipeBackPageRoute(
                                        builder: (_) => const ScenarioSelectionScreen()),
                                  );
                                }
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
                              title: "Web Explorer",
                              subtitle: "Read the web",
                              icon: Icons.language,
                              accentColor: const Color(0xFF1976D2), // Blue
                              onTap: () {
                                HapticsManager.medium();
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    SwipeBackPageRoute(builder: (_) => const MediaHubScreen()),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Row 2: Reading Room & Shadowing
                    Row(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: _buildListActionCard(
                              context: context,
                              isDark: isDark,
                              title: "Reading Room",
                              subtitle: "Classic literature",
                              icon: Icons.auto_stories,
                              accentColor: const Color(0xFFFF8F00), // Amber
                              onTap: () {
                                HapticsManager.medium();
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    SwipeBackPageRoute(builder: (_) => const StoryLibraryScreen()),
                                  );
                                }
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
                              title: "Shadowing",
                              subtitle: "Perfect pronunciation",
                              icon: Icons.mic,
                              accentColor: const Color(0xFF009688), // Teal
                              onTap: () {
                                HapticsManager.medium();
                                Navigator.push(
                                  context,
                                  SwipeBackPageRoute(builder: (_) => const ShadowingStudioScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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

  Widget _buildSquareActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    String? imageAsset,
    bool isNew = false,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return BouncingButton(
      scaleFactor: 0.97,
      onPressed: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon container
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 24,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE27C5A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "NEW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'NotoSerifSC',
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  height: 1.2,
                  fontSize: 11,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

