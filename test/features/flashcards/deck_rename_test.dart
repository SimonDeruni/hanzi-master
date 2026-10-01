import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_settings_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/rename_deck_dialog.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class _FakeDeckRepository implements DeckRepository {
  final Map<String, Deck> _store = {};

  _FakeDeckRepository([List<Deck> initial = const []]) {
    for (final d in initial) {
      _store[d.id] = d;
    }
  }

  @override
  Future<Either<String, List<Deck>>> getDecks() async {
    return Right(_store.values.toList());
  }

  @override
  Future<Either<String, Deck>> getDeckById(String id) async {
    final d = _store[id];
    if (d == null) return const Left('Deck not found');
    return Right(d);
  }

  @override
  Future<Either<String, Deck>> createDeck(String name,
      {String description = ''}) async {
    final deck = Deck(
      id: 'custom-${_store.length + 1}',
      name: name,
      description: description,
      createdAt: DateTime.now(),
    );
    _store[deck.id] = deck;
    return Right(deck);
  }

  @override
  Future<Either<String, Deck>> updateDeck(Deck deck) async {
    if (!_store.containsKey(deck.id)) {
      return const Left('Deck not found');
    }
    _store[deck.id] = deck;
    return Right(deck);
  }

  @override
  Future<Either<String, void>> deleteDeck(String id) async {
    _store.remove(id);
    return const Right(null);
  }

  @override
  Future<Either<String, Deck>> ensureHSKDeckExists(int level) async {
    final id = 'hsk$level';
    final deck = Deck(
      id: id,
      name: 'HSK $level',
      createdAt: DateTime.now(),
    );
    _store[id] = deck;
    return Right(deck);
  }

  @override
  Future<Either<String, Deck>> ensureThematicDeckExists(
    String id, {
    required String name,
    required String description,
  }) async {
    final deck = Deck(
      id: id,
      name: name,
      description: description,
      createdAt: DateTime.now(),
    );
    _store[id] = deck;
    return Right(deck);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Deck entity custom vs system classification', () {
    test('default deck is recognized as system and not custom', () {
      final deck = Deck(
        id: 'default',
        name: 'The Main Library',
        createdAt: DateTime(2026),
      );
      expect(deck.isCustom, isFalse);
      expect(deck.isSystemDeck, isTrue);
    });

    test('hsk1 through hsk6 decks are recognized as system decks', () {
      for (int level = 1; level <= 6; level++) {
        final deck = Deck(
          id: 'hsk$level',
          name: 'HSK $level',
          createdAt: DateTime(2026),
        );
        expect(deck.isCustom, isFalse);
        expect(deck.isSystemDeck, isTrue);
      }
    });

    test('thematic decks are recognized as system decks', () {
      final deck = Deck(
        id: 'thematic_travel',
        name: 'Travel & Exploration',
        createdAt: DateTime(2026),
      );
      expect(deck.isCustom, isFalse);
      expect(deck.isSystemDeck, isTrue);
    });

    test('custom UUID or user decks are recognized as custom', () {
      final deck1 = Deck(
        id: 'd9b73678-2cfa-4ebf-a0e4-b78f44d82f71',
        name: 'Coffee Shop Phrases',
        createdAt: DateTime(2026),
      );
      expect(deck1.isCustom, isTrue);
      expect(deck1.isSystemDeck, isFalse);

      final deck2 = Deck(
        id: 'custom-hunan-dialect',
        name: 'Hunan Dialect',
        createdAt: DateTime(2026),
      );
      expect(deck2.isCustom, isTrue);
      expect(deck2.isSystemDeck, isFalse);
    });
  });

  group('DeckController.renameDeck', () {
    test('renames an existing custom deck and propagates to state and repository',
        () async {
      final initialDeck = Deck(
        id: 'custom-1',
        name: 'Original Name',
        createdAt: DateTime(2026),
      );
      final repo = _FakeDeckRepository([initialDeck]);
      final container = ProviderContainer(
        overrides: [
          deckRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      // Wait for loadDecks
      await container.read(deckControllerProvider.notifier).loadDecks();

      final controller = container.read(deckControllerProvider.notifier);
      final updated = await controller.renameDeck('custom-1', 'Renamed Vocabulary');

      expect(updated, isNotNull);
      expect(updated!.name, equals('Renamed Vocabulary'));

      // Check controller state
      final currentDecks = container.read(deckControllerProvider).valueOrNull!;
      expect(currentDecks.firstWhere((d) => d.id == 'custom-1').name,
          equals('Renamed Vocabulary'));

      // Check repository persistence
      final fromRepo = await repo.getDeckById('custom-1');
      expect(fromRepo.getOrElse((_) => throw Exception()).name,
          equals('Renamed Vocabulary'));
    });

    test('ignores empty or whitespace-only names and returns null', () async {
      final initialDeck = Deck(
        id: 'custom-1',
        name: 'Original Name',
        createdAt: DateTime(2026),
      );
      final repo = _FakeDeckRepository([initialDeck]);
      final container = ProviderContainer(
        overrides: [
          deckRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(deckControllerProvider.notifier).loadDecks();

      final controller = container.read(deckControllerProvider.notifier);
      final updated = await controller.renameDeck('custom-1', '   ');

      expect(updated, isNull);

      final currentDecks = container.read(deckControllerProvider).valueOrNull!;
      expect(currentDecks.firstWhere((d) => d.id == 'custom-1').name,
          equals('Original Name'));
    });

    test('returns target deck unchanged if renamed to the exact same name',
        () async {
      final initialDeck = Deck(
        id: 'custom-1',
        name: 'Same Name',
        createdAt: DateTime(2026),
      );
      final repo = _FakeDeckRepository([initialDeck]);
      final container = ProviderContainer(
        overrides: [
          deckRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(deckControllerProvider.notifier).loadDecks();

      final controller = container.read(deckControllerProvider.notifier);
      final updated = await controller.renameDeck('custom-1', 'Same Name');

      expect(updated, isNotNull);
      expect(updated!.name, equals('Same Name'));
    });
  });

  group('showRenameDeckDialog UI interaction', () {
    testWidgets('allows user to type a new deck name and save',
        (tester) async {
      final initialDeck = Deck(
        id: 'custom-1',
        name: 'Old Deck Name',
        createdAt: DateTime(2026),
      );
      final repo = _FakeDeckRepository([initialDeck]);

      Deck? resultDeck;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            deckRepositoryProvider.overrideWithValue(repo),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Consumer(
              builder: (context, ref, _) {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        resultDeck = await showRenameDeckDialog(
                          context,
                          ref: ref,
                          deck: initialDeck,
                        );
                      },
                      child: const Text('Open Rename Dialog'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Open Rename Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Rename Deck'), findsOneWidget);
      expect(find.text('Old Deck Name'), findsOneWidget);

      // Enter new name
      await tester.enterText(find.byType(TextField), 'Mastered HSK Cards');
      await tester.pump();

      // Tap Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Dialog closed and result returned
      expect(find.text('Rename Deck'), findsNothing);
      expect(resultDeck, isNotNull);
      expect(resultDeck!.name, equals('Mastered HSK Cards'));
    });

    testWidgets('cancelling dialog dismisses without saving',
        (tester) async {
      final initialDeck = Deck(
        id: 'custom-1',
        name: 'Keep This Name',
        createdAt: DateTime(2026),
      );
      final repo = _FakeDeckRepository([initialDeck]);

      Deck? resultDeck;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            deckRepositoryProvider.overrideWithValue(repo),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Consumer(
              builder: (context, ref, _) {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        resultDeck = await showRenameDeckDialog(
                          context,
                          ref: ref,
                          deck: initialDeck,
                        );
                      },
                      child: const Text('Open Dialog'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Rename Deck'), findsNothing);
      expect(resultDeck, isNull);
    });
  });

  group('DeckSettingsSheet rename integration', () {
    testWidgets('shows editable deck name tile for custom decks',
        (tester) async {
      final customDeck = Deck(
        id: 'custom-my-deck',
        name: 'My Special Deck',
        createdAt: DateTime(2026),
      );
      final repo = _FakeDeckRepository([customDeck]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            deckRepositoryProvider.overrideWithValue(repo),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: DeckSettingsSheet(deck: customDeck),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Deck Settings'), findsOneWidget);
      expect(find.text('Deck Name'), findsOneWidget);
      expect(find.text('My Special Deck'), findsOneWidget);
      expect(find.byIcon(Icons.drive_file_rename_outline_rounded), findsOneWidget);
    });

    testWidgets('shows localized title without rename tile for system decks',
        (tester) async {
      final systemDeck = Deck(
        id: 'hsk1',
        name: 'HSK 1',
        createdAt: DateTime(2026),
      );
      final repo = _FakeDeckRepository([systemDeck]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            deckRepositoryProvider.overrideWithValue(repo),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: DeckSettingsSheet(deck: systemDeck),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Deck Settings'), findsOneWidget);
      expect(find.text('HSK 1: Foundation'), findsOneWidget);
      expect(find.byIcon(Icons.drive_file_rename_outline_rounded), findsNothing);
    });
  });
}
