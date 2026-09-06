import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/localization/app_locale_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('uses and persists the first supported phone locale on first launch',
      () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final locale = await initializeAppLocale(
      preferences: preferences,
      preferredLocales: const [Locale('nl'), Locale('fr', 'CA')],
    );

    expect(locale, 'fr');
    expect(preferences.getString(appLocalePreferenceKey), 'fr');
  });

  test('falls back to English when none of the phone locales is supported',
      () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final locale = await initializeAppLocale(
      preferences: preferences,
      preferredLocales: const [Locale('nl'), Locale('pl')],
    );

    expect(locale, fallbackAppLocaleCode);
    expect(preferences.getString(appLocalePreferenceKey), 'en');
  });

  test('does not replace an existing valid app language', () async {
    SharedPreferences.setMockInitialValues({appLocalePreferenceKey: 'de'});
    final preferences = await SharedPreferences.getInstance();

    final locale = await initializeAppLocale(
      preferences: preferences,
      preferredLocales: const [Locale('fr')],
    );

    expect(locale, 'de');
    expect(preferences.getString(appLocalePreferenceKey), 'de');
  });

  test('activeSupportedLocales contains exactly the 13 LTR locales and excludes Arabic', () {
    final codes = activeSupportedLocales.map((l) => l.languageCode).toSet();
    expect(codes.contains('ar'), isFalse);
    expect(codes.length, 13);
    expect(codes, containsAll({'en', 'de', 'es', 'fr', 'hi', 'id', 'it', 'ja', 'ko', 'pt', 'ru', 'th', 'vi'}));
  });

  test('falls back to English when phone locale is Arabic', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final locale = await initializeAppLocale(
      preferences: preferences,
      preferredLocales: const [Locale('ar', 'EG'), Locale('ar')],
    );

    expect(locale, fallbackAppLocaleCode);
    expect(preferences.getString(appLocalePreferenceKey), 'en');
  });

  test('sanitizes existing saved Arabic locale back to English', () async {
    SharedPreferences.setMockInitialValues({appLocalePreferenceKey: 'ar'});
    final preferences = await SharedPreferences.getInstance();

    final locale = await initializeAppLocale(
      preferences: preferences,
      preferredLocales: const [Locale('ar')],
    );

    expect(locale, fallbackAppLocaleCode);
    expect(preferences.getString(appLocalePreferenceKey), 'en');
  });
}
