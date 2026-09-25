// TEMPORARY diagnostic harness: drives the REAL DeckReviewSessionScreen against
// a faithful in-memory mirror of StudyActivityRepositoryImpl, so the production
// StudyQueueBuilder decides the queue instead of a stub.
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
import 'package:hanzi_master/features/flashcards/presentation/screens/session_summary_screen.dart';
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

Future<_MirrorActivityRepository> _pumpSession(
  WidgetTester tester,
  List<Flashcard> cards,
) async {
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

  final _MirrorActivityRepository activity = _MirrorActivityRepository();

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(preferences),
        deckRepositoryProvider.overrideWithValue(_StubDeckRepository()),
        studyActivityRepositoryProvider.overrideWithValue(activity),
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
        home: const DeckReviewSessionScreen(
          deckId: _deckId,
          mode: StudyMode.reading,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return activity;
}

/// Reads the "Ready to study" preview's own numbers, e.g. due=2 new=3.
String _previewCounts(WidgetTester tester) {
  String read(String key) {
    final Finder finder = find.descendant(
      of: find.byKey(Key(key)),
      matching: find.byType(Text),
    );
    if (finder.evaluate().isEmpty) return '?';
    return (tester.widget<Text>(finder.first)).data ?? '?';
  }

  return 'due=${read('study_queue_due_count')} '
      'learning=${read('study_queue_learning_count')} '
      'new=${read('study_queue_new_count')}';
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
    final _MirrorActivityRepository activity = await _pumpSession(tester, cards);

    debugPrint('PREVIEW -> ${_previewCounts(tester)}');
    await tester.tap(find.byKey(const Key('study_session_start')));
    await tester.pumpAndSettle();

    final int gradings = await _gradeUntilSessionEnds(tester);
    debugPrint('GRADINGS=$gradings recorded=${activity.recorded}');
    debugPrint('summary=${find.byType(SessionSummaryScreen).evaluate().length}');
    expect(gradings, greaterThan(2));
  });
}
