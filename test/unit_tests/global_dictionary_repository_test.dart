import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/data/repositories/global_dictionary_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;
  late GlobalDictionaryRepository repository;

  setUpAll(sqfliteFfiInit);

  setUp(() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
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

    await _insertWord(
      database,
      id: 1,
      hanzi: '喂',
      pinyin: 'wei2',
      definition: 'hello when answering the phone',
      french: 'Bonjour',
      spanish: 'Hola',
    );
    await _insertWord(
      database,
      id: 2,
      hanzi: '哈罗',
      pinyin: 'ha1 luo2',
      definition: 'hello loanword',
      french: 'Bonjour',
      spanish: 'Hola',
    );
    await _insertWord(
      database,
      id: 3,
      hanzi: '你好',
      pinyin: 'ni3 hao3',
      definition: 'hello; hi',
      french: 'Bonjour',
      spanish: 'Hola',
    );
    await _insertWord(
      database,
      id: 4,
      hanzi: '学校',
      pinyin: 'xue2 xiao4',
      definition: 'school',
      french: 'École',
      spanish: 'Escuela',
    );
    await _insertWord(
      database,
      id: 5,
      hanzi: '行动',
      pinyin: 'xing2 dong4',
      definition: 'action',
      french: 'Action',
      spanish: 'Acción',
    );
    await _insertWord(
      database,
      id: 8,
      hanzi: '测试',
      pinyin: 'ce4 shi4',
      definition: 'test; testing',
      french: 'test; essai',
      spanish: 'prueba',
    );

    repository = GlobalDictionaryRepository.forTesting(
      database,
      const {'你好': 1},
    );
  });

  tearDown(() => database.close());

  for (final languageCase in <({String query, String language})>[
    (query: 'bonjour', language: 'French'),
    (query: 'hola', language: 'Spanish'),
  ]) {
    test('ranks common vocabulary first for ${languageCase.language}',
        () async {
      final result = await repository.search(
        languageCase.query,
        targetLanguage: languageCase.language,
      );
      final cards = result.fold(
        (error) => fail(error),
        (cards) => cards,
      );

      expect(cards.first.hanzi, '你好');
    });
  }

  test('keeps stronger text relevance ahead of popularity', () async {
    await _insertWord(
      database,
      id: 6,
      hanzi: '问候',
      pinyin: 'wen4 hou4',
      definition: 'greeting',
      french: 'salutation',
      spanish: 'saludo',
    );

    final result = await repository.search(
      'salutation',
      targetLanguage: 'French',
    );
    final cards = result.fold(
      (error) => fail(error),
      (cards) => cards,
    );

    expect(cards.first.hanzi, '问候');
  });

  test('French search ignores case and diacritics', () async {
    for (final query in ['école', 'ECOLE']) {
      final result = await repository.search(query, targetLanguage: 'French');
      final cards = result.fold((error) => fail(error), (cards) => cards);

      expect(cards.map((card) => card.hanzi), contains('学校'));
    }
  });

  test('Spanish search ignores diacritics', () async {
    final result = await repository.search(
      'accion',
      targetLanguage: 'Spanish',
    );
    final cards = result.fold((error) => fail(error), (cards) => cards);

    expect(cards.map((card) => card.hanzi), contains('行动'));
  });

  test('finds a general French definition search such as test', () async {
    final result = await repository.search(
      'test',
      targetLanguage: 'French',
    );
    final cards = result.fold((error) => fail(error), (cards) => cards);

    expect(cards.map((card) => card.hanzi), contains('测试'));
    expect(cards.firstWhere((card) => card.hanzi == '测试').definition,
        'test; essai');
  });

  test('attaches localized definition quality metadata', () async {
    final sourceHash =
        Uint8List.fromList(List<int>.generate(32, (index) => index));
    await database.insert('localized_definition_quality', {
      'word_id': 3,
      'language_code': 'fr',
      'score': 42,
      'expansion_eligible': 1,
      'source_definition_hash': sourceHash,
      'scoring_version': 'localized-quality-v1',
      'reasons': '["partial_sense_coverage"]',
    });

    final card = await repository.getExact('你好', targetLanguage: 'French');
    expect(card, isNotNull);
    expect(card!.dictionaryWordId, 3);
    expect(card.englishDefinition, 'hello; hi');
    expect(card.localizedDefinitionQuality, 42);
    expect(card.isExpansionEligible, isTrue);
    expect(
      card.sourceDefinitionHash,
      '000102030405060708090a0b0c0d0e0f'
      '101112131415161718191a1b1c1d1e1f',
    );
    expect(card.sourceDefinitionHash, matches(RegExp(r'^[0-9a-f]{64}$')));
  });

  test('word ID lookup preserves the selected sense and language', () async {
    await _insertWord(
      database,
      id: 7,
      hanzi: '喂',
      pinyin: 'wei4',
      definition: 'to feed',
      french: 'nourrir',
      spanish: 'alimentar',
    );

    final card = await repository.getByWordId(7, targetLanguage: 'French');

    expect(card, isNotNull);
    expect(card!.dictionaryWordId, 7);
    expect(card.pinyin, 'wèi');
    expect(card.definition, 'nourrir');
    expect(card.definitionLanguage, 'French');
    expect(card.englishDefinition, 'to feed');
  });

  test('dictionary search provider uses the multilingual repository and locale',
      () {
    final source = File(
      'lib/features/flashcards/presentation/providers/dictionary_provider.dart',
    ).readAsStringSync();

    expect(source, contains('ref.watch(translationLanguageProvider)'));
    expect(source, contains('ref.read(globalDictionaryRepositoryProvider)'));
    expect(source, contains('targetLanguage: targetLanguage'));
    expect(source, isNot(contains('repository.searchAll(query)')));
  });

  test('getExact prioritizes common word and lowercase pinyin over surname',
      () async {
    await _insertWord(
      database,
      id: 100,
      hanzi: '力',
      pinyin: 'Li4',
      definition: 'surname Li',
      french: 'force',
      spanish: 'fuerza',
    );
    await _insertWord(
      database,
      id: 101,
      hanzi: '力',
      pinyin: 'li4',
      definition: 'power; force; strength; ability; strenuously',
      french: 'force',
      spanish: 'fuerza',
    );

    final cardFr = await repository.getExact('力', targetLanguage: 'French');
    expect(cardFr, isNotNull);
    expect(cardFr!.pinyin, 'lì');
    expect(cardFr.definition, 'force');
    expect(cardFr.definitionLanguage, 'French');

    final cardEs = await repository.getExact('力', targetLanguage: 'Spanish');
    expect(cardEs, isNotNull);
    expect(cardEs!.pinyin, 'lì');
    expect(cardEs.definition, 'fuerza');
    expect(cardEs.definitionLanguage, 'Spanish');
  });
}

Future<void> _insertWord(
  Database database, {
  required int id,
  required String hanzi,
  required String pinyin,
  required String definition,
  required String french,
  required String spanish,
}) {
  return database.insert('words', {
    'id': id,
    'traditional': hanzi,
    'simplified': hanzi,
    'pinyin': pinyin,
    'pinyin_no_tones': pinyin.replaceAll(RegExp(r'[0-9]'), ''),
    'definition': definition,
    'definition_fr': french,
    'definition_de': '',
    'definition_es': spanish,
    'definition_ru': '',
    'definition_it': '',
    'definition_pt': '',
    'definition_ja': '',
    'definition_ko': '',
    'definition_vi': '',
    'definition_id': '',
    'definition_ar': '',
    'definition_hi': '',
    'definition_th': '',
  });
}
