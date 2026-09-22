import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/profile_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

class GlobalSliverAppBar extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showBackButton;
  
  const GlobalSliverAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return SliverAppBar(
      automaticallyImplyLeading: showBackButton,
      // Canonical surface so the header never differs from the body beneath it.
      backgroundColor: AppTheme.surfaceOf(context),
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      pinned: true,
      centerTitle: false,
      toolbarHeight: 72,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: 'Serif',
                color: isDark ? Colors.white : Colors.black87,
                letterSpacing: 0.5,
                fontSize: 28,
              ),
            ),
          ),
          if (subtitle != null)
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
        ],
      ),
      actions: [
        if (actions != null) ...actions!,
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () => Navigator.push(context, SwipeBackPageRoute(builder: (context) => const ProfileScreen())),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              child: Icon(
                Icons.person_outline,
                size: 20,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
