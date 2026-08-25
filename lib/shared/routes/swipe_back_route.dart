import 'package:flutter/material.dart';

class _SwipeBackDetector extends StatefulWidget {
  final Widget child;
  const _SwipeBackDetector({required this.child});

  @override
  State<_SwipeBackDetector> createState() => _SwipeBackDetectorState();
}

class _SwipeBackDetectorState extends State<_SwipeBackDetector> {
  double _dragStartX = 0;
  double _dragDistance = 0;
  DateTime _lastPointerDown = DateTime.now();

  void _onPointerDown(PointerDownEvent event) {
    _dragStartX = event.position.dx;
    _dragDistance = 0;
    _lastPointerDown = DateTime.now();
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_dragStartX < 40) {
      final delta = event.position.dx - _dragStartX;
      _dragDistance = delta;
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    final startX = _dragStartX;
    final distance = _dragDistance;
    _dragStartX = 0;
    _dragDistance = 0;
    if (startX < 40 && distance > 0) {
      final duration = DateTime.now().difference(_lastPointerDown);
      final velocity = duration.inMilliseconds > 0
          ? distance / (duration.inMilliseconds / 1000)
          : 0.0;
      if (distance > 80 || velocity > 500) {
        final navigator = Navigator.of(context);
        if (navigator.canPop()) navigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 40,
          child: Listener(
            behavior: HitTestBehavior.deferToChild,
            onPointerDown: _onPointerDown,
            onPointerMove: _onPointerMove,
            onPointerUp: _onPointerUp,
          ),
        ),
      ],
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
