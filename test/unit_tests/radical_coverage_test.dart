/// The radical coverage contract.
///
/// `assets/data/radicals.json` is a curated **subset**: 71 radicals with a name, a
/// meaning and a mnemonic, translated into 13 locales. It is *not* the source of
/// truth for which radical a character has — `hanzi_metadata.json` assigns one to
/// each of the 9574 characters it covers, and 3795 of those assignments (39.6%)
/// name a radical the catalog does not carry (`阝`, `⺼`, `虫`, `米`, `牛`, `穴`,
/// `舟`, `王`, `酉`, `攵`, `礻`, `页`, `马`, `鸟`, `鱼` …).
///
/// The character sheet used the catalog as a **veto**: a component it did not
/// carry was dropped, so 122 HSK characters (4.7% of the vocabulary — `出`, `对`,
/// `非`, `牛`, `面`, `用`, `也`, `已`, `书` …) showed no anatomy at all, and most
/// others showed a truncated one. These tests pin both halves of the fix: every
/// radical the metadata names can be described by *some* source, and the screen
/// enriches through the catalog instead of gating on it.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String _screenPath =
    'lib/features/flashcards/presentation/screens/character_detail_screen.dart';

/// Decomposition markers and "unknown" — never a real radical.
const Set<String> _structural = <String>{
  '⿰', '⿱', '⿲', '⿳', '⿴', '⿵', '⿶', '⿷',
  '⿸', '⿹', '⿺', '⿻', '？', '?',
};

Map<String, dynamic> _json(String path) =>
    (json.decode(File(path).readAsStringSync()) as Map).cast<String, dynamic>();

void main() {
  late Map<String, dynamic> catalog;
  late Map<String, dynamic> meta;
  late String screen;

  setUpAll(() {
    catalog =
        _json('assets/data/radicals.json')['radicals'] as Map<String, dynamic>;
    meta = _json('assets/data/hanzi_metadata.json');
    screen = File(_screenPath).readAsStringSync().replaceAll('\r\n', '\n');
  });

  /// The metadata's own description of a character, used as the fallback name.
  String? definitionOf(String char) {
    final Object? entry = meta[char];
    if (entry is! Map) return null;
    final Object? definition = entry['definition'];
    return definition is String && definition.isNotEmpty ? definition : null;
  }

  group('the data can describe what it assigns', () {
    test('the catalog is a curated subset, not the assignment table', () {
      expect(catalog.length, greaterThan(50),
          reason: 'A shrunken catalog is a data regression');
      expect(meta.length, greaterThan(9000),
          reason: 'The metadata is the radical source of truth');
    });

    test('every assignable radical is nameable by one of the two sources', () {
      final Set<String> undescribed = <String>{};
      int assignments = 0;
      int outsideCatalog = 0;

      for (final Object? entry in meta.values) {
        if (entry is! Map) continue;
        final Object? radical = entry['radical'];
        if (radical is! String || radical.isEmpty) continue;
        if (_structural.contains(radical)) continue;
        assignments++;
        if (catalog.containsKey(radical)) continue;
        outsideCatalog++;
        if (definitionOf(radical) == null) undescribed.add(radical);
      }

      expect(assignments, greaterThan(9000));
      expect(outsideCatalog, greaterThan(1000),
          reason: 'The catalog is a subset — this is the size of the gap it '
              'must not be allowed to veto');
      expect(undescribed, isEmpty,
          reason: 'Assigned but unnameable, so the anatomy card renders blank: '
              '$undescribed');
    });

    test('no HSK word has a character the anatomy cannot show', () {
      bool describes(String char) =>
          catalog.containsKey(char) || definitionOf(char) != null;

      final Set<String> unresolved = <String>{};
      for (final String level in <String>['1', '2', '3', '4', '5', '6']) {
        final File file = File('assets/data/hsk${level}_bundle.json');
        if (!file.existsSync()) continue;
        final Object? vocabulary = _json(file.path)['vocabulary'];
        if (vocabulary is! List) continue;
        for (final Object? word in vocabulary) {
          if (word is! Map || word['hanzi'] is! String) continue;
          for (final String char in (word['hanzi'] as String).split('')) {
            final Object? entry = meta[char];
            if (entry is! Map) continue;
            final Object? radical = entry['radical'];
            if (radical is! String ||
                radical.isEmpty ||
                _structural.contains(radical) ||
                !describes(radical)) {
              unresolved.add(char);
            }
          }
        }
      }
      expect(unresolved, isEmpty,
          reason:
              'HSK characters whose radical the sheet cannot show at all: '
              '$unresolved');
    });
  });

  group('the sheet enriches through the catalog', () {
    test('the catalog no longer vetoes a radical', () {
      expect(screen, contains('describesComponent('),
          reason: 'A radical counts when either source can describe it');
      expect(screen, contains('describeComponent('),
          reason: 'The curated entry wins when there is one');
      // The two veto sites. (`radicalData.containsKey(char)` also appears in the
      // "do we need the fallback bundle?" check, which is not a display filter.)
      expect(screen, isNot(contains('radicalData.containsKey(primaryRadical)')),
          reason: 'Gating the primary radical on the 71-entry catalog is the bug: '
              'it dropped 39.6% of the metadata\'s assignments and left 4.7% of '
              'the HSK vocabulary with no anatomy at all');
      expect(
        RegExp(r'if \(radicalData\.containsKey\(comp\)\)').hasMatch(screen),
        isFalse,
        reason: 'And the component list must not be filtered by it either',
      );
    });

    test('a metadata-only component still fills the card it renders into', () {
      // _buildAnatomyCard reads info['name'], info['meaning'] and tests
      // info['mnemonic'] for null, and _showRadicalDetails reads name/meaning.
      final String describe = screen.substring(
        screen.indexOf('Map<String, dynamic>? describeComponent('),
      );
      expect(describe, contains("'name': definition"));
      expect(describe, contains("'meaning': ''"));
      expect(describe, contains("'mnemonic': null"));
    });
  });
}
