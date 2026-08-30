import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class AiHubScreen extends ConsumerStatefulWidget {
  final int initialTabIndex;

  const AiHubScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  ConsumerState<AiHubScreen> createState() => _AiHubScreenState();
}

class _AiHubScreenState extends ConsumerState<AiHubScreen> {
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
            // ── Segmented tab switcher (Matching Explore Screen) ───
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
                    Expanded(
                      child: _buildSegmentTab(
                        index: 0,
                        icon: Icons.forum_rounded,
                        label: AppLocalizations.of(context)!.roleplay,
                        isSelected: _selectedTab == 0,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: _buildSegmentTab(
                        index: 1,
                        icon: Icons.graphic_eq_rounded,
                        label: AppLocalizations.of(context)!.shadowing,
                        isSelected: _selectedTab == 1,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Main content area (IndexedStack to preserve state) ───
            Expanded(
              child: IndexedStack(
                index: _selectedTab,
                children: const [
                  ScenarioSelectionScreen(showBackButton: false),
                  ShadowingStudioScreen(showBackButton: false),
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
