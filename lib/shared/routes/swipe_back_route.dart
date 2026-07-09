import 'package:flutter/material.dart';

class _SwipeBackDetector extends StatefulWidget {
  final Widget child;
  const _SwipeBackDetector({required this.child});

  @override
  State<_SwipeBackDetector> createState() => _SwipeBackDetectorState();
}

class _SwipeBackDetectorState extends State<_SwipeBackDetector> {
  double? _dragStartX;
  double _dragDistance = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: (details) {
        _dragStartX = details.globalPosition.dx;
        _dragDistance = 0;
      },
      onHorizontalDragUpdate: (details) {
        if (_dragStartX != null && _dragStartX! < 40) {
          _dragDistance += details.primaryDelta ?? 0;
        }
      },
      onHorizontalDragEnd: (details) {
        final startX = _dragStartX;
        final distance = _dragDistance;
        _dragStartX = null;
        _dragDistance = 0;
        if (startX != null && startX < 40) {
          final velocity = details.primaryVelocity ?? 0;
          if (distance > 80 || velocity > 500) {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) navigator.pop();
          }
        }
      },
      child: widget.child,
    );
  }
}

class SwipeBackPageRoute<T> extends MaterialPageRoute<T> {
  SwipeBackPageRoute({required super.builder, super.settings, super.maintainState, super.fullscreenDialog});

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: _SwipeBackDetector(child: builder(context)),
    );
  }
}
