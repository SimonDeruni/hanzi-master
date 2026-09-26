import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

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

    return Scaffold(
      backgroundColor: AppTheme.surfaceOf(context),
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
                  color: isDark ? AppTheme.cardBgDark : AppTheme.cardBgLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.06),
                  ),
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
        duration: ZenMotion.of(context, ZenMotion.quick),
        curve: ZenMotion.natural,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppTheme.accentDark : AppTheme.accentLight)
                  .withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: isSelected
              ? Border.all(
                  color: isDark ? AppTheme.accentDark : AppTheme.accentLight,
                  width: 1.3,
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
                  ? (isDark ? AppTheme.accentDark : AppTheme.accentLight)
                  : (isDark ? Colors.white54 : Colors.black38),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? (isDark ? AppTheme.accentDark : AppTheme.accentLight)
                    : (isDark ? Colors.white54 : Colors.black38),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
