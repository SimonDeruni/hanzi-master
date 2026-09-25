import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_selection_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Guards the Zen & Ink redesign of `DeckSelectionSheet` — the picker behind
/// "Add to Deck" and "Extract to Deck".
///
/// The layout and styling half is verified against source because exercising
/// the real sheet needs typed Hive boxes (`Box<FlashcardModel>` /
/// `Box<DeckModel>`) plus registered adapters; the localization half runs for
/// real across every supported locale.
/// Removes `//` comments so documenting an idiom is not mistaken for using it.
String _withoutLineComments(String source) =>
    source.split('\n').map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    }).join('\n');

void main() {
  late String source;

  setUpAll(() {
    source = _withoutLineComments(
      File(
        'lib/features/flashcards/presentation/widgets/deck_selection_sheet.dart',
      ).readAsStringSync(),
    );
  });

  group('the sheet hugs its content instead of filling the viewport', () {
    test('nothing returns an Expanded and the deck list is height-capped', () {
      // Regression: `Expanded` inside a `mainAxisSize.min` Column stretched the
      // modal to the full screen, stranding two deck rows in empty paper.
      expect(source, isNot(contains('return Expanded(')));
      expect(source, contains('mainAxisSize: MainAxisSize.min'));
      expect(source, contains('MediaQuery.of(context).size.height * 0.45'));
      expect(source, contains('shrinkWrap: true'));
    });
  });

  group('the sheet wears the Zen & Ink vocabulary, not Material defaults', () {
    test('the canonical accent replaces the colorScheme indigo', () {
      expect(source, contains('AppTheme.accentOf(context)'));
      expect(source, isNot(contains('Colors.indigo')));
      expect(source, isNot(contains('colorScheme.primary')));
      expect(source, contains('const Color(0xFFD4AF37)'),
          reason: "Emperor's Gold hairline");
    });

    test('confirmations are raised through the calligraphic toast', () {
      // A bare `SnackBar` renders *behind* the modal barrier, so from an
      // article it arrived dimmed and then half-covered by the closing sheet.
      // The shared toast lives on the root overlay instead.
      expect(source, contains('ZenToast.showOn('));
      expect(source, contains('ZenToastTone.error'));
      expect(source, isNot(contains('SnackBar(')));
      expect(source, contains('l10n.addedWordsToDeck('));
      expect(source, contains('l10n.addedWordsAndUpdatedWords('));
      expect(source, contains('l10n.updatedWordsInDeck('));
    });

    test('deck rows are hand-built calligraphic rows, not ListTiles', () {
      expect(source, contains('BouncingButton'),
          reason: 'Press feedback must stay paired with haptics');
      expect(source, contains('AppTheme.carbonInkLight'));
      expect(source, isNot(contains('ListTile')),
          reason: 'Default Material rows were replaced by styled rows');
    });
  });

  group('every visible label is localized', () {
    test('no English fallback literal survives in the sheet', () {
      expect(source, contains('AppLocalizations.of(context)!'));
      expect(source, contains('l10n.chooseADeck'));
      expect(source, contains('l10n.whereWouldYouLikeWords(wordCount)'));
      expect(source, contains('l10n.createNewDeck'));
      expect(source, contains('l10n.deckItemsCount(cardCount)'));
      expect(source, contains('l10n.newDeck'));
      expect(source, contains('l10n.cancelAction'));
      expect(source, contains('l10n.createAction'));
      expect(source, contains('l10n.errorPrefix'));
      expect(source, isNot(contains("?? '")),
          reason: 'A fallback English literal cannot expand for 13 locales');
      expect(source, isNot(contains('"Choose a Deck"')));
      expect(source, isNot(contains('"Create New Deck"')));
    });
  });

  group('the new deck-picker strings are translated in every locale', () {
    late AppLocalizations english;

    setUpAll(() async {
      english = await AppLocalizations.delegate.load(const Locale('en'));
    });

    test('no locale leaks a placeholder or falls back to English', () async {
      for (final Locale locale in AppLocalizations.supportedLocales) {
        final AppLocalizations l10n =
            await AppLocalizations.delegate.load(locale);
        final String prompt = l10n.whereWouldYouLikeWords(25);
        final String count = l10n.deckItemsCount(299);

        expect(prompt, contains('25'), reason: locale.languageCode);
        expect(count, contains('299'), reason: locale.languageCode);
        expect(prompt, isNot(contains('{count}')), reason: locale.languageCode);
        expect(count, isNot(contains('{count}')), reason: locale.languageCode);

        if (locale.languageCode != 'en') {
          expect(prompt, isNot(english.whereWouldYouLikeWords(25)),
              reason: 'Untranslated prompt for ${locale.languageCode}');
          expect(count, isNot(english.deckItemsCount(299)),
              reason: 'Untranslated item count for ${locale.languageCode}');
        }
      }
    });

    test('the French copy is the expected wording', () async {
      final AppLocalizations fr =
          await AppLocalizations.delegate.load(const Locale('fr'));

      expect(fr.whereWouldYouLikeWords(25),
          'Où souhaitez-vous enregistrer ces 25 mots ?');
      expect(fr.deckItemsCount(299), '299 éléments');
    });
  });

  group('the picker renders at content height, not full screen', () {
    testWidgets('two decks hug their content on a 390x844 viewport',
        (WidgetTester tester) async {
      final AppLocalizations l10n =
          await AppLocalizations.delegate.load(const Locale('en'));

      await _pumpPicker(tester);

      expect(find.text(l10n.chooseADeck), findsOneWidget);
      expect(find.text(l10n.whereWouldYouLike), findsOneWidget);
      expect(find.text(l10n.createNewDeck), findsOneWidget);
      expect(find.text(l10n.theMainLibrary), findsOneWidget);
      expect(find.text(l10n.hsk3Intermediate), findsOneWidget);
      expect(find.text(l10n.deckItemsCount(2)), findsOneWidget);

      // Regression: `Expanded` inside the `mainAxisSize.min` Column stretched
      // the modal to the whole viewport, stranding two rows in empty paper.
      final double pickerHeight =
          tester.getSize(find.byType(DeckSelectionSheet)).height;
      expect(pickerHeight, lessThan(420),
          reason: 'The sheet must hug its content, not fill the viewport');
      expect(pickerHeight, lessThan(844 * 0.6));
    });

    testWidgets('a long deck library scrolls inside the card, still capped',
        (WidgetTester tester) async {
      await _pumpPicker(tester, decks: _manyDecks);

      final double pickerHeight =
          tester.getSize(find.byType(DeckSelectionSheet)).height;
      expect(pickerHeight, lessThan(844 * 0.8),
          reason: 'Even a long list may not fill the screen');
      expect(find.byType(ListView), findsOneWidget,
          reason: 'The overflow scrolls inside the capped card');
    });

    testWidgets('the French picker is fully localized',
        (WidgetTester tester) async {
      await _pumpPicker(tester, locale: 'fr');

      expect(find.text('Choisissez un deck'), findsOneWidget);
      expect(find.text('Où souhaitez-vous enregistrer ce caractère ?'),
          findsOneWidget);
      expect(find.text('2 éléments'), findsOneWidget);
      expect(find.text('Choose a Deck'), findsNothing);
    });
  });
}

/// Two decks; the second holds two cards, so its row count is non-zero.
final List<Deck> _decks = <Deck>[
  Deck(id: 'default', name: 'My Library', createdAt: DateTime(2026)),
  Deck(id: 'hsk3', name: 'HSK 3', createdAt: DateTime(2026)),
];

/// A library long enough to overflow the 45% cap.
final List<Deck> _manyDecks = <Deck>[
  ..._decks,
  for (int i = 0; i < 12; i++)
    Deck(id: 'custom-$i', name: 'Custom $i', createdAt: DateTime(2026)),
];

final List<Flashcard> _cards = <Flashcard>[
  _card('hsk3', '汉'),
  _card('hsk3', '字'),
];

Flashcard _card(String deckId, String hanzi) => Flashcard(
      id: 'card-$hanzi',
      hanzi: hanzi,
      pinyin: 'hàn',
      definition: 'definition',
      hskLevel: 3,
      strokePaths: const [],
      modeStats: const {},
      deckId: deckId,
    );

/// Pumps the sheet on the tightest supported viewport with Hive-free providers.
Future<void> _pumpPicker(
  WidgetTester tester, {
  String locale = 'en',
  List<Deck>? decks,
  List<Flashcard>? cards,
}) async {
  final List<Deck> deckList = decks ?? _decks;
  final List<Flashcard> cardList = cards ?? _cards;

  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        // The sheet's provider chain is Hive-free: decks load from the stub
        // repository, cards come from a controller that never touches Hive.
        deckRepositoryProvider.overrideWithValue(_StubDeckRepository(deckList)),
        flashcardControllerProvider
            .overrideWith(() => _FakeFlashcardController(cardList)),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        locale: Locale(locale),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DeckSelectionSheet(card: cardList.first)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _StubDeckRepository implements DeckRepository {
  _StubDeckRepository(this.decks);

  final List<Deck> decks;

  // Only getDecks() is reachable from the picker; anything else would mean the
  // sheet started mutating decks, so it throws instead of silently passing.
  @override
  Future<Either<String, List<Deck>>> getDecks() async => right(decks);

  @override
  Future<Either<String, Deck>> createDeck(String name,
          {String description = ''}) =>
      throw UnimplementedError('createDeck is not part of the picker');

  @override
  Future<Either<String, Deck>> getDeckById(String id) =>
      throw UnimplementedError('getDeckById is not part of the picker');

  @override
  Future<Either<String, Deck>> updateDeck(Deck deck) =>
      throw UnimplementedError('updateDeck is not part of the picker');

  @override
  Future<Either<String, void>> deleteDeck(String id) =>
      throw UnimplementedError('deleteDeck is not part of the picker');

  @override
  Future<Either<String, Deck>> ensureHSKDeckExists(int level) =>
      throw UnimplementedError('ensureHSKDeckExists is not part of the picker');

  @override
  Future<Either<String, Deck>> ensureThematicDeckExists(String id,
          {required String name, required String description}) =>
      throw UnimplementedError(
          'ensureThematicDeckExists is not part of the picker');
}

class _FakeFlashcardController extends FlashcardController {
  _FakeFlashcardController(this.cards);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;
}
