import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/domain/logic/spoken_text_highlight.dart';

void main() {
  group('spokenHanziRangeForOffsets', () {
    test('maps a local TTS character offset to its visible Hanzi index', () {
      final range = spokenHanziRangeForOffsets('悟空，欲往西天。', 3, 4);

      expect(range?.start, 2);
      expect(range?.end, 3);
    });

    test('maps a multi-character word and ignores preceding punctuation', () {
      final range = spokenHanziRangeForOffsets('悟空，前往西天。', 3, 5);

      expect(range?.start, 2);
      expect(range?.end, 4);
      expect(range?.contains(2), isTrue);
      expect(range?.contains(3), isTrue);
      expect(range?.contains(4), isFalse);
    });

    test('returns null for punctuation-only and invalid ranges', () {
      expect(spokenHanziRangeForOffsets('悟空，前往', 2, 3), isNull);
      expect(spokenHanziRangeForOffsets('悟空', -1, 1), isNull);
      expect(spokenHanziRangeForOffsets('悟空', 1, 1), isNull);
    });

    test('uses UTF-16 offsets for supplementary characters', () {
      final range = spokenHanziRangeForOffsets('𠮷人', 2, 3);

      expect(range?.start, 1);
      expect(range?.end, 2);
    });
  });
}
