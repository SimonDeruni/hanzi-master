import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. THE STATE CLASS (What we remember)
class SettingsState {
  final bool isDarkMode;
  final double speechRate; // 0.0 to 1.0
  final double animationSpeed; // 0.5 to 2.0
  final bool hasCompletedOnboarding;
  final bool isTutorialCompleted; // The Scroll of Origin

  SettingsState({
    this.isDarkMode = false, 
    this.speechRate = 0.5, 
    this.animationSpeed = 1.0,
    this.hasCompletedOnboarding = false,
    this.isTutorialCompleted = false,
  });

  SettingsState copyWith({
    bool? isDarkMode, 
    double? speechRate, 
    double? animationSpeed,
    bool? hasCompletedOnboarding,
    bool? isTutorialCompleted,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      speechRate: speechRate ?? this.speechRate,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      isTutorialCompleted: isTutorialCompleted ?? this.isTutorialCompleted,
    );
  }
}

// 2. THE CONTROLLER (The Brain)
class SettingsController extends StateNotifier<SettingsState> {
  final SharedPreferences prefs;

  SettingsController(this.prefs) : super(SettingsState(
    isDarkMode: prefs.getBool(_keyTheme) ?? false,
    speechRate: prefs.getDouble(_keySpeed) ?? 0.5,
    animationSpeed: prefs.getDouble(_keyAnimationSpeed) ?? 1.0,
    hasCompletedOnboarding: prefs.getBool(_keyOnboarding) ?? false,
    isTutorialCompleted: prefs.getBool(_keyTutorial) ?? false,
  ));

  static const _keyTheme = 'is_dark_mode';
  static const _keySpeed = 'speech_rate';
  static const _keyAnimationSpeed = 'animation_speed';
  static const _keyOnboarding = 'has_completed_onboarding';
  static const _keyTutorial = 'tutorial_completed';

  Future<void> completeTutorial() async {
    await prefs.setBool(_keyTutorial, true);
    state = state.copyWith(isTutorialCompleted: true);
  }

  Future<void> completeOnboarding() async {
    await prefs.setBool(_keyOnboarding, true);
    state = state.copyWith(hasCompletedOnboarding: true);
  }

  Future<void> toggleDarkMode(bool value) async {
    await prefs.setBool(_keyTheme, value);
    state = state.copyWith(isDarkMode: value);
  }

  Future<void> setSpeechRate(double value) async {
    await prefs.setDouble(_keySpeed, value);
    state = state.copyWith(speechRate: value);
  }

  Future<void> setAnimationSpeed(double value) async {
    await prefs.setDouble(_keyAnimationSpeed, value);
    state = state.copyWith(animationSpeed: value);
  }
}

// 3. THE PROVIDER (To access it)
// We throw UnimplementedError because we MUST override this in main.dart with the loaded SharedPreferences
final settingsProvider = StateNotifierProvider<SettingsController, SettingsState>((ref) {
  throw UnimplementedError("SettingsProvider must be overridden in main.dart");
});