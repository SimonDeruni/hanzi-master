import 'package:flutter/material.dart';

/// Accessibility helper for animation-heavy widgets.
///
/// Reads the platform "Reduce Motion" / "Remove animations" setting, surfaced by
/// Flutter as [MediaQueryData.disableAnimations]. When it is on, decorative and
/// looping animations must degrade to their static end-state instead of
/// repeating forever — perpetual pulsing is a genuine problem for users with
/// vestibular disorders.
extension MotionPreferences on BuildContext {
  /// True when the user has asked the OS to reduce motion.
  ///
  /// Defaults to `false` when no [MediaQuery] is present so widgets stay
  /// animatable in bare test harnesses.
  bool get reduceMotion =>
      MediaQuery.maybeOf(this)?.disableAnimations ?? false;
}

/// Resolves an animation's behaviour against the user's motion preference.
///
/// Usage inside a widget's `build`:
/// ```dart
/// final motion = MotionPreferences.resolve(context, controller: _controller);
/// if (motion.shouldLoop) motion.start(0);
/// ```
///
/// The controller is only started when motion is allowed, and is snapped to
/// [staticValue] when it is not, so the widget still renders its "complete"
/// look rather than frame zero.
class MotionResolution {
  const MotionResolution({
    required this.reduceMotion,
    required this.controller,
    required this.staticValue,
    required this.loop,
  });

  /// Whether the user asked to reduce motion.
  final bool reduceMotion;

  /// The controller to drive, or null if the widget has none.
  final AnimationController? controller;

  /// The value the animation should rest at when motion is reduced.
  final double staticValue;

  /// Whether this is a perpetual effect (shimmer, breathing glow).
  final bool loop;

  /// True when the animation should run normally.
  bool get shouldAnimate => !reduceMotion;

  /// True when a repeating animation should actually repeat.
  bool get shouldLoop => !reduceMotion && loop;

  /// Starts or freezes the animation to match the motion preference.
  ///
  /// Safe to call from `initState` and `didChangeDependencies`; it no-ops when
  /// the controller is already in the desired state.
  void apply() {
    final c = controller;
    if (c == null) return;

    if (reduceMotion) {
      if (c.isAnimating) c.stop();
      if (c.value != staticValue) c.value = staticValue;
      return;
    }

    if (loop) {
      if (!c.isAnimating) c.repeat(reverse: true);
    } else if (!c.isAnimating && c.value == 0) {
      c.forward();
    }
  }

  /// Convenience constructor that reads the preference from [context].
  static MotionResolution resolve(
    BuildContext context, {
    AnimationController? controller,
    double staticValue = 1.0,
    bool loop = false,
  }) {
    return MotionResolution(
      reduceMotion: context.reduceMotion,
      controller: controller,
      staticValue: staticValue,
      loop: loop,
    );
  }
}
