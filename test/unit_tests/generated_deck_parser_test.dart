import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

void main() {
  group('GeminiService.parseGeneratedDeckCards', () {
    test('accepts labeled HSK levels returned by the live model', () {
      final cards = GeminiService.parseGeneratedDeckCards([
        {
          'hanzi': '你好',
          'pinyin': 'nǐ hǎo',
          'english': 'bonjour',
          'hskLevel': 'HSK1',
          'partOfSpeech': 'phrase',
        },
      ]);

      expect(cards, hasLength(1));
      expect(cards.single['hskLevel'], '1');
      expect(cards.single['english'], 'bonjour');
    });

    test('accepts wrapped card lists and clamps invalid levels', () {
      final cards = GeminiService.parseGeneratedDeckCards({
        'cards': [
          {
            'hanzi': '旅行',
            'pinyin': 'lǚxíng',
            'definition': 'voyager',
            'hskLevel': 9,
          },
        ],
      });

      expect(cards.single['hskLevel'], '6');
      expect(cards.single['english'], 'voyager');
    });

    test('drops malformed cards instead of persisting empty entries', () {
      final cards = GeminiService.parseGeneratedDeckCards([
        {'hanzi': '', 'pinyin': 'x', 'english': 'invalid'},
        {'hanzi': '谢谢', 'pinyin': '', 'english': 'merci'},
        {'hanzi': '酒店', 'pinyin': 'jiǔdiàn'},
      ]);

      expect(cards, isEmpty);
    });
  });
}
