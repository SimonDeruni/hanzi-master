/// Builds an exam paper from the app's own data — never from a prompt.
///
/// This is where §11.3 of `docs/AI_TUTOR_CONCEPT.md` is enforced item by item:
///
///  * every item is **assembled from bundled vocabulary**, so the answer key is
///    correct by construction rather than by trust;
///  * every item has **exactly one defensible answer** — a distractor that is also
///    correct-looking (the *other* pinyin of the same character, say) is excluded,
///    not hoped against;
///  * an item that cannot be built (no sentence for `fillBlank` at this level, a
///    vocabulary too small for four distinct options) is **dropped and counted**,
///    so the learner is told the paper is thinner than the blueprint asked for.
///
/// [ExamBuilder.buildFrom] is pure — no assets, no clock, no unseeded randomness —
/// so a test can pin an exact paper.
library;

import 'dart:math';

import 'package:hanzi_master/features/exam/data/hsk_lexicon.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_word.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:uuid/uuid.dart';

abstract final class ExamBuilder {
  /// Four options, like the real papers — or the item is dropped.
  static const int optionCount = 4;

  /// The fewest options that still make a question. Below this an item is a coin
  /// toss, so it is dropped instead.
  static const int minOptions = 3;

  /// Builds the paper for [blueprint] from the bundled vocabulary of its level.
  static Future<ExamPaper?> build({
    required ExamBlueprint blueprint,
    int? seed,
    DateTime? now,
    String? passage,
  }) async {
    final List<ExamWord> words = await HskLexicon.level(blueprint.level);
    if (words.isEmpty) return null;
    return buildFrom(
      blueprint: blueprint,
      words: words,
      seed: seed,
      now: now,
      passage: passage,
    );
  }

  static ExamPaper? buildFrom({
    required ExamBlueprint blueprint,
    required List<ExamWord> words,
    int? seed,
    DateTime? now,
    String? deckId,
    String? deckName,
    String? passage,
  }) {
    // Four distinct options cannot be made from three words.
    if (words.length < optionCount + 1) return null;

    final Random random = Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final List<ExamWord> pool = List<ExamWord>.from(words)..shuffle(random);
    final Set<String> usedUuids = <String>{};
    int cursor = 0;
    int dropped = 0;
    final List<ExamSection> sections = <ExamSection>[];

    // The text `passageFill` blanks words in: whatever the caller supplied (a graded
    // story, say), or the pool's own example sentences joined. Either way it is text
    // the app already had — nothing here writes a passage at exam time.
    final String? examPassage = (passage != null && passage.trim().isNotEmpty)
        ? passage.trim()
        : _derivedPassage(pool);

    for (final ExamSectionPlan plan in blueprint.sections) {
      // A section whose kinds the source cannot carry *at all* simply is not in the
      // paper — a level with no sentences has no word-order section, and saying so
      // through a missing section is truer than reporting a shortfall of items it
      // never had. What *is* counted is a section that was buildable but thinner
      // than asked for, which is the case a learner should see (§11.3.3).
      final bool buildable = plan.kinds
          .any((ExamItemKind kind) => _satisfiable(kind, pool, examPassage));
      if (!buildable) continue;

      final List<ExamItem> items = <ExamItem>[];

      // One slot per item the blueprint asked for, each with its declared kind.
      // A slot that cannot be built is left empty and counted — never filled with
      // a different kind of question, which would be a silent change to the exam,
      // and never allowed to end the section (looking for a `fillBlank` at a level
      // with no sentences would otherwise walk the whole pool).
      for (int slot = 0; slot < plan.items; slot++) {
        final ExamItemKind kind = plan.kinds[slot % plan.kinds.length];
        if (!_satisfiable(kind, pool, examPassage)) continue;

        ExamWord? word;
        while (cursor < pool.length) {
          final ExamWord candidate = pool[cursor++];
          if (usedUuids.contains(candidate.id)) continue;
          // The kinds that need the word to carry something ask for it here, so a
          // slot looks for a *usable* word instead of giving up on the first one.
          if (kind == ExamItemKind.fillBlank && !candidate.canFillBlank) {
            continue;
          }
          if ((kind == ExamItemKind.orderTokens ||
                  kind == ExamItemKind.grammarError) &&
              (candidate.sentence?.trim().isEmpty ?? true)) {
            continue;
          }
          if (kind == ExamItemKind.toneChoice &&
              candidate.baseSyllable == null) {
            continue;
          }
          if (kind == ExamItemKind.dictation &&
              !PinyinUtils.hasToneInformation(candidate.pinyin)) {
            continue;
          }
          if (kind == ExamItemKind.passageFill &&
              !(examPassage?.contains(candidate.hanzi) ?? false)) {
            continue;
          }
          word = candidate;
          break;
        }
        if (word == null) continue; // the pool is exhausted

        final ExamItem? item = _item(
          kind: kind,
          word: word,
          pool: pool,
          random: random,
          passage: examPassage,
        );
        if (item == null) continue;

        usedUuids.add(word.id);
        items.add(item);
      }

      // A blueprint can ask for more than the vocabulary can supply: the shortfall
      // is stated in the report (§11.3.3), never hidden.
      dropped += plan.items - items.length;
      if (items.isEmpty) continue;
      sections.add(ExamSection(
        kind: plan.kind,
        minutes: plan.minutes,
        items: items,
      ));
    }

    if (sections.isEmpty) return null;
    return ExamPaper(
      id: const Uuid().v4(),
      blueprintId: blueprint.id,
      level: blueprint.level,
      createdAt: now ?? DateTime.now(),
      passMark: blueprint.passMark,
      dropped: dropped,
      deckId: deckId,
      deckName: deckName,
      sections: sections,
    );
  }

  /// A paper from the learner's own **deck** — the same builder, the same rules,
  /// a different vocabulary source.
  ///
  /// This is the point of the whole abstraction: an exam from "Tones" or "HSK 3"
  /// or a deck of thirty characters someone imported is still an exam — timed, no
  /// hints, one frozen key, a report — because the items come from the cards the
  /// learner chose. Every distractor is another card *in that deck*, so an item
  /// cannot be answered from vocabulary the deck never taught.
  ///
  /// Returns null when the deck cannot carry a paper at all (fewer than
  /// [ExamBlueprint.minimumVocabulary] usable cards). The caller turns that into
  /// the app's existing "not enough cards" answer, which is the honest response:
  /// four words are not an exam.
  static ExamPaper? buildFromCards({
    required List<Flashcard> cards,
    String? deckName,
    int? seed,
    DateTime? now,
  }) {
    if (cards.isEmpty) return null;
    final String deckId = cards.first.deckId;

    // Cards that cannot carry a key (no pinyin, no definition) are left out
    // *before* the paper is sized, so a half-finished deck does not produce a
    // paper full of dropped slots.
    final List<ExamWord> words = <ExamWord>[
      for (final Flashcard card in cards)
        if (ExamWord.fromCard(card).isUsable) ExamWord.fromCard(card),
    ];

    final ExamBlueprint? blueprint = ExamBlueprint.forDeck(
      vocabularySize: words.length,
      // A label hint only, never the scope (see [dominantLevel]).
      level: dominantLevel(cards),
    );
    if (blueprint == null) return null;

    return buildFrom(
      blueprint: blueprint,
      words: words,
      seed: seed,
      now: now,
      deckId: deckId,
      deckName: deckName,
    );
  }

  /// The HSK level most of the deck's cards carry, or 0 when nothing dominates.
  ///
  /// Used only as a label hint on the stored paper. It is deliberately *not* used
  /// to scope the vocabulary — the deck's own cards are the scope — because a deck
  /// called "HSK 3" with two HSK 5 words in it is still the deck the learner
  /// studies.
  static int dominantLevel(List<Flashcard> cards) {
    final Map<int, int> counts = <int, int>{};
    for (final Flashcard card in cards) {
      if (card.hskLevel > 0) {
        counts[card.hskLevel] = (counts[card.hskLevel] ?? 0) + 1;
      }
    }
    int level = 0;
    int best = 0;
    counts.forEach((int candidate, int count) {
      if (count > best) {
        best = count;
        level = candidate;
      }
    });
    return level;
  }

  /// The pool's own example sentences, joined into a short text for `passageFill`.
  ///
  /// Honest about what it is: the app's authored examples, not a coherent
  /// paragraph. It is the passage a paper can always have from its own material,
  /// and the caller may pass a better one (a graded story) when it has it.
  static String? _derivedPassage(List<ExamWord> pool) {
    final List<String> sentences = _sentences(pool);
    if (sentences.length < minOptions) return null;
    return sentences.take(4).join(' ');
  }

  /// Whether [pool] can build this kind at all.
  ///
  /// This is the guard that keeps a section whole: a blueprint may ask for
  /// `fillBlank` at a level whose bundle has no sentences, and the honest outcome
  /// is dropping those items — not losing the questions around them.
  static bool _satisfiable(
    ExamItemKind kind,
    List<ExamWord> pool,
    String? passage,
  ) {
    switch (kind) {
      case ExamItemKind.fillBlank:
        return pool.any((ExamWord word) => word.canFillBlank);
      case ExamItemKind.orderTokens:
        // Word order needs a sentence to work on — not a sentence containing the
        // word: the sentence *is* the material, and the word only carried it here.
        return _sentences(pool).length >= 2;
      case ExamItemKind.toneChoice:
        return pool.any((ExamWord word) => word.baseSyllable != null);
      case ExamItemKind.dictation:
        return pool.any(
            (ExamWord word) => PinyinUtils.hasToneInformation(word.pinyin));
      case ExamItemKind.grammarError:
        // Three untouched sentences and one altered: without three others there is
        // no item, and inventing a sentence would be inventing content.
        return _sentences(pool).length >= 4;
      case ExamItemKind.passageFill:
        return passage != null && passage.trim().isNotEmpty;
      case ExamItemKind.audioToCharacter:
      case ExamItemKind.characterToMeaning:
      case ExamItemKind.characterToPinyin:
        return pool.length > optionCount;
    }
  }

  /// Every distinct example sentence the pool carries — the corpus an
  /// error-spotting item is built from, and never a sentence the app made up.
  static List<String> _sentences(List<ExamWord> pool) {
    final Set<String> seen = <String>{};
    final List<String> found = <String>[];
    for (final ExamWord word in pool) {
      final String? sentence = word.sentence?.trim();
      if (sentence == null || sentence.isEmpty) continue;
      if (seen.add(sentence)) found.add(sentence);
    }
    return found;
  }

  static ExamItem? _item({
    required ExamItemKind kind,
    required ExamWord word,
    required List<ExamWord> pool,
    required Random random,
    String? passage,
  }) {
    // The kinds that are not "a stem plus four options" build themselves.
    switch (kind) {
      case ExamItemKind.toneChoice:
        return _toneItem(word, random);
      case ExamItemKind.dictation:
        return _dictationItem(word);
      case ExamItemKind.orderTokens:
        return _orderItem(word, pool, random);
      case ExamItemKind.grammarError:
        return _grammarItem(word, pool, random);
      case ExamItemKind.passageFill:
        return _passageItem(word, pool, passage, random);
      case ExamItemKind.audioToCharacter:
      case ExamItemKind.characterToMeaning:
      case ExamItemKind.characterToPinyin:
      case ExamItemKind.fillBlank:
        break;
    }

    final String answer;
    final List<String> distractors;

    switch (kind) {
      case ExamItemKind.audioToCharacter:
        answer = word.hanzi;
        distractors = _distractors(pool, word, random, (ExamWord w) => w.hanzi);
      case ExamItemKind.characterToMeaning:
        answer = word.shortDefinition;
        distractors =
            _distractors(pool, word, random, (ExamWord w) => w.shortDefinition);
      case ExamItemKind.characterToPinyin:
        answer = word.pinyin;
        distractors =
            _distractors(pool, word, random, (ExamWord w) => w.pinyin);
      case ExamItemKind.fillBlank:
        if (!word.canFillBlank) return null;
        answer = word.hanzi;
        distractors = _distractors(pool, word, random, (ExamWord w) => w.hanzi);
      default:
        // Every other kind was built and returned by the switch above; this case is
        // here so the compiler can see that this switch is exhaustive.
        throw StateError('$kind builds itself and never reaches here');
    }

    final List<String>? options = _mix(answer, distractors, random);
    if (options == null) return null;

    return ExamItem(
      kind: kind,
      hanzi: word.hanzi,
      pinyin: word.pinyin,
      definition: word.shortDefinition,
      sentence: kind == ExamItemKind.fillBlank
          ? word.sentence!.replaceAll(word.hanzi, '＿＿')
          : null,
      answer: answer,
      options: options,
    );
  }

  /// The four tones of one syllable, marked: the minimal pair a tone item is
  /// about. Derived, never authored — the key is the word's own pinyin.
  static ExamItem? _toneItem(ExamWord word, Random random) {
    final String? base = word.baseSyllable;
    if (base == null) return null;
    final int tone = PinyinUtils.toneFromSyllable(word.pinyin);
    // A neutral-tone word has no place in a 1-4 tone question: its "tone" is the
    // absence of one, which is a different lesson.
    if (tone < 1 || tone > 4) return null;

    final List<String> options = <String>[
      for (int candidate = 1; candidate <= 4; candidate++)
        PinyinUtils.convertNumericToMarks('$base$candidate'),
    ]..shuffle(random);

    // The key is the marked form of the syllable's own tone, so a pool that writes
    // pinyin with numbers and one that writes it with marks give the same item.
    final String answer = PinyinUtils.convertNumericToMarks('$base$tone');
    if (!options.contains(answer)) return null;

    return ExamItem(
      kind: ExamItemKind.toneChoice,
      hanzi: word.hanzi,
      pinyin: word.pinyin,
      definition: word.shortDefinition,
      answer: answer,
      options: options,
    );
  }

  /// Hear it, type the pinyin. The key is the authored pinyin; grading normalises
  /// tone marks and tone numbers to one form and still requires the tone.
  static ExamItem? _dictationItem(ExamWord word) {
    if (!PinyinUtils.hasToneInformation(word.pinyin)) return null;
    return ExamItem(
      kind: ExamItemKind.dictation,
      hanzi: word.hanzi,
      pinyin: word.pinyin,
      definition: word.shortDefinition,
      answer: word.pinyin,
      options: const <String>[],
    );
  }

  /// Put the words back in order, using the sentence's own words — segmented
  /// against the pool, so the tokens are words the learner has met.
  static ExamItem? _orderItem(
      ExamWord word, List<ExamWord> pool, Random random) {
    final String? sentence = word.sentence?.trim();
    if (sentence == null || sentence.isEmpty) return null;
    final List<String>? tokens = segment(sentence, pool);
    if (tokens == null || tokens.length < 2) return null;

    final List<String> jumbled = List<String>.from(tokens)..shuffle(random);
    if (_sameOrder(jumbled, tokens)) {
      // Shuffling can hand the answer back: swap two tokens so it is a task.
      jumbled.insert(0, jumbled.removeAt(1));
    }
    return ExamItem(
      kind: ExamItemKind.orderTokens,
      hanzi: word.hanzi,
      pinyin: word.pinyin,
      definition: word.shortDefinition,
      sentence: sentence,
      answer: tokens.join(' '),
      options: jumbled,
    );
  }

  /// Four sentences, three untouched and one altered by the app.
  ///
  /// The key is the sentence the app changed, so the item asks "which one is
  /// broken" without judging grammar and without inventing content: the other three
  /// come from the pool's own authored sentences.
  static ExamItem? _grammarItem(
    ExamWord word,
    List<ExamWord> pool,
    Random random,
  ) {
    final String? target = word.sentence?.trim();
    if (target == null || target.isEmpty) return null;
    final String? broken = _break(target);
    if (broken == null) return null;

    final List<String> others = _sentences(pool)
        .where((String sentence) => sentence != target)
        .toList()
      ..shuffle(random);
    if (others.length < minOptions) return null;

    final List<String> options = <String>[
      broken,
      ...others.take(optionCount - 1),
    ]..shuffle(random);

    return ExamItem(
      kind: ExamItemKind.grammarError,
      hanzi: word.hanzi,
      pinyin: word.pinyin,
      definition: word.shortDefinition,
      // The correct version, which is what the review list should show.
      sentence: target,
      answer: broken,
      options: options,
    );
  }

  /// A passage the app was handed, with one of its own words blanked: the key is
  /// the word the app removed, so nothing here is judged either.
  static ExamItem? _passageItem(
    ExamWord word,
    List<ExamWord> pool,
    String? passage,
    Random random,
  ) {
    final String? text = passage?.trim();
    if (text == null || text.isEmpty || !text.contains(word.hanzi)) return null;

    final List<String> distractors =
        _distractors(pool, word, random, (ExamWord w) => w.hanzi);
    final List<String>? options = _mix(word.hanzi, distractors, random);
    if (options == null) return null;

    return ExamItem(
      kind: ExamItemKind.passageFill,
      hanzi: word.hanzi,
      pinyin: word.pinyin,
      definition: word.shortDefinition,
      sentence: text.replaceFirst(word.hanzi, '＿＿'),
      answer: word.hanzi,
      options: options,
    );
  }

  /// The corruption rules: deliberately few, each producing a sentence that is
  /// *categorically* wrong rather than merely unusual, so the key cannot be argued
  /// with. A doubled 很, 不 or 的 is never right; 非常 is left out because
  /// `非常非常` is legitimate emphasis. The set is versioned with the blueprint, and
  /// a sentence the rules cannot alter yields no item rather than a weak one.
  static const List<String> _doublable = <String>['很', '不', '的'];

  static String? _break(String sentence) {
    for (final String particle in _doublable) {
      if (sentence.contains(particle)) {
        return sentence.replaceFirst(particle, '$particle$particle');
      }
    }
    return null;
  }

  static bool _sameOrder(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  /// The longest word the segmenter looks for.
  static const int _maxTokenLength = 4;

  /// Splits [sentence] into words the pool knows, longest match first, falling back
  /// to single characters — Chinese has no spaces, so "arrange these words" has to
  /// define what a word is before it can ask.
  ///
  /// Non-Chinese characters (punctuation) are not tokens: they stay in
  /// [ExamItem.sentence], which is what the learner reads the answer against.
  static List<String>? segment(String sentence, List<ExamWord> pool) {
    final Set<String> known = <String>{
      for (final ExamWord word in pool)
        if (word.hanzi.isNotEmpty) word.hanzi,
    };
    final List<String> tokens = <String>[];
    int index = 0;

    while (index < sentence.length) {
      if (!_isHan(sentence[index])) {
        index++;
        continue;
      }
      String? match;
      for (int length = _maxTokenLength; length >= 1; length--) {
        final int end = index + length;
        if (end > sentence.length) continue;
        final String candidate = sentence.substring(index, end);
        if (!candidate.split('').every(_isHan)) continue;
        if (length == 1 || known.contains(candidate)) {
          match = candidate;
          break;
        }
      }
      if (match == null) return null;
      tokens.add(match);
      index += match.length;
    }
    return tokens.isEmpty ? null : tokens;
  }

  static bool _isHan(String char) {
    if (char.isEmpty) return false;
    final int rune = char.runes.first;
    return rune >= 0x4E00 && rune <= 0x9FFF;
  }

  /// Distractors for an item about [word], taken from [pool] starting at a random
  /// point so two items in one paper do not share a set.
  ///
  /// For the kinds whose stem *is* the character, candidates carrying that same
  /// character are skipped: HSK lists 只 as both zhī and zhǐ, so the other reading
  /// would have been a second correct option.
  static List<String> _distractors(
    List<ExamWord> pool,
    ExamWord word,
    Random random,
    String Function(ExamWord word) value,
  ) {
    final bool stemIsCharacter = value(word) != word.hanzi;
    final Set<String> taken = <String>{value(word).trim().toLowerCase()};
    final List<String> found = <String>[];
    final int start = random.nextInt(pool.length);

    for (int i = 0; i < pool.length && found.length < optionCount - 1; i++) {
      final ExamWord other = pool[(start + i) % pool.length];
      if (other.id == word.id) continue;
      if (stemIsCharacter && other.hanzi == word.hanzi) continue;
      final String candidate = value(other).trim();
      if (candidate.isEmpty) continue;
      if (!taken.add(candidate.toLowerCase())) continue;
      found.add(candidate);
    }
    return found;
  }

  /// The option list: the answer plus the distractors, shuffled and distinct.
  static List<String>? _mix(
      String answer, List<String> distractors, Random random) {
    final String trimmed = answer.trim();
    if (trimmed.isEmpty || distractors.length < minOptions - 1) return null;

    final List<String> options = <String>[trimmed, ...distractors]
      ..shuffle(random);
    final Set<String> distinct =
        options.map((String option) => option.toLowerCase()).toSet();
    if (distinct.length != options.length) return null;
    if (!options.contains(trimmed)) return null;
    return options;
  }
}
