import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/widget_service.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/progression/domain/study_progress.dart';
import 'package:hanzi_master/features/progression/presentation/screens/dashboard_screen.dart';
import 'package:hanzi_master/features/progression/presentation/widgets/today_insight_card.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _EmptyFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => const [];

  @override
  Future<Flashcard?> loadStrokesFor(Flashcard card) async => card;
}

class _EmptyDeckRepository implements DeckRepository {
  @override
  Future<Either<String, List<Deck>>> getDecks() async => const Right([]);

  @override
  Future<Either<String, Deck>> getDeckById(String id) async => Left(id);

  @override
  Future<Either<String, Deck>> createDeck(String name,
          {String description = ''}) async =>
      const Left('Not supported in this test');

  @override
  Future<Either<String, Deck>> updateDeck(Deck deck) async =>
      const Left('Not supported in this test');

  @override
  Future<Either<String, void>> deleteDeck(String id) async =>
      const Left('Not supported in this test');

  @override
  Future<Either<String, Deck>> ensureHSKDeckExists(int level) async =>
      const Left('Not supported in this test');

  @override
  Future<Either<String, Deck>> ensureThematicDeckExists(
    String id, {
    required String name,
    required String description,
  }) async =>
      const Left('Not supported in this test');
}

class _NoOpTranslationService extends LocalTranslationService {
  _NoOpTranslationService() : super(targetLanguage: 'French');

  @override
  Future<String> translateEnglishDefinition(String definition,
          {String? hanzi}) async =>
      definition;
}

class _RecordingNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushedRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }
}

void main() {
  testWidgets('quick actions sit directly below word of the day',
      (tester) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final preferences = await SharedPreferences.getInstance();
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          deckRepositoryProvider.overrideWithValue(_EmptyDeckRepository()),
          flashcardControllerProvider
              .overrideWith(_EmptyFlashcardController.new),
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
          home: DashboardScreen(onNavigate: (_) {}),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    final wordTop = tester
        .getTopLeft(find.byKey(const Key('dashboard_word_of_the_day')))
        .dy;
    final actionsTop =
        tester.getTopLeft(find.byKey(const Key('dashboard_quick_actions'))).dy;
    final progressTop = tester
        .getTopLeft(find.byKey(const Key('dashboard_practice_progress')))
        .dy;
    final searchTop =
        tester.getTopLeft(find.byKey(const Key('dashboard_search'))).dy;

    expect(wordTop, lessThan(actionsTop));
    expect(actionsTop, lessThan(progressTop));
    expect(progressTop, lessThan(searchTop));
    expect(find.text('Scanner'), findsOneWidget);
    expect(find.text('Interprète'), findsOneWidget);
  });

  testWidgets('dashboard practice and weekly cards are localized in French',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const emptyPeriod = ProgressPeriod(
      sessionCount: 0,
      cardsStudied: 0,
      totalAttempts: 0,
      correctAttempts: 0,
      duration: Duration.zero,
      activeDays: 0,
    );
    const progress = StudyProgress(
      todayCards: 0,
      dailyCardGoal: 10,
      currentStreak: 0,
      thisWeek: emptyPeriod,
      previousWeek: emptyPeriod,
    );

    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('fr'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: HabitProgressCards(progress: progress),
          ),
        ),
      ),
    );

    for (final text in <String>[
      'Pratique du jour',
      '0 / 10 cartes',
      'Un objectif simple et atteignable. Aucune pénalité pour un jour de repos.',
      'Cette semaine',
      'Cartes',
      'Précision',
      'Minutes',
      'Jours actifs',
      'Votre première semaine de pratique suivie',
    ]) {
      expect(find.text(text), findsOneWidget);
    }

    for (final text in <String>[
      'Today’s practice',
      '0 / 10 cards',
      'A small, achievable target. No penalty for a rest day.',
      'This week',
      'Cards',
      'Accuracy',
      'Active days',
      'Your first week of tracked practice',
    ]) {
      expect(find.text(text), findsNothing);
    }
  });

  testWidgets('bundled word of the day definition is immediately French',
      (tester) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final preferences = await SharedPreferences.getInstance();
    final word = wordOfTheDayVocabulary.singleWhere(
      (candidate) => candidate.hanzi == '温暖',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
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
            body: TranslatedDefinition(
              definition: word.definition,
              hanzi: word.hanzi,
              bundledTranslations: word.localizedDefinitions,
            ),
          ),
        ),
      ),
    );

    expect(find.text('chaleur · chaleureux'), findsOneWidget);
    expect(find.text('warmth · warm'), findsNothing);
  });

  testWidgets('word of the day opens character details without a saved card',
      (tester) async {
    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final preferences = await SharedPreferences.getInstance();
    final word = wordOfTheDayFor(DateTime.now());
    final navigatorObserver = _RecordingNavigatorObserver();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          localTranslationServiceProvider
              .overrideWithValue(_NoOpTranslationService()),
          flashcardControllerProvider
              .overrideWith(_EmptyFlashcardController.new),
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
          navigatorObservers: [navigatorObserver],
          home: const Scaffold(body: TodayInsightCard()),
        ),
      ),
    );
    await tester.pump();

    final tapTarget = tester.widget<InkWell>(
      find.descendant(
        of: find.byType(TodayInsightCard),
        matching: find.byType(InkWell),
      ),
    );
    expect(tapTarget.onTap, isNotNull);
    tapTarget.onTap!();
    await tester.pump();

    expect(navigatorObserver.pushedRoutes, hasLength(2));
    final card =
        navigatorObserver.pushedRoutes.last.settings.arguments as Flashcard;
    expect(card.hanzi, word.hanzi);
    expect(card.pinyin, word.pinyin);
    expect(card.definition, word.definition);
  });
}
