import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';

void main() {
  group('PinyinUtils', () {
    test('getTone identifies all 4 tones correctly', () {
      expect(PinyinUtils.getTone('mā'), 1);
      expect(PinyinUtils.getTone('má'), 2);
      expect(PinyinUtils.getTone('mǎ'), 3);
      expect(PinyinUtils.getTone('mà'), 4);
      expect(PinyinUtils.getTone('ma'), 5);
    });

    test('getTone handles mixed case and different vowels', () {
      expect(PinyinUtils.getTone('Nǐ'), 3);
      expect(PinyinUtils.getTone('hǎo'), 3);
      expect(PinyinUtils.getTone('shì'), 4);
      expect(PinyinUtils.getTone('lǜ'), 4);
    });

    test('tokenize splits multi-syllable words correctly', () {
      final tokens = PinyinUtils.tokenize('nǐhǎo');
      expect(tokens.length, 2);
      expect(tokens[0]['text'], 'nǐ');
      expect(tokens[0]['tone'], 3);
      expect(tokens[1]['text'], 'hǎo');
      expect(tokens[1]['tone'], 3);
    });

    test('tokenize preserves punctuation and spaces as tone 5', () {
      final tokens = PinyinUtils.tokenize('Nǐ hǎo ma?');
      // "Nǐ", " ", "hǎo", " ", "ma", "?"
      expect(tokens.length, 6);
      expect(tokens[0]['text'], 'Nǐ');
      expect(tokens[0]['tone'], 3);
      expect(tokens[1]['text'], ' ');
      expect(tokens[1]['tone'], 5);
      expect(tokens[5]['text'], '?');
      expect(tokens[5]['tone'], 5);
    });

    test('tokenize handles complex vowels and diacritics', () {
      final tokens = PinyinUtils.tokenize('lǜsè de zhuōzi');
      // lǜ, sè, " ", de, " ", zhuō, zi
      expect(tokens[0]['text'], 'lǜ');
      expect(tokens[0]['tone'], 4);
      expect(tokens[5]['text'], 'zhuō');
      expect(tokens[5]['tone'], 1);
    });
  });
}
