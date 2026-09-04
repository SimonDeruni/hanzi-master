import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/shared/widgets/quick_look_positioning.dart';

void main() {
  test('positions below an anchor in the upper half', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 900),
      safePadding: EdgeInsets.zero,
      anchorRect: const Rect.fromLTWH(380, 100, 40, 30),
    );

    expect(layout, isNotNull);
    expect(layout!.isAboveAnchor, isFalse);
    expect(layout.top, 138);
  });

  test('positions above an anchor near the bottom', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 900),
      safePadding: EdgeInsets.zero,
      anchorRect: const Rect.fromLTWH(380, 760, 40, 30),
    );

    expect(layout, isNotNull);
    expect(layout!.isAboveAnchor, isTrue);
    expect(layout.top + layout.maxHeight, 752);
  });

  test('clamps the popover inside horizontal safe margins', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(600, 900),
      safePadding: const EdgeInsets.only(left: 20, right: 10),
      anchorRect: const Rect.fromLTWH(0, 100, 20, 20),
    );

    expect(layout, isNotNull);
    expect(layout!.left, 32);
    expect(layout.left + layout.width, lessThanOrEqualTo(578));
  });

  test('falls back for large accessibility text', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 900),
      safePadding: EdgeInsets.zero,
      anchorRect: const Rect.fromLTWH(380, 100, 40, 30),
      textScaleFactor: 1.5,
    );

    expect(layout, isNull);
  });

  test('falls back when neither side has enough vertical room', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 500),
      safePadding: EdgeInsets.zero,
      anchorRect: const Rect.fromLTWH(380, 235, 40, 30),
    );

    expect(layout, isNull);
  });
}
