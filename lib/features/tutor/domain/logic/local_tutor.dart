/// A tutor that needs no model.
///
/// Two reasons this exists rather than being an afterthought:
///
///  1. **The feature has to work with no API key and offline.** Stroke order,
///     anatomy and exam folders are all built from bundled data, so the honest
///     degradation is a real answer — not an error toast.
///  2. **It is the fallback the parser falls back to.** If the model returns
///     something unusable, the learner gets this instead of a blank bubble, and
///     `TutorReply.fromModel == false` says so on screen.
///
/// It is deliberately dumb: keyword → block. The intelligence is the model's when
/// there is one; the *guarantees* are always the app's.
library;

import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';

abstract final class LocalTutor {
  /// "make me an exam", in the languages the app ships. Matching a request is all
  /// this needs — deciding *how* is the app's job, not a language model's.
  static const List<String> _examWords = <String>[
    'exam',
    'test',
    'quiz',
    'examen',
    'prüfung',
    'exam',
    'esame',
    'prova',
    'экзамен',
    'тест',
    '試験',
    '시험',
    'บทสอบ',
    'kỳ thi',
    'امتحان',
    'परीक्षा',
    'ujian',
    '考试',
    '考',
  ];

  static bool looksLikeExamRequest(String message) {
    final String lower = message.toLowerCase();
    for (final String word in _examWords) {
      if (lower.contains(word)) return true;
    }
    return false;
  }

  /// Composes the best model-free answer available.
  static TutorReply compose({
    required String message,
    required TutorContext context,
  }) {
    if (looksLikeExamRequest(message)) {
      final TutorDeckSummary? deck = context.focusedDeck;
      if (deck == null && context.decks.isNotEmpty) {
        // Never guess which deck: ask, with the decks as tappable answers.
        return TutorReply(
          say: context.decks.length == 1
              ? null
              : 'Which deck should the exam draw from?',
          ask: TutorAsk(
            question: 'Which deck should the exam draw from?',
            options: context.decks
                .take(4)
                .map((TutorDeckSummary deck) =>
                    TutorAskOption(label: deck.name, value: deck.id))
                .toList(),
          ),
        );
      }
      if (deck != null && deck.cardCount > 0) {
        final int items = deck.cardCount < 20 ? deck.cardCount : 20;
        return TutorReply(
          say: 'I can build a $items-item exam folder from ${deck.name}. '
              'Every item comes from that deck, so nothing is invented.',
          makes: <TutorMake>[
            TutorMake(
              kind: TutorMakeKind.examFolder,
              deckId: deck.id,
              items: items,
              title: deck.name,
            ),
          ],
        );
      }
    }

    // A character in hand is the other thing this can answer without a model.
    final String? hanzi = _singleCharacter(message);
    if (hanzi != null) {
      return TutorReply(
        say: 'Here is how $hanzi is built, and how it is written.',
        artefacts: <TutorArtefact>[
          TutorArtefact(
              TutorArtefactType.characterAnatomy, <String, Object?>{'hanzi': hanzi}),
          TutorArtefact(
              TutorArtefactType.strokeOrder, <String, Object?>{'hanzi': hanzi}),
        ],
      );
    }

    return const TutorReply(
      say: 'Ask me about a character — I will show you how it is built and how it '
          'is written — or ask me for an exam on one of your decks.',
    );
  }

  /// The single CJK character in a message, if there is exactly one kind of them.
  /// (A learner typing "explain 好" means 好.)
  static String? _singleCharacter(String message) {
    final Set<String> found = <String>{};
    for (final int rune in message.runes) {
      if (rune >= 0x4E00 && rune <= 0x9FFF) {
        found.add(String.fromCharCode(rune));
      }
      if (found.length > 1) return null;
    }
    return found.isEmpty ? null : found.first;
  }
}
