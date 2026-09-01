import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/flashcards/presentation/providers/settings_controller.dart';

final translationLanguageProvider =
    StateNotifierProvider<TranslationLanguageNotifier, String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final appLocale = ref.read(settingsProvider).locale;
  return TranslationLanguageNotifier(prefs, appLocale: appLocale);
});

class TranslationLanguageNotifier extends StateNotifier<String> {
  static const String preferenceKey = 'translation_target_language';

  final SharedPreferences _prefs;

  TranslationLanguageNotifier(this._prefs, {required String appLocale})
      : super(_initialLanguage(_prefs, appLocale));

  static String _initialLanguage(SharedPreferences prefs, String appLocale) {
    final savedLanguage = prefs.getString(preferenceKey);
    if (savedLanguage != null &&
        supportedTranslationLanguages.contains(savedLanguage)) {
      return savedLanguage;
    }
    return translationLanguageForLocale(appLocale);
  }

  Future<void> setLanguage(String language) async {
    if (!supportedTranslationLanguages.contains(language)) return;
    await _prefs.setString(preferenceKey, language);
    state = language;
  }
}

String translationLanguageForLocale(String locale) {
  switch (locale.toLowerCase().split(RegExp('[-_]')).first) {
    case 'ar':
      return 'Arabic';
    case 'de':
      return 'German';
    case 'es':
      return 'Spanish';
    case 'fr':
      return 'French';
    case 'hi':
      return 'Hindi';
    case 'id':
      return 'Indonesian';
    case 'it':
      return 'Italian';
    case 'ja':
      return 'Japanese';
    case 'ko':
      return 'Korean';
    case 'pt':
      return 'Portuguese';
    case 'ru':
      return 'Russian';
    case 'vi':
      return 'Vietnamese';
    case 'th':
      return 'Thai';
    default:
      return 'English';
  }
}

const List<String> supportedTranslationLanguages = [
  'English',
  'French',
  'Spanish',
  'German',
  'Italian',
  'Japanese',
  'Korean',
  'Portuguese',
  'Russian',
  'Hindi',
  'Arabic',
  'Indonesian',
  'Vietnamese',
  'Thai',
];

/// Partner language is locked to Mandarin/Chinese — the app's target language.
const List<String> supportedPartnerLanguages = [
  'Mandarin',
];
