import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// Cross-fades between a button's idle icon and a progress spinner.
///
/// In-button loading swaps were previously plain `if/else` branches, so the
/// icon vanished and the spinner appeared in the same frame. Tweening the swap
/// makes the "work started" moment readable rather than a flicker. Size is held
/// constant by both children so the surrounding button never reflows.
///
/// Under reduced motion the switch is instant but still state-correct.
class LoadingSwap extends StatelessWidget {
  final bool isLoading;
  final Widget icon;

  /// Spinner diameter; should match the icon's visual size.
  final double size;

  /// Spinner colour; defaults to the icon's inherited colour.
  final Color? spinnerColor;

  /// Stroke width of the spinner.
  final double strokeWidth;

  const LoadingSwap({
    super.key,
    required this.isLoading,
    required this.icon,
    this.size = 16,
    this.spinnerColor,
    this.strokeWidth = 2,
  });

  /// Duration used when motion is permitted; sourced from [ZenMotion.swap].
  static const Duration animationDuration = ZenMotion.swap;

  @override
  Widget build(BuildContext context) {
    final duration =
        context.reduceMotion ? Duration.zero : animationDuration;

    return AnimatedSwitcher(
      duration: duration,
      // Keep the footprint stable so a Row does not jitter mid-swap.
      layoutBuilder: (currentChild, previousChildren) => SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [...previousChildren, if (currentChild != null) currentChild],
        ),
      ),
      child: isLoading
          ? SizedBox(
              key: const ValueKey('spinner'),
              width: size,
              height: size,
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth,
                color: spinnerColor,
              ),
            )
          : SizedBox(
              key: const ValueKey('icon'),
              width: size,
              height: size,
              child: Center(child: icon),
            ),
    );
  }
}
