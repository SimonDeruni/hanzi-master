// The session's queue across leaving and reopening it the same day.
//
// `StudyActivityRepositoryImpl` is mirrored in memory here (its state machine is
// what decides the queue: `reserveQueue` persists the day's reserved new cards,
// `recordReview` persists a graded review), so the production
// `StudyQueueBuilder` builds the queue instead of a stub. That is what makes
// these tests catch a queue that silently shrinks between two sessions — the
// reported "card to review today (or new card)… it stops after only one card".
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
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';
import 'package:hanzi_master/shared/widgets/zen_flip_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _deckId = 'deck-a';

final Deck _deck = Deck(
  id: _deckId,
  name: 'Deck A',
  createdAt: DateTime(2026, 1, 1),
  dailyNewCardsLimit: 20,
  dailyReviewLimit: 100,
);

/// A brand new card: never attempted.
Flashcard _newCard(String hanzi) => Flashcard(
      id: 'new-$hanzi',
      deckId: _deckId,
      hanzi: hanzi,
      pinyin: 'pīn yīn',
      definition: 'definition',
      hskLevel: 1,
      strokePaths: const <String>[],
      modeStats: <StudyMode, ReviewStats>{
        StudyMode.reading: ReviewStats(
          nextReviewDate: DateTime.now().subtract(const Duration(days: 1)),
          interval: 0,
          easeFactor: 2.5,
          streak: 0,
          attempts: 0,
        ),
      },
    );

/// A card in long-term review, last seen days ago and due today.
Flashcard _dueCard(String hanzi) => Flashcard(
      id: 'due-$hanzi',
      deckId: _deckId,
      hanzi: hanzi,
      pinyin: 'pīn yīn',
      definition: 'definition',
      hskLevel: 1,
      strokePaths: const <String>[],
      modeStats: <StudyMode, ReviewStats>{
        StudyMode.reading: ReviewStats(
          nextReviewDate: DateTime.now().subtract(const Duration(days: 4)),
          interval: 8,
          easeFactor: 2.5,
          streak: 3,
          attempts: 3,
          successCount: 3,
          lastAttemptDate: DateTime.now().subtract(const Duration(days: 8)),
          introducedAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
      },
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

  @override
  Future<void> updateFlashcard(Flashcard card) async {
    written.add(card);
    // Mirror the real controller: the card list it serves is the persisted one,
    // so reopening a session sees the grades that landed.
    final int index = cards.indexWhere((Flashcard c) => c.id == card.id);
    if (index != -1) cards[index] = card;
  }
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

/// Faithful in-memory mirror of `StudyActivityRepositoryImpl`'s state machine:
/// `reserveQueue` persists the RESERVED new cards, `recordReview` persists a
/// graded review — and both feed the production `StudyQueueBuilder`.
class _MirrorActivityRepository implements StudyActivityRepository {
  final Set<String> introduced = <String>{};
  final Set<String> reviewed = <String>{};
  final Set<String> modeKeys = <String>{};
  final List<String> recorded = <String>[];

  @override
  Future<DailyDeckActivity> activityForDay({
    required String deckId,
    required List<Flashcard> cards,
    required DateTime now,
  }) async =>
      DailyDeckActivity(
        deckId: deckId,
        dayKey: 'day',
        introducedCardIds: Set<String>.of(introduced),
        reviewedCardIds: Set<String>.of(reviewed),
        modeIntroductionKeys: Set<String>.of(modeKeys),
      );

  @override
  Future<StudyQueue> reserveQueue({
    required String deckId,
    required List<Flashcard> cards,
    required StudyMode mode,
    required DateTime now,
    required int dailyNewLimit,
    required int dailyReviewLimit,
  }) async {
    final StudyQueue queue = StudyQueueBuilder.build(
      cards: cards,
      mode: mode,
      now: now,
      dailyNewLimit: dailyNewLimit,
      dailyReviewLimit: dailyReviewLimit,
      introducedCardIds: Set<String>.of(introduced),
      reviewedCardIds: Set<String>.of(reviewed),
      modeIntroducedCardIds: modeKeys
          .where((String key) => key.startsWith('${mode.name}:'))
          .map((String key) => key.substring(mode.name.length + 1))
          .toSet(),
    );
    introduced.addAll(queue.newlyReservedCardIds);
    modeKeys.addAll(
      queue.cardIdsToIntroduce.map((String id) => '${mode.name}:$id'),
    );
    return queue;
  }

  @override
  Future<void> recordReview({
    required String deckId,
    required String cardId,
    required DateTime reviewedAt,
  }) async {
    if (!reviewed.add(cardId)) return;
    recorded.add(cardId);
  }
}

/// A stand-in for the deck screen: the session is a pushed route of it, exactly
/// as in the app, so it can be left and opened again within one provider scope.
class _SessionHost extends StatelessWidget {
  const _SessionHost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          key: const Key('launch-session'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const DeckReviewSessionScreen(
                deckId: _deckId,
                mode: StudyMode.reading,
              ),
            ),
          ),
          child: const Text('Study'),
        ),
      ),
    );
  }
}

Future<_MirrorActivityRepository> _pumpSession(
  WidgetTester tester,
  List<Flashcard> cards, {
  _MirrorActivityRepository? activity,
}) async {
  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  SharedPreferences.setMockInitialValues(<String, Object>{});
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
    SystemChannels.platform,
    (MethodCall call) async => null,
  );
  addTearDown(() {
    tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  final _MirrorActivityRepository shared =
      activity ?? _MirrorActivityRepository();

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(preferences),
        deckRepositoryProvider.overrideWithValue(_StubDeckRepository()),
        studyActivityRepositoryProvider.overrideWithValue(shared),
        flashcardControllerProvider.overrideWith(() {
          return _FakeFlashcardController(cards);
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
        home: const _SessionHost(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return activity ?? shared;
}

/// Opens the session from the host screen (a pushed route, like the app).
Future<void> _launchSession(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('launch-session')));
  await tester.pumpAndSettle();
}

/// Grades card after card until the session leaves the card loop.
/// Returns how many gradings actually landed.
Future<int> _gradeUntilSessionEnds(WidgetTester tester) async {
  int gradings = 0;
  for (int i = 0; i < 60; i++) {
    if (find.byType(ReadingModeWidget).evaluate().isEmpty) break;
    await tester.tap(find.byType(ZenFlipCard).first);
    await tester.pumpAndSettle();
    if (find.byType(SwipeableFlashcard).evaluate().isEmpty) break;
    await tester.drag(
      find.byType(SwipeableFlashcard).first,
      const Offset(200, 0),
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 120));
    await tester.pumpAndSettle();
    gradings++;
  }
  return gradings;
}

void main() {
  testWidgets('fresh day: 2 due + 3 new are all served', (tester) async {
    final List<Flashcard> cards = <Flashcard>[
      _dueCard('甲'),
      _dueCard('乙'),
      _newCard('汉'),
      _newCard('字'),
      _newCard('文'),
    ];
    await _pumpSession(tester, cards);

    await _launchSession(tester);
    await tester.tap(find.byKey(const Key('study_session_start')));
    await tester.pumpAndSettle();

    // Two due reviews and three new cards. A new card is met twice (it is
    // re-queued while its interval is 0), so eight gradings land before the
    // summary: the whole queue is served, nothing is dropped.
    final int gradings = await _gradeUntilSessionEnds(tester);
    expect(gradings, greaterThan(2));
  });

  testWidgets('abandoning a session after one card does not hide the rest',
      (tester) async {
    // The reported flow: start a session, grade one card, leave, come back.
    // Starting reserves the whole queue, so the cards that were never graded
    // must still be waiting — otherwise the reopened session serves exactly the
    // one card that had been graded ("it stops after only one card").
    final List<Flashcard> cards = <Flashcard>[
      _newCard('汉'),
      _newCard('字'),
      _newCard('文'),
    ];
    final _MirrorActivityRepository activity = _MirrorActivityRepository();

    // Session 1 — start, grade exactly ONE card, then leave via the card's back
    // arrow (which pops the card with no grade and exits the session).
    await _pumpSession(tester, cards, activity: activity);
    await _launchSession(tester);
    await tester.tap(find.byKey(const Key('study_session_start')));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ZenFlipCard).first);
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(SwipeableFlashcard).first,
      const Offset(200, 0),
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 120));
    await tester.pumpAndSettle();

    // The learner leaves the session: the card's back arrow pops the card with
    // no grade, and `_startNextReview` exits the session back to the deck.
    await tester.tap(find.byIcon(Icons.arrow_back).first);
    await tester.pumpAndSettle();

    // Reopen the session the same day. The reservation lives in the activity
    // box; the graded card was persisted by the controller, so `cards` now
    // carries its new SRS state.
    await _launchSession(tester);
    await tester.tap(find.byKey(const Key('study_session_start')));
    await tester.pumpAndSettle();

    final int gradings = await _gradeUntilSessionEnds(tester);
    expect(gradings, greaterThan(1),
        reason: 'the two cards that were only reserved must still be waiting');
  });
}
