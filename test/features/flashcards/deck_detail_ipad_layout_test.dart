/// The deck screen's iPad treatment (F4 of `docs/IPAD_ADAPTIVE_PLAN.md`): at
/// ≥840dp the deck's numbers move *beside* the card list. The iPhone layout must
/// not change at all, and this pair of tests is what keeps both statements true.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_detail_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/locale_layout_harness.dart';

/// The deck screen's card rows render `TranslatedDefinition`, which reads the
/// local translation service — a real one wants the dictionary repository and an
/// API key pool, so it is faked (the override the repo's other localization
/// tests use). Returning the input unchanged marks the row as untranslated,
/// which is all this layout test needs.
class _FakeTranslationService extends LocalTranslationService {
  _FakeTranslationService() : super(targetLanguage: 'English');

  @override
  Future<String> translateEnglishDefinition(String definition,
          {String? hanzi}) async =>
      definition;
}

class _FakeFlashcardController extends FlashcardController {
  _FakeFlashcardController(this.cards);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;
}

class _FakeDeckController extends StateNotifier<AsyncValue<List<Deck>>>
    implements DeckController {
  _FakeDeckController([List<Deck> decks = const <Deck>[]])
      : super(AsyncValue<List<Deck>>.data(decks));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Deck _deck() => Deck(
      id: 'hsk1',
      name: 'HSK 1',
      createdAt: DateTime(2026, 1, 1),
    );

/// One reviewable card, so the deck's actions are enabled.
Flashcard _card(String hanzi) => Flashcard(
      id: 'card-$hanzi',
      deckId: 'hsk1',
      hanzi: hanzi,
      pinyin: 'wén huà',
      definition: 'civilization',
      hskLevel: 2,
      strokePaths: const <String>['M 200 200 L 800 800'],
      modeStats: const <StudyMode, ReviewStats>{},
    );

Widget _host({
  required List<Flashcard> cards,
  List<Override> overrides = const <Override>[],
}) =>
    ProviderScope(
      overrides: <Override>[
        deckControllerProvider
            .overrideWith((ref) => _FakeDeckController(<Deck>[_deck()])),
        flashcardControllerProvider
            .overrideWith(() => _FakeFlashcardController(cards)),
        ...overrides,
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
        home: DeckDetailScreen(deck: _deck()),
      ),
    );


Future<void> _pumpAt(
  WidgetTester tester,
  Size size, {
  List<Flashcard> cards = const <Flashcard>[],
  List<Override> overrides = const <Override>[],
}) async {
  // The view API, not `binding.setSurfaceSize` (see locale_layout_harness.dart).
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    _host(cards: cards, overrides: overrides),
  );
  await tester.pumpAndSettle();
}

/// A deck with cards is what makes the action block render at all
/// (`if (deckCards.isNotEmpty)`), so the tests below cannot use an empty deck —
/// which means the card rows' providers have to be satisfied too.
Future<List<Override>> _cardRowOverrides() async {
  SharedPreferences.setMockInitialValues(<String, Object>{'app_locale': 'en'});
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  return <Override>[
    sharedPreferencesProvider.overrideWithValue(preferences),
    localTranslationServiceProvider
        .overrideWithValue(_FakeTranslationService()),
  ];
}

void main() {
  testWidgets('an iPad shows the deck insight rail beside the cards',
      (WidgetTester tester) async {
    await _pumpAt(tester, const Size(1024, 1366));

    // Rail-only labels: neither appears in the phone layout.
    expect(find.text('My Progress'), findsOneWidget);
    expect(find.text('Number of Cards'), findsOneWidget);

    // The card list is still there beside it (the screen's own scroll view).
    expect(find.byType(NestedScrollView), findsOneWidget);
  });

  testWidgets('an iPhone keeps the single-column layout, with no rail',
      (WidgetTester tester) async {
    await _pumpAt(tester, const Size(390, 844));

    expect(find.text('My Progress'), findsNothing);
    expect(find.text('Number of Cards'), findsNothing);
    expect(find.byType(NestedScrollView), findsOneWidget);
  });

  testWidgets('a Split View slice behaves like the phone, not the iPad',
      (WidgetTester tester) async {
    // 600-839dp is medium: a 320dp rail there would squeeze the cards, so the
    // wide branch must not fire just because the device is an iPad.
    await _pumpAt(tester, const Size(700, 1000));

    expect(find.text('My Progress'), findsNothing);
    expect(find.text('Number of Cards'), findsNothing);
  });

  // Deck actions live in the list pane, not in the insight rail.
  group('deck actions stay in the list pane, out of the rail', () {
    testWidgets('a phone renders deck actions without Practice Writing button',
        (WidgetTester tester) async {
      await _pumpAt(
        tester,
        const Size(390, 844),
        cards: <Flashcard>[_card('文')],
        overrides: await _cardRowOverrides(),
      );

      // Practice Writing button was removed per user request
      expect(
        find.widgetWithText(OutlinedButton, 'Practice Writing'),
        findsNothing,
      );

      // Remaining core actions render cleanly
      expect(find.widgetWithText(ElevatedButton, 'Review'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Story'), findsOneWidget);
      expect(
        find.widgetWithText(OutlinedButton, 'Practice in Roleplay'),
        findsOneWidget,
      );

      expectNoOverflow(tester, reason: 'phone deck actions in en');
    });

    testWidgets('an iPad keeps deck actions in the list pane, out of the rail',
        (WidgetTester tester) async {
      await _pumpAt(
        tester,
        const Size(1024, 1366),
        cards: <Flashcard>[_card('文')],
        overrides: await _cardRowOverrides(),
      );

      // The rail is there...
      expect(find.text('My Progress'), findsOneWidget);
      expectNoOverflow(tester, reason: 'iPad deck actions in en');

      expect(
        find.widgetWithText(OutlinedButton, 'Practice Writing'),
        findsNothing,
      );

      // ...and the deck actions are not in the rail: the rail is 320dp of a 1024dp
      // window, so buttons belonging to the list pane end well left of it.
      const double railWidth = 320;
      const double windowWidth = 1024;
      final Rect button = tester.getRect(
        find.widgetWithText(OutlinedButton, 'Practice in Roleplay'),
      );
      expect(
        button.right,
        lessThanOrEqualTo(windowWidth - railWidth),
        reason: 'deck actions live in the list pane',
      );
    });
  });
}
