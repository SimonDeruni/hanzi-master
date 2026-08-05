import 'package:flutter/material.dart';

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
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<BreathingWidget> createState() => _BreathingWidgetState();
}

class _BreathingWidgetState extends State<BreathingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.minScale, end: widget.maxScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    if (widget.isBreathing) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant BreathingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isBreathing && !oldWidget.isBreathing) {
      _controller.repeat(reverse: true);
    } else if (!widget.isBreathing && oldWidget.isBreathing) {
      _controller.animateTo(0.5, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
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
        final scale = widget.isBreathing ? _animation.value : 1.0;
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
