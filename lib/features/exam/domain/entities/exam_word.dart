/// One word an item can be built from, whatever it came from.
///
/// The builder does not care whether this is a word from the bundled HSK
/// vocabulary or a card in the learner's own deck: an item needs a hanzi (also
/// what TTS speaks), a pinyin for one kind of key, a definition for another, and
/// optionally a sentence for `fillBlank`. Putting that in one value type is what
/// lets the same builder, the same blueprint and the same grader serve both
/// sources — an exam from a deck and an HSK paper are the same exam over
/// different words, and the deck is just the vocabulary source the learner chose.
library;

import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

class ExamWord {
  const ExamWord({
    required this.id,
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    this.sentence,
  });

  /// Where it came from: a bundle uuid, or a card's id.
  final String id;

  final String hanzi;
  final String pinyin;
  final String definition;

  /// An example sentence containing [hanzi], when the source has one — the HSK 1
  /// bundle, or a card the learner saved context for.
  final String? sentence;

  /// The first sense only: "to love; affection" is a dictionary entry, and an
  /// option in an exam is not.
  String get shortDefinition {
    final String first = definition.split(';').first.trim();
    return first.isEmpty ? definition.trim() : first;
  }

  bool get canFillBlank {
    final String? text = sentence;
    return text != null && text.contains(hanzi);
  }

  /// A single-syllable pinyin, which is what a tone question can be asked about:
  /// `bàba` says nothing about *which* syllable's tone is in question, `bà` does.
  bool get isSingleSyllable =>
      pinyin.trim().isNotEmpty && !pinyin.trim().contains(RegExp(r'\s'));

  /// The base syllable without its tone mark — `bà` → `ba`. Null when the pinyin
  /// carries no tone information at all, because a tone item about it would have
  /// no key.
  String? get baseSyllable {
    if (!isSingleSyllable || !PinyinUtils.hasToneInformation(pinyin)) {
      return null;
    }
    return PinyinUtils.stripTone(pinyin.trim());
  }

  /// Whether this word can carry an item at all: a key needs something to ask
  /// about *and* something to be right about.
  ///
  /// Cards that fail this are left out before a paper is sized, so a deck with
  /// half-finished cards does not produce a paper full of dropped slots.
  bool get isUsable =>
      hanzi.trim().isNotEmpty &&
      pinyin.trim().isNotEmpty &&
      definition.trim().isNotEmpty;

  /// A word from the learner's own card. The definition the learner already sees
  /// is the key, with the English one as a fallback for a card whose localised
  /// definition never arrived.
  factory ExamWord.fromCard(Flashcard card) => ExamWord(
        id: card.id,
        hanzi: card.hanzi,
        pinyin: card.pinyin,
        definition: card.definition.trim().isNotEmpty
            ? card.definition
            : (card.englishDefinition ?? ''),
        sentence: card.sourceSentence,
      );

  /// The word an exam item was built from, recovered from the item itself.
  ///
  /// A report knows which items were missed, and an item carries the word it asked
  /// about — so "practise what you just missed" needs no second lookup and nothing
  /// has to be remembered between the sitting and the retake.
  factory ExamWord.fromItem(ExamItem item) => ExamWord(
        id: 'missed:${item.hanzi}',
        hanzi: item.hanzi,
        pinyin: item.pinyin ?? '',
        definition: item.definition ?? '',
        sentence: item.sentence,
      );
}
