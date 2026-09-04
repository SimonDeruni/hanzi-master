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
      id: 4,
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
