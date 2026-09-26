import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// Collapses and fades [child] out, then reports that it has gone.
///
/// The vocabulary had an entrance (`StaggeredListItem`) but **no exit**, so a row
/// removed by a button — a card added to a deck leaving the picker, a word
/// leaving a list — simply ceased to exist. `Dismissible` covers the swipe case;
/// this covers the data-driven one.
///
/// The caller keeps the row in its data until [onRemoved] fires, which is what
/// gives the animation something to draw:
///
/// ```dart
/// final Set<String> _exiting = <String>{};
/// // on the remove button: setState(() => _exiting.add(card.id));
/// ZenExit(
///   removing: _exiting.contains(card.id),
///   onRemoved: () => commitTheRemoval(card),
///   child: theRow,
/// )
/// ```
///
/// [onRemoved] fires **exactly once**. Under the platform "Reduce Motion"
/// setting no frames are scheduled and it fires on the next frame instead, so the
/// data still settles: motion is reduced, the behaviour is not.
class ZenExit extends StatefulWidget {
  /// The row being removed.
  final Widget child;

  /// Set true once the caller wants this row gone.
  final bool removing;

  /// Called once the row has finished leaving.
  final VoidCallback onRemoved;

  /// The axis the row collapses along. Rows collapse vertically, chips
  /// horizontally.
  final Axis axis;

  const ZenExit({
    super.key,
    required this.child,
    required this.removing,
    required this.onRemoved,
    this.axis = Axis.vertical,
  });

  @override
  State<ZenExit> createState() => _ZenExitState();
}

class _ZenExitState extends State<ZenExit> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  /// 1 -> 0: drives both the fade and the collapse, so the row shrinks as it
  /// disappears and the rows below close the gap in step.
  late final Animation<double> _shrink;

  /// Guards the single [ZenExit.onRemoved] callback.
  bool _reported = false;

  /// Guards a single play of the exit.
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: ZenMotion.exit);
    _shrink = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: ZenMotion.natural),
    );
    _controller.addStatusListener(_onStatus);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Not `initState`: reading the platform preference goes through
    // `MediaQuery`, which is an inherited lookup.
    if (widget.removing) _start();
  }

  @override
  void didUpdateWidget(ZenExit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.removing && !oldWidget.removing) _start();
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) _report();
  }

  /// The one place [ZenExit.onRemoved] is invoked.
  void _report() {
    if (_reported) return;
    _reported = true;
    widget.onRemoved();
  }

  void _start() {
    if (_started) return;
    _started = true;

    if (context.reduceMotion) {
      // Deferred by one frame: firing straight from didChangeDependencies would
      // re-enter build when the caller commits the removal in `setState`.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _report();
      });
      return;
    }

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Not removing yet, or motion is reduced: the row is plain content.
    if (!widget.removing || context.reduceMotion) return widget.child;

    return AnimatedBuilder(
      animation: _shrink,
      builder: (BuildContext context, Widget? inner) => SizeTransition(
        sizeFactor: _shrink,
        axis: widget.axis,
        child: FadeTransition(opacity: _shrink, child: inner),
      ),
      child: widget.child,
    );
  }
}
