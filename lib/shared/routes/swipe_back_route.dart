import 'package:flutter/material.dart';

/// A page route that supports iOS-style swipe-back gesture.
/// The previous screen peeks out from behind the current one.
class SwipeBackRoute extends MaterialPageRoute {
  SwipeBackRoute({required super.builder});

  @override
  bool get fullscreenDialog => false;
}

/// Alias kept for backwards-compatibility — all existing call-sites use this name.
typedef SwipeBackPageRoute = SwipeBackRoute;
