import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final translationLanguageProvider = StateNotifierProvider<TranslationLanguageNotifier, String>((ref) {
  return TranslationLanguageNotifier();
});

class TranslationLanguageNotifier extends StateNotifier<String> {
  static const String _prefKey = 'translation_target_language';
  
  TranslationLanguageNotifier() : super('English') {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString(_prefKey);
    if (savedLang != null) {
      state = savedLang;
    }
  }

  Future<void> setLanguage(String language) async {
    state = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, language);
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
];
