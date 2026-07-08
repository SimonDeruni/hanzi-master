import 'package:flutter/material.dart';

class _SwipeBackDetector extends StatefulWidget {
  final Widget child;
  const _SwipeBackDetector({required this.child});

  @override
  State<_SwipeBackDetector> createState() => _SwipeBackDetectorState();
}

class _SwipeBackDetectorState extends State<_SwipeBackDetector> {
  double? _dragStartX;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: (details) {
        _dragStartX = details.globalPosition.dx;
      },
      onHorizontalDragEnd: (details) {
        final startX = _dragStartX;
        _dragStartX = null;
        if (startX != null && startX < 40 && details.primaryVelocity != null && details.primaryVelocity! > 500) {
          final navigator = Navigator.of(context);
          if (navigator.canPop()) navigator.pop();
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
