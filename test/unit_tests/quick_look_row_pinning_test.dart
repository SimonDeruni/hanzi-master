import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/features/flashcards/data/repositories/global_dictionary_repository.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Quick Look must show the **specific row** the reader's card came from, in the
/// **specific language** of that row.
///
/// One spelling can carry several rows: 的 has four (de5, dí, dì, dī) and 喂 has
/// two (wèi "to feed", wéi "hello on the phone"). `getExact` decides between
/// them with sense heuristics — surname entries and uppercase readings last —
/// which is right for a character tapped cold in an article, and wrong for a
/// card the reader already owns: that card names its row, and re-resolving by
/// spelling can hand back a sibling row's reading and a sibling row's
/// `definition_<language>` cell under the same character. These tests pin both
/// halves — the row is honoured, and the text comes from that row's localised
/// cell rather than from the row the heuristics would have chosen.
class _LibraryController extends FlashcardController {
  _LibraryController(this.cards);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(sqfliteFfiInit);

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'app_locale': 'fr',
      'translation_target_language': 'French',
    });
  });

  /// Two rows for 喂: the phone greeting (id 1) and the verb (id 7). The
  /// heuristics prefer the longer English gloss, so they pick id 1 — the row the
  /// saved card did *not* come from. Row 9 is an unrelated word, for the
  /// drifted-id case.
  Future<ProviderContainer> buildContainer({
    required int? pinnedWordId,
    String language = 'French',
    List<Flashcard>? library,
  }) async {
    final Database database =
        await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    addTearDown(database.close);
    await database.execute('''
      CREATE TABLE words (
        id INTEGER PRIMARY KEY,
        traditional TEXT,
        simplified TEXT,
        pinyin TEXT,
        pinyin_no_tones TEXT,
        definition TEXT,
        definition_fr TEXT,
        definition_de TEXT,
        definition_es TEXT,
        definition_ru TEXT,
        definition_it TEXT,
        definition_pt TEXT,
        definition_ja TEXT,
        definition_ko TEXT,
        definition_vi TEXT,
        definition_id TEXT,
        definition_ar TEXT,
        definition_hi TEXT,
        definition_th TEXT
      )
    ''');
    await database.execute('''
      CREATE TABLE localized_definition_quality (
        word_id INTEGER NOT NULL,
        language_code TEXT NOT NULL,
        score INTEGER NOT NULL,
        expansion_eligible INTEGER NOT NULL,
        source_definition_hash TEXT NOT NULL,
        scoring_version TEXT NOT NULL,
        reasons TEXT NOT NULL,
        PRIMARY KEY (word_id, language_code)
      )
    ''');
    await database.insert('words', <String, Object?>{
      'id': 1,
      'traditional': '喂',
      'simplified': '喂',
      'pinyin': 'wei2',
      'pinyin_no_tones': 'wei',
      'definition': 'hello when answering the phone',
      'definition_fr': 'allô',
      'definition_de': 'hallo',
      'definition_es': 'hola',
      'definition_ru': 'алло',
    });
    await database.insert('words', <String, Object?>{
      'id': 7,
      'traditional': '餵',
      'simplified': '喂',
      'pinyin': 'wei4',
      'pinyin_no_tones': 'wei',
      'definition': 'to feed',
      'definition_fr': 'nourrir',
      'definition_de': 'füttern',
      'definition_es': 'alimentar',
      'definition_ru': 'кормить',
    });
    await database.insert('words', <String, Object?>{
      'id': 9,
      'traditional': '好',
      'simplified': '好',
      'pinyin': 'hao3',
      'pinyin_no_tones': 'hao',
      'definition': 'good; well',
      'definition_fr': 'bien',
      'definition_de': 'gut',
      'definition_es': 'bien',
      'definition_ru': 'хорошо',
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(prefs),
        globalDictionaryRepositoryProvider.overrideWithValue(
          GlobalDictionaryRepository.forTesting(database, const <String, int>{}),
        ),
        flashcardControllerProvider.overrideWith(
          () => _LibraryController(
            library ??
                <Flashcard>[
                  Flashcard(
                    id: 'global_7',
                    deckId: 'deck-1',
                    hanzi: '喂',
                    pinyin: 'wèi',
                    definition: 'nourrir',
                    definitionLanguage: 'French',
                    dictionaryWordId: pinnedWordId,
                    englishDefinition: 'to feed',
                    hskLevel: 1,
                    strokePaths: const <String>[],
                    modeStats: const {},
                  ),
                ],
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    await container
        .read(translationLanguageProvider.notifier)
        .setLanguage(language);
    // Let the library settle before the lookup is read. `quickLookProvider`
    // watches it, so reading while it is still loading hands back a computation
    // that is immediately discarded — and the awaited `.future` belongs to that
    // discarded one. The sheet watches the provider rather than awaiting it, so
    // this is test plumbing, not product behaviour.
    await container.read(flashcardControllerProvider.future);
    return container;
  }

  test('the row the card names is the row shown, in that row\'s language',
      () async {
    final ProviderContainer container = await buildContainer(pinnedWordId: 7);

    final Flashcard? card = await container.read(quickLookProvider('喂').future);

    expect(card, isNotNull);
    expect(card!.dictionaryWordId, 7,
        reason: 'The saved row must survive the lookup');
    expect(card.pinyin, 'wèi', reason: 'The verb reading, not the greeting');
    expect(card.definition, 'nourrir',
        reason: 'Row 7\'s French cell, not the row the heuristics pick');
    expect(card.definitionLanguage, 'French');
    expect(card.englishDefinition, 'to feed');

    // The counterfactual, so this test cannot pass by accident: the spelling
    // lookup alone answers with row 1 (the greeting's longer English gloss wins
    // the sense heuristics), which is the row the reader never asked for.
    final Flashcard? bySpelling = await container
        .read(globalDictionaryRepositoryProvider)
        .getExact('喂', targetLanguage: 'French');
    expect(bySpelling!.dictionaryWordId, 1);
    expect(bySpelling.definition, 'allô');
  });

  test('the pinned row answers in whichever language is active', () async {
    final ProviderContainer container = await buildContainer(pinnedWordId: 7);

    final Flashcard? french =
        await container.read(quickLookProvider('喂').future);
    expect(french!.definition, 'nourrir');

    await container
        .read(translationLanguageProvider.notifier)
        .setLanguage('German');
    final Flashcard? german =
        await container.read(quickLookProvider('喂').future);

    expect(german!.dictionaryWordId, 7, reason: 'Still the same row');
    expect(german.definition, 'füttern');
    expect(german.definitionLanguage, 'German');
  });

  test('an id that no longer spells the word falls back to the spelling',
      () async {
    // Row 9 is a different word entirely: `init` replaces a stale dictionary
    // copy wholesale and row ids are not stable across builds, so a pinned id
    // that has drifted must not be trusted — the spelling lookup answers again.
    final ProviderContainer container = await buildContainer(pinnedWordId: 9);

    final Flashcard? card = await container.read(quickLookProvider('喂').future);

    expect(card, isNotNull);
    expect(card!.hanzi, '喂');
    expect(card.dictionaryWordId, 1,
        reason: 'The spelling lookup decides when the id has drifted');
    expect(card.definition, 'allô');
  });

  test('a character with no saved card is resolved from the spelling', () async {
    final ProviderContainer container =
        await buildContainer(pinnedWordId: null, library: const <Flashcard>[]);

    final Flashcard? card = await container.read(quickLookProvider('喂').future);

    expect(card, isNotNull);
    expect(card!.dictionaryWordId, 1);
    expect(card.definition, 'allô');
    expect(card.definitionLanguage, 'French');
  });
}
