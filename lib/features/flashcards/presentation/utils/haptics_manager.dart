import 'package:flutter/services.dart';

class HapticsManager {
  // Controlled by the user's settings toggle
  static bool _enabled = true;

  static void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  // Light tick for standard buttons (like typing)
  static Future<void> light() async {
    if (!_enabled) return;
    await HapticFeedback.lightImpact();
  }

  // Medium thud for important actions (like revealing a card)
  static Future<void> medium() async {
    if (!_enabled) return;
    await HapticFeedback.mediumImpact();
  }

  // Heavy vibration for errors or "Hard" ratings
  static Future<void> heavy() async {
    if (!_enabled) return;
    await HapticFeedback.heavyImpact();
  }

  // Selection tick
  static Future<void> selection() async {
    if (!_enabled) return;
    await HapticFeedback.selectionClick();
  }

  // Success vibration (double tick)
  static Future<void> success() async {
    if (!_enabled) return;
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.lightImpact();
  }

  // Error vibration (triple heavy tick)
  static Future<void> error() async {
    if (!_enabled) return;
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }
}
