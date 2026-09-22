import 'package:flutter/material.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

/// A Zen & Ink streak flame badge with a subtle breathing glow animation.
///
/// Features a gentle pulse loop over 1800ms using [ZenMotion.breathe],
/// with an ambient cinnabar/amber halo glow. Honours the platform
/// "Reduce Motion" setting by holding the glow at its resting intensity.
class StreakFlameBadge extends StatefulWidget {
  final int streak;
  final String label;
  final VoidCallback? onTap;

  const StreakFlameBadge({
    super.key,
    required this.streak,
    required this.label,
    this.onTap,
  });

  @override
  State<StreakFlameBadge> createState() => _StreakFlameBadgeState();
}

class _StreakFlameBadgeState extends State<StreakFlameBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: ZenMotion.ambient,
    );

    _glowAnimation = CurvedAnimation(
      parent: _controller,
      curve: ZenMotion.breathe,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Under reduced motion the glow sits at mid-pulse instead of looping.
    MotionResolution.resolve(
      context,
      controller: _controller,
      staticValue: 0.5,
      loop: true,
    ).apply();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, _) {
        final t = _glowAnimation.value;
        // Flame breathing scale (1.0 -> 1.08)
        final flameScale = 1.0 + (0.08 * t);
        // Glow opacity and blur radius
        final glowOpacity = 0.20 + (0.18 * t);
        final glowBlur = 8.0 + (6.0 * t);
        final glowSpread = 0.5 + (1.5 * t);

        const flameColor = Color(0xFFFF7A00); // Vibrant Amber / Fire Orange

        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: flameColor.withValues(alpha: isDark ? 0.14 : 0.09),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: flameColor.withValues(alpha: 0.35 + (0.25 * t)),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: flameColor.withValues(alpha: glowOpacity),
                  blurRadius: glowBlur,
                  spreadRadius: glowSpread,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: flameScale,
                  child: const Text(
                    '🔥',
                    style: TextStyle(fontSize: 14, height: 1.0),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? const Color(0xFFFFB266)
                        : const Color(0xFFC2410C),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
