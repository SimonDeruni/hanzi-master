import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// Assembles a composed glyph out of its component [parts].
///
/// This is the teaching beat of a radical lesson, not decoration: it has to show
/// *how a character is built*, so the parts must read as separate pieces before
/// they become the whole.
///
/// Choreography:
///
/// 1. every part flies in from its own offset - its own side of the finished
///    glyph - slightly rotated, over [ZenMotion.entrance], eased with
///    [ZenMotion.enter];
/// 2. successive parts are [ZenMotion.stagger] apart, so the eye can follow them
///    one at a time, and they settle together;
/// 3. only then does the composed glyph arrive on [ZenMotion.arrival], whose
///    overshoot reads as a stamp, while the parts dissolve into it.
///
/// Usage:
///
/// ```dart
/// ZenAssembly(parts: <String>['日', '月'], composed: '明')
/// ```
///
/// The composed glyph is drawn from [composedStyle] exactly as given, so it can
/// be layered straight over the static glyph a host screen already renders in
/// the same slot: the resting state is unchanged pixel for pixel.
///
/// Under the platform "Reduce Motion" setting nothing is animated: the composed
/// glyph is rendered immediately and no ticker is scheduled at all.
class ZenAssembly extends StatefulWidget {
  /// Component glyphs, laid out left to right in reading order.
  final List<String> parts;

  /// The glyph the [parts] build.
  final String composed;

  /// Square edge of the slot the assembly flies into.
  final double size;

  /// Style for the parts.
  ///
  /// Colour, weight and family are honoured; `fontSize` is **not** - the layout
  /// owns it, so any number of parts fits [size].
  final TextStyle? partStyle;

  /// Style for the composed glyph. Used exactly as given.
  final TextStyle? composedStyle;

  const ZenAssembly({
    super.key,
    required this.parts,
    required this.composed,
    this.size = 140,
    this.partStyle,
    this.composedStyle,
  }) : assert(size > 0, 'the assembly needs a slot to fly into');

  @override
  State<ZenAssembly> createState() => _ZenAssemblyState();
}

class _ZenAssemblyState extends State<ZenAssembly>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  /// One travel animation per part: from its own corner into its own slot.
  List<Animation<Offset>> _approach = const <Animation<Offset>>[];

  /// One rotation per part: a slight tilt that straightens as it lands.
  List<Animation<double>> _tilt = const <Animation<double>>[];

  /// One opacity per part, also used to dissolve the parts into the whole.
  List<Animation<double>> _ink = const <Animation<double>>[];

  /// 0 -> 1 while the parts fade out under the arriving composed glyph.
  late Animation<double> _dissolve;

  /// 0.55 -> 1 (with overshoot) as the composed glyph lands.
  late Animation<double> _rise;

  /// 0 -> 1 as the composed glyph becomes visible.
  late Animation<double> _reveal;

  /// Fraction of the slot the parts travel from: far enough to read as "flying
  /// in", near enough to stay in the gap around the tile.
  static const double _travelFactor = 0.95;

  /// Slight, not a spin.
  static const double _tiltRadians = 0.22;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _timelineLength(widget.parts.length),
    );
    _buildTimeline();
  }

  /// One assembly, as a single timeline: every part gets one [ZenMotion.entrance]
  /// of flight, the parts are [ZenMotion.stagger] apart, and the composed glyph
  /// gets a final [ZenMotion.entrance] of its own to arrive in.
  static Duration _timelineLength(int partCount) =>
      _hold(partCount) + ZenMotion.entrance + ZenMotion.entrance;

  /// The delay before the last part starts.
  static Duration _hold(int partCount) =>
      partCount > 1 ? ZenMotion.stagger * (partCount - 1) : Duration.zero;

  void _buildTimeline() {
    final int count = widget.parts.length;
    final double micros = _timelineLength(count).inMicroseconds.toDouble();
    double fraction(Duration at) => at.inMicroseconds / micros;

    _approach = <Animation<Offset>>[];
    _tilt = <Animation<double>>[];
    _ink = <Animation<double>>[];

    for (int i = 0; i < count; i++) {
      final Duration start = ZenMotion.stagger * i;
      final Animation<double> flight = CurvedAnimation(
        parent: _controller,
        curve: Interval(
          fraction(start),
          fraction(start + ZenMotion.entrance),
          curve: ZenMotion.enter,
        ),
      );
      _approach.add(
        Tween<Offset>(begin: _originOf(i, count), end: Offset.zero)
            .animate(flight),
      );
      _tilt.add(Tween<double>(begin: _tiltOf(i), end: 0).animate(flight));
      _ink.add(flight);
    }

    // The composed glyph waits for the last part to land. There is always a
    // second `entrance` left after that point, so `landed` is never 1.
    final double landed = fraction(_hold(count) + ZenMotion.entrance);

    _dissolve = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        landed,
        landed + (1 - landed) / 2,
        curve: ZenMotion.settle,
      ),
    );
    _rise = Tween<double>(begin: 0.55, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(landed, 1, curve: ZenMotion.arrival),
      ),
    );
    _reveal = CurvedAnimation(
      parent: _controller,
      curve: Interval(landed, 1, curve: ZenMotion.enter),
    );
  }

  /// Where part [index] of [count] flies in from.
  ///
  /// The parts are spread across the finished glyph, so each one arrives from its
  /// own side: the first part of a two-part character comes from the upper left,
  /// the second from the lower right. Deterministic on purpose - a teaching
  /// animation has to look the same every time it is taught.
  Offset _originOf(int index, int count) {
    final double dx = count <= 1 ? 0 : (index / (count - 1)) * 2 - 1;
    final double dy = index.isEven ? -1 : 1;
    final Offset direction = Offset(dx, dy);
    return direction / direction.distance * (widget.size * _travelFactor);
  }

  /// The tilt part [index] starts with, in radians, straightening to zero.
  double _tiltOf(int index) => (index.isEven ? -1 : 1) * _tiltRadians;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Not `initState`: reading the platform preference goes through
    // `MediaQuery`, which is an inherited lookup.
    MotionResolution.resolve(
      context,
      controller: _controller,
      staticValue: 1,
    ).apply();
  }

  @override
  void didUpdateWidget(ZenAssembly oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool recomposed = oldWidget.composed != widget.composed ||
        oldWidget.size != widget.size ||
        !listEquals(oldWidget.parts, widget.parts);
    if (!recomposed) return;

    // A different character is a different assembly: re-time it and teach it
    // again from the top.
    _controller.duration = _timelineLength(widget.parts.length);
    _buildTimeline();
    if (context.reduceMotion) {
      if (_controller.value != 1) _controller.value = 1;
    } else {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Used exactly as given when the caller passes one: the host screen already
    // draws this same glyph in this same slot.
    final TextStyle composed = widget.composedStyle ??
        TextStyle(fontSize: widget.size * 0.46, fontWeight: FontWeight.bold);

    // Reduce motion: the assembled glyph *is* the end state, so render it and
    // schedule nothing. This path never touches the ticker at all.
    if (context.reduceMotion) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: Center(child: Text(widget.composed, style: composed)),
      );
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) => Stack(
          alignment: Alignment.center,
          // The parts start outside the slot, so the slot must not clip them.
          clipBehavior: Clip.none,
          children: <Widget>[
            ..._partGlyphs(),
            Opacity(
              opacity: _reveal.value,
              child: Transform.scale(
                scale: _rise.value,
                child: Text(widget.composed, style: composed),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The parts, each translated from its own corner into its own slot.
  List<Widget> _partGlyphs() {
    final int count = widget.parts.length;
    if (count == 0) return const <Widget>[];

    // The layout owns the glyph size, so any number of parts fits the slot.
    final double slot = math.min(widget.size * 0.86 / count, widget.size * 0.48);
    final TextStyle partStyle =
        (widget.partStyle ?? const TextStyle(fontWeight: FontWeight.bold))
            .copyWith(fontSize: slot * 0.94);

    return <Widget>[
      for (int i = 0; i < count; i++)
        Transform.translate(
          // Own slot, plus whatever is left of the flight into it.
          offset:
              _approach[i].value + Offset(slot * (i - (count - 1) / 2), 0),
          child: Transform.rotate(
            angle: _tilt[i].value,
            child: Opacity(
              // Fade in on approach, out again as the composed glyph lands.
              opacity: _ink[i].value * (1 - _dissolve.value),
              child: Text(widget.parts[i], style: partStyle),
            ),
          ),
        ),
    ];
  }
}
