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

  group('buildSpokenCharTimings and findActiveTiming', () {
    test('accurately builds timings and looks up active character through pauses', () {
      const sentence = '你好世界，春暖花开。';
      final boundaries = [
        {
          'Offset': 500000,
          'Duration': 8500000,
          'text': {'Text': '你好世界', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 10000000,
          'Duration': 2125000,
          'text': {'Text': '，', 'BoundaryType': 'PunctuationBoundary'},
        },
        {
          'Offset': 12125000,
          'Duration': 8250000,
          'text': {'Text': '春暖花开', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 20500000,
          'Duration': 1125000,
          'text': {'Text': '。', 'BoundaryType': 'PunctuationBoundary'},
        },
      ];

      final timings = buildSpokenCharTimings(text: sentence, boundaries: boundaries);
      expect(timings.length, 8);

      // Verify character mapping and bounds
      expect(timings[0].char, '你');
      expect(timings[0].hanziIndex, 0);
      expect(timings[0].startMs, 50.0);
      expect(timings[0].endMs, 262.5);

      expect(timings[1].char, '好');
      expect(timings[1].hanziIndex, 1);

      expect(timings[2].char, '世');
      expect(timings[2].hanziIndex, 2);

      expect(timings[3].char, '界');
      expect(timings[3].hanziIndex, 3);
      expect(timings[3].endMs, 900.0);

      expect(timings[4].char, '春');
      expect(timings[4].hanziIndex, 4);
      expect(timings[4].startMs, 1212.5);

      // Lookup tests at various playback positions
      // 100ms -> '你'
      expect(findActiveTiming(timings, 100.0)?.char, '你');
      // 300ms -> '好'
      expect(findActiveTiming(timings, 300.0)?.char, '好');
      // 700ms -> '界'
      expect(findActiveTiming(timings, 700.0)?.char, '界');
      // 1050ms (during comma pause) -> remains on last spoken character '界'
      expect(findActiveTiming(timings, 1050.0)?.char, '界');
      // 1220ms -> '春'
      expect(findActiveTiming(timings, 1220.0)?.char, '春');
      // 1500ms -> '暖'
      expect(findActiveTiming(timings, 1500.0)?.char, '暖');
      // Past end -> '开'
      expect(findActiveTiming(timings, 3000.0)?.char, '开');
    });

    test('ignores SentenceBoundary packets and maintains character alignment', () {
      const sentence = '不自出力，以《损》推演。';
      final boundaries = [
        {
          'Offset': 500000,
          'Duration': 33875000,
          'text': {'Text': '不自出力，以《损》推演。', 'BoundaryType': 'SentenceBoundary'},
        },
        {
          'Offset': 500000,
          'Duration': 2125000,
          'text': {'Text': '不', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 2625000,
          'Duration': 1375000,
          'text': {'Text': '自', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 4125000,
          'Duration': 4375000,
          'text': {'Text': '出力', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 9500000,
          'Duration': 1875000,
          'text': {'Text': '，', 'BoundaryType': 'PunctuationBoundary'},
        },
        {
          'Offset': 11375000,
          'Duration': 3000000,
          'text': {'Text': '以', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 14375000,
          'Duration': 4750000,
          'text': {'Text': '损', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 20875000,
          'Duration': 5250000,
          'text': {'Text': '推演', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 26250000,
          'Duration': 1125000,
          'text': {'Text': '。', 'BoundaryType': 'PunctuationBoundary'},
        },
      ];

      final timings = buildSpokenCharTimings(text: sentence, boundaries: boundaries);
      // 8 spoken characters: 不(1) + 自(1) + 出力(2) + 以(1) + 损(1) + 推演(2) = 8
      expect(timings.length, 8);
      expect(timings.map((t) => t.char).join(), '不自出力以损推演');
      expect(timings[0].char, '不');
      expect(timings[0].hanziIndex, 0);
      expect(timings[4].char, '以');
      expect(timings[4].hanziIndex, 4);
      expect(timings[5].char, '损');
      expect(timings[5].hanziIndex, 5);
      expect(timings[6].char, '推');
      expect(timings[6].hanziIndex, 6);
      expect(timings[7].char, '演');
      expect(timings[7].hanziIndex, 7);
    });
  });
}
