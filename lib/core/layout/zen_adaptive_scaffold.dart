import 'package:flutter/material.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';

/// One destination of the app shell (F4 of `docs/IPAD_ADAPTIVE_PLAN.md`).
@immutable
class ZenDestination {
  const ZenDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  /// Every label is the localized string — never a hardcoded English one.
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// Tablets get a rail instead of the phone's bottom bar.
///
/// Rendered *beside* the content (the caller owns the body), so a 12.9" iPad
/// does not waste a full-width strip at the bottom of the screen. Labels are
/// always shown, which also removes the bottom bar's localized-label overflow
/// class of bugs on wide screens.
class ZenNavigationRail extends StatelessWidget {
  const ZenNavigationRail({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.footer,
    this.backgroundColor,
  });

  final List<ZenDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  /// Pinned to the bottom of the rail — the natural home for the Now Playing
  /// transport or a profile chip.
  final Widget? footer;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final ZenWindow window = ZenWindow.of(context);
    final bool extended = window.isExpanded;
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      extended: extended,
      minExtendedWidth: 180,
      labelType:
          extended ? NavigationRailLabelType.none : NavigationRailLabelType.all,
      backgroundColor: backgroundColor,
      // A rail is a *vertical* stack of localized labels: at 2x text scale in a
      // 320dp-tall landscape window four destinations do not fit. `scrollable`
      // lets the group scroll instead of overflowing, and `trailingAtBottom`
      // keeps the footer pinned after a `Flexible` so it cannot be pushed out
      // either. (Both found by test/core/ipad_layout_sweep_test.dart.)
      scrollable: true,
      trailingAtBottom: true,
      trailing: footer == null
          ? null
          : Padding(
              padding: EdgeInsets.only(bottom: window.isAtLeastLarge ? 24 : 12),
              child: footer,
            ),
      destinations: <NavigationRailDestination>[
        for (final ZenDestination destination in destinations)
          NavigationRailDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            // A rail label is a localized string in a 180dp column: let it
            // ellipsize rather than overflow the rail (locale guard rules).
            label: Text(
              destination.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
