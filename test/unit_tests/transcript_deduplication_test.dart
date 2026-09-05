import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/data/youtube_repository.dart';
import 'package:hanzi_master/features/media/domain/models/video_transcript.dart';

void main() {
  group('YoutubeRepository.deduplicateAndMergeLines', () {
    test('returns empty or single-item list unchanged', () {
      expect(YoutubeRepository.deduplicateAndMergeLines([]), isEmpty);

      final single = [
        TranscriptLine(
          text: '你好',
          start: const Duration(seconds: 0),
          duration: const Duration(seconds: 2),
        ),
      ];
      final result = YoutubeRepository.deduplicateAndMergeLines(single);
      expect(result.length, 1);
      expect(result.first.text, '你好');
    });

    test('merges consecutive identical cues and sums continuous duration', () {
      final raw = [
        TranscriptLine(
          text: '今天我要挑战只用现金',
          start: const Duration(seconds: 34),
          duration: const Duration(seconds: 2),
        ),
        TranscriptLine(
          text: '今天我要挑战只用现金',
          start: const Duration(seconds: 36),
          duration: const Duration(seconds: 2),
        ),
      ];

      final merged = YoutubeRepository.deduplicateAndMergeLines(raw);
      expect(merged.length, 1);
      expect(merged[0].text, '今天我要挑战只用现金');
      expect(merged[0].start, const Duration(seconds: 34));
      expect(merged[0].duration, const Duration(seconds: 4)); // 34s to 38s
    });

    test('ignores punctuation and spacing differences between consecutive identical cues', () {
      final raw = [
        TranscriptLine(
          text: 'jīn tiān wǒ yào tiǎo zhàn zhǐ yònɡ xiàn jīn bú yònɡ shǒu jī fù qián ',
          start: const Duration(seconds: 34),
          duration: const Duration(seconds: 2),
        ),
        TranscriptLine(
          text: 'jīn tiān wǒ yào tiǎo zhàn zhǐ yònɡ xiàn jīn bú yònɡ shǒu jī fù qián',
          start: const Duration(seconds: 36),
          duration: const Duration(seconds: 2),
        ),
      ];

      final merged = YoutubeRepository.deduplicateAndMergeLines(raw);
      expect(merged.length, 1);
      expect(merged[0].start, const Duration(seconds: 34));
      expect(merged[0].duration, const Duration(seconds: 4));
    });

    test('preserves best pinyin and translation when merging', () {
      final raw = [
        TranscriptLine(
          text: '你好世界',
          start: const Duration(seconds: 10),
          duration: const Duration(seconds: 2),
          pinyin: 'nǐ hǎo shì jiè',
        ),
        TranscriptLine(
          text: '你好世界',
          start: const Duration(seconds: 12),
          duration: const Duration(seconds: 3),
          translation: 'Hello world',
        ),
      ];

      final merged = YoutubeRepository.deduplicateAndMergeLines(raw);
      expect(merged.length, 1);
      expect(merged[0].text, '你好世界');
      expect(merged[0].start, const Duration(seconds: 10));
      expect(merged[0].duration, const Duration(seconds: 5)); // 10s to 15s
      expect(merged[0].pinyin, 'nǐ hǎo shì jiè');
      expect(merged[0].translation, 'Hello world');
    });

    test('does NOT merge distant repetitions (> 2.5s apart)', () {
      final raw = [
        TranscriptLine(
          text: '谢谢大家',
          start: const Duration(seconds: 10),
          duration: const Duration(seconds: 2), // ends at 12s
        ),
        TranscriptLine(
          text: '谢谢大家',
          start: const Duration(seconds: 60), // 48s gap
          duration: const Duration(seconds: 2),
        ),
      ];

      final merged = YoutubeRepository.deduplicateAndMergeLines(raw);
      expect(merged.length, 2);
      expect(merged[0].start, const Duration(seconds: 10));
      expect(merged[1].start, const Duration(seconds: 60));
    });

    test('keeps distinct consecutive cues intact', () {
      final raw = [
        TranscriptLine(
          text: '第一句话',
          start: const Duration(seconds: 0),
          duration: const Duration(seconds: 2),
        ),
        TranscriptLine(
          text: '第二句话',
          start: const Duration(seconds: 2),
          duration: const Duration(seconds: 2),
        ),
        TranscriptLine(
          text: '第三句话',
          start: const Duration(seconds: 4),
          duration: const Duration(seconds: 2),
        ),
      ];

      final merged = YoutubeRepository.deduplicateAndMergeLines(raw);
      expect(merged.length, 3);
      expect(merged[0].text, '第一句话');
      expect(merged[1].text, '第二句话');
      expect(merged[2].text, '第三句话');
    });
  });
}
