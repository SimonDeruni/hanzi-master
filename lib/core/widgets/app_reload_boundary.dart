import 'package:flutter/widgets.dart';

/// Recreates all application UI state when the app language changes.
class AppReloadBoundary extends StatelessWidget {
  const AppReloadBoundary({
    super.key,
    required this.locale,
    required this.child,
  });

  final String locale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey<String>('app-locale-$locale'),
      child: child,
    );
  }
}
