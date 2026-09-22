import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

class ShimmerSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double? widthFactor;
  final bool isDark;
  final BorderRadiusGeometry? borderRadius;

  const ShimmerSkeleton({
    super.key,
    this.width,
    this.height = 14,
    this.widthFactor,
    required this.isDark,
    this.borderRadius,
  });

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: ZenMotion.ambient,
    );
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: ZenMotion.breathe),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Rest at a mid-shimmer value when motion is reduced, so the skeleton is
    // still visibly a placeholder without pulsing forever.
    MotionResolution.resolve(
      context,
      controller: _controller,
      staticValue: 0.5,
      loop: true,
    ).apply();
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
        final shimmer = Color.lerp(
          widget.isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          widget.isDark ? Colors.grey.shade600 : Colors.grey.shade400,
          _animation.value,
        )!;

        Widget container = Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: shimmer,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
          ),
        );

        if (widget.widthFactor != null) {
          return FractionallySizedBox(
            widthFactor: widget.widthFactor,
            child: container,
          );
        }

        return container;
      },
    );
  }
}
