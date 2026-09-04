import 'dart:math' as math;

import 'package:flutter/widgets.dart';

@immutable
class QuickLookPopoverLayout {
  final double left;
  final double top;
  final double width;
  final double maxHeight;
  final bool isAboveAnchor;

  const QuickLookPopoverLayout({
    required this.left,
    required this.top,
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
  const anchorGap = 8.0;
  const preferredWidth = 400.0;
  const minimumWidth = 280.0;
  const minimumHeight = 260.0;
  const preferredHeight = 520.0;

  if (textScaleFactor > 1.3 ||
      viewportSize.width < minimumWidth + viewportMargin * 2 ||
      !anchorRect.center.dx.isFinite ||
      !anchorRect.center.dy.isFinite) {
    return null;
  }

  final safeLeft = safePadding.left + viewportMargin;
  final safeRight = viewportSize.width - safePadding.right - viewportMargin;
  final safeTop = safePadding.top + viewportMargin;
  final safeBottom = viewportSize.height - safePadding.bottom - viewportMargin;
  final width = math.min(preferredWidth, safeRight - safeLeft);
  final belowHeight = safeBottom - anchorRect.bottom - anchorGap;
  final aboveHeight = anchorRect.top - anchorGap - safeTop;
  final useAbove = aboveHeight > belowHeight;
  final availableHeight = useAbove ? aboveHeight : belowHeight;

  if (width < minimumWidth || availableHeight < minimumHeight) return null;

  final maxHeight = math.min(preferredHeight, availableHeight);
  final unclampedLeft = anchorRect.center.dx - width / 2;
  final left = unclampedLeft.clamp(safeLeft, safeRight - width).toDouble();
  final top = useAbove
      ? anchorRect.top - anchorGap - maxHeight
      : anchorRect.bottom + anchorGap;

  return QuickLookPopoverLayout(
    left: left,
    top: top,
    width: width,
    maxHeight: maxHeight,
    isAboveAnchor: useAbove,
  );
}
