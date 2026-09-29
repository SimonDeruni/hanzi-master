import 'dart:typed_data';

import 'package:hanzi_master/core/services/pitch_detector_service.dart';
import 'package:hanzi_master/core/utils/tone_evaluator.dart';
import 'package:hanzi_master/core/utils/tone_templates.dart';

/// Folds a **local** tone measurement into the grader's word list.
///
/// This is stage 8 of `docs/LOCAL_TONE_PLAN.md`, and the reason it exists is audit 39:
/// Azure names the *reference* syllable and never the tone that was produced, so before
/// this the app could only report "not measured". Here the recording itself is measured,
/// on the device, with no vendor and no network.
///
/// ## It refuses more than it grades, on purpose
///
/// * **One Hanzi only.** With a single syllable the whole contour *is* the syllable, so
///   nothing has to be segmented and nothing is guessed. A phrase would need to know where
///   each syllable starts — exactly what Azure's `Offset`/`Duration` would provide, and
///   `docs/LOCAL_TONE_PLAN.md` §1 is still waiting on that confirmation. Until then a
///   phrase is left to Azure's honest "not measured" rather than sliced into equal parts
///   and pretended to be.
/// * Every other refusal lives in [ToneEvaluator]: too few voiced frames, no fixed shape
///   for the tone, an octave jump, or pitch that matches no tone closely enough.
/// * **A failure here is never a grading failure.** Four features depend on
///   `gradeAudio`, so every path out of this class returns the words unchanged rather
///   than throwing.
class LocalToneGrader {
  const LocalToneGrader();

  static final RegExp _hanzi = RegExp(r'[\u4e00-\u9fff]');

  /// How many Hanzi a reference contains.
  static int hanziCount(String text) => _hanzi.allMatches(text).length;

  /// Whether this take can be measured locally at all — see the class comment for why
  /// it is one character and no more.
  static bool canGrade(List<Map<String, dynamic>> words) {
    if (words.length != 1) return false;
    final word = (words.first['word'] ?? '').toString().trim();
    return word.length == 1 && hanziCount(word) == 1;
  }

  /// Measures [audioBytes] and returns [words] with the tone filled in.
  ///
  /// Unchanged when the take cannot be measured, which is the common case today.
  static Future<List<Map<String, dynamic>>> apply({
    required List<int> audioBytes,
    required List<Map<String, dynamic>> words,
  }) async {
    try {
      if (!canGrade(words)) return words;

      final word = words.first;
      final expectedTone = (word['expectedTone'] as num?)?.toInt() ?? 0;
      if (!ToneTemplates.isGradable(expectedTone)) return words;

      // **A syllable that was not heard has no tone to measure.** If Azure omitted the
      // character, or never assessed it, then whatever the microphone caught — a cough, a
      // word of English, another language entirely — still traces *some* pitch contour,
      // and the evaluator would name a tone from it with full confidence. That would be
      // the audit-39 fabrication arriving by a new route: not inventing a tone from a
      // score, but measuring one from speech that was never the syllable.
      //
      // A *mispronounced* syllable is deliberately still graded: it was heard, and its
      // tone is a fair thing to report. `isOmitted` and `assessed: false` are the
      // "nothing was said here" states.
      if (word['isOmitted'] == true || word['assessed'] == false) return words;

      final contour = await PitchDetectorService()
          .extractPitchContour(Uint8List.fromList(audioBytes));
      if (contour.isEmpty) return words;

      // A lone character *is* the phrase, so its third tone is phrase-final and keeps
      // its full dip.
      final assessment = ToneEvaluator.evaluate(
        contour: contour,
        expectedTone: expectedTone,
      );

      final updated = Map<String, dynamic>.from(word);
      updated['actualTone'] = assessment.actualTone;
      // Carried alongside so a screen can explain *why* there is no verdict without
      // re-deriving it. Existing consumers ignore these keys.
      updated['toneVerdict'] = assessment.verdict.name;
      updated['toneSpanSemitones'] = assessment.spanSemitones;

      // The measurement is the authority on tone, so it also settles whether a fault is
      // the tone. Only when Azure already accepted the *segments*: `isPartial` means
      // "right syllable, wrong tone", and calling a mispronounced syllable a tone fault
      // would invent a second error.
      if (assessment.measured && word['isCorrect'] == true) {
        updated['isCorrect'] = assessment.matchesTarget;
        updated['isPartial'] = !assessment.matchesTarget;
      }

      return [updated];
    } catch (_) {
      // A pitch measurement must never be able to break grading.
      return words;
    }
  }
}
