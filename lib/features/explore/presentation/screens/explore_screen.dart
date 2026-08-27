import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_hub_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_catalog_screen.dart';

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
    final topBarBg = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- TOP SEGMENTED PILL SWITCHER (MATCHING DESIGN) ---
            Container(
              color: topBarBg,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFFF7A00),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? Colors.black : const Color(0xFFFF7A00)).withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // TAB 0: READING ROOM (藏书阁)
                    Expanded(
                      child: _buildTabPill(
                        index: 0,
                        title: '📖 Reading Room',
                        subtitle: '96 Full Books',
                        isSelected: _selectedTab == 0,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 4),
                    // TAB 1: WEB EXPLORER (网络探索 / 媒体中心)
                    Expanded(
                      child: _buildTabPill(
                        index: 1,
                        title: '🌐 Web Explorer',
                        subtitle: 'Live Reader',
                        isSelected: _selectedTab == 1,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPill({
    required int index,
    required String title,
    required String subtitle,
    required bool isSelected,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () {
        if (_selectedTab != index) {
          HapticsManager.selection();
          setState(() {
            _selectedTab = index;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF3A3A3C) : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? (isDark ? Colors.white : const Color(0xFF1A1A1B))
                    : (isDark ? Colors.white70 : Colors.white),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
