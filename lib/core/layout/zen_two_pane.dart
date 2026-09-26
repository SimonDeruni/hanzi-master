import 'package:flutter/material.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';

/// A list pane beside a detail pane — the single biggest iPad win for a browse
/// app, and the reason `Navigator.push` needs a companion (F4 of
/// `docs/IPAD_ADAPTIVE_PLAN.md`).
///
/// **Usage rule:** the *caller* keeps its existing compact flow. A screen adopts
/// this by branching once:
///
/// ```dart
/// if (!context.zenWindow.useTwoPane) {
///   return _ExistingPhoneLayout(); // push/pop, byte-for-byte unchanged
/// }
/// return ZenTwoPaneScaffold(
///   listPane: _ResultList(onSelected: (word) => setState(() => _selected = word)),
///   detailPane: _selected == null ? null : _Definition(word: _selected!),
///   emptyDetail: const _NothingSelected(),
/// );
/// ```
///
/// Two safety rails, because a Split View half can be much narrower than the
/// device: the detail pane is never allowed below [detailMinWidth], and below
/// that the list simply takes the whole window.
class ZenTwoPaneScaffold extends StatelessWidget {
  const ZenTwoPaneScaffold({
    super.key,
    required this.listPane,
    required this.emptyDetail,
    this.detailPane,
    this.listPaneWidth,
    this.backgroundColor,
  });

  /// Always visible on the leading side.
  final Widget listPane;

  /// `null` when nothing is selected.
  final Widget? detailPane;

  /// Shown in the detail position when [detailPane] is null — an instruction,
  /// not an error ("Select a word to see its definition").
  final Widget emptyDetail;

  /// Defaults to 300dp at medium and 340dp at expanded.
  final double? listPaneWidth;

  final Color? backgroundColor;

  /// Never squeeze the detail pane below this, whatever the window says.
  static const double detailMinWidth = 320;

  @override
  Widget build(BuildContext context) {
    final ZenWindow window = ZenWindow.of(context);
    final double requested = listPaneWidth ?? (window.isExpanded ? 340 : 300);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Too tight for two panes (a narrow Split View slice, or a rotation in
        // flight): degrade to the list alone rather than crush both.
        if (window.isAtLeastMedium == false ||
            constraints.maxWidth - requested < detailMinWidth) {
          return listPane;
        }
        return ColoredBox(
          color: backgroundColor ?? Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(width: requested, child: listPane),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(
                child: detailPane ?? emptyDetail,
              ),
            ],
          ),
        );
      },
    );
  }
}
