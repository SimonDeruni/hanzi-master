import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/hanko_seal_stamp.dart';

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
      duration: const Duration(milliseconds: 130),
    );
    _stampScaleAnimation = Tween<double>(begin: 1.25, end: 1.0).animate(
      CurvedAnimation(parent: _stampController, curve: Curves.easeOutBack),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
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

      // Phase 1: Stamp impact animation (1.25 -> 1.0 with haptic tap)
      await _stampController.forward(from: 0.0);
      await HapticsManager.medium();

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
          curve: Curves.easeInOutQuart,
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

  @override
  Widget build(BuildContext context) {
    final double rotateAngle = _panOffset.dx * 0.002;

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedBuilder(
        animation: Listenable.merge([_slideController, _stampController]),
        builder: (context, _) {
          final currentOffset = _isAnimatingStamp && _slideController.isAnimating
              ? _slideAnimation.value
              : _panOffset;

          final double currentScale = _isAnimatingStamp
              ? _stampScaleAnimation.value
              : 1.18;

          final double currentOpacity = _isAnimatingStamp
              ? 1.0
              : (_activeSeal != null ? 0.85 : 0.0);

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
