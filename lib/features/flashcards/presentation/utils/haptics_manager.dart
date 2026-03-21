import 'package:flutter/services.dart';

class HapticsManager {
  // Light tick for standard buttons (like typing)
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  // Medium thud for important actions (like revealing a card)
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  // Heavy vibration for errors or "Hard" ratings
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  // Selection tick
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }

  // Success vibration (double tick)
  static Future<void> success() async {
    // There isn't a direct "success" in standard Flutter, 
    // so we simulate it with two light ticks.
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.lightImpact();
  }

  // Error vibration (triple heavy tick)
  static Future<void> error() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }
}