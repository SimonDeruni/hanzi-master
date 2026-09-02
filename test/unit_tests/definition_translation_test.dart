import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeTranslationService extends LocalTranslationService {
  _FakeTranslationService() : super(targetLanguage: 'French');

  final List<String> requests = [];
  final translation = Completer<String>();

  @override
  Future<String> translateEnglishDefinition(String definition,
      {String? hanzi}) async {
    requests.add(definition);
    return translation.future;
  }
}

void main() {
  group('definition language settings', () {
    test('maps every supported app locale to a translation language', () {
      expect(translationLanguageForLocale('en'), 'English');
      expect(translationLanguageForLocale('fr-FR'), 'French');
      expect(translationLanguageForLocale('pt_BR'), 'Portuguese');
      expect(translationLanguageForLocale('ja'), 'Japanese');
      expect(translationLanguageForLocale('th'), 'Thai');
      expect(translationLanguageForLocale('unknown'), 'English');
    });

    test('translation language defaults to app locale and persists separately',
        () async {
      SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      addTearDown(container.dispose);

      expect(container.read(translationLanguageProvider), 'French');

      await container
          .read(translationLanguageProvider.notifier)
          .setLanguage('Japanese');

      expect(container.read(translationLanguageProvider), 'Japanese');
      expect(prefs.getString('translation_target_language'), 'Japanese');
      expect(container.read(settingsProvider).locale, 'fr');
    });

    test('English definition preference defaults false and persists', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final controller = SettingsController(prefs);

      expect(controller.state.useEnglishDefinitions, isFalse);
      await controller.toggleUseEnglishDefinitions(true);

      expect(controller.state.useEnglishDefinitions, isTrue);
      expect(prefs.getBool('use_english_definitions'), isTrue);
    });
  });

  testWidgets('translates the complete definition and reacts to preference',
      (tester) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('use_english_definitions', false);
    final service = _FakeTranslationService();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        localTranslationServiceProvider.overrideWithValue(service),
      ],
    );
    addTearDown(container.dispose);

    const definition =
        'to test; an examination (formal); example: a complete definition';
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: TranslatedDefinition(definition: definition),
          ),
        ),
      ),
    );

    expect(find.text(definition), findsOneWidget);
    await tester.pump();
    expect(service.requests, [definition]);
    service.translation.complete('Traduction complète');
    await tester.pumpAndSettle();
    expect(find.text('Traduction complète'), findsOneWidget);

    await container
        .read(settingsProvider.notifier)
        .toggleUseEnglishDefinitions(true);
    await tester.pump();
    expect(find.text(definition), findsOneWidget);
    expect(find.text('Traduction complète'), findsNothing);
  });

  for (final languageCase in <({String locale, String language, String text})>[
    (locale: 'fr', language: 'French', text: 'Définition française complète'),
    (locale: 'ja', language: 'Japanese', text: '完全な日本語の定義'),
  ]) {
    testWidgets(
        'does not retranslate an already localized ${languageCase.language} definition',
        (tester) async {
      SharedPreferences.setMockInitialValues(
          {'app_locale': languageCase.locale});
      final prefs = await SharedPreferences.getInstance();
      final service = _FakeTranslationService();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          localTranslationServiceProvider.overrideWithValue(service),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: TranslatedDefinition(
                definition: languageCase.text,
                definitionLanguage: languageCase.language,
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text(languageCase.text), findsOneWidget);
      expect(service.requests, isEmpty);
    });
  }
}
