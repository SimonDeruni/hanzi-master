import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/local_tone_grader.dart';

import '../../support/tone_audio_harness.dart';

/// Stage 8 — the wiring.
///
/// The evaluator's own suite uses hand-written contours, and the detector's uses
/// synthetic PCM, but neither proves that a recording **changes what a learner sees**.
/// This file is the seam between them: `gradeAudio`'s word list in, the measured tone out.
///
/// The cases below are mostly about what the grader *refuses* to do, because that is
/// where the risk lives. `gradeAudio` feeds shadowing, the live call, Echo Hall roleplay
/// and flashcards speaking, and all four read `actualTone` as "a tone was measured" — so
/// a wrong measurement here is worse than no measurement.

/// One word as Azure hands it over, before the local pass sees it.
Map<String, dynamic> azureWord(
  String word, {
  int expectedTone = 1,
  int actualTone = 0,
  bool isCorrect = true,
  bool isPartial = false,
}) =>
    <String, dynamic>{
      'word': word,
      'expectedTone': expectedTone,
      'actualTone': actualTone,
      'isCorrect': isCorrect,
      'isPartial': isPartial,
      'score': 100,
    };

void main() {
  group('LocalToneGrader — what it will not grade', () {
    test('a phrase is left exactly as Azure left it', () async {
      final words = [
        azureWord('妈', expectedTone: 1),
        azureWord('妈', expectedTone: 1),
      ];

      final result = await LocalToneGrader.apply(
        audioBytes: toneWavFor(1),
        words: words,
      );

      // Nothing was divided, nothing was guessed.
      expect(LocalToneGrader.canGrade(words), isFalse);
      expect(result.length, 2);
      expect(result.every((w) => w['actualTone'] == 0), isTrue);
    });

    test('a multi-character "word" is still a phrase', () {
      expect(LocalToneGrader.canGrade([azureWord('妈妈')]), isFalse);
      expect(LocalToneGrader.hanziCount('妈妈'), 2);
      expect(LocalToneGrader.canGrade([azureWord('妈')]), isTrue);
    });

    test('a neutral tone is not graded — there is no fixed shape to grade it against',
        () async {
      final words = [azureWord('吗', expectedTone: 5)];

      final result = await LocalToneGrader.apply(
        audioBytes: toneWavFor(4),
        words: words,
      );

      expect(result.first['actualTone'], 0);
      expect(result.first.containsKey('toneVerdict'), isFalse);
    });

    test('a syllable Azure never heard is never given a tone', () async {
      // This is the guard against the loudest failure mode there is: speak a word of
      // English instead of the character, and the microphone still traces *some* pitch
      // contour. Measuring a tone from it and naming it confidently would be the audit-39
      // fabrication arriving by a new route — not inventing a tone from a score, but
      // measuring one from speech that was never the syllable.
      for (final flag in <Map<String, dynamic>>[
        {'isOmitted': true},
        {'assessed': false},
      ]) {
        final words = [azureWord('妈', expectedTone: 2)..addAll(flag)];

        final result = await LocalToneGrader.apply(
          audioBytes: toneWavFor(2),
          words: words,
        );

        expect(result.first['actualTone'], 0,
            reason: 'nothing was said in that slot, so nothing may be measured: $flag');
        expect(result.first.containsKey('toneVerdict'), isFalse);
      }
    });

    test('silence leaves the words untouched rather than inventing a tone', () async {
      final words = [azureWord('妈', expectedTone: 1)];
      // Four windows of exact zero: no pitch at all.
      final silence = toneWav(List<double>.filled(4, 0));

      final result = await LocalToneGrader.apply(
        audioBytes: silence,
        words: words,
      );

      expect(result.first['actualTone'], 0,
          reason: 'silence must never be named as a tone');
      expect(result.first['toneVerdict'], 'unvoiced');
    });
  });

  group('LocalToneGrader — what it does grade', () {
    test('a lone character gets a real tone out of real audio', () async {
      // The whole path: WAV in, detector, evaluator, word list out.
      final words = [azureWord('妈', expectedTone: 2)];

      final result = await LocalToneGrader.apply(
        audioBytes: toneWavFor(2),
        words: words,
      );

      expect(result.first['actualTone'], 2);
      expect(result.first['isCorrect'], isTrue);
      expect(result.first['isPartial'], isFalse);
      expect(result.first['toneSpanSemitones'], isNotNull);
    });

    test('a level tone is not mistaken for a moving one', () async {
      final words = [azureWord('妈', expectedTone: 1)];

      final result = await LocalToneGrader.apply(
        audioBytes: toneWavFor(1),
        words: words,
      );

      expect(result.first['actualTone'], 1);
      expect(result.first['toneSpanSemitones'], lessThan(1.5));
    });

    test('a wrong tone overrules Azure and is reported as a tone fault', () async {
      // Azure heard the syllable correctly, so it said the word was fine. The learner
      // said a falling tone where a rising one was asked for.
      final words = [azureWord('妈', expectedTone: 2, isCorrect: true)];

      final result = await LocalToneGrader.apply(
        audioBytes: toneWavFor(4),
        words: words,
      );

      expect(result.first['actualTone'], 4);
      expect(result.first['isCorrect'], isFalse,
          reason: 'a measured wrong tone is a wrong answer');
      expect(result.first['isPartial'], isTrue,
          reason: 'right syllable, wrong tone — exactly what isPartial means');
    });

    test('a mispronounced syllable is not relabelled as a tone fault', () async {
      // Azure rejected the *sounds*. Overwriting isCorrect would be right, but
      // isPartial means "right syllable, wrong tone", and claiming that here would
      // invent a second, unrelated error.
      final words = [
        azureWord('妈', expectedTone: 2, isCorrect: false, isPartial: false),
      ];

      final result = await LocalToneGrader.apply(
        audioBytes: toneWavFor(4),
        words: words,
      );

      expect(result.first['isCorrect'], isFalse);
      expect(result.first['isPartial'], isFalse);
      // The tone is still reported — a bad syllable can also have a bad tone.
      expect(result.first['actualTone'], 4);
    });

    test('the untouched fields survive the pass', () async {
      final words = [azureWord('妈', expectedTone: 1)];

      final result = await LocalToneGrader.apply(
        audioBytes: toneWavFor(1),
        words: words,
      );

      expect(result.first['word'], '妈');
      expect(result.first['score'], 100);
    });
  });
}
