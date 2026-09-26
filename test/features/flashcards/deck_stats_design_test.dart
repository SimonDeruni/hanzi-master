@Tags(<String>['locale-sweep'])
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/stats_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../support/locale_layout_harness.dart';

Flashcard _studiedCard({
  required String hanzi,
  required String definition,
  required int attempts,
  required int successes,
  int interval = 0,
  int streak = 1,
}) {
  return Flashcard(
    id: 'card-$hanzi',
    deckId: 'hsk1',
    hanzi: hanzi,
    pinyin: 'pīn yīn',
    definition: definition,
    hskLevel: 2,
    strokePaths: const <String>[],
    modeStats: <StudyMode, ReviewStats>{
      StudyMode.reading: ReviewStats(
        nextReviewDate: DateTime.now(),
        interval: interval,
        easeFactor: 2.5,
        streak: streak,
        attempts: attempts,
        successCount: successes,
        lastAttemptDate: DateTime.now(),
        introducedAt: DateTime.now(),
      ),
      StudyMode.speaking: ReviewStats(
        nextReviewDate: DateTime.now(),
        interval: interval,
        easeFactor: 2.5,
        streak: streak,
        attempts: 4,
        successCount: 1,
        lastAttemptDate: DateTime.now(),
        introducedAt: DateTime.now(),
      ),
    },
  );
}

class _FakeFlashcardController extends FlashcardController {
  _FakeFlashcardController(this.cards);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;
}

Widget _host({
  required List<Flashcard> cards,
  Locale locale = const Locale('en'),
}) {
  return ProviderScope(
    overrides: <Override>[
      flashcardControllerProvider
          .overrideWith(() => _FakeFlashcardController(cards)),
    ],
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      locale: locale,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: DeckStatsView(deckId: 'hsk1')),
    ),
  );
}

void main() {
  testWidgets('the deck tab carries no app bar and no back button',
      (tester) async {
    // Regression: this view used to render a whole Scaffold with an AppBar, so
    // the deck screen's Statistics tab showed a second title bar and a second
    // back arrow inside a screen that already had both.
    await tester.pumpWidget(
      _host(
        cards: <Flashcard>[
          _studiedCard(
            hanzi: '难',
            definition: 'difficult',
            attempts: 9,
            successes: 2,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsNothing);
    expect(find.byIcon(Icons.arrow_back), findsNothing);
    expect(find.byIcon(Icons.arrow_back_ios_new), findsNothing);
    expect(find.byIcon(Icons.arrow_back_ios), findsNothing);
  });

  test('the deck screen mounts the view, not the routed screen', () {
    // A source guard, because the defect was purely a composition mistake.
    final String source = File(
      'lib/features/flashcards/presentation/screens/deck_detail_screen.dart',
    ).readAsStringSync();

    expect(source, contains('DeckStatsView('));
    expect(source, contains('deckId: widget.deck.id'));
    // …and it names the deck, so the tab's numbers are visibly that deck's and
    // not the library's.
    expect(source, contains('deckName:'));
    expect(source, isNot(contains('StatsScreen(deckId: widget.deck.id)')));
  });

  testWidgets('shows mastery, per-mode retention, workload and the word lists',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _host(
        cards: <Flashcard>[
          _studiedCard(
            hanzi: '难',
            definition: 'difficult',
            attempts: 9,
            successes: 2,
          ),
          _studiedCard(
            hanzi: '易',
            definition: 'easy',
            attempts: 5,
            successes: 5,
            interval: 40,
            streak: 7,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    // Mastery ring and its legend.
    expect(find.text('Library Mastery'), findsOneWidget);
    expect(find.text('Mastered'), findsWidgets);

    // Retention: the overall figure plus every practice mode, including the
    // modes this deck has never touched.
    expect(find.text('Accuracy by Mode'), findsOneWidget);
    for (final String mode in <String>[
      'Calligraphy',
      'Reading',
      'Recall',
      'Speaking',
      'Listening',
    ]) {
      expect(find.text(mode), findsOneWidget, reason: mode);
    }

    // Workload.
    expect(find.text('Upcoming Reviews (Next 7 Days)'), findsOneWidget);
    expect(find.text('Due today'), findsOneWidget);

    // The lower cards are below the fold in a lazy ListView: scroll them in.
    await tester.scrollUntilVisible(
      find.text('Tricky characters'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    // The two word lists, each row keyed so a learner can open it.
    expect(find.text('Tricky characters'), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('deck-stats-tricky-难')),
      findsOneWidget,
    );
    // This week's intake and the per-word effort are spelled out.
    expect(find.text('Average attempts per word'), findsOneWidget);
    expect(find.text('New in the last 7 days'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Strongest characters'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('Strongest characters'), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('deck-stats-strongest-易')),
      findsOneWidget,
    );
  });

  testWidgets('the cards use the book-screen ink well', (tester) async {
    await tester.pumpWidget(
      _host(
        cards: <Flashcard>[
          _studiedCard(
            hanzi: '难',
            definition: 'difficult',
            attempts: 9,
            successes: 2,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    final Container card = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('Library Mastery'),
            matching: find.byType(Container),
          )
          .first,
    );
    final BoxDecoration decoration = card.decoration! as BoxDecoration;
    expect(decoration.borderRadius, BorderRadius.circular(18));
    expect(decoration.color, AppTheme.cardBgLight);
  });

  testWidgets('an empty deck says so instead of showing zeros', (tester) async {
    await tester.pumpWidget(_host(cards: <Flashcard>[]));
    await tester.pumpAndSettle();

    expect(find.text('No cards in this deck yet'), findsOneWidget);
  });

  testWidgets('every block fits the tightest viewport in every locale',
      (tester) async {
    final List<Flashcard> cards = <Flashcard>[
      _studiedCard(
        hanzi: '难',
        definition: 'sehr schwieriges Zeichen für den Alltag',
        attempts: 9,
        successes: 2,
      ),
      _studiedCard(
        hanzi: '易',
        definition: 'facile',
        attempts: 5,
        successes: 5,
        interval: 40,
        streak: 7,
      ),
    ];

    await expectNoOverflowAcrossLocales(
      tester,
      (BuildContext context) => _host(cards: cards),
      locales: const <String>['de', 'ru', 'th', 'hi', 'ja'],
    );
  });
}
