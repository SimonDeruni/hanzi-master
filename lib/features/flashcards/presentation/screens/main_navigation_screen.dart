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
import 'package:hanzi_master/core/services/analytics_service.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _selectedIndex = 0;

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
      l10n?.library ?? 'Library',
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
  Widget build(BuildContext context) {
    final flashcardsState = ref.watch(flashcardControllerProvider);

    if (flashcardsState.isLoading && flashcardsState.valueOrNull == null) {
      return const Scaffold(
        body: CalligraphyBackground(
          child: Center(
            child: CircularProgressIndicator(color: Colors.brown),
          ),
        ),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
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
          backgroundColor:
              isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
          selectedItemColor:
              isDark ? const Color(0xFFFF7A00) : const Color(0xFFFF7A00),
          unselectedItemColor: isDark
              ? const Color(0xFFFDFCF0).withValues(alpha: 0.4)
              : const Color(0xFF1A1A1B).withValues(alpha: 0.5),
          showUnselectedLabels: true,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: AppLocalizations.of(context)?.dashboardTitle ?? 'Dashboard',
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
              label: AppLocalizations.of(context)?.library ?? 'Library',
            ),
          ],
        ),
      ),
    );
  }
}
