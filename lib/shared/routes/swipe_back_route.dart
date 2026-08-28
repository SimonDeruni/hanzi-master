import 'package:flutter/material.dart';

/// A page route that supports iOS-style swipe-back gesture.
/// The previous screen peeks out from behind the current one.
class SwipeBackRoute<T> extends MaterialPageRoute<T> {
  SwipeBackRoute({required super.builder, super.settings});

  @override
  bool get fullscreenDialog => false;
}

/// Alias kept for backwards-compatibility — all existing call-sites use this name.
typedef SwipeBackPageRoute<T> = SwipeBackRoute<T>;

