import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/services/zen_sound_service.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';

/// A Zen & Ink 3D perspective flip card widget.
///
/// Flips smoothly along the Y-axis over [ZenMotion.quick] using
/// [ZenMotion.natural], delivering the tactile sensation of flipping Xuan
/// parchment.
class ZenFlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final bool isFlipped;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onTap;

  const ZenFlipCard({
    super.key,
    required this.front,
    required this.back,
    required this.isFlipped,
    this.duration = ZenMotion.quick,
    this.curve = ZenMotion.natural,
    this.onTap,
  });

  @override
  State<ZenFlipCard> createState() => _ZenFlipCardState();
}

class _ZenFlipCardState extends State<ZenFlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.isFlipped ? 1.0 : 0.0,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(covariant ZenFlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    if (widget.isFlipped != oldWidget.isFlipped) {
      ZenSoundService.instance.playPaperFlip();
      // Turning a card over is the signature gesture of a flashcard app, so it
      // earns the "reveal" impact - in both directions - beside the paper sound.
      HapticsManager.medium();
      // Reduced motion: present the target face without the 3D rotation.
      if (context.reduceMotion) {
        _controller.value = widget.isFlipped ? 1.0 : 0.0;
      } else if (widget.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final value = _animation.value;
          final isBack = value > 0.5;
          final double angle = value * math.pi;

          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.0015);

          if (isBack) {
            transform.rotateY(angle - math.pi);
          } else {
            transform.rotateY(angle);
          }

          // Subtle Xuan paper lighting shimmer as card turns edge-on
          final lightIntensity = math.sin(value * math.pi) * 0.12;

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                isBack ? widget.back : widget.front,
                if (lightIntensity > 0.01)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: lightIntensity * 1.5),
                              Colors.black.withValues(alpha: lightIntensity * 0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
