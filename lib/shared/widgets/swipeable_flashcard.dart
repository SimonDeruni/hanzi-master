import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

class _SwipeableFlashcardState extends State<SwipeableFlashcard> {
  Offset _panOffset = Offset.zero;
  bool _isSwiping = false;

  void _onPanStart(DragStartDetails details) {
    if (!widget.isSwipeEnabled) return;
    setState(() => _isSwiping = true);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isSwipeEnabled) return;
    setState(() => _panOffset += details.delta);
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isSwipeEnabled) return;
    
    setState(() => _isSwiping = false);
    
    // Thresholds
    if (_panOffset.dx < -120) {
      widget.onSwiped(0); // Again
    } else if (_panOffset.dx > 120) {
      widget.onSwiped(4); // Good
    } else if (_panOffset.dy < -120) {
      widget.onSwiped(5); // Easy
    } else if (_panOffset.dy > 120) {
      widget.onSwiped(2); // Hard
    } else {
      // Spring back
      setState(() => _panOffset = Offset.zero);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double rotateAngle = _panOffset.dx * 0.002;
    
    // Add overlays based on pan offset
    String overlayText = "";
    Color overlayColor = Colors.transparent;
    
    if (_panOffset.dx < -50) { overlayText = "AGAIN"; overlayColor = Colors.red; }
    else if (_panOffset.dx > 50) { overlayText = "GOOD"; overlayColor = Colors.green; }
    else if (_panOffset.dy < -50) { overlayText = "EASY"; overlayColor = Colors.blue; }
    else if (_panOffset.dy > 50) { overlayText = "HARD"; overlayColor = Colors.orange; }

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedContainer(
        duration: _isSwiping ? Duration.zero : 300.ms,
        curve: Curves.easeOutBack,
        transform: Matrix4.translationValues(_panOffset.dx, _panOffset.dy, 0)
          ..rotateZ(rotateAngle),
        child: Stack(
          children: [
            widget.child,
            if (overlayText.isNotEmpty)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: overlayColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: -0.2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: overlayColor, width: 4),
                          borderRadius: BorderRadius.circular(12),
                          color: isDark ? Colors.black87 : Colors.white.withValues(alpha: 0.9),
                        ),
                        child: Text(
                          overlayText,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: overlayColor,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
