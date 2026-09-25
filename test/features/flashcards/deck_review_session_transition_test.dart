import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/daily_deck_activity.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/study_queue_builder.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/study_activity_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_review_session_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/reading_mode.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/hanko_seal_stamp.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';
import 'package:hanzi_master/shared/widgets/zen_flip_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Deck _deck = Deck(
  id: 'deck-a',
  name: 'Deck A',
  createdAt: DateTime(2026, 1, 1),
  dailyNewCardsLimit: 20,
  dailyReviewLimit: 50,
);

Flashcard _card(String hanzi) => Flashcard(
      id: 'card-$hanzi',
      deckId: 'deck-a',
      hanzi: hanzi,
      pinyin: 'pīn yīn',
      definition: 'definition',
      hskLevel: 1,
      strokePaths: const <String>[],
      modeStats: const <StudyMode, ReviewStats>{},
    );

class _FakeFlashcardController extends FlashcardController {
  _FakeFlashcardController(this.cards);

  final List<Flashcard> cards;
  final List<Flashcard> written = <Flashcard>[];

  @override
  Future<List<Flashcard>> build() async => cards;

  @override
  Future<List<Flashcard>> getCardsForDeck(String deckId) async =>
      cards.where((Flashcard card) => card.deckId == deckId).toList();

  // The persistence half runs in the background; the test only records it.
  @override
  Future<void> updateFlashcard(Flashcard card) async => written.add(card);
}

class _StubDeckRepository implements DeckRepository {
  @override
  Future<Either<String, List<Deck>>> getDecks() async => right(<Deck>[_deck]);

  @override
  Future<Either<String, Deck>> getDeckById(String id) async => right(_deck);

  @override
  Future<Either<String, Deck>> createDeck(String name,
          {String description = ''}) =>
      throw UnimplementedError();

  @override
  Future<Either<String, Deck>> updateDeck(Deck deck) =>
      throw UnimplementedError();

  @override
  Future<Either<String, void>> deleteDeck(String id) =>
      throw UnimplementedError();

  @override
  Future<Either<String, Deck>> ensureHSKDeckExists(int level) =>
      throw UnimplementedError();

  @override
  Future<Either<String, Deck>> ensureThematicDeckExists(
    String id, {
    required String name,
    required String description,
  }) =>
      throw UnimplementedError();
}

class _StubActivityRepository implements StudyActivityRepository {
  _StubActivityRepository(this.cards);

  final List<Flashcard> cards;
  final List<String> recorded = <String>[];

  @override
  Future<StudyQueue> reserveQueue({
    required String deckId,
    required List<Flashcard> cards,
    required StudyMode mode,
    required DateTime now,
    required int dailyNewLimit,
    required int dailyReviewLimit,
  }) async =>
      StudyQueue(
        cards: cards,
        // Every card counts as introduced here, so the screen does not try to
        // write `introducedAt` before the first card.
        cardIdsToIntroduce: const <String>{},
        newlyReservedCardIds: const <String>{},
        reviewCardIdsToReserve: const <String>{},
        dueCount: 0,
        learningCount: 0,
        newCount: cards.length,
      );

  @override
  Future<DailyDeckActivity> activityForDay({
    required String deckId,
    required List<Flashcard> cards,
    required DateTime now,
  }) async =>
      DailyDeckActivity(deckId: deckId, dayKey: 'day');

  @override
  Future<void> recordReview({
    required String deckId,
    required String cardId,
    required DateTime reviewedAt,
  }) async =>
      recorded.add(cardId);
}

Future<List<_FakeFlashcardController>> _pumpSession(
  WidgetTester tester,
  List<Flashcard> cards,
) async {
  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  // Collects every notifier Riverpod builds: `overrideWith` must return a fresh
  // instance per build, so a captured one would trip Riverpod's own asserts.
  final List<_FakeFlashcardController> controllers =
      <_FakeFlashcardController>[];

  // The card subtree reads the translation language (and, through it, settings),
  // both of which sit on SharedPreferences.
  SharedPreferences.setMockInitialValues(<String, Object>{});
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  // Haptics go out on `SystemChannels.platform`, which no test binding answers;
  // without a handler the call never completes. Mocked rather than ignored so a
  // future `await HapticsManager...` mid-flow cannot silently stall a test.
  tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
    SystemChannels.platform,
    (MethodCall call) async => null,
  );
  addTearDown(() {
    tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(preferences),
        deckRepositoryProvider.overrideWithValue(_StubDeckRepository()),
        studyActivityRepositoryProvider
            .overrideWithValue(_StubActivityRepository(cards)),
        flashcardControllerProvider.overrideWith(() {
          final _FakeFlashcardController controller =
              _FakeFlashcardController(cards);
          controllers.add(controller);
          return controller;
        }),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        locale: const Locale('en'),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const DeckReviewSessionScreen(
          deckId: 'deck-a',
          mode: StudyMode.reading,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return controllers;
}

/// Reveals the current card and grades it "Good" by swiping right.
///
/// The card's exit is three beats: the stamp (130ms), a deliberate 90ms pause so
/// the seal registers, then the slide-off. The middle beat schedules no frame of
/// its own, so `pumpAndSettle` alone would stop short of the pop.
Future<void> _gradeCardBySwiping(WidgetTester tester) async {
  await tester.tap(find.byType(ZenFlipCard));
  await tester.pumpAndSettle();
  await tester.drag(find.byType(SwipeableFlashcard), const Offset(200, 0));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 120));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('finishing a card never reveals the preview behind it',
      (tester) async {
    // Reported: "the animation when we finish a card is weird". Each card is a
    // route of its own, and the screen behind it used to be the "Ready to
    // study" preview — so every finished card faded the whole page out to a
    // Start button and faded back in, once per word.
    await _pumpSession(tester, <Flashcard>[_card('汉'), _card('字')]);

    expect(find.byKey(const Key('study_session_preview')), findsOneWidget);
    await tester.tap(find.byKey(const Key('study_session_start')));
    await tester.pumpAndSettle();

    // First card open: the preview is no longer in the tree at all.
    expect(find.byType(ReadingModeWidget), findsOneWidget);
    expect(find.byKey(const Key('study_session_preview')), findsNothing);
    expect(find.byKey(const Key('study_session_start')), findsNothing);

    // Grade it: reveal, then swipe right for "Good".
    await _gradeCardBySwiping(tester);

    // The next word is already up, and the preview never appeared in between.
    expect(find.text('字'), findsOneWidget);
    expect(find.byType(ReadingModeWidget), findsOneWidget);
    expect(find.byKey(const Key('study_session_preview')), findsNothing);
    expect(find.byKey(const Key('study_session_start')), findsNothing);
  });

  testWidgets('the next card settles in while the swap is still running',
      (tester) async {
    await _pumpSession(tester, <Flashcard>[_card('汉'), _card('字')]);

    await tester.tap(find.byKey(const Key('study_session_start')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));

    // Mid-transition the card is already being laid out: the swap is a card
    // fade + rise, not a page-sized slide with a blank frame behind it.
    expect(find.byType(ReadingModeWidget), findsOneWidget);
  });

  testWidgets('a finished card is still written, in the background',
      (tester) async {
    // Persisting used to sit between the finished card and the next one. It now
    // runs alongside the swap, so the write must still land.
    final List<Flashcard> cards = <Flashcard>[_card('汉'), _card('字')];
    final List<_FakeFlashcardController> controllers =
        await _pumpSession(tester, cards);

    await tester.tap(find.byKey(const Key('study_session_start')));
    await tester.pumpAndSettle();
    await _gradeCardBySwiping(tester);

    expect(
      controllers.expand((_FakeFlashcardController c) => c.written).map(
            (Flashcard card) => card.id,
          ),
      contains('card-汉'),
    );
  });

  test('the card swap uses the shared motion vocabulary', () {
    final String source = File(
      'lib/features/flashcards/presentation/screens/deck_review_session_screen.dart',
    ).readAsStringSync();

    // Incoming on `quick`, outgoing on `swap`, both collapsing under reduced
    // motion — and never a full page transition per card.
    expect(source, contains('class _CardRoute<T> extends PageRouteBuilder<T>'));
    expect(source, contains('transitionDuration: reduceMotion'));
    expect(source, contains('ZenMotion.quick'));
    expect(source, contains('reverseTransitionDuration'));
    expect(source, contains('ZenMotion.swap'));
    expect(source, contains('context.reduceMotion'));
    expect(source, isNot(contains('MaterialPageRoute<int>')));
    // The preview is gated on the session not having started.
    expect(source, contains('_sessionStarted'));
    expect(source, contains('_buildSessionSurface()'));
  });

  test('a finished card is written in the background, not between cards', () {
    final String source = File(
      'lib/features/flashcards/presentation/screens/deck_review_session_screen.dart',
    ).readAsStringSync();

    // The write is chained off the previous one and drained before leaving.
    expect(source, contains('_writeChain = _writeChain'));
    expect(source, contains('_drainPendingWrites'));
    expect(source, contains('await _drainPendingWrites();'));
  });
}
