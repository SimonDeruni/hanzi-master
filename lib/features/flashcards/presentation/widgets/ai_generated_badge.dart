import 'package:flutter/material.dart';

/// Legacy placeholder - AI Generated Badge and explanation sheet are disabled.
class AIGeneratedBadge extends StatelessWidget {
  final double fontSize;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double iconSize;

  const AIGeneratedBadge({
    super.key,
    this.fontSize = 10,
    this.margin = const EdgeInsets.only(bottom: 8),
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.iconSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
