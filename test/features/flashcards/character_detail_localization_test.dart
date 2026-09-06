import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _personCard = Flashcard(
  id: 'person',
  hanzi: '人',
  pinyin: 'rén',
  definition: 'A human being',
  hskLevel: 1,
  strokePaths: ['M 0 0'],
  modeStats: {},
);

class _InMemoryFlashcardController extends FlashcardController {
  _InMemoryFlashcardController([this.cards = const [_personCard]]);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;

  @override
  Future<Flashcard?> loadStrokesFor(Flashcard card) async => card;
}

class _NoOpTranslationService extends LocalTranslationService {
  _NoOpTranslationService() : super(targetLanguage: 'French');

  final List<String> requests = [];

  @override
  Future<String> translateEnglishDefinition(String definition,
      {String? hanzi}) async {
    requests.add(definition);
    return definition;
  }
}

void main() {
  testWidgets('character anatomy uses the French radical catalog',
      (tester) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final preferences = await SharedPreferences.getInstance();
    final radical = await LocalizedCatalogService.getRadicalData('人', 'fr');
    expect(radical?['name'], 'Personne');

    await tester.binding.setSurfaceSize(const Size(1000, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          localTranslationServiceProvider
              .overrideWithValue(_NoOpTranslationService()),
          flashcardControllerProvider
              .overrideWith(_InMemoryFlashcardController.new),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: CharacterDetailScreen(card: _personCard),
        ),
      ),
    );
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 500)),
    );
    for (var attempt = 0;
        attempt < 20 && find.text('人 ANATOMIE').evaluate().isEmpty;
        attempt++) {
      await tester.pump(const Duration(milliseconds: 100));
      final exception = tester.takeException();
      if (exception != null &&
          !exception.toString().contains('RenderFlex overflowed')) {
        throw exception;
      }
    }
    expect(find.text('人 ANATOMIE'), findsOneWidget);
    expect(find.text('Personne'), findsOneWidget);
    expect(find.text('Une personne debout.'), findsOneWidget);

    expect(find.text('人 ANATOMY'), findsNothing);
    expect(find.text('Person'), findsNothing);
    expect(find.text('A person standing.'), findsNothing);
  });

  testWidgets('does not retranslate a localized French card definition',
      (tester) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final preferences = await SharedPreferences.getInstance();
    final translationService = _NoOpTranslationService();
    const frenchDefinition =
        "n’est-ce pas, interjection employée comme question-tag pour inviter à l’approbation";
    const card = Flashcard(
      id: 'reported-fu-shi',
      hanzi: '弗是',
      pinyin: 'fú shì',
      definition: frenchDefinition,
      definitionLanguage: 'French',
      hskLevel: 0,
      strokePaths: [],
      modeStats: {},
    );

    await tester.binding.setSurfaceSize(const Size(1000, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          localTranslationServiceProvider.overrideWithValue(translationService),
          flashcardControllerProvider.overrideWith(
            () => _InMemoryFlashcardController(const [card]),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: CharacterDetailScreen(card: card),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(frenchDefinition), findsOneWidget);
    expect(translationService.requests, isEmpty);
  });

  testWidgets('separates compound words from contextual character content',
      (tester) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final preferences = await SharedPreferences.getInstance();
    const compound = Flashcard(
      id: 'people',
      hanzi: '人民',
      pinyin: 'ren2 min2',
      definition: 'le peuple',
      definitionLanguage: 'French',
      hskLevel: 1,
      strokePaths: [],
      modeStats: {},
    );
    final contextData = GeminiContext(
      mnemonic: 'Un moyen mnémotechnique distinct.',
      sentences: [
        ExampleSentence(
          chinese: '人民很好。',
          pinyin: 'Rénmín hěn hǎo.',
          english: 'Le peuple va bien.',
        ),
      ],
      lookAlikes: [
        LookAlike(
          character: '入',
          pinyin: 'rù',
          english: 'entrer',
          difference: 'Le trait de gauche commence plus haut.',
        ),
      ],
    );

    await tester.binding.setSurfaceSize(const Size(500, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          localTranslationServiceProvider
              .overrideWithValue(_NoOpTranslationService()),
          flashcardControllerProvider
              .overrideWith(_InMemoryFlashcardController.new),
          commonWordsProvider.overrideWith(
            (ref, character) async => const [compound],
          ),
          characterContextProvider.overrideWith(
            (ref, card) async => contextData,
          ),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: CharacterDetailScreen(card: _personCard),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('MOTS COURANTS'), findsOneWidget);
    expect(find.text('人民'), findsOneWidget);
    expect(find.text('rén mín'), findsOneWidget);
    expect(find.text('le peuple'), findsOneWidget);

    expect(
        find.byKey(const ValueKey('context-section-heading')), findsOneWidget);
    expect(find.text('CONTEXTE'), findsOneWidget);
    expect(find.text('Ancrage Mémoriel IA'), findsNothing);
    expect(find.text('Un moyen mnémotechnique distinct.'), findsNothing);
    expect(find.text("PHRASES D'EXEMPLE"), findsOneWidget);

    final wordsBottom = tester.getBottomLeft(find.text('le peuple')).dy;
    final contextTop = tester
        .getTopLeft(find.byKey(const ValueKey('context-section-heading')))
        .dy;
    expect(contextTop, greaterThan(wordsBottom));

    // DrawingCanvas schedules a one-shot delayed animation after settling.
    await tester.pump(const Duration(seconds: 3));
  });
}
