import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';

/// Shakes [child] horizontally to **reject** an action.
///
/// `docs/UI_UX_STANDARDS.md` § Motion lists an error shake as the one Tier 2
/// vocabulary row with no implementation: a rejected answer, a refused
/// permission or a failed save should *move* as well as recolour, so the refusal
/// is felt and not merely seen. Every usage is paired with a `HapticsManager`
/// call, as the standard requires.
///
/// Usage is a monotonically increasing counter, so a caller never has to build a
/// controller:
/// ```dart
/// int _rejections = 0;
/// // on a rejection: setState(() => _rejections++);
/// ZenShake(trigger: _rejections, child: theSurface),
/// ```
///
/// Only an **increase** plays a shake, which is what makes the common
/// "the rejected tile is the selected one" pattern safe: a tile that stops being
/// the rejected one drops its trigger back to `0` and must not animate.
///
/// The rest state is exactly [child] (offset `0`), so a surface that never shakes
/// is indistinguishable from one that is not wrapped. Under the platform
/// "Reduce Motion" setting the travel is dropped entirely and the caller's
/// haptic carries the rejection on its own.
class ZenShake extends StatefulWidget {
  /// The surface being rejected.
  final Widget child;

  /// Bump this to play one shake. Only an increase from the previous value
  /// plays; decreases are ignored.
  final int trigger;

  /// Peak horizontal offset, in logical pixels.
  final double distance;

  const ZenShake({
    super.key,
    required this.child,
    required this.trigger,
    this.distance = 9,
  });

  @override
  State<ZenShake> createState() => _ZenShakeState();
}

class _ZenShakeState extends State<ZenShake>
    with SingleTickerProviderStateMixin {
  /// One shake, at the standard's error-shake duration.
  late final AnimationController _controller;

  /// Right, left, right, left - damped, and settled exactly back at 0.
  ///
  /// The final keyframe is `0`, not a small residue: a non-zero rest offset
  /// would leave the rejected surface permanently displaced.
  late final Animation<double> _amplitude;

  @override
  void initState() {
    super.initState();
    // Built here rather than as a lazy `late final` field. Under "Reduce Motion"
    // [build] hands the child straight back and never touches the controller, so
    // a lazy field would first be constructed inside `dispose()` - by which time
    // the `TickerMode` scope is gone and `SingleTickerProviderStateMixin`'s
    // `createTicker` assertion fires while the tree is being finalised.
    _controller = AnimationController(
      vsync: this,
      duration: ZenMotion.shake,
    );
    _amplitude = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: 0, end: 1), weight: 1),
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: 1, end: -0.8), weight: 2),
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: -0.8, end: 0.5), weight: 2),
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: 0.5, end: -0.2), weight: 2),
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: -0.2, end: 0), weight: 1),
      ],
    ).animate(CurvedAnimation(parent: _controller, curve: ZenMotion.natural));
  }

  @override
  void didUpdateWidget(ZenShake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger > oldWidget.trigger) {
      // A rejection has to be *felt*, not only seen - and this widget owns the
      // buzz so no caller can forget to pair it. Four call sites existed and
      // exactly one of them buzzed, which is what a repeated `HapticsManager`
      // call at each call site buys you. It sits outside the guard below on
      // purpose: Reduce Motion collapses the travel, never the touch.
      HapticsManager.error();
      // Reduced motion: the travel does not happen; the haptic above still did.
      if (!context.reduceMotion) _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Reduced motion: hand the child straight back, with no transform at all.
    if (context.reduceMotion) return widget.child;

    return AnimatedBuilder(
      animation: _amplitude,
      builder: (BuildContext context, Widget? inner) => Transform.translate(
        offset: Offset(_amplitude.value * widget.distance, 0),
        child: inner,
      ),
      child: widget.child,
    );
  }
}
