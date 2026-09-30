/// The deck-preview vocabulary chips must resolve through the dictionary.
///
/// **The reported defect.** A French reader opening "Wushu & Tai Chi" saw
/// `bow stance`, `saber technique; broadsword art`, `staff technique; cudgel
/// play` and `Wudang Mountain martial lineage` — the English the deck data
/// carries — while three of their neighbours correctly showed the database's
/// French (`enchaînement de mouvements dans les arts martiaux`, `escrime`).
///
/// The sheet was the one definition surface in the app that printed its English
/// source instead of resolving it; every other one goes through
/// `TranslatedDefinition`. It now takes the database's own `definitionLanguage`,
/// so a row the database already holds in the reader's language is printed
/// verbatim without spending a request, and anything else is translated.
///
/// Those five headwords have since been replaced by dictionary-served ones (弓步,
/// 刀法, 棍术 and 武当 are not in CC-CEDICT at all, and 少林's French cell is
/// empty), so the fake below stands in for the three shapes the database still
/// answers with: already in the reader's language, an English cell, and no row.
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/core/services/character_lookup_service.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/features/course/data/thematic_decks_data.dart';
import 'package:hanzi_master/features/course/presentation/screens/tome_manager_screen.dart';
import 'package:hanzi_master/features/course/presentation/widgets/calligraphic_deck_cover.dart';
import 'package:hanzi_master/features/flashcards/data/repositories/global_dictionary_repository.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _FakeDeckRepository implements DeckRepository {
  @override
  Future<Either<String, List<Deck>>> getDecks() async => const Right(<Deck>[]);

  @override
  Future<Either<String, Deck>> getDeckById(String id) async =>
      const Left('Not supported');

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
  Future<Either<String, Deck>> ensureHSKDeckExists(int level) async => Right(
      Deck(id: 'hsk$level', name: 'HSK $level', createdAt: DateTime(2026)));

  @override
  Future<Either<String, Deck>> ensureThematicDeckExists(
    String thematicId, {
    required String name,
    required String description,
  }) async =>
      Right(Deck(
          id: thematicId,
          name: name,
          description: description,
          createdAt: DateTime(2026)));
}

class _FakeDeckController extends StateNotifier<AsyncValue<List<Deck>>>
    implements DeckController {
  _FakeDeckController() : super(const AsyncValue<List<Deck>>.data(<Deck>[]));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => const <Flashcard>[];
}

/// Stands in for `dictionary.db`. Two rows come back in the reader's own
/// language, one row comes back in English — which is not hypothetical: 22 cells
/// across the deck catalogue are still empty (五行 has no French, 月饼 no Hindi),
/// and `_mapRowToCard` falls back to the English column for those. The rest of
/// the deck is left unserved, the shape a new deck would have before the
/// dictionary caught up with it.
class _FakeLookupService extends CharacterLookupService {
  _FakeLookupService() : super(GlobalDictionaryRepository());

  static const Map<String, CharacterInfo> _rows = <String, CharacterInfo>{
    '功夫': CharacterInfo(
      hanzi: '功夫',
      pinyin: 'gōng fu',
      definition: 'kung-fu',
      definitionLanguage: 'fr',
      hskLevel: 0,
    ),
    '剑法': CharacterInfo(
      hanzi: '剑法',
      pinyin: 'jiàn fǎ',
      definition: 'escrime',
      definitionLanguage: 'fr',
      hskLevel: 0,
    ),
    '招式': CharacterInfo(
      hanzi: '招式',
      pinyin: 'zhāo shì',
      definition: 'a formalized martial move',
      definitionLanguage: 'English',
      hskLevel: 0,
    ),
  };

  @override
  Future<List<CharacterInfo>> lookupAll(Iterable<String> chars,
      {String? targetLanguage}) async {
    return <CharacterInfo>[
      for (final String hanzi in chars)
        if (_rows.containsKey(hanzi)) _rows[hanzi]!,
    ];
  }
}

/// A lookup service preloaded from the real dictionary.
///
/// The answers are fetched in `setUpAll`, because real sqflite I/O cannot
/// complete inside `testWidgets`' fake-async zone — awaiting it there hangs the
/// test rather than failing it. The strings are still the database's own.
class _PreloadedLookupService extends CharacterLookupService {
  _PreloadedLookupService(this._answers)
      : super(GlobalDictionaryRepository());

  final Map<String, String> _answers;

  @override
  Future<List<CharacterInfo>> lookupAll(Iterable<String> chars,
      {String? targetLanguage}) async {
    return <CharacterInfo>[
      for (final String hanzi in chars)
        if (_answers.containsKey(hanzi))
          CharacterInfo(
            hanzi: hanzi,
            pinyin: '',
            definition: _answers[hanzi]!,
            definitionLanguage: 'fr',
            hskLevel: 0,
          ),
    ];
  }
}

class _RecordingTranslationService extends LocalTranslationService {
  _RecordingTranslationService() : super(targetLanguage: 'French');

  final List<String> requests = <String>[];

  @override
  Future<String> translateEnglishDefinition(String definition,
      {String? hanzi}) async {
    requests.add(definition);
    return 'TRADUIT';
  }
}

/// Opens the "Wushu & Tai Chi" preview sheet as a French reader would.
///
/// [lookup] defaults to the stub above; pass a service backed by the real
/// `dictionary.db` to exercise the whole path end to end.
Future<_RecordingTranslationService> _openWushuPreview(
  WidgetTester tester, {
  CharacterLookupService? lookup,
}) async {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);

  SharedPreferences.setMockInitialValues(<String, Object>{'app_locale': 'fr'});
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final _RecordingTranslationService translation =
      _RecordingTranslationService();
  final ProviderContainer container = ProviderContainer(
    overrides: <Override>[
      sharedPreferencesProvider.overrideWithValue(preferences),
      deckRepositoryProvider.overrideWithValue(_FakeDeckRepository()),
      deckControllerProvider.overrideWith((ref) => _FakeDeckController()),
      flashcardControllerProvider.overrideWith(() => _FakeFlashcardController()),
      characterLookupServiceProvider
          .overrideWithValue(lookup ?? _FakeLookupService()),
      localTranslationServiceProvider.overrideWithValue(translation),
    ],
  );
  addTearDown(container.dispose);
  await container
      .read(translationLanguageProvider.notifier)
      .setLanguage('French');

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(
        locale: Locale('fr'),
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: TomeManagerScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();

  // Isolate the deck, then open its preview. The search matches a deck's
  // vocabulary, so this term comes from 太极拳 — and it is deliberately not one
  // of the strings the assertions look for.
  await tester.enterText(find.byType(TextField), 'shadowboxing');
  await tester.pumpAndSettle();
  await tester.tap(find.byType(CalligraphicDeckCover).first);
  await tester.pumpAndSettle();
  return translation;
}

void main() {
  late List<Map<String, String>> chips;
  late Map<String, String> frenchAnswers;

  setUpAll(() async {
    // Real I/O lives here: `testWidgets` bodies run in a fake-async zone where a
    // sqflite future never completes.
    sqfliteFfiInit();
    final Database database = await databaseFactoryFfi.openDatabase(
      // Absolute: the ffi factory resolves a relative path under
      // `.dart_tool/sqflite_common_ffi/databases/` instead of the repo root.
      '${Directory.current.path}/assets/data/dictionary.db',
      options: OpenDatabaseOptions(readOnly: true, singleInstance: false),
    );
    addTearDown(database.close);

    final GlobalDictionaryRepository repository =
        GlobalDictionaryRepository.forTesting(database, const <String, int>{});
    final ThematicDeckDefinition wushu = ThematicDecksData.collections.firstWhere(
        (ThematicDeckDefinition deck) => deck.id == 'thematic_wushu');
    chips = wushu.vocabulary.take(12).toList();
    frenchAnswers = <String, String>{};
    for (final Map<String, String> chip in chips) {
      final String hanzi = chip['hanzi']!;
      final Flashcard? card =
          await repository.getExact(hanzi, targetLanguage: 'fr');
      expect(card, isNotNull, reason: hanzi);
      expect(
        card!.definitionLanguage,
        'fr',
        reason: '$hanzi must be served in French, not the English fallback',
      );
      frenchAnswers[hanzi] = card.definition.trim();
    }
  });

  testWidgets('every chip shows the dictionary definition in the reader language',
      (WidgetTester tester) async {
    final _RecordingTranslationService translation = await _openWushuPreview(
      tester,
      lookup: _PreloadedLookupService(frenchAnswers),
    );

    expect(chips.length, equals(12));
    for (final Map<String, String> chip in chips) {
      final String hanzi = chip['hanzi']!;
      expect(
        find.text(frenchAnswers[hanzi]!),
        findsOneWidget,
        reason: 'the chip for $hanzi must read "${frenchAnswers[hanzi]}"',
      );
      // The English the deck data carries must not be on screen at all.
      expect(find.text(chip['definition']!), findsNothing, reason: hanzi);
    }

    // Not one of them needed the translator: the dictionary already answered.
    expect(
      translation.requests,
      isEmpty,
      reason: 'all twelve are served from the dictionary in French',
    );
  });

  testWidgets('the chip prints the database definition the reader can read',
      (WidgetTester tester) async {
    final _RecordingTranslationService translation =
        await _openWushuPreview(tester);

    // Served by the database in French: printed verbatim.
    expect(find.text('escrime'), findsOneWidget);
    expect(find.text('kung-fu'), findsOneWidget);

    // ...and never spent as a translation request, because there is nothing to do.
    expect(find.text('swordsmanship; sword art'), findsNothing);
    expect(
      translation.requests,
      isNot(contains('swordsmanship; sword art')),
      reason: 'the database already answered in French',
    );
  });

  testWidgets('no chip shows the deck English to a French reader',
      (WidgetTester tester) async {
    final _RecordingTranslationService translation =
        await _openWushuPreview(tester);

    // Headwords with no row in the fake, and one whose row came back in English.
    // Each is translated, never printed as the English it came from — exactly
    // what the reported screenshot showed.
    const List<String> englishOnly = <String>[
      'martial arts skill', // 武功 — no row served
      'to practise kung fu or tai chi', // 练功
      'a formalized martial move', // 招式 — the row came back in English
      'to ward off; to parry', // 招架
      'to sit in meditation', // 打坐
      'tai chi; shadowboxing', // 太极拳
    ];
    for (final String english in englishOnly) {
      expect(find.text(english), findsNothing, reason: english);
      expect(translation.requests, contains(english), reason: english);
    }

    // Twelve chips. 功夫 and 剑法 come back in French and are printed verbatim;
    // 招式 comes back in English and is translated, as are the nine headwords the
    // fake leaves unserved. So ten of the twelve are the translator's.
    expect(translation.requests.length, equals(10));
    expect(find.text('TRADUIT'), findsNWidgets(10));
  });
}
