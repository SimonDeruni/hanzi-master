import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// The app's canonical horizontally-scrolling filter pill.
///
/// Extraction of the animated pill already used by the Deck Library
/// (`tome_manager_screen`). The Echo Hall and Media Hub filters previously used
/// `ChoiceChip`, whose colour and label-style swaps snap in a single frame — so
/// the same interaction felt inconsistent between screens. All three now share
/// this widget, so selection always eases over the same 180ms.
///
/// Honours the platform "Reduce Motion" setting by dropping the tween.
class ZenFilterPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  /// Unselected background; defaults to the active card colour.
  final Color? background;

  const ZenFilterPill({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    this.background,
  });

  /// Duration used when motion is permitted; sourced from [ZenMotion.swap].
  static const Duration animationDuration = ZenMotion.swap;

  @override
  Widget build(BuildContext context) {
    final cardBg = background ??
        (isDark ? const Color(0xFF242426) : Colors.white);
    final selectedBg =
        isDark ? Colors.amber.shade700 : const Color(0xFF2C2C2E);

    return GestureDetector(
      onTap: () {
        HapticsManager.light();
        onTap();
      },
      child: AnimatedContainer(
        // Reduced motion collapses the transition to an instant swap.
        duration: context.reduceMotion ? Duration.zero : animationDuration,
        curve: ZenMotion.enter,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? Colors.white12 : Colors.black12),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.white70 : Colors.black87),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }
}
