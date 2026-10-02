import 'package:flutter/material.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

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

/// A trailing-edge panel — the tablet form of a detail surface that belongs
/// *beside* the content rather than centred over it.
///
/// On a phone it is the familiar bottom sheet. At expanded (≥840dp) — an iPad in
/// either orientation — it slides in from the trailing edge as a full-height,
/// width-capped panel, so a "what do you want to do with this" chooser reads as a
/// side desk instead of a stretched phone sheet. A centred dialog ([zenDialog])
/// stays the right form for a plain form; the side panel is for surfaces whose
/// content the reader wants to keep in view while deciding.
Future<T?> zenSidePanel<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool dismissible = true,
  bool useRootNavigator = false,
  bool isScrollControlled = true,
  double width = 420,
}) {
  if (!ZenWindow.of(context).isExpanded) {
    // Phones (and a Split View half): the bottom sheet is still the idiom.
    return zenSheet<T>(
      context,
      builder: builder,
      isScrollControlled: isScrollControlled,
      dismissible: dismissible,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
    );
  }
  return showGeneralDialog<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: dismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withValues(alpha: 0.28),
    transitionDuration: ZenMotion.page,
    pageBuilder: (BuildContext dialogContext, _, __) => Row(
      children: <Widget>[
        const Spacer(),
        SizedBox(
          width: width,
          height: double.infinity,
          child: SafeArea(left: false, child: builder(dialogContext)),
        ),
      ],
    ),
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      final CurvedAnimation curved =
          CurvedAnimation(parent: animation, curve: ZenMotion.settle);
      // Reduced motion: cross-fade only, no travel.
      if (context.reduceMotion) {
        return FadeTransition(opacity: curved, child: child);
      }
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(curved),
        child: FadeTransition(opacity: curved, child: child),
      );
    },
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
