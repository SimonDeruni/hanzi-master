import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const expectedCounts = <int, int>{
    1: 154,
    2: 162,
    3: 299,
    4: 601,
    5: 1300,
    6: 2500,
  };

  test('all installable HSK bundles contain valid vocabulary', () {
    for (final entry in expectedCounts.entries) {
      final level = entry.key;
      final path = level == 1
          ? 'assets/data/hsk1.json'
          : 'assets/data/hsk${level}_bundle.json';
      final file = File(path);
      expect(file.existsSync(), isTrue, reason: 'Missing HSK $level asset');

      final decoded = jsonDecode(file.readAsStringSync());
      final vocabulary = level == 1
          ? decoded as List<dynamic>
          : (decoded as Map<String, dynamic>)['vocabulary'] as List<dynamic>;
      expect(vocabulary, hasLength(entry.value),
          reason: 'Unexpected HSK $level vocabulary count');

      for (var index = 0; index < vocabulary.length; index++) {
        final item = vocabulary[index] as Map<String, dynamic>;
        expect(item['hanzi'], isA<String>(),
            reason: 'HSK $level entry $index has no hanzi');
        expect((item['hanzi'] as String).trim(), isNotEmpty,
            reason: 'HSK $level entry $index has empty hanzi');
        expect(item['pinyin'], isA<String>(),
            reason: 'HSK $level entry $index has no pinyin');
        expect(item['definition'], isA<String>(),
            reason: 'HSK $level entry $index has no definition');
      }
    }
  });
}
