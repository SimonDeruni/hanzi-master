import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

class StaggeredListItem extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration delay;

  const StaggeredListItem({
    super.key,
    required this.child,
    required this.index,
    this.delay = ZenMotion.stagger,
  });

  @override
  State<StaggeredListItem> createState() => _StaggeredListItemState();
}

class _StaggeredListItemState extends State<StaggeredListItem>
    with SingleTickerProviderStateMixin {
  /// Entrance animation length, excluding the stagger delay.
  static const Duration _entranceDuration = ZenMotion.entrance;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Limit index to max 20 to prevent extremely long delays for very long lists
    final effectiveIndex = widget.index > 20 ? 20 : widget.index;
    final stagger = widget.delay * effectiveIndex;
    final holdMicros = stagger.inMicroseconds;
    final entranceMicros = _entranceDuration.inMicroseconds;

    _controller = AnimationController(
      vsync: this,
      duration: stagger + _entranceDuration,
    );

    // The delay is expressed inside the controller's timeline rather than via a
    // Timer.
    //
    // The previous implementation used `Future.delayed`, which is not driven by
    // the ticker: if that callback never ran (widget disposed mid-delay, or a
    // host that settles the animation clock without draining pending timers),
    // the item was stranded at opacity 0 — invisible content, the worst possible
    // failure for a list row. Encoding the delay as a hold at the start of a
    // TweenSequence makes the animation the single source of truth, so full
    // opacity is always reached once it completes.
    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: holdMicros.toDouble()),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: ZenMotion.enter)),
        weight: entranceMicros.toDouble(),
      ),
    ]).animate(_controller);

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: ConstantTween(const Offset(0, 0.2)),
        weight: holdMicros.toDouble(),
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, 0.2), end: Offset.zero)
            .chain(CurveTween(curve: ZenMotion.natural)),
        weight: entranceMicros.toDouble(),
      ),
    ]).animate(_controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      // Show the item immediately at its settled position.
      if (_controller.value != 1.0) _controller.value = 1.0;
    } else if (!_controller.isAnimating && _controller.value == 0) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
