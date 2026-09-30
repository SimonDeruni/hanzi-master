import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/hanko_seal_stamp.dart';
import 'package:hanzi_master/core/services/zen_sound_service.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

class SwipeableFlashcard extends StatefulWidget {
  final Widget child;
  final bool isSwipeEnabled;
  final Function(int) onSwiped;

  const SwipeableFlashcard({
    super.key,
    required this.child,
    this.isSwipeEnabled = true,
    required this.onSwiped,
  });

  @override
  State<SwipeableFlashcard> createState() => _SwipeableFlashcardState();
}

class _SwipeableFlashcardState extends State<SwipeableFlashcard>
    with TickerProviderStateMixin {
  Offset _panOffset = Offset.zero;
  bool _isAnimatingStamp = false;

  // Stamp impact animation
  late AnimationController _stampController;
  late Animation<double> _stampScaleAnimation;
  HankoSealData? _activeSeal;

  // Slide off-screen animation
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _stampController = AnimationController(
      vsync: this,
      duration: ZenMotion.tap,
    );
    _stampScaleAnimation = Tween<double>(begin: 1.25, end: 1.0).animate(
      CurvedAnimation(parent: _stampController, curve: ZenMotion.arrival),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: ZenMotion.swap,
    );
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(_slideController);
  }

  @override
  void dispose() {
    _stampController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (!widget.isSwipeEnabled || _isAnimatingStamp) return;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isSwipeEnabled || _isAnimatingStamp) return;
    setState(() {
      _panOffset += details.delta;
      _activeSeal = _resolveSealFromOffset(_panOffset);
    });
  }

  HankoSealData? _resolveSealFromOffset(Offset offset) {
    if (offset.dx < -50) return HankoSealData.again;
    if (offset.dx > 50) return HankoSealData.good;
    if (offset.dy < -50) return HankoSealData.easy;
    if (offset.dy > 50) return HankoSealData.hard;
    return null;
  }

  Future<void> _onPanEnd(DragEndDetails details) async {
    if (!widget.isSwipeEnabled || _isAnimatingStamp) return;

    int? resolvedGrade;
    Offset exitDirection = Offset.zero;

    // Thresholds
    if (_panOffset.dx < -120) {
      resolvedGrade = 0; // Again
      exitDirection = const Offset(-600, 0);
    } else if (_panOffset.dx > 120) {
      resolvedGrade = 4; // Good
      exitDirection = const Offset(600, 0);
    } else if (_panOffset.dy < -120) {
      resolvedGrade = 5; // Easy
      exitDirection = const Offset(0, -600);
    } else if (_panOffset.dy > 120) {
      resolvedGrade = 2; // Hard
      exitDirection = const Offset(0, 600);
    }

    if (resolvedGrade != null) {
      _isAnimatingStamp = true;
      _activeSeal = HankoSealData.fromGrade(resolvedGrade);

      // Reduced motion: register the grade instantly instead of stamping a seal
      // and sliding the card off screen.
      if (context.reduceMotion) {
        setState(() {
          _isAnimatingStamp = false;
          _activeSeal = null;
          _panOffset = Offset.zero;
        });
        widget.onSwiped(resolvedGrade);
        return;
      }

      // Phase 1: Stamp impact animation (1.25 -> 1.0 with haptic tap)
      await _stampController.forward(from: 0.0);
      ZenSoundService.instance.playSealStamp();
      // Fired, not awaited: the exit below must never queue behind the haptic
      // channel — it is feedback for a gesture that has already happened. This
      // also matches how the rest of the app calls `HapticsManager`.
      unawaited(HapticsManager.medium());

      // Brief tactile pause so user perceives the stamped seal
      await Future.delayed(const Duration(milliseconds: 90));

      if (!mounted) return;

      // Phase 2: Slide off screen
      _slideAnimation = Tween<Offset>(
        begin: _panOffset,
        end: _panOffset + exitDirection,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: ZenMotion.natural,
        ),
      );

      await _slideController.forward(from: 0.0);

      if (mounted) {
        widget.onSwiped(resolvedGrade);
      }
    } else {
      // Spring back to center
      setState(() {
        _panOffset = Offset.zero;
        _activeSeal = null;
      });
    }
  }

  /// The study card's width cap.
  ///
  /// [ZenContentWidth.study] was declared for exactly this surface — *"A study
  /// surface (flashcard, quiz)"* — and was never applied by anything. See [build]
  /// for why leaving it unbounded is what made the mastery seal land off-screen
  /// on an iPad.
  static const double _maxCardWidth = ZenContentWidth.study;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // **Why the cap belongs here.** The seal is pinned 24dp from the card's
        // right edge, and the whole stack above the painter is rotated about the
        // card's *centre*. Unbounded, that corner sits ~450dp from the pivot on
        // a 1024dp iPad but only ~150dp on a phone, so the very same tilt — up
        // to 13.7° at the 120dp grade threshold — flings the seal ~100dp on iPad
        // against ~35dp on a phone; with the simultaneous 120dp translation it
        // left the window and got sliced. Capping the surface shortens that lever
        // arm to phone-like numbers, and leaves ~300dp of window either side of
        // the seal at full swipe.
        //
        // Height is preserved so the card still fills its pane, and a host
        // narrower than the cap is bit-for-bit unchanged.
        final double width = constraints.maxWidth.isFinite
            ? math.min(constraints.maxWidth, _maxCardWidth)
            : _maxCardWidth;
        return Center(
          child: SizedBox(
            width: width,
            height:
                constraints.maxHeight.isFinite ? constraints.maxHeight : null,
            child: _buildCard(_panOffset.dx * 0.002),
          ),
        );
      },
    );
  }

  /// The card itself, at its final — possibly capped — size.
  Widget _buildCard(double rotateAngle) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedBuilder(
        animation: Listenable.merge([_slideController, _stampController]),
        builder: (context, _) {
          final currentOffset =
              _isAnimatingStamp && _slideController.isAnimating
                  ? _slideAnimation.value
                  : _panOffset;

          final double currentScale =
              _isAnimatingStamp ? _stampScaleAnimation.value : 1.18;

          final double currentOpacity =
              _isAnimatingStamp ? 1.0 : (_activeSeal != null ? 0.85 : 0.0);

          return Transform(
            transform: Matrix4.translationValues(
              currentOffset.dx,
              currentOffset.dy,
              0,
            )..rotateZ(rotateAngle),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                widget.child,
                // Hanko Seal Stamp in upper corner
                if (_activeSeal != null)
                  Positioned(
                    top: 24,
                    right: 24,
                    child: HankoSealStamp(
                      data: _activeSeal!,
                      scale: currentScale,
                      opacity: currentOpacity,
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
