import 'package:flutter/material.dart';

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

class _ShimmerSkeletonState extends State<ShimmerSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
