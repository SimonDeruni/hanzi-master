import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/widget_service.dart';

void main() {
  group('wordOfTheDayFor', () {
    test('returns the same word throughout a local calendar day', () {
      final morning = wordOfTheDayFor(DateTime(2026, 9, 2, 8));
      final evening = wordOfTheDayFor(DateTime(2026, 9, 2, 23, 59));

      expect(evening, same(morning));
    });

    test('rotates at midnight', () {
      final today = wordOfTheDayFor(DateTime(2026, 9, 2, 23, 59));
      final tomorrow = wordOfTheDayFor(DateTime(2026, 9, 3));

      expect(tomorrow.hanzi, isNot(today.hanzi));
    });

    test('uses calendar-day distance from the shared 2024 epoch', () {
      expect(wordOfTheDayFor(DateTime(2024)).hanzi, '你好');
      expect(wordOfTheDayFor(DateTime(2024, 1, 2)).hanzi, '学习');
    });
  });

  test('wordOfTheDayUri creates a searchable app link', () {
    const word = WordOfTheDay(
      hanzi: '学习',
      pinyin: 'xué xí',
      definition: 'to study',
    );

    final uri = wordOfTheDayUri(word);

    expect(uri.scheme, 'sinospark');
    expect(uri.host, 'word');
    expect(uri.queryParameters['hanzi'], '学习');
  });
}
