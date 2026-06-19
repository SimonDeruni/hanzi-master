import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/stats_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/settings_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/streak_seal.dart';
import 'package:hanzi_master/features/premium/presentation/screens/paywall_sheet.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';

class GlobalSliverAppBar extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  
  const GlobalSliverAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return SliverAppBar(
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.95),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      expandedHeight: subtitle != null ? 160 : 120,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 24, bottom: subtitle != null ? 48 : 16),
        title: Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
        background: subtitle != null 
            ? Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 24, bottom: 16, right: 80), // right padding to avoid actions overlap if needed, though they fade
                child: Text(
                  subtitle!,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDark ? Colors.white70 : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : null,
      ),
      actions: [
        if (actions != null) ...actions!,
        Consumer(
          builder: (context, ref, child) {
            final isPremium = ref.watch(premiumControllerProvider).valueOrNull ?? false;
            return Row(
              children: [
                if (isPremium)
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.workspace_premium, color: Colors.amber),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.workspace_premium_outlined, color: Colors.indigo),
                    onPressed: () => PaywallSheet.show(context),
                  ),
              ],
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.only(right: 8.0, top: 10, bottom: 10),
          child: StreakSeal(),
        ),
        IconButton(
          icon: const Icon(Icons.bar_chart),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StatsScreen())),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
        ),
      ],
    );
  }
}
