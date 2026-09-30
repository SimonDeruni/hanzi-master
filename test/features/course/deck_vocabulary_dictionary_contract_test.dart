/// Every word a deck teaches must be a word the dictionary can serve.
///
/// **Why this exists.** A French reader opening "Wushu & Tai Chi" was shown
/// `bow stance`, `saber technique; broadsword art`, `staff technique; cudgel
/// play` and `Wudang Mountain martial lineage`. The cause was not the wiring -
/// the preview already looked the words up in `dictionary.db`, and it returned
/// the French for `套路`, `散打` and `剑法` correctly. The cause was that 33 of
/// the 428 headwords the decks teach were not in the dictionary at all (弓步,
/// 刀法, 棍术 and 武当 are not in CC-CEDICT either, and the spine is a faithful
/// copy of it), and a further 27 had a row whose localised cells were empty.
///
/// This opens the real shipped asset and holds the catalogue to the rule: a deck
/// may only teach words the dictionary actually has.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/course/data/thematic_decks_data.dart';
import 'package:hanzi_master/features/flashcards/data/repositories/global_dictionary_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Every language the app ships a definition column for.
const List<String> _languages = <String>[
  'ar', 'de', 'es', 'fr', 'hi', 'id', 'it', 'ja', 'ko', 'pt', 'ru', 'th', 'vi',
];

/// The cells that are still empty, measured 2026-09-29 against the app's own
/// row selection.
///
/// These eleven words are headwords in the dictionary; what is missing is one to
/// four translations for them. They are listed rather than forbidden so the gap
/// cannot grow silently: filling a cell means deleting its entry here, and adding
/// a deck word with an empty cell fails. 24 cells in total, against 15,555 rows
/// in the dictionary as a whole.
const Map<String, List<String>> _knownEmptyCells = <String, List<String>>{
  '五行': <String>['fr', 'hi', 'th'],
  '古筝': <String>['ar', 'hi', 'ja', 'vi'],
  '四合院': <String>['hi', 'pt', 'th', 'vi'],
  '月饼': <String>['hi'],
  '江南': <String>['ja'],
  '清明节': <String>['ja', 'ko'],
  '生肖': <String>['it', 'ja', 'ko'],
  '电动车': <String>['id'],
  '端午节': <String>['hi'],
  '舞狮': <String>['ar', 'hi'],
  '离职': <String>['ko', 'vi'],
};

void main() {
  late Database database;
  late GlobalDictionaryRepository repository;

  setUpAll(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(
      // Absolute: the ffi factory resolves a relative path under
      // `.dart_tool/sqflite_common_ffi/databases/` instead of the repo root.
      '${Directory.current.path}/assets/data/dictionary.db',
      options: OpenDatabaseOptions(readOnly: true, singleInstance: false),
    );
    repository =
        GlobalDictionaryRepository.forTesting(database, const <String, int>{});
  });

  tearDownAll(() async => database.close());

  test('every deck word is a headword of the shipped dictionary', () async {
    final List<String> absent = <String>[];
    for (final deck in ThematicDecksData.collections) {
      for (final word in deck.vocabulary) {
        final String hanzi = word['hanzi'] ?? '';
        if (await repository.getExact(hanzi) == null) {
          absent.add('${deck.id} / $hanzi');
        }
      }
    }
    expect(
      absent,
      isEmpty,
      reason: 'These words are taught by a deck but are not in the dictionary, '
          'so no surface - the preview, the dictionary screen, tap-a-word - can '
          'define them in any language: $absent',
    );
  });

  test('the catalogue is served in every shipped language but the known cells',
      () async {
    final Map<String, List<String>> empty = <String, List<String>>{};
    for (final deck in ThematicDecksData.collections) {
      for (final word in deck.vocabulary) {
        final String hanzi = word['hanzi'] ?? '';
        final List<String> holes = <String>[];
        for (final String language in _languages) {
          final card = await repository.getExact(hanzi,
              targetLanguage: language);
          if (card == null || card.definitionLanguage == 'English') {
            holes.add(language);
          }
        }
        if (holes.isNotEmpty) empty[hanzi] = holes;
      }
    }
    expect(
      empty,
      _knownEmptyCells,
      reason: 'A deck word whose localised cell is empty falls back to English, '
          'which is what the reported screenshot showed. Fix the cell, or pick a '
          'word the dictionary can serve.',
    );
  });
}
