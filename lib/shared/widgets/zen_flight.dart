import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// Flies a widget from one on-screen anchor to another and reports the landing.
///
/// The vocabulary had an entrance (`StaggeredListItem`) and an exit (`ZenExit`)
/// but nothing that *travels*: a word added to a deck left its row and appeared
/// in the deck with nothing joining the two. This is that beat — the card lifts
/// off the button the user tapped and lands on the deck it went into.
///
/// The flight lives on the **root overlay**, above the app bar it lands on,
/// rather than inside the caller's subtree: the row it came from is collapsing
/// (or already gone) underneath it, so it cannot be a child of that row.
///
/// ## Contract
///
/// * The flight is **decoration**. [to] returns a future that completes once the
///   card has landed, but no write may depend on it: start the flight, then let
///   the save proceed on its own. A failed flight is not a failed add.
/// * Under the platform **Reduce Motion** setting nothing travels: no
///   [OverlayEntry] is ever inserted. [onArrived] still fires — on the next
///   frame, deferred like `ZenExit` so a caller may `setState` from it — and the
///   returned future completes then. Motion is reduced; the behaviour is not.
/// * An anchor that is no longer on screen (its row scrolled away, its element
///   unmounted) is treated exactly like Reduce Motion: the caller is told, and
///   nothing is drawn. No guessed coordinates are ever used.
class ZenFlight {
  const ZenFlight._();

  /// The flights currently in an overlay, oldest first.
  static final List<OverlayEntry> _flights = <OverlayEntry>[];

  /// How many flights are on screen right now.
  ///
  /// Lets a caller tell that an entry was inserted and removed again — a flight
  /// is fire-and-forget, so this is otherwise invisible from outside.
  static int get activeFlights => _flights.length;

  /// Flies [child] from the widget keyed [from] to the one keyed [to].
  ///
  /// Both keys must be attached to on-screen widgets at the moment of the call:
  /// the anchors are read once, up front, so a row that starts collapsing (or a
  /// sheet that closes) underneath the flight cannot drag it off course.
  ///
  /// [onArrived] is called exactly once — on landing, or on the next frame when
  /// nothing travels. The returned future completes immediately after it.
  static Future<void> to({
    required BuildContext context,
    required GlobalKey from,
    required GlobalKey to,
    required Widget child,
    VoidCallback? onArrived,
  }) {
    final OverlayState? overlay = Overlay.maybeOf(context, rootOverlay: true);
    final Offset? origin = _centreOf(from);
    final Offset? target = _centreOf(to);

    // Nothing to travel between: the user asked for reduced motion, the call
    // came from a bare harness with no overlay, or an anchor is off screen.
    if (context.reduceMotion ||
        overlay == null ||
        origin == null ||
        target == null) {
      return _settleWithoutFlight(onArrived);
    }

    final Completer<void> landed = Completer<void>();
    late final OverlayEntry entry;
    bool removed = false;

    /// The one place the flight ends: drop the entry, tell the caller, complete.
    void land() {
      if (removed) return;
      removed = true;
      _flights.remove(entry);
      if (entry.mounted) entry.remove();
      onArrived?.call();
      if (!landed.isCompleted) landed.complete();
    }

    entry = OverlayEntry(
      builder: (BuildContext context) => _ZenFlightCard(
        origin: origin,
        target: target,
        onLanded: land,
        child: child,
      ),
    );
    _flights.add(entry);
    overlay.insert(entry);

    // The insert above is synchronous, so a caller that never awaits still sees
    // the flight; the future is only for callers that want the landing.
    return landed.future;
  }

  /// Reports a landing without drawing anything, on the next frame.
  ///
  /// Deferred rather than synchronous for the same reason `ZenExit` defers:
  /// firing straight out of a tap handler that is mid-`setState` is how a
  /// re-entrant build gets started.
  static Future<void> _settleWithoutFlight(VoidCallback? onArrived) {
    final Completer<void> settled = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onArrived?.call();
      if (!settled.isCompleted) settled.complete();
    });
    return settled.future;
  }

  /// The screen-space centre of the widget keyed [key], or null if it is gone.
  static Offset? _centreOf(GlobalKey key) {
    final BuildContext? context = key.currentContext;
    if (context == null) return null;

    final RenderObject? object = context.findRenderObject();
    if (object is! RenderBox || !object.hasSize) return null;

    return object.localToGlobal(object.size.center(Offset.zero));
  }
}

/// The flying card: one quick hop on [ZenMotion.enter], shrinking and fading.
class _ZenFlightCard extends StatefulWidget {
  const _ZenFlightCard({
    required this.origin,
    required this.target,
    required this.onLanded,
    required this.child,
  });

  /// Where the flight starts, in screen space.
  final Offset origin;

  /// Where it lands, in screen space.
  final Offset target;

  /// Called once, from the post-frame phase, after the card has landed.
  final VoidCallback onLanded;

  /// The card itself. It must size to its content — the overlay positions it by
  /// its own centre, and it is laid out with unbounded constraints.
  final Widget child;

  @override
  State<_ZenFlightCard> createState() => _ZenFlightCardState();
}

class _ZenFlightCardState extends State<_ZenFlightCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: ZenMotion.quick);
    _progress = CurvedAnimation(parent: _controller, curve: ZenMotion.enter);
    _controller.addStatusListener(_onStatus);
    _controller.forward();
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    // The status listener fires in the frame's transient-callback phase, so the
    // entry is removed in the post-frame phase instead, where dropping an
    // overlay child cannot disturb the build that is underway.
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onLanded());
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onStatus);
    _progress.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _progress,
        builder: (BuildContext context, Widget? inner) {
          final double t = _progress.value;
          final Offset centre = Offset.lerp(widget.origin, widget.target, t)!;

          // Shrink to a quarter and fade over the last two fifths of the hop, so
          // the card stays legible while it travels and is gone as it lands.
          final double scale = 1 - 0.75 * t;
          final double opacity = (1 - (t - 0.6) / 0.4).clamp(0.0, 1.0);

          return Stack(
            children: <Widget>[
              Positioned(
                left: centre.dx,
                top: centre.dy,
                child: Transform.scale(
                  alignment: Alignment.topLeft,
                  scale: scale,
                  // Shifts the card by half its *own* size, so its centre sits on
                  // `centre` without anyone having to know how big it is.
                  child: FractionalTranslation(
                    translation: const Offset(-0.5, -0.5),
                    child: Opacity(
                      opacity: opacity,
                      // The overlay sits beside the Scaffold, not under it, so
                      // the Material default text style has to be reintroduced
                      // or a card of `Text` paints in the debug fallback style.
                      child: Material(
                        type: MaterialType.transparency,
                        child: inner,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        child: widget.child,
      ),
    );
  }
}
