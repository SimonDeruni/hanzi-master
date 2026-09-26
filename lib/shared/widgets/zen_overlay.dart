import 'package:flutter/material.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';

/// One entry point for every transient surface (F5 of
/// `docs/IPAD_ADAPTIVE_PLAN.md`).
///
/// Today the app opens **42** `showModalBottomSheet` surfaces. On an iPad a
/// full-width sheet at the bottom of a 1366dp window reads as a stretched
/// phone; the platform idiom is a form sheet / dialog. These helpers keep the
/// phone behaviour untouched and switch on the window class, so adoption is a
/// one-line change per call site:
///
/// ```dart
/// - await showModalBottomSheet<void>(context: context, builder: (c) => Body());
/// + await zenSheet<void>(context, builder: (c) => Body());
/// ```
///
/// Purely *anchored* choosers (a menu hanging off the control that opened it)
/// should use `PopupMenuButton`/`MenuAnchor` directly — that is the third
/// idiom in the plan.
Future<T?> zenSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool dismissible = true,
  bool scrollable = false,
  bool useSafeArea = true,
  bool? enableDrag,
  bool? showDragHandle,
  bool useRootNavigator = false,
  BoxConstraints? constraints,
  Color? backgroundColor,
  ShapeBorder? shape,
}) {
  if (ZenWindow.of(context).isExpanded) {
    // The tablet form: a width-capped dialog. The switch is at *expanded*
    // (≥840dp) on purpose — 600-839dp is a large phone or a Split View half,
    // where the bottom sheet is still the platform idiom. `constraints.maxWidth`
    // keeps the intent of call sites that sized their sheet.
    return zenDialog<T>(
      context,
      builder: builder,
      dismissible: dismissible,
      scrollable: scrollable,
      useRootNavigator: useRootNavigator,
      maxWidth: constraints?.maxWidth ?? ZenContentWidth.overlay,
    );
  }
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    isDismissible: dismissible,
    enableDrag: enableDrag ?? dismissible,
    showDragHandle: showDragHandle,
    useRootNavigator: useRootNavigator,
    constraints: constraints,
    backgroundColor: backgroundColor,
    shape: shape,
    builder: builder,
  );
}

/// A centred, width-capped dialog — the tablet form of [zenSheet].
Future<T?> zenDialog<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool dismissible = true,
  bool scrollable = false,
  bool useRootNavigator = false,
  double maxWidth = ZenContentWidth.overlay,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: dismissible,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext dialogContext) => ZenOverlayFrame(
      maxWidth: maxWidth,
      scrollable: scrollable,
      child: builder(dialogContext),
    ),
  );
}

/// A small chooser (tone, app language, deck, voice, study mode).
///
/// Narrower than a form: 420dp on tablets, the usual sheet on phones.
Future<T?> zenPicker<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool dismissible = true,
}) {
  if (ZenWindow.of(context).isExpanded) {
    return zenDialog<T>(
      context,
      builder: builder,
      dismissible: dismissible,
      scrollable: true,
      maxWidth: 420,
    );
  }
  return showModalBottomSheet<T>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    isDismissible: dismissible,
    enableDrag: dismissible,
    builder: builder,
  );
}

/// The shared frame behind [zenDialog]: themed, inset, width-capped and never
/// taller than the window (a 12.9" iPad in landscape has room, a Split View
/// half does not).
class ZenOverlayFrame extends StatelessWidget {
  const ZenOverlayFrame({
    super.key,
    required this.child,
    this.maxWidth = ZenContentWidth.overlay,
    this.scrollable = false,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final double maxWidth;

  /// Wraps the child in a scroll view — use it for anything that can grow with
  /// a translation or a larger text scale.
  final bool scrollable;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final ZenWindow window = ZenWindow.of(context);
    Widget content = Padding(padding: padding, child: child);
    if (scrollable) {
      content = SingleChildScrollView(child: content);
    }
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: window.isCompact ? 24 : window.gutter,
        vertical: 24,
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: window.size.height * 0.85,
        ),
        child: content,
      ),
    );
  }
}
