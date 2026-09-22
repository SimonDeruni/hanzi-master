import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/course/data/thematic_decks_data.dart';
import 'package:hanzi_master/features/course/presentation/screens/tome_manager_screen.dart';
import 'package:hanzi_master/features/course/presentation/widgets/calligraphic_deck_cover.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class _FakeDeckRepository implements DeckRepository {
  final List<Deck> _decks;

  _FakeDeckRepository([this._decks = const []]);

  @override
  Future<Either<String, List<Deck>>> getDecks() async => Right(_decks);

  @override
  Future<Either<String, Deck>> getDeckById(String id) async =>
      Right(_decks.firstWhere((d) => d.id == id));

  @override
  Future<Either<String, Deck>> createDeck(String name,
          {String description = ''}) async =>
      const Left('Not supported');

  @override
  Future<Either<String, Deck>> updateDeck(Deck deck) async =>
      const Left('Not supported');

  @override
  Future<Either<String, void>> deleteDeck(String id) async =>
      const Right(null);

  @override
  Future<Either<String, Deck>> ensureHSKDeckExists(int level) async =>
      Right(Deck(id: 'hsk$level', name: 'HSK $level', createdAt: DateTime(2026, 1, 1)));

  @override
  Future<Either<String, Deck>> ensureThematicDeckExists(
    String thematicId, {
    required String name,
    required String description,
  }) async =>
      Right(Deck(id: thematicId, name: name, description: description, createdAt: DateTime(2026, 1, 1)));
}

class _FakeDeckController extends StateNotifier<AsyncValue<List<Deck>>>
    implements DeckController {
  _FakeDeckController(List<Deck> decks) : super(AsyncValue.data(decks));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => const [];
}

Widget _wrapTestWidget(Widget child, {List<Deck> installedDecks = const []}) {
  return ProviderScope(
    overrides: [
      deckRepositoryProvider.overrideWithValue(_FakeDeckRepository(installedDecks)),
      deckControllerProvider.overrideWith((ref) => _FakeDeckController(installedDecks)),
      flashcardControllerProvider.overrideWith(() => _FakeFlashcardController()),
    ],
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: child,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThematicDecksData Categories & Collections', () {
    test('contains all expected categories with multiple decks', () {
      expect(ThematicDecksData.categories, containsAll(['Culture', 'Sports', 'Education', 'Travel', 'Business']));

      final cultureDecks = ThematicDecksData.getByCategory('Culture');
      final sportsDecks = ThematicDecksData.getByCategory('Sports');
      final educationDecks = ThematicDecksData.getByCategory('Education');
      final travelDecks = ThematicDecksData.getByCategory('Travel');
      final businessDecks = ThematicDecksData.getByCategory('Business');

      expect(cultureDecks.length, greaterThanOrEqualTo(3));
      expect(sportsDecks.length, greaterThanOrEqualTo(3));
      expect(educationDecks.length, greaterThanOrEqualTo(3));
      expect(travelDecks.length, greaterThanOrEqualTo(3));
      expect(businessDecks.length, greaterThanOrEqualTo(3));

      // Check essential subject coverage
      expect(sportsDecks.any((d) => d.id == 'thematic_wushu'), isTrue);
      expect(sportsDecks.any((d) => d.id == 'thematic_ball_games'), isTrue);
      expect(cultureDecks.any((d) => d.id == 'thematic_tcm'), isTrue);
      expect(educationDecks.any((d) => d.id == 'thematic_tech'), isTrue);
    });

    test('all decks have valid vocabulary, pinyin, and definitions', () {
      for (final deck in ThematicDecksData.collections) {
        expect(deck.title.isNotEmpty, isTrue);
        expect(deck.titleHanzi.isNotEmpty, isTrue);
        expect(deck.watermarkHanzi.isNotEmpty, isTrue);
        expect(deck.gradientColors.length, equals(2));
        expect(deck.vocabulary.isNotEmpty, isTrue);

        for (final word in deck.vocabulary) {
          expect(word['hanzi']?.isNotEmpty, isTrue);
          expect(word['pinyin']?.isNotEmpty, isTrue);
          expect(word['definition']?.isNotEmpty, isTrue);
        }
      }
    });
  });

  group('CalligraphicDeckCover', () {
    testWidgets('renders title, plaque, and badges properly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalligraphicDeckCover(
              title: 'Wushu & Tai Chi',
              titleHanzi: '武术太极',
              watermarkHanzi: '武',
              gradientColors: [Color(0xFF134E4A), Color(0xFF042F2E)],
              badgeText: '20 词',
              isInstalled: true,
              width: 172,
              height: 148,
            ),
          ),
        ),
      );

      expect(find.text('武术太极'), findsOneWidget);
      expect(find.text('Wushu & Tai Chi'), findsOneWidget);
      expect(find.text('20 词'), findsOneWidget);
      expect(find.text('SAVED'), findsOneWidget);
      expect(find.text('武'), findsOneWidget);
    });
  });

  group('TomeManagerScreen Horizontal Shelf Layout', () {
    testWidgets('renders category shelves and master bookshelf status', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        _wrapTestWidget(
          const TomeManagerScreen(),
          installedDecks: [
            Deck(id: 'hsk1', name: 'HSK 1', createdAt: DateTime(2026, 1, 1)),
            Deck(id: 'thematic_travel', name: 'Travel & Survival', createdAt: DateTime(2026, 1, 1)),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // Verify Header & Status
      // The header was renamed from "Master Deck Library" to the localized
      // "Deck Library" (l10n.deckLibraryTitle).
      expect(find.text('Deck Library'), findsOneWidget);
      expect(find.text('Master Bookshelf Status'), findsOneWidget);
      expect(find.textContaining('collections installed offline'), findsOneWidget);

      // Verify Category Shelves headers exist
      expect(find.text('Official HSK Curriculum'), findsOneWidget);
      expect(find.text('Culture & Heritage'), findsOneWidget);
      expect(find.text('Sports & Martial Arts'), findsOneWidget);

      // Verify Category Filter Pills
      expect(find.text('Official HSK'), findsWidgets);
      expect(find.text('Culture'), findsWidgets);
      expect(find.text('Sports'), findsWidgets);
    });

    testWidgets('category filter pills filter visible shelves', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        _wrapTestWidget(const TomeManagerScreen()),
      );
      await tester.pumpAndSettle();

      // Tap 'Sports' filter pill
      final sportsPill = find.widgetWithText(GestureDetector, 'Sports').first;
      await tester.tap(sportsPill);
      await tester.pumpAndSettle();

      // Only Sports shelf should be visible
      expect(find.text('Sports & Martial Arts'), findsOneWidget);
      expect(find.text('Official HSK Curriculum'), findsNothing);
      expect(find.text('Culture & Heritage'), findsNothing);
    });

    testWidgets('search bar filters decks by keyword', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        _wrapTestWidget(const TomeManagerScreen()),
      );
      await tester.pumpAndSettle();

      // Enter unique search text "Curling" (in Winter Sports deck)
      await tester.enterText(find.byType(TextField), 'Curling');
      await tester.pumpAndSettle();

      expect(find.text('Sports & Martial Arts'), findsOneWidget);
      expect(find.text('Culture & Heritage'), findsNothing);
      expect(find.text('Official HSK Curriculum'), findsNothing);
    });
  });
}
