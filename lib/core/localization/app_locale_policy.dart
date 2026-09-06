import 'package:flutter/widgets.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

const appLocalePreferenceKey = 'app_locale';
const fallbackAppLocaleCode = 'en';

/// Locales that are temporarily deferred from active app selection
/// (e.g. RTL languages pending a dedicated future full-app RTL QA phase).
const deferredAppLocaleCodes = {'ar'};

/// The active supported locales exposed to MaterialApp and the UI (13 LTR languages).
List<Locale> get activeSupportedLocales => AppLocalizations.supportedLocales
    .where((locale) =>
        !deferredAppLocaleCodes.contains(locale.languageCode.toLowerCase()))
    .toList();

String resolvePreferredAppLocale(Iterable<Locale> preferredLocales) {
  final supportedCodes = activeSupportedLocales
      .map((locale) => locale.languageCode.toLowerCase())
      .toSet();

  for (final locale in preferredLocales) {
    final languageCode = locale.languageCode.toLowerCase();
    if (supportedCodes.contains(languageCode)) return languageCode;
  }
  return fallbackAppLocaleCode;
}

Future<String> initializeAppLocale({
  required SharedPreferences preferences,
  required Iterable<Locale> preferredLocales,
}) async {
  final savedLocale = preferences.getString(appLocalePreferenceKey);
  if (savedLocale != null &&
      savedLocale.trim().isNotEmpty &&
      !deferredAppLocaleCodes.contains(savedLocale.toLowerCase())) {
    return savedLocale;
  }

  final locale = resolvePreferredAppLocale(preferredLocales);
  await preferences.setString(appLocalePreferenceKey, locale);
  return locale;
}
