import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/character_chat_sheet.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';

class _NoOpTranslationService extends LocalTranslationService {
  _NoOpTranslationService() : super(targetLanguage: 'French');

  @override
  Future<String> translateEnglishDefinition(String definition,
          {String? hanzi}) async =>
      definition;
}

void main() {
  test('all quick-prompt payloads are localized in every supported locale',
      () async {
    final english = await AppLocalizations.delegate.load(const Locale('en'));
    final englishPrompts = characterChatPrompts(english);

    expect(englishPrompts, hasLength(16));
    expect(englishPrompts[4].prompt, isNot(englishPrompts[5].prompt));

    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = await AppLocalizations.delegate.load(locale);
      final prompts = characterChatPrompts(l10n);
      final expected = [
        l10n.whatIsTheOracleBoneScriptOriginOfTh,
        l10n.howDidTheAncientFormOfThisCharacter,
        l10n.giveMe3CommonWordsThatContainThisCh,
        l10n.whatOtherCharactersShareTheSameRadi,
        l10n.isThereAChineseIdiomFeaturingThisCharacter,
        l10n.isThereAChineseProverbOrSayingFeatu,
        l10n.explainTheStrokeOrderRulesForThisCh,
        l10n.giveMeOneCalligraphyTipForWritingTh,
        l10n.isThereAnythingTrickyAboutUsingThis,
        l10n.whatWordsAreCommonlyConfusedWithThi,
        l10n.doesThisCharacterCarryCulturalSymbo,
        l10n.isThisCharacterCommonlySeenInChines,
        l10n.whatDoesTheRadicalOfThisCharacterMe,
        l10n.breakDownEveryComponentAndItsMeanin,
        l10n.giveMeATrickToRememberTheCorrectTon,
        l10n.areThereCommonHomophonesThatAreOfte,
      ];

      expect(
        prompts.map((prompt) => prompt.prompt),
        orderedEquals(expected),
        reason: 'Incorrect payload mapping for ${locale.languageCode}',
      );
      expect(
        prompts.every((prompt) => prompt.prompt.trim().isNotEmpty),
        isTrue,
        reason: 'Empty payload for ${locale.languageCode}',
      );
      expect(
        prompts[4].prompt,
        isNot(prompts[5].prompt),
        reason:
            'Idiom and proverb payloads must differ in ${locale.languageCode}',
      );

      if (locale.languageCode != 'en') {
        for (var i = 0; i < prompts.length; i++) {
          expect(
            prompts[i].prompt,
            isNot(englishPrompts[i].prompt),
            reason:
                'English payload fallback at index $i for ${locale.languageCode}',
          );
        }
      }
    }
  });

  testWidgets('origin story chip sends and displays the French prompt',
      (tester) async {
    String? sentMessage;
    SharedPreferences.setMockInitialValues({'app_locale': 'fr', AiConsentSheet.prefKey: true});
    final preferences = await SharedPreferences.getInstance();
    await tester.binding.setSurfaceSize(const Size(1000, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          localTranslationServiceProvider
              .overrideWithValue(_NoOpTranslationService()),
        ],
        child: MaterialApp(
          locale: const Locale('fr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CharacterChatSheet(
              hanzi: '网',
              pinyin: 'wǎng',
              definition: 'net',
              messageSender: (message) async {
                sentMessage = message;
                return 'Réponse du tuteur';
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text("📜 Histoire d'origine"));
    await tester.pumpAndSettle();

    const frenchPrompt =
        "Quelle est l'origine de ce caractère dans l'écriture oraculaire (ossécaille) ?";
    expect(sentMessage, frenchPrompt);
    expect(find.text(frenchPrompt), findsOneWidget);
    expect(
      find.text('What is the oracle bone script origin of this character?'),
      findsNothing,
    );
  });

  testWidgets(
      'CharacterChatSheet queries translator with hanzi and displays translated French definition',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      'app_locale': 'fr',
      'translation_target_language': 'French',
      'use_english_definitions': false,
    });
    final preferences = await SharedPreferences.getInstance();
    await tester.binding.setSurfaceSize(const Size(1000, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    String? passedHanzi;
    final mockTranslationService = _MockFrenchTranslationService(
      onTranslate: (def, hanzi) {
        passedHanzi = hanzi;
        if (hanzi == '专注') {
          return 'se concentrer / concentré';
        }
        return def;
      },
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          translationLanguageProvider.overrideWith(
              (ref) => TranslationLanguageNotifier(preferences, appLocale: 'fr')),
          localTranslationServiceProvider
              .overrideWithValue(mockTranslationService),
        ],
        child: MaterialApp(
          locale: const Locale('fr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CharacterChatSheet(
              hanzi: '专注',
              pinyin: 'zhuānzhù',
              definition: 'to focus; to direct attention',
              messageSender: (_) async => 'OK',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(passedHanzi, '专注');
    expect(find.text('se concentrer / concentré'), findsOneWidget);
  });
}

class _MockFrenchTranslationService extends LocalTranslationService {
  final String Function(String definition, String? hanzi) onTranslate;

  _MockFrenchTranslationService({required this.onTranslate})
      : super(targetLanguage: 'French');

  @override
  Future<String> translateEnglishDefinition(String definition,
          {String? hanzi}) async =>
      onTranslate(definition, hanzi);
}
