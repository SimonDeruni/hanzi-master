import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

class BreathingWidget extends StatefulWidget {
  final Widget child;
  final bool isBreathing;
  final double minScale;
  final double maxScale;
  final Duration duration;

  const BreathingWidget({
    super.key,
    required this.child,
    this.isBreathing = true,
    this.minScale = 0.98,
    this.maxScale = 1.02,
    this.duration = ZenMotion.ambientFast,
  });

  @override
  State<BreathingWidget> createState() => _BreathingWidgetState();
}

class _BreathingWidgetState extends State<BreathingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  /// Set from [didChangeDependencies]; suppresses the loop under reduced motion.
  bool _reduceMotion = false;

  /// True only when the caller wants breathing AND motion is permitted.
  bool get _shouldBreathe => widget.isBreathing && !_reduceMotion;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.minScale, end: widget.maxScale).animate(
      CurvedAnimation(parent: _controller, curve: ZenMotion.breathe),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = context.reduceMotion;
    if (reduce != _reduceMotion) {
      _reduceMotion = reduce;
      _syncController();
    } else if (widget.isBreathing) {
      _syncController();
    }
  }

  @override
  void didUpdateWidget(covariant BreathingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncController();
  }

  /// Starts the breathing loop, or settles to the resting scale.
  void _syncController() {
    if (_shouldBreathe) {
      if (!_controller.isAnimating) _controller.repeat(reverse: true);
    } else if (_controller.isAnimating) {
      _controller.animateTo(0.5,
          duration: ZenMotion.quick, curve: ZenMotion.enter);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // When not breathing, snap to scale 1.0. If breathing, use the animation value.
        final scale = _shouldBreathe ? _animation.value : 1.0;
        return Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
