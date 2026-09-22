import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// Eases its child between sizes instead of snapping to the new height.
///
/// A "Show more" / "Show less" toggle that changes a [Text]'s `maxLines` used to
/// grow the surrounding panel in a single frame, which reads as a jolt and makes
/// the page look like it jumped. Wrapping the growable child makes the panel
/// open and close smoothly, and the surrounding content slides rather than
/// teleports.
///
/// Under the platform "Reduce Motion" setting the resize is instant.
class ZenExpand extends StatelessWidget {
  /// The content whose height should animate.
  final Widget child;

  /// Overrides the default duration (only pass this for unusually long or
  /// short expansions).
  final Duration? duration;

  const ZenExpand({super.key, required this.child, this.duration});

  @override
  Widget build(BuildContext context) {
    // Reduced motion: return the child directly, with no resize animator.
    // A zero-duration AnimatedSize is NOT safe here - RenderAnimatedSize would
    // re-dirty itself during layout and throw.
    if (context.reduceMotion) {
      return child;
    }

    return AnimatedSize(
      duration: duration ?? ZenMotion.quick,
      curve: ZenMotion.natural,
      // Grow downwards from the top edge, so the toggle button stays put while
      // the text below it expands.
      alignment: Alignment.topCenter,
      child: child,
    );
  }
}
