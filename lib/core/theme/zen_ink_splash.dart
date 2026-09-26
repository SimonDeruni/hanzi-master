import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'zen_motion.dart';

/// A tap that seeps instead of flashing.
///
/// Flutter's stock splash is a uniform grey disc. The app is Xuan paper and
/// cinnabar ink everywhere else, so this factory paints the tap as a **drop of
/// ink on paper**: a feathered, slightly irregular blob that spreads quickly,
/// soaks, then dissipates. It is a response to a touch, so it satisfies
/// `docs/UI_UX_STANDARDS.md` § Motion — *"nothing animates as decoration"*.
///
/// Wired once, in both themes:
/// ```dart
/// ThemeData(splashFactory: ZenInkSplashFactory())
/// ```
/// and every `InkWell` / `InkResponse` / `Material` button in the app inherits
/// it — Flutter has 35 `InkWell`s here, so this is one line for all of them.
///
/// Under the platform "Reduce Motion" setting the bleed collapses to a static
/// tint: the feedback stays, the travel goes.
class ZenInkSplashFactory extends InteractiveInkFeatureFactory {
  const ZenInkSplashFactory();

  /// Fraction of the tap colour actually painted.
  ///
  /// Deliberately faint (10%): the bleed sits *under* text and glyphs, and must
  /// never compete with them.
  static const double strength = 0.10;

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return ZenInkSplash(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      ink: color.withValues(alpha: strength),
      targetRadius: radius ?? reachOf(referenceBox, rectCallback, position),
      textDirection: textDirection,
      containedInkWell: containedInkWell,
      rectCallback: rectCallback,
      borderRadius: borderRadius,
      customBorder: customBorder,
      onRemoved: onRemoved,
      reduceMotion: WidgetsBinding
          .instance.platformDispatcher.accessibilityFeatures.disableAnimations,
    );
  }

  /// Distance from the touch to the furthest corner of the surface, so the bleed
  /// can reach the whole of it whatever the shape.
  static double reachOf(
    RenderBox box,
    RectCallback? rectCallback,
    Offset position,
  ) {
    final Rect rect = rectCallback?.call() ?? (Offset.zero & box.size);
    final double dx =
        math.max(position.dx - rect.left, rect.right - position.dx);
    final double dy =
        math.max(position.dy - rect.top, rect.bottom - position.dy);
    return math.sqrt(dx * dx + dy * dy);
  }

  /// The rect the ink is confined to, so a bleed inside a list row, a card or an
  /// icon button is cut off by that shape rather than overflowing it.
  ///
  /// Mirrors Flutter's own `_getClipCallback` for [InkRipple], which is private.
  static RectCallback? clipOf(
    RenderBox box,
    bool containedInkWell,
    RectCallback? rectCallback,
  ) {
    if (rectCallback != null) {
      assert(containedInkWell);
      return rectCallback;
    }
    if (containedInkWell) {
      return () => Offset.zero & box.size;
    }
    return null;
  }
}

/// One drop of ink, seeping into the surface under the fingertip.
class ZenInkSplash extends InteractiveInkFeature {
  /// Where the finger landed, in the ink surface's coordinates.
  final Offset position;

  /// How far the bleed may spread.
  final double targetRadius;

  /// True when the platform asked for reduced motion.
  final bool reduceMotion;

  final Color _ink;
  final TextDirection _textDirection;
  final BorderRadius _borderRadius;
  final RectCallback? _clipCallback;

  late final AnimationController _bleed;
  late final Animation<double> _radius;
  late final Animation<double> _alpha;

  bool _disposed = false;

  ZenInkSplash({
    required super.controller,
    required super.referenceBox,
    required this.position,
    required Color ink,
    required this.targetRadius,
    required this.reduceMotion,
    required TextDirection textDirection,
    required bool containedInkWell,
    required RectCallback? rectCallback,
    BorderRadius? borderRadius,
    super.customBorder,
    super.onRemoved,
  })  : _ink = ink,
        _textDirection = textDirection,
        _borderRadius = borderRadius ?? BorderRadius.zero,
        _clipCallback = ZenInkSplashFactory.clipOf(
          referenceBox,
          containedInkWell,
          rectCallback,
        ),
        super(color: ink) {
    _bleed = AnimationController(
      duration: ZenMotion.quick,
      vsync: controller.vsync,
    )
      ..addListener(controller.markNeedsPaint)
      ..addStatusListener(_onStatus);

    // Spread fast, then hold: ink soaks outward quickly and then sits.
    _radius = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 1)
            .chain(CurveTween(curve: ZenMotion.enter)),
        weight: 55,
      ),
      TweenSequenceItem<double>(tween: ConstantTween<double>(1), weight: 45),
    ]).animate(_bleed);

    // Appear, sit, dissipate - the fade begins before the spread finishes, so the
    // ink never looks like a solid disc waiting to be removed.
    _alpha = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1), weight: 12),
      TweenSequenceItem<double>(tween: ConstantTween<double>(1), weight: 33),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 0)
            .chain(CurveTween(curve: ZenMotion.breathe)),
        weight: 55,
      ),
    ]).animate(_bleed);

    if (reduceMotion) {
      // Feedback stays, travel goes: the ink is simply *there* at a fixed tint
      // until the gesture resolves.
      _bleed
        ..duration = Duration.zero
        ..value = 0.5;
    } else {
      _bleed.forward();
    }

    controller.addInkFeature(this);
  }

  @override
  void confirm() {
    if (_disposed || _bleed.value >= 1) return;
    // A confirmed tap dissipates without waiting out the soak. Under reduce
    // motion it dissipates instantly: the feedback resolves, nothing travels.
    _bleed.animateTo(
      1,
      duration: reduceMotion ? Duration.zero : ZenMotion.swap,
    );
  }

  @override
  void cancel() => dispose();

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) dispose();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _bleed.dispose();
    super.dispose();
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final double alpha = _alpha.value;
    final double radius = targetRadius * _radius.value;
    if (radius <= 0.5 || alpha <= 0.004) return;

    final Offset? originOffset = MatrixUtils.getAsTranslation(transform);
    canvas.save();
    if (originOffset == null) {
      canvas.transform(transform.storage);
    } else {
      canvas.translate(originOffset.dx, originOffset.dy);
    }

    // Clipped exactly the way Flutter's own splash is, so a bleed can never
    // escape the row, card or button it belongs to.
    final Rect? clipRect = _clipCallback?.call();
    if (clipRect != null) {
      final ShapeBorder? border = customBorder;
      if (border != null) {
        canvas.clipPath(
          border.getOuterPath(clipRect, textDirection: _textDirection),
        );
      } else if (_borderRadius != BorderRadius.zero) {
        canvas.clipRRect(_borderRadius.toRRect(clipRect));
      } else {
        canvas.clipRect(clipRect);
      }
    }

    // A drop of ink is not a circle: two slow lobes give the boundary the
    // irregular, liquid edge of a real bleed.
    final Path blob = Path();
    const int steps = 44;
    for (int i = 0; i <= steps; i++) {
      final double theta = (i / steps) * 2 * math.pi;
      final double wobble = 1 +
          0.055 * math.sin(3 * theta + 1.1) +
          0.035 * math.sin(5 * theta - 0.4);
      final double r = radius * wobble;
      final Offset point =
          position + Offset(math.cos(theta) * r, math.sin(theta) * r);
      if (i == 0) {
        blob.moveTo(point.dx, point.dy);
      } else {
        blob.lineTo(point.dx, point.dy);
      }
    }
    blob.close();

    // The radial gradient feathers the edge: ink thins as it soaks outward,
    // where a flat fill would read as a pasted-on disc.
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..shader = RadialGradient(
        colors: <Color>[
          _ink.withValues(alpha: alpha),
          _ink.withValues(alpha: alpha * 0.5),
          _ink.withValues(alpha: 0),
        ],
        stops: const <double>[0, 0.70, 1],
      ).createShader(
        Rect.fromCircle(center: position, radius: radius * 1.08),
      );

    canvas.drawPath(blob, paint);
    canvas.restore();
  }
}
