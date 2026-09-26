import 'package:flutter/material.dart';

import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// Canonical motion vocabulary for the "Zen & Ink" aesthetic.
///
/// Every animation in the app must source its duration and curve from here.
/// `docs/UI_UX_STANDARDS.md` mandates a "natural brush" feel, and scattered
/// literals are how that drifts screen by screen: before this class there were
/// 26 separate `Curves.easeInOutQuart` literals and no shared durations.
///
/// **Tier 1 is frozen.** `strokeUnit` / `forStrokes` back the stroke-drawing
/// animation; the Hero flight curve is frozen too. See the standard's Motion
/// section — a motion task never includes Tier 1. Everything else below is
/// Tier 2 (interface chrome) and is deliberately shared.
class ZenMotion {
  const ZenMotion._();

  // --- Curves ---

  /// The canonical natural-brush curve, mandated by the UI/UX standard.
  static const Curve natural = Curves.easeInOutQuart;

  /// Arrival overshoot for rewards (seals, streak badges, purchase unlock).
  static const Curve arrival = Curves.easeOutBack;

  /// Gentle settle used by the page transition (no travel overshoot).
  static const Curve settle = Curves.easeInOutQuart;

  /// Content entrance: quick departure, soft landing. List rows and reveals.
  static const Curve enter = Curves.easeOutCubic;

  /// Ambient cycles: breathing glows, shimmer sweeps, recording pulses.
  static const Curve breathe = Curves.easeInOutSine;

  // --- Durations ---

  /// Quick feedback: taps, selection, hovers (300ms per the standard).
  static const Duration quick = Duration(milliseconds: 300);

  /// Small state swaps: icon to spinner, chip colour, pills, tab switches.
  static const Duration swap = Duration(milliseconds: 180);

  /// Full-screen transitions and content reveals.
  static const Duration page = Duration(milliseconds: 500);

  /// The reverse (pop) leg of a full-screen transition.
  static const Duration pageReverse = Duration(milliseconds: 350);

  /// Press feedback on buttons, tiles and cards.
  static const Duration tap = Duration(milliseconds: 130);

  /// How long a toast or snackbar stays on screen.
  ///
  /// Deliberately long: Russian and Vietnamese expand a label to 2.08x English,
  /// so a short dwell is unreadable. See the standard's locale budget.
  static const Duration toast = Duration(milliseconds: 2000);

  /// Animation budget for ONE stroke; total = [forStrokes].
  ///
  /// **Frozen (Tier 1)** — do not re-time the drawing animation.
  static const Duration strokeUnit = Duration(milliseconds: 800);

  /// One full cycle of a perpetual ambient effect (shimmer, breathing).
  static const Duration ambient = Duration(seconds: 2);

  /// One cycle of a fast ambient pulse (recording / listening indicator).
  static const Duration ambientFast = Duration(milliseconds: 1000);

  /// Entrance animation for a single list row, excluding its [stagger].
  static const Duration entrance = Duration(milliseconds: 400);

  /// Per-item step between successive list entrances.
  static const Duration stagger = Duration(milliseconds: 50);

  /// A row, card or chip leaving the screen.
  ///
  /// Deliberately shorter than [entrance]: a departure should read as clearing
  /// space, not as a performance. `Dismissible` covers the swipe case; this
  /// covers the data-driven one, where a button (or a provider update) removes
  /// the row. Pair it with [natural]; see `ZenExit`.
  static const Duration exit = Duration(milliseconds: 250);

  /// Choreography beat for sequenced reveals: `delay: beat * 2` = 200ms.
  static const Duration beat = Duration(milliseconds: 100);

  /// Error shake for a rejected stroke or a failed action.
  static const Duration shake = Duration(milliseconds: 500);

  /// Total duration for drawing [strokes] strokes.
  ///
  /// **Frozen (Tier 1)** — the drawing canvas owns this formula.
  static Duration forStrokes(int strokes) => strokeUnit * strokes;

  /// Resolves an interface-motion [token] against the platform preference.
  ///
  /// Returns [Duration.zero] when the user has enabled the OS "Reduce Motion"
  /// setting, so a one-shot animation collapses straight to its end state
  /// instead of sliding. This is the single-line form of the standard's rule:
  ///
  /// ```dart
  /// AnimatedContainer(duration: ZenMotion.of(context, ZenMotion.swap), ...)
  /// ```
  ///
  /// Controllers cannot use this (their duration is fixed in `initState`, which
  /// has no [BuildContext]); gate those with `MotionResolution.resolve(...)`
  /// from `didChangeDependencies` instead.
  static Duration of(BuildContext context, Duration token) =>
      context.reduceMotion ? Duration.zero : token;
}

/// The single page transition for the app.
///
/// A short cross-fade with a gentle 3% upward lift, so every push feels the
/// same. It replaces the dated `FadeUpwardsPageTransitionsBuilder` (a vertical
/// slide) and matches the feel already shipped in the onboarding arc and the
/// paywall unlock.
///
/// iOS and macOS intentionally keep [CupertinoPageTransitionsBuilder] instead:
/// that builder supplies the platform's interactive edge-swipe back gesture,
/// which [SwipeBackRoute] depends on, so overriding it would remove a
/// first-class navigation affordance.
class ZenPageTransitionsBuilder extends PageTransitionsBuilder {
  const ZenPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Reduced motion: cross-fade only, no travel.
    if (context.reduceMotion) {
      return FadeTransition(opacity: animation, child: child);
    }

    final CurvedAnimation curved = CurvedAnimation(
      parent: animation,
      curve: ZenMotion.settle,
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        // 3% lift: enough to signal direction, small enough to stay calm.
        position: Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
