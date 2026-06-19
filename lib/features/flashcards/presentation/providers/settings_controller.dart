import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. THE STATE CLASS (What we remember)
class SettingsState {
  final bool isDarkMode;
  final double speechRate; // 0.0 to 1.0
  final double animationSpeed; // 0.5 to 2.0
  final bool hasCompletedOnboarding;
  final bool isTutorialCompleted; // The Scroll of Origin
  final int guideDisappearanceStreak;
  
  // Phase 2 Settings
  final bool isHardMode;
  final bool autoPlayAudio;
  final bool hapticsEnabled;
  final int dailyGoal;
  final String locale;

  SettingsState({
    this.isDarkMode = false, 
    this.speechRate = 0.5, 
    this.animationSpeed = 1.0,
    this.hasCompletedOnboarding = false,
    this.isTutorialCompleted = false,
    this.guideDisappearanceStreak = 2,
    this.isHardMode = false,
    this.autoPlayAudio = false,
    this.hapticsEnabled = true,
    this.dailyGoal = 50,
    this.locale = 'en',
  });

  SettingsState copyWith({
    bool? isDarkMode, 
    double? speechRate, 
    double? animationSpeed,
    bool? hasCompletedOnboarding,
    bool? isTutorialCompleted,
    int? guideDisappearanceStreak,
    bool? isHardMode,
    bool? autoPlayAudio,
    bool? hapticsEnabled,
    int? dailyGoal,
    String? locale,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      speechRate: speechRate ?? this.speechRate,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      isTutorialCompleted: isTutorialCompleted ?? this.isTutorialCompleted,
      guideDisappearanceStreak: guideDisappearanceStreak ?? this.guideDisappearanceStreak,
      isHardMode: isHardMode ?? this.isHardMode,
      autoPlayAudio: autoPlayAudio ?? this.autoPlayAudio,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      locale: locale ?? this.locale,
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
    guideDisappearanceStreak: prefs.getInt(_keyGuideStreak) ?? 2,
    isHardMode: prefs.getBool(_keyHardMode) ?? false,
    autoPlayAudio: prefs.getBool(_keyAutoPlay) ?? false,
    hapticsEnabled: prefs.getBool(_keyHaptics) ?? true,
    dailyGoal: prefs.getInt(_keyDailyGoal) ?? 50,
    locale: prefs.getString(_keyLocale) ?? 'en',
  ));

  static const _keyTheme = 'is_dark_mode';
  static const _keySpeed = 'speech_rate';
  static const _keyAnimationSpeed = 'animation_speed';
  static const _keyOnboarding = 'has_completed_onboarding';
  static const _keyTutorial = 'tutorial_completed';
  static const _keyGuideStreak = 'guide_disappearance_streak';
  static const _keyHardMode = 'hard_mode_enabled';
  static const _keyAutoPlay = 'auto_play_audio';
  static const _keyHaptics = 'haptics_enabled';
  static const _keyDailyGoal = 'daily_goal';
  static const _keyLocale = 'app_locale';

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

  Future<void> setGuideDisappearanceStreak(int value) async {
    await prefs.setInt(_keyGuideStreak, value);
    state = state.copyWith(guideDisappearanceStreak: value);
  }

  Future<void> toggleHardMode(bool value) async {
    await prefs.setBool(_keyHardMode, value);
    state = state.copyWith(isHardMode: value);
  }

  Future<void> toggleAutoPlayAudio(bool value) async {
    await prefs.setBool(_keyAutoPlay, value);
    state = state.copyWith(autoPlayAudio: value);
  }

  Future<void> toggleHaptics(bool value) async {
    await prefs.setBool(_keyHaptics, value);
    state = state.copyWith(hapticsEnabled: value);
  }

  Future<void> setDailyGoal(int value) async {
    await prefs.setInt(_keyDailyGoal, value);
    state = state.copyWith(dailyGoal: value);
  }

  Future<void> setLocale(String value) async {
    await prefs.setString(_keyLocale, value);
    state = state.copyWith(locale: value);
  }
}

// 3. THE PROVIDER (To access it)
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final settingsProvider = StateNotifierProvider<SettingsController, SettingsState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsController(prefs);
});
