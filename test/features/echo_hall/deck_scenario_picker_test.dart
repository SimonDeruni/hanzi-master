@Tags(<String>['locale-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/deck_scenario_picker_sheet.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../support/locale_layout_harness.dart';

Deck _deck(String id, String name) => Deck(
      id: id,
      name: name,
      createdAt: DateTime(2026, 1, 1),
    );

Flashcard _card(String deckId, int index) => Flashcard(
      id: 'card-$index',
      deckId: deckId,
      hanzi: '汉字$index',
      pinyin: 'hàn zì',
      definition: 'character',
      hskLevel: 1,
      strokePaths: const <String>[],
      modeStats: const <StudyMode, ReviewStats>{},
    );

/// Same fakes the other deck surfaces use (`tome_manager_shelf_test`), so the
/// picker is exercised against the real provider types.
class _FakeDeckController extends StateNotifier<AsyncValue<List<Deck>>>
    implements DeckController {
  _FakeDeckController(List<Deck> decks) : super(AsyncValue.data(decks));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeFlashcardController extends FlashcardController {
  _FakeFlashcardController(this.cards);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;
}

Widget _host({
  required List<Deck> decks,
  required List<Flashcard> cards,
  Locale locale = const Locale('en'),
}) {
  return ProviderScope(
    overrides: <Override>[
      deckControllerProvider
          .overrideWith((Ref ref) => _FakeDeckController(decks)),
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
      home: const Scaffold(body: DeckScenarioPickerSheet()),
    ),
  );
}

/// A host that opens the sheet from a button, so the test can see what the
/// picker returns to its caller.
Widget _tappedHost({
  required List<Deck> decks,
  required List<Flashcard> cards,
  required void Function(Deck?) onPicked,
}) {
  return ProviderScope(
    overrides: <Override>[
      deckControllerProvider
          .overrideWith((Ref ref) => _FakeDeckController(decks)),
      flashcardControllerProvider
          .overrideWith(() => _FakeFlashcardController(cards)),
    ],
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              key: const ValueKey<String>('open-picker'),
              onPressed: () async {
                onPicked(await DeckScenarioPickerSheet.show(context));
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('lists every deck with its name, level and card count',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _host(
        decks: <Deck>[
          _deck('hsk3', 'HSK 3'),
          _deck('travel', 'Travel & Food'),
          _deck('empty', 'Empty Deck'),
        ],
        cards: <Flashcard>[
          _card('hsk3', 1),
          _card('hsk3', 2),
          _card('hsk3', 3),
          _card('travel', 4),
        ],
      ),
    );
    await tester.pumpAndSettle();

    // The title and the purpose of the picker are stated, in the app's language.
    expect(find.text('Choose a Deck'), findsOneWidget);
    expect(
      find.text('Practice flashcard vocabulary in a live dialogue'),
      findsOneWidget,
    );

    // Graded decks get a level chip; every deck reports how many cards it holds.
    expect(find.text('HSK 3 (Intermediate)'), findsOneWidget);
    expect(find.text('Travel & Food'), findsOneWidget);
    expect(find.text('HSK 3'), findsOneWidget);
    expect(find.text('3 Cards'), findsOneWidget);
    expect(find.text('1 Cards'), findsOneWidget);
  });

  testWidgets('a deck with no cards cannot be chosen', (tester) async {
    final List<Deck?> picked = <Deck?>[];
    await tester.pumpWidget(
      _tappedHost(
        decks: <Deck>[_deck('empty', 'Empty')],
        cards: <Flashcard>[],
        onPicked: picked.add,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey<String>('open-picker')));
    await tester.pumpAndSettle();

    expect(find.text('Empty'), findsOneWidget);
    expect(find.text('0 Cards'), findsOneWidget);

    // Tapping it does nothing at all — the sheet stays open and nothing is
    // returned, because an empty deck cannot seed a scenario.
    await tester.tap(find.byKey(const ValueKey<String>('deck-scenario-empty')));
    await tester.pumpAndSettle();
    expect(picked, isEmpty);
    expect(find.byKey(const ValueKey<String>('deck-scenario-picker')),
        findsOneWidget);
  });

  testWidgets('choosing a deck returns it to the caller', (tester) async {
    final List<Deck?> picked = <Deck?>[];
    await tester.pumpWidget(
      _tappedHost(
        decks: <Deck>[_deck('travel', 'Travel & Food')],
        cards: <Flashcard>[_card('travel', 1)],
        onPicked: picked.add,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey<String>('open-picker')));
    await tester.pumpAndSettle();
    await tester
        .tap(find.byKey(const ValueKey<String>('deck-scenario-travel')));
    await tester.pumpAndSettle();

    expect(picked.single?.id, 'travel');
    // The sheet closed behind the choice.
    expect(find.byKey(const ValueKey<String>('deck-scenario-picker')),
        findsNothing);
  });

  testWidgets('an empty library explains itself instead of showing nothing',
      (tester) async {
    await tester.pumpWidget(_host(decks: <Deck>[], cards: <Flashcard>[]));
    await tester.pumpAndSettle();

    expect(find.text('No decks found.'), findsOneWidget);
    expect(
      find.text('Download official HSK & thematic decks'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.layers_outlined), findsOneWidget);
  });

  testWidgets('long deck names do not overflow in any locale', (tester) async {
    await expectNoOverflowAcrossLocales(
      tester,
      (BuildContext context) => _host(
        decks: <Deck>[
          _deck('hsk3', 'HSK 3'),
          _deck('travel', 'Подготовка к путешествию и еде вместе с семьёй'),
          _deck('kitchen', 'การเดินทางและอาหาร'),
        ],
        cards: <Flashcard>[
          _card('hsk3', 1),
          _card('travel', 2),
          _card('travel', 3),
          _card('kitchen', 4),
        ],
      ),
      locales: const <String>['de', 'ru', 'th', 'hi', 'ja'],
    );
  });
}
