import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_hub_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_search_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/show_catalog_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_catalog_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  final int initialTabIndex;

  const ExploreScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- Segmented tab switcher (Matching AI Hub style) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Container(
                height: 52,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2C2C2E)
                      : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    // TAB 0: BOOKS
                    Expanded(
                      child: _buildSegmentTab(
                        index: 0,
                        icon: Icons.menu_book_rounded,
                        label: AppLocalizations.of(context)!.books,
                        isSelected: _selectedTab == 0,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 2),
                    // TAB 1: WEB
                    Expanded(
                      child: _buildSegmentTab(
                        index: 1,
                        icon: Icons.language_rounded,
                        label: AppLocalizations.of(context)!.web,
                        isSelected: _selectedTab == 1,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 2),
                    // TAB 2: SHOWS
                    Expanded(
                      child: _buildSegmentTab(
                        index: 2,
                        icon: Icons.live_tv_rounded,
                        label: AppLocalizations.of(context)!.shows,
                        isSelected: _selectedTab == 2,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 2),
                    // TAB 3: VIDEO
                    Expanded(
                      child: _buildSegmentTab(
                        index: 3,
                        icon: Icons.smart_display_rounded,
                        label: AppLocalizations.of(context)!.video,
                        isSelected: _selectedTab == 3,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- MAIN CONTENT AREA (INDEXED STACK TO PRESERVE STATE) ---
            Expanded(
              child: IndexedStack(
                index: _selectedTab,
                children: const [
                  BookCatalogScreen(showBackButton: false),
                  MediaHubScreen(showBackButton: false),
                  ShowCatalogScreen(),
                  MediaSearchScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentTab({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () {
        if (_selectedTab != index) {
          HapticsManager.selection();
          setState(() => _selectedTab = index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutQuart,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFB300).withValues(alpha: isDark ? 0.25 : 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFFFFB300).withValues(alpha: 0.4),
                  width: 1,
                )
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? const Color(0xFFFFB300)
                  : (isDark ? Colors.white54 : Colors.black38),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? (isDark ? const Color(0xFFFFD54F) : const Color(0xFF1A1A1B))
                    : (isDark ? Colors.white54 : Colors.black38),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
