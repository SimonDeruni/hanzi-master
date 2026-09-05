import 'package:flutter/material.dart';

abstract final class OnboardingDesign {
  static const backgroundLight = Color(0xFFFDFCF0);
  static const backgroundDark = Color(0xFF1A1A1B);

  static const horizontalPadding = 24.0;
  static const topPadding = 16.0;
  static const bottomPadding = 24.0;
  static const sectionSpacing = 24.0;

  static const titleFontSize = 32.0;
  static const bodyFontSize = 16.0;
  static const primaryButtonHeight = 56.0;
  static const primaryButtonRadius = 16.0;

  static const screenPadding = EdgeInsets.fromLTRB(
    horizontalPadding,
    topPadding,
    horizontalPadding,
    bottomPadding,
  );
}
