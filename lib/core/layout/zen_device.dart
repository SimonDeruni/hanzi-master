import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';

/// Device class and orientation policy — F2 of `docs/IPAD_ADAPTIVE_PLAN.md`.
///
/// The app used to force portrait in `main()` for every device, which pinned an
/// iPad to a phone-shaped column and fought landscape readers. The policy is now:
///
/// * **phones** → portrait only (unchanged behaviour),
/// * **tablets** → all four orientations, so landscape and Split View work.
///
/// Screens that genuinely need a fixed orientation (camera capture, calligraphy
/// capture) ask through [ZenOrientationLock] and release it in `dispose`.
abstract final class ZenDevice {
  /// True when the running window is tablet-sized.
  ///
  /// Deliberately reads the platform view rather than a `BuildContext` so it can
  /// be used from `main()` before the first frame.
  static bool get isTabletWindow {
    final views = WidgetsBinding.instance.platformDispatcher.views;
    if (views.isEmpty) return false;
    final view = views.first;
    final double ratio =
        view.devicePixelRatio == 0 ? 1.0 : view.devicePixelRatio;
    return view.physicalSize.shortestSide / ratio >=
        ZenBreakpoints.tabletShortestSide;
  }

  /// Applies the startup orientation policy (call from `main()`).
  static Future<void> applyStartupOrientation() =>
      isTabletWindow ? allowAllOrientations() : lockPortrait();

  /// Re-applies the startup policy; used when a locked route pops.
  static Future<void> restoreDefaultOrientation() => applyStartupOrientation();

  /// Portrait only — phones, and tablet camera/canvas routes.
  static Future<void> lockPortrait() =>
      SystemChrome.setPreferredOrientations(const <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

  /// Defers to the system (an empty list means "no preference").
  static Future<void> allowAllOrientations() =>
      SystemChrome.setPreferredOrientations(const <DeviceOrientation>[]);
}

/// A route-scoped orientation lock that restores the device policy when the
/// route pops.
///
/// Reference-counted, because a sheet can be pushed on top of a camera route.
/// On tablets [portraitForCapture] is a no-op: the capture screens are two-pane
/// in landscape instead of forcing a rotation (see the plan, screens #71/#44).
abstract final class ZenOrientationLock {
  static int _depth = 0;

  /// True while at least one route holds a lock.
  static bool get isLocked => _depth > 0;

  static Future<void> portraitForCapture() async {
    _depth++;
    if (ZenDevice.isTabletWindow) return;
    await ZenDevice.lockPortrait();
  }

  /// Releases one lock; the last release restores the device policy.
  static Future<void> release() async {
    if (_depth > 0) _depth--;
    if (_depth > 0) return;
    await ZenDevice.restoreDefaultOrientation();
  }
}
