import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeTranslationService extends LocalTranslationService {
  _FakeTranslationService() : super(targetLanguage: 'Spanish');

  final List<String> requests = [];

  @override
  Future<String> translateEnglishDefinition(String definition,
      {String? hanzi}) async {
    requests.add(definition);
    return 'China en espagnol';
  }
}

void main() {
  testWidgets(
      'scanner result shows French and honors the English definition preference',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      'app_locale': 'fr',
      'use_english_definitions': false,
    });
    final prefs = await SharedPreferences.getInstance();
    final translationService = _FakeTranslationService();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        localTranslationServiceProvider.overrideWithValue(translationService),
      ],
    );
    addTearDown(container.dispose);

    final word = AiWord(
      hanzi: '中国',
      pinyin: 'Zhōngguó',
      meaning: 'Chine',
      english: 'China',
      hskLevel: 1,
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: ScannerResultDefinition(
              word: word,
              resultLanguage: 'French',
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Chine'), findsOneWidget);
    expect(find.text('China'), findsNothing);

    await container
        .read(settingsProvider.notifier)
        .toggleUseEnglishDefinitions(true);
    await tester.pump();

    expect(find.text('China'), findsOneWidget);
    expect(find.text('Chine'), findsNothing);

    await container
        .read(settingsProvider.notifier)
        .toggleUseEnglishDefinitions(false);
    await container
        .read(translationLanguageProvider.notifier)
        .setLanguage('Spanish');
    await tester.pumpAndSettle();

    expect(translationService.requests, ['China']);
    expect(find.text('China en espagnol'), findsOneWidget);
    expect(find.text('Chine'), findsNothing);
  });
}
