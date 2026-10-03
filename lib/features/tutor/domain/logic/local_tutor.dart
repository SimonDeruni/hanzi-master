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

import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_memory.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

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

  static bool looksLikeExamRequest(String message, {AppLocalizations? l10n}) {
    final String lower = message.toLowerCase();
    for (final String word in _examWords) {
      if (lower.contains(word)) return true;
    }
    // The feature's own name, in the learner's language. `_examWords` above is a
    // keyword list rather than interface text — those are the words a learner
    // might *type* — but only the ARB knows what the app calls this feature in,
    // say, Thai or Indonesian, so that one word comes from there.
    if (l10n != null) {
      final String named = l10n.practiceQuiz.trim().toLowerCase();
      if (named.isNotEmpty && lower.contains(named)) return true;
    }
    return false;
  }

  /// Composes the best model-free answer available.
  ///
  /// Every sentence here comes from the ARB via [l10n]: a fallback that answered
  /// in English would be worse than no fallback, because it looks like the
  /// tutor ignored the learner's language.
  static TutorReply compose({
    required String message,
    required TutorContext context,
    required AppLocalizations l10n,
    TutorMemory memory = TutorMemory.empty,
  }) {
    final String lower = message.toLowerCase();
    if (looksLikeExamRequest(message, l10n: l10n) || lower.contains('hsk')) {
      // A named level makes it a **paper**, not a folder of the learner's own
      // cards: the blueprint is the app's (§5.2) and every item comes from the
      // bundled HSK vocabulary, so the key cannot be wrong (§11.3).
      final int? level = _levelIn(message);
      final ExamBlueprint? blueprint =
          level == null ? null : ExamBlueprint.forLevel(level);
      if (blueprint != null && level != null) {
        return TutorReply(
          say: '${l10n.examTitle(level)} · '
              '${l10n.deckItemsCount(blueprint.totalItems)}',
          makes: <TutorMake>[
            TutorMake(
              kind: TutorMakeKind.examPaper,
              level: level,
              items: blueprint.totalItems,
              title: l10n.hskLevel('$level'),
            ),
          ],
        );
      }

      // "an HSK test" with no level named is still a paper — asked about, not
      // guessed at, and not quietly turned into a folder.
      final TutorDeckSummary? deck = context.focusedDeck;
      final bool wantsPaper = LocalTutor.wantsPaper(message);

      // An exam on a deck the learner has: their own cards are the vocabulary, so
      // the paper is built from the deck rather than from the bundled lists. This
      // is what "create an exam from any deck" means.
      if (wantsPaper &&
          deck != null &&
          deck.cardCount >= ExamBlueprint.minimumVocabulary) {
        return TutorReply(
          say: '${l10n.examTitleDeck(deck.name)} · '
              '${l10n.deckItemsCount(deck.cardCount)}',
          makes: <TutorMake>[
            TutorMake(
              kind: TutorMakeKind.examPaper,
              deckId: deck.id,
              items: deck.cardCount,
              title: deck.name,
            ),
          ],
        );
      }

      // A deck in hand and no exam flavour ("quiz me on this deck"): the drill
      // folder it has always been.
      if (!wantsPaper && deck != null && deck.cardCount > 0) {
        final int items = deck.cardCount < 20 ? deck.cardCount : 20;
        return TutorReply(
          say: l10n.tutorQuizProposal(items, deck.name),
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

      // Several decks and none in hand: never guess which one, ask.
      if (deck == null && context.decks.isNotEmpty) {
        return TutorReply(
          say: context.decks.length == 1 ? null : l10n.tutorChooseDeck,
          ask: TutorAsk(
            question: l10n.tutorChooseDeck,
            options: context.decks
                .take(4)
                .map((TutorDeckSummary deck) =>
                    TutorAskOption(label: deck.name, value: deck.id))
                .toList(),
          ),
        );
      }

      // No level and no deck: the bundled vocabulary can still make a paper, so
      // ask which level. The value is a message that will be understood when it
      // comes back as one.
      return TutorReply(
        ask: TutorAsk(
          question: l10n.targetHskLevel,
          options: <TutorAskOption>[
            for (final int candidate in const <int>[1, 2, 3, 4])
              TutorAskOption(
                label: l10n.hskLevel('$candidate'),
                value: 'HSK $candidate exam',
              ),
          ],
        ),
      );
    }

    // A character in hand is the other thing this can answer without a model.
    final String? hanzi = _singleCharacter(message);
    if (hanzi != null) return _characterReply(hanzi, l10n);

    // A follow-up with no subject of its own — "and how is it written?" after 好 —
    // still has one: the character the conversation is about. The gate is that the
    // message names nothing else and stays short, so a real question is never
    // hijacked by it.
    final String? lastCharacter = memory.lastCharacter;
    if (lastCharacter != null && _looksLikeFollowUp(message)) {
      return _characterReply(lastCharacter, l10n);
    }

    return TutorReply(say: l10n.tutorFallbackIntro);
  }

  /// Both things this can show for one character, with the sentence that frames
  /// them.
  static TutorReply _characterReply(String hanzi, AppLocalizations l10n) =>
      TutorReply(
        say: l10n.tutorCharacterIntro(hanzi),
        artefacts: <TutorArtefact>[
          TutorArtefact(TutorArtefactType.characterAnatomy,
              <String, Object?>{'hanzi': hanzi}),
          TutorArtefact(
              TutorArtefactType.strokeOrder, <String, Object?>{'hanzi': hanzi}),
        ],
      );

  /// The HSK level named in a message, if any: "hsk 3", "HSK4", "3级".
  static final RegExp _hskLevel =
      RegExp(r'hsk\s*([1-6])', caseSensitive: false);
  static final RegExp _jLevel = RegExp(r'([1-6])\s*级');

  static int? _levelIn(String message) {
    for (final RegExp pattern in <RegExp>[_hskLevel, _jLevel]) {
      final RegExpMatch? match = pattern.firstMatch(message);
      final int? level =
          match == null ? null : int.tryParse(match.group(1) ?? '');
      if (level != null &&
          level >= ExamBlueprint.minLevel &&
          level <= ExamBlueprint.maxLevel) {
        return level;
      }
    }
    return null;
  }

  /// A message that asks for nothing else: no character of its own, no quiz, a
  /// handful of words. That is what "and how is it written?" looks like.
  static bool _looksLikeFollowUp(String message) {
    final String trimmed = message.trim();
    if (trimmed.isEmpty || trimmed.length > 48) return false;
    // A word count, approximated. CJK has no spaces, so the length cap above is
    // the real gate for those languages.
    return trimmed.split(RegExp(r'\s+')).length <= 7;
  }

  /// Words that mean "sit a paper" rather than "quiz me".
  ///
  /// `_examWords` above is deliberately broad — it decides whether the message is
  /// about testing at all — while this one decides *what kind*: an exam flavour
  /// (a timed paper, from a deck or a level) or a drill flavour (a folder of the
  /// learner's own cards). The app's own word for a quiz is not here, so
  /// "quiz me on this deck" still builds the drill it always did.
  static const List<String> _paperWords = <String>[
    'exam',
    'test',
    'examen',
    'prüfung',
    'esame',
    'prova',
    'экзамен',
    'тест',
    '試験',
    '시험',
    'สอบ',
    'thi',
    'امتحان',
    'परीक्षा',
    'ujian',
    '考试',
    '考',
  ];

  static bool wantsPaper(String message) {
    final String lower = message.toLowerCase();
    if (lower.contains('hsk')) return true;
    for (final String word in _paperWords) {
      if (lower.contains(word)) return true;
    }
    return false;
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
