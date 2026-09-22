import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// A loading spinner that eases in instead of blinking into place.
///
/// A bare `CircularProgressIndicator` appears in a single frame, which reads as
/// a flicker on a fast connection and as a hard cut on a slow one. Fading the
/// spinner in with a small upward drift makes "the app is thinking" feel
/// deliberate, matching the Zen page transition.
///
/// Under the platform "Reduce Motion" setting the fade collapses to zero: the
/// spinner is simply shown at once. Motion is reduced, information is not.
///
/// It accepts the same spinner options as [CircularProgressIndicator] so it can
/// replace one directly:
/// ```dart
/// // before: const Center(child: CircularProgressIndicator())
/// const Center(child: ZenLoader())
/// ```
class ZenLoader extends StatelessWidget {
  /// Spinner colour; defaults to the theme's progress indicator colour.
  final Color? color;

  /// Background (track) colour, forwarded to the spinner.
  final Color? backgroundColor;

  /// Progress value in `0.0..1.0`, or `null` for an indeterminate spinner.
  final double? value;

  /// Stroke width; the Material default is 4.0.
  final double strokeWidth;

  /// Optional caption drawn under the spinner.
  final String? label;

  /// Optional accessibility label for screen readers.
  final String? semanticsLabel;

  const ZenLoader({
    super.key,
    this.color,
    this.backgroundColor,
    this.value,
    this.strokeWidth = 4.0,
    this.label,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return ZenFadeIn(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: color,
            backgroundColor: backgroundColor,
            value: value,
            strokeWidth: strokeWidth,
            semanticsLabel: semanticsLabel,
          ),
          // A caption makes a long wait feel accounted for rather than stuck.
          if (label != null) ...[
            const SizedBox(height: 12),
            Text(
              label!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}

/// Fades (and slightly lifts) its [child] when it first appears.
///
/// Use it for content that replaces a loader, so the result eases in instead of
/// snapping. Under "Reduce Motion" the child is returned untouched.
class ZenFadeIn extends StatelessWidget {
  /// The content to reveal.
  final Widget child;

  /// How far the content drifts up, in logical pixels. 0 keeps it still.
  final double rise;

  const ZenFadeIn({super.key, required this.child, this.rise = 6});

  @override
  Widget build(BuildContext context) {
    // Reduced motion: show the content immediately, with no drift.
    if (context.reduceMotion) {
      return child;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: ZenMotion.of(context, ZenMotion.quick),
      curve: ZenMotion.natural,
      // Passed through so the child is not rebuilt on every animation tick.
      child: child,
      builder: (BuildContext context, double t, Widget? inner) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, rise * (1 - t)),
            child: inner,
          ),
        );
      },
    );
  }
}
