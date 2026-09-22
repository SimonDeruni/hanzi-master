import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dictionary_screen.dart';
import 'package:hanzi_master/features/progression/presentation/screens/dashboard_screen.dart';
import 'package:hanzi_master/features/chat/presentation/screens/ai_hub_screen.dart';
import 'package:hanzi_master/features/explore/presentation/screens/explore_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/widget_service.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _selectedIndex = widgetWordSearch.value == null ? 0 : 3;

  void _openWidgetWord() {
    if (widgetWordSearch.value != null && mounted) {
      setState(() => _selectedIndex = 3);
    }
  }

  void _onNavigate(int index) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedIndex = index;
    });

    final l10n = AppLocalizations.of(context);
    final screenNames = [
      l10n?.dashboardTitle ?? 'Dashboard',
      l10n?.explore ?? 'Explore',
      l10n?.aiHubTitle ?? 'AI Hub',
      l10n?.libraryLabel ?? 'Library',
    ];
    if (index >= 0 && index < screenNames.length) {
      ref.read(analyticsServiceProvider).logScreenView(screenNames[index]);
    }
  }

  late final List<Widget> _screens = [
    DashboardScreen(onNavigate: _onNavigate),
    const ExploreScreen(),
    const AiHubScreen(),
    const DictionaryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    widgetWordSearch.addListener(_openWidgetWord);
    // Log the initial screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      ref
          .read(analyticsServiceProvider)
          .logScreenView(l10n?.dashboardTitle ?? 'Dashboard');
    });
  }

  @override
  void dispose() {
    widgetWordSearch.removeListener(_openWidgetWord);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flashcardsState = ref.watch(flashcardControllerProvider);

    if (flashcardsState.isLoading && flashcardsState.valueOrNull == null) {
      return const Scaffold(
        body: CalligraphyBackground(
          child: Center(
            child: ZenLoader(color: Colors.brown),
          ),
        ),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: List.generate(_screens.length, (index) {
          final isActive = index == _selectedIndex;
          return _KeepAliveTab(
            key: ValueKey(index),
            isActive: isActive,
            child: _screens[index],
          );
        }),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceOf(context),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            HapticsManager.light();
            _onNavigate(index);
          },
          backgroundColor: AppTheme.surfaceOf(context),
          selectedItemColor: AppTheme.accentFire,
          unselectedItemColor: isDark
              ? AppTheme.carbonInkDark.withValues(alpha: 0.4)
              : const Color(0xFF1A1A1B).withValues(alpha: 0.5),
          showUnselectedLabels: true,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label:
                  AppLocalizations.of(context)?.dashboardTitle ?? 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              activeIcon: const Icon(Icons.explore),
              label: AppLocalizations.of(context)?.explore ?? 'Explore',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.auto_awesome_outlined),
              activeIcon: const Icon(Icons.auto_awesome),
              label: AppLocalizations.of(context)?.aiHubTitle ?? 'AI Hub',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu_book_outlined),
              activeIcon: const Icon(Icons.menu_book),
              label: AppLocalizations.of(context)?.libraryLabel ?? 'Library',
            ),
          ],
        ),
      ),
    );
  }
}

/// Keeps a tab screen alive and cross-fades it in/out via [AnimatedOpacity].
class _KeepAliveTab extends StatefulWidget {
  const _KeepAliveTab({
    super.key,
    required this.child,
    required this.isActive,
  });
  final Widget child;
  final bool isActive;

  @override
  State<_KeepAliveTab> createState() => _KeepAliveTabState();
}

class _KeepAliveTabState extends State<_KeepAliveTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedOpacity(
      duration: ZenMotion.of(context, ZenMotion.swap),
      curve: ZenMotion.natural,
      opacity: widget.isActive ? 1.0 : 0.0,
      child: IgnorePointer(
        ignoring: !widget.isActive,
        child: widget.child,
      ),
    );
  }
}
