import 'dart:math' as math;

import 'package:flutter/widgets.dart';

@immutable
class QuickLookPopoverLayout {
  final double left;
  final double? top;
  final double? bottom;
  final double width;
  final double maxHeight;
  final bool isAboveAnchor;

  const QuickLookPopoverLayout({
    required this.left,
    this.top,
    this.bottom,
    required this.width,
    required this.maxHeight,
    required this.isAboveAnchor,
  });
}

/// Returns a safe popover layout, or `null` when a bottom sheet is more usable.
QuickLookPopoverLayout? calculateQuickLookPopoverLayout({
  required Size viewportSize,
  required EdgeInsets safePadding,
  required Rect anchorRect,
  double textScaleFactor = 1,
}) {
  const viewportMargin = 12.0;
  const topMargin = 16.0;
  const bottomMargin = 16.0;
  const anchorGap = 8.0;
  const preferredWidth = 400.0;
  const minimumWidth = 280.0;
  const minimumHeight = 240.0;
  const preferredHeight = 520.0;

  if (textScaleFactor > 1.3 ||
      viewportSize.width < minimumWidth + viewportMargin * 2 ||
      !anchorRect.center.dx.isFinite ||
      !anchorRect.center.dy.isFinite) {
    return null;
  }

  final safeLeft = safePadding.left + viewportMargin;
  final safeRight = viewportSize.width - safePadding.right - viewportMargin;
  final safeTop = safePadding.top + topMargin;
  final safeBottom = viewportSize.height - safePadding.bottom - bottomMargin;
  final width = math.min(preferredWidth, safeRight - safeLeft);
  final belowHeight = safeBottom - anchorRect.bottom - anchorGap;
  final aboveHeight = anchorRect.top - anchorGap - safeTop;

  // Collision detection: pick direction with sufficient clearance
  bool useAbove;
  if (aboveHeight >= minimumHeight && belowHeight >= minimumHeight) {
    // Both directions have sufficient space:
    // If anchor is in upper 45% of viewport, spawn below to avoid crowding top/status bar;
    // otherwise spawn above the word.
    if (anchorRect.center.dy < viewportSize.height * 0.45) {
      useAbove = false;
    } else {
      useAbove = aboveHeight >= belowHeight;
    }
  } else if (belowHeight >= minimumHeight) {
    useAbove = false;
  } else if (aboveHeight >= minimumHeight) {
    useAbove = true;
  } else {
    return null;
  }

  if (width < minimumWidth) return null;

  final availableHeight = useAbove ? aboveHeight : belowHeight;
  final maxHeight = math.min(preferredHeight, availableHeight);
  final unclampedLeft = anchorRect.center.dx - width / 2;
  final left = unclampedLeft.clamp(safeLeft, safeRight - width).toDouble();

  // When above anchor, anchor to the bottom edge (just above the word)
  // so short/medium cards sit right on the word rather than shooting up to safeTop.
  // When below anchor, anchor to top edge (just below the word).
  final double? top = useAbove ? null : (anchorRect.bottom + anchorGap);
  final double? bottom = useAbove
      ? (viewportSize.height - (anchorRect.top - anchorGap))
      : null;

  return QuickLookPopoverLayout(
    left: left,
    top: top,
    bottom: bottom,
    width: width,
    maxHeight: maxHeight,
    isAboveAnchor: useAbove,
  );
}
