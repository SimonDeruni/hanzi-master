/// The chat motion kit, shared by the app's two AI conversations: the Bureau du
/// savant (one character) and the Echo Hall roleplay (one scenario).
///
/// Both carried their own copy of "a bubble rises in". Keeping the vocabulary in
/// one place is what makes the two transcripts feel like one product, and it is
/// the only way the reduced-motion behaviour stays identical between them.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// Rises a freshly appended message into place — a short fade with a 10% lift.
///
/// One-shot, so a bubble plays its entrance exactly once while it is on screen
/// and never replays on scroll. Honours the platform "Reduce Motion" setting by
/// resting at the end state instead of travelling.
class ChatMessageEntrance extends StatefulWidget {
  const ChatMessageEntrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.animate = true,
    this.onEntered,
  });

  final Widget child;

  /// Waiting time before the entrance starts — used to stagger a group that is
  /// appended together (suggestion chips, and a transcript's first paint).
  final Duration delay;

  /// `false` rests at the end state straight away. A long transcript passes this
  /// once it has seen the id: a `SliverList` recycles the elements it scrolls
  /// past, so without it every bubble replays its entrance on the way up.
  final bool animate;

  /// Called once, as soon as the entrance is scheduled (immediately when it is
  /// skipped). The caller memoises the message id here.
  final VoidCallback? onEntered;

  @override
  State<ChatMessageEntrance> createState() => _ChatMessageEntranceState();
}

class _ChatMessageEntranceState extends State<ChatMessageEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: ZenMotion.entrance);
  late final Animation<double> _fade =
      CurvedAnimation(parent: _controller, curve: ZenMotion.enter);
  late final Animation<Offset> _lift = Tween<Offset>(
    begin: const Offset(0, 0.10),
    end: Offset.zero,
  ).animate(_fade);

  bool _scheduled = false;
  Timer? _delayTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_scheduled) return;
    _scheduled = true;

    // Reduced motion, or a bubble that already had its entrance: rest fully
    // visible, with no travel.
    if (context.reduceMotion || !widget.animate) {
      _controller.value = 1;
      widget.onEntered?.call();
      return;
    }

    _controller.duration = ZenMotion.of(context, ZenMotion.entrance);
    if (widget.delay <= Duration.zero) {
      _controller.forward();
    } else {
      // A cancellable timer, so an entered-then-disposed bubble never leaves a
      // pending timer behind (which widget tests report as a failure).
      _delayTimer = Timer(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
    widget.onEntered?.call();
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _lift, child: widget.child),
    );
  }
}

/// Three ink dots breathing in sequence — the "the other side is writing"
/// signal, shared so both transcripts settle at the same rhythm.
///
/// One controller drives all three through staggered [Interval]s. The previous
/// copy started three delayed `forward()`s *and* a `repeat()` on every
/// controller, so the sequence it claimed to stagger never actually happened.
class ChatTypingDots extends StatefulWidget {
  const ChatTypingDots({super.key, this.color = Colors.indigo});

  /// The dot colour; defaults to the Bureau du savant's ink.
  final Color color;

  @override
  State<ChatTypingDots> createState() => _ChatTypingDotsState();
}

class _ChatTypingDotsState extends State<ChatTypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: ZenMotion.page);
  late final List<Animation<double>> _dots = List<Animation<double>>.generate(
    3,
    (int i) => Tween<double>(begin: 0.25, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(i * 0.18, 0.5 + (i * 0.18), curve: ZenMotion.breathe),
      ),
    ),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Perpetual, so reduced motion parks every dot at full opacity.
    MotionResolution.resolve(context, controller: _controller, loop: true)
        .apply();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        3,
        (int i) => AnimatedBuilder(
          animation: _dots[i],
          builder: (BuildContext context, Widget? child) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withValues(alpha: _dots[i].value),
            ),
          ),
        ),
      ),
    );
  }
}
