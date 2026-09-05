import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';

final appLanguageControllerProvider = Provider<AppLanguageController>((ref) {
  return AppLanguageController(ref);
});

class AppLanguageController {
  AppLanguageController(this._ref);

  final Ref _ref;

  Future<void> setLanguage(String locale) async {
    final currentLocale = _ref.read(settingsProvider).locale;
    if (locale == currentLocale) return;

    // Update language-dependent services before rebuilding the application UI.
    await _ref
        .read(translationLanguageProvider.notifier)
        .setLanguage(translationLanguageForLocale(locale));
    await _ref.read(settingsProvider.notifier).setLocale(locale);
  }
}
