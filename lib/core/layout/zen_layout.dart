import 'package:flutter/widgets.dart';

/// The five Material-3 window size classes, as defined in
/// `docs/IPAD_ADAPTIVE_PLAN.md` (F3).
///
/// Every adaptive branch in the app reads one of these instead of comparing
/// `MediaQuery` sizes inline, so "what is a tablet?" has exactly one answer.
enum ZenWindowClass {
  /// `< 600dp` — phones, iPhone landscape.
  compact,

  /// `600-839dp` — iPad mini/Air portrait, Split View half, Android tablets.
  medium,

  /// `840-1199dp` — iPad Air/Pro portrait, iPad landscape.
  expanded,

  /// `1200-1599dp` — iPad Pro 12.9" portrait, Stage Manager.
  large,

  /// `>= 1600dp` — iPad Pro landscape, external display.
  extraLarge,
}

/// Width bounds in logical pixels — the single source of truth for adaptivity.
///
/// Keep in sync with the table in `docs/IPAD_ADAPTIVE_PLAN.md`; the guard test
/// (`test/core/adaptive_layout_guard_test.dart`) keeps screens honest.
abstract final class ZenBreakpoints {
  static const double compactMax = 600;
  static const double mediumMax = 840;
  static const double expandedMax = 1200;
  static const double largeMax = 1600;

  /// Shortest logical side at which a window counts as a tablet. iPad mini
  /// portrait is 744dp, so it qualifies; no phone does.
  static const double tabletShortestSide = 600;

  static ZenWindowClass classify(double width) {
    if (width < compactMax) return ZenWindowClass.compact;
    if (width < mediumMax) return ZenWindowClass.medium;
    if (width < expandedMax) return ZenWindowClass.expanded;
    if (width < largeMax) return ZenWindowClass.large;
    return ZenWindowClass.extraLarge;
  }
}

/// Content caps per surface kind (F3).
///
/// These cap the *measure* — the line length a reader has to track — never the
/// box that holds the text. Leaving a surface uncapped is correct for
/// dashboards, grids and canvases.
abstract final class ZenContentWidth {
  /// Body copy: 680dp ≈ the 60-75 characters that stay readable.
  static const double reading = 680;

  /// One page of a two-page spread.
  static const double readingColumn = 620;

  /// Long-form article inside a scroll view.
  static const double article = 720;

  /// A form or settings pane.
  static const double form = 560;

  /// A modal dialog / form sheet.
  static const double overlay = 640;

  /// A study surface (flashcard, quiz).
  static const double study = 720;

  /// Onboarding and auth cards.
  static const double centering = 480;
}

/// A snapshot of the window, resolved once per build.
@immutable
class ZenWindow {
  const ZenWindow(this.size);

  /// Width/height in logical pixels.
  final Size size;

  factory ZenWindow.of(BuildContext context) =>
      ZenWindow(MediaQuery.sizeOf(context));

  ZenWindowClass get windowClass => ZenBreakpoints.classify(size.width);

  bool get isCompact => windowClass == ZenWindowClass.compact;
  bool get isMedium => windowClass == ZenWindowClass.medium;
  bool get isAtLeastMedium => size.width >= ZenBreakpoints.compactMax;
  bool get isExpanded => size.width >= ZenBreakpoints.mediumMax;
  bool get isAtLeastLarge => size.width >= ZenBreakpoints.expandedMax;

  /// Landscape is about the window, not the device — a Split View pane can be
  /// tall and narrow even on a 13" iPad.
  bool get isLandscape => size.width > size.height;

  /// True for iPad-class windows, in either orientation.
  bool get isTablet => size.shortestSide >= ZenBreakpoints.tabletShortestSide;

  /// Screen gutter that steps with the window class (16 → 24 → 32).
  double get gutter => switch (windowClass) {
        ZenWindowClass.compact => 16,
        ZenWindowClass.medium => 24,
        ZenWindowClass.expanded => 24,
        ZenWindowClass.large => 32,
        ZenWindowClass.extraLarge => 32,
      };

  /// The navigation chrome to use: a bottom bar on phones, a rail on tablets.
  /// Medium (600-839dp) is a Split-View half on iPad, where a rail still wins
  /// because it leaves the full width to content.
  bool get useNavigationRail => isAtLeastMedium;

  /// Whether a list+detail layout has room. `ZenTwoPaneScaffold` itself falls
  /// back to a single pane when the detail would be squeezed, so this is only
  /// the first gate.
  bool get useTwoPane => isAtLeastMedium;

  @override
  bool operator ==(Object other) => other is ZenWindow && other.size == size;

  @override
  int get hashCode => size.hashCode;

  @override
  String toString() => 'ZenWindow(${size.width.toInt()}x'
      '${size.height.toInt()}, ${windowClass.name})';
}

/// Ergonomic accessors: `context.isTabletWindow`, `context.zenGutter`, …
extension ZenWindowContext on BuildContext {
  ZenWindow get zenWindow => ZenWindow.of(this);
  ZenWindowClass get zenWindowClass => zenWindow.windowClass;
  bool get isCompactWindow => zenWindow.isCompact;
  bool get isTabletWindow => zenWindow.isTablet;
  bool get isLandscapeWindow => zenWindow.isLandscape;
  bool get useNavigationRail => zenWindow.useNavigationRail;
  double get zenGutter => zenWindow.gutter;
}

/// Picks a value per window class, falling back to the next smaller one:
/// `zenValue(context, compact: 1, medium: 2, expanded: 3)`.
T zenValue<T>(
  BuildContext context, {
  required T compact,
  T? medium,
  T? expanded,
  T? large,
  T? extraLarge,
}) {
  final ZenWindowClass windowClass = ZenWindow.of(context).windowClass;
  return switch (windowClass) {
    ZenWindowClass.compact => compact,
    ZenWindowClass.medium => medium ?? compact,
    ZenWindowClass.expanded => expanded ?? medium ?? compact,
    ZenWindowClass.large => large ?? expanded ?? medium ?? compact,
    ZenWindowClass.extraLarge =>
      extraLarge ?? large ?? expanded ?? medium ?? compact,
  };
}

/// Centres [child] and caps its width so text keeps a readable measure.
///
/// Replaces the one-off `maxWidth:` sites (F3): a cap belongs to the *surface
/// kind*, not to a screen, so it lives here.
class ZenContentPane extends StatelessWidget {
  const ZenContentPane({
    super.key,
    required this.child,
    this.maxWidth = ZenContentWidth.article,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;

  /// `null` = uncapped (dashboards, grids, canvases).
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final ZenWindow window = ZenWindow.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: maxWidth == null
            ? const BoxConstraints()
            : BoxConstraints(maxWidth: maxWidth!),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: window.gutter),
          child: child,
        ),
      ),
    );
  }
}

/// Density-driven grid delegates (F7) — the column count follows the width.
///
/// `maxCrossAxisExtent` replaces the old fixed column count: same look on a
/// phone (pass `maxTileWidth` ≈ phone-content-width / original-column-count),
/// but the count then grows with the window instead of staying stuck at 2-4.
///
/// Keep `childAspectRatio` unless a tile declares how its text degrades — a
/// fixed [tileHeight] is a fixed height around text, which is exactly what
/// clips localized labels (see the locale layout guards).
abstract final class ZenGrid {
  /// Glyph/word tiles.
  static SliverGridDelegateWithMaxCrossAxisExtent tiles({
    double maxTileWidth = 200,
    double childAspectRatio = 1,
    double? tileHeight,
    double spacing = 12,
    double? crossSpacing,
    double? mainSpacing,
  }) =>
      _delegate(
        maxExtent: maxTileWidth,
        childAspectRatio: childAspectRatio,
        height: tileHeight,
        spacing: spacing,
        crossSpacing: crossSpacing,
        mainSpacing: mainSpacing,
      );

  /// Book/story covers: taller rows, narrower tiles.
  static SliverGridDelegateWithMaxCrossAxisExtent covers({
    double maxCoverWidth = 180,
    double childAspectRatio = 0.6,
    double? coverHeight,
    double spacing = 16,
    double? crossSpacing,
    double? mainSpacing,
  }) =>
      _delegate(
        maxExtent: maxCoverWidth,
        childAspectRatio: childAspectRatio,
        height: coverHeight,
        spacing: spacing,
        crossSpacing: crossSpacing,
        mainSpacing: mainSpacing,
      );

  /// Media/video cards (16:9 plus a caption line).
  static SliverGridDelegateWithMaxCrossAxisExtent media({
    double maxCardWidth = 320,
    double childAspectRatio = 1.4,
    double? cardHeight,
    double spacing = 16,
    double? crossSpacing,
    double? mainSpacing,
  }) =>
      _delegate(
        maxExtent: maxCardWidth,
        childAspectRatio: childAspectRatio,
        height: cardHeight,
        spacing: spacing,
        crossSpacing: crossSpacing,
        mainSpacing: mainSpacing,
      );

  static SliverGridDelegateWithMaxCrossAxisExtent _delegate({
    required double maxExtent,
    required double childAspectRatio,
    required double? height,
    required double spacing,
    required double? crossSpacing,
    required double? mainSpacing,
  }) {
    final double cross = crossSpacing ?? spacing;
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: maxExtent + cross,
      // Ignored by the framework when `mainAxisExtent` is set.
      childAspectRatio: childAspectRatio,
      mainAxisExtent: height,
      crossAxisSpacing: cross,
      mainAxisSpacing: mainSpacing ?? spacing,
    );
  }
}
