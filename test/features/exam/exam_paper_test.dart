/// The exam, as an exam.
///
/// `docs/AI_TUTOR_CONCEPT.md` §5 and §11.3 make claims that are only worth
/// anything if they are enforced, and these are the tests that enforce them:
///
///  * **The answer key is derived locally and frozen** — never generated, never
///    guessed, and stored with the paper so a retake cannot be moved under a
///    learner mid-sitting.
///  * **Exactly one defensible answer.** A distractor that is also correct (the
///    other reading of the same character) is excluded rather than hoped against.
///  * **An item that cannot be built is dropped and counted**, so a thinner paper
///    is visible.
///  * **The model may propose a paper; it may not write one.** The only thing a
///    reply can choose is the level.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/features/exam/data/exam_builder.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_word.dart';
import 'package:hanzi_master/features/exam/domain/logic/exam_grader.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/tutor/data/tutor_envelope_parser.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/domain/logic/local_tutor.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final AppLocalizations enL10n = lookupAppLocalizations(const Locale('en'));

  /// A vocabulary pool shaped like the bundles: uuids, hanzi, pinyin, a
  /// multi-sense definition, and optionally a sentence containing the word.
  List<ExamWord> pool({int count = 40, bool withSentences = false}) =>
      <ExamWord>[
        for (int i = 0; i < count; i++)
          ExamWord(
            id: 'w${i.toString().padLeft(3, '0')}',
            hanzi: '词$i',
            pinyin: 'ci$i',
            definition: 'meaning $i; second sense $i',
            sentence: withSentences ? '我 说 词$i 。' : null,
          ),
      ];

  ExamWord wordOf(List<ExamWord> words, String hanzi) =>
      words.firstWhere((ExamWord word) => word.hanzi == hanzi);

  group('the blueprint', () {
    test('exists for every HSK level the app has vocabulary for', () {
      expect(ExamBlueprint.supportedLevels, <int>[1, 2, 3, 4, 5, 6]);
      for (final int level in ExamBlueprint.supportedLevels) {
        final ExamBlueprint blueprint = ExamBlueprint.forLevel(level)!;
        expect(blueprint.level, level);
        expect(blueprint.sections.first.kind, ExamSectionKind.listening,
            reason: 'HSK always opens with audio');
        expect(
            blueprint.totalItems,
            blueprint.sections
                .fold(0, (int sum, ExamSectionPlan s) => sum + s.items));
        expect(blueprint.totalMinutes, greaterThan(0));
        // Writing is promised from the level where the real paper has it. Whether a
        // paper *contains* it is the source's business, not the blueprint's.
        expect(blueprint.hasWriting, level >= 3,
            reason: 'writing from HSK 3, as in the real paper');
      }
      expect(ExamBlueprint.forLevel(0), isNull);
      expect(ExamBlueprint.forLevel(7), isNull);
    });

    test('grows with the level', () {
      expect(
        ExamBlueprint.forLevel(6)!.totalItems,
        greaterThan(ExamBlueprint.forLevel(1)!.totalItems),
      );
    });
  });

  group('the builder', () {
    ExamPaper paper({int seed = 1, bool withSentences = false}) =>
        ExamBuilder.buildFrom(
          blueprint: ExamBlueprint.forLevel(1)!,
          words: pool(withSentences: withSentences),
          seed: seed,
          now: DateTime(2026, 2, 10),
        )!;

    test('every item has exactly one correct option in its list', () {
      final List<ExamWord> words = pool(withSentences: true);
      final ExamPaper built = paper(withSentences: true);
      final Set<String> allSentences = <String>{
        for (final ExamWord word in words)
          if (word.sentence != null) word.sentence!.trim(),
      };

      for (final ExamItem item in built.items) {
        // Typed and arranged items are not "pick one of four": a dictation answer is
        // what the learner wrote, and a word-order answer is a sequence, so their
        // own invariants are asserted in their own cases below.
        final bool isChoice = item.kind != ExamItemKind.dictation &&
            item.kind != ExamItemKind.orderTokens;
        if (isChoice) {
          expect(item.options, contains(item.answer));
          expect(item.options.toSet().length, item.options.length,
              reason: 'options must be distinct: ${item.options}');
          expect(item.options.length,
              greaterThanOrEqualTo(ExamBuilder.minOptions));
        }

        // And the key is the *app's* data for that word, not something invented.
        final ExamWord source = wordOf(words, item.hanzi);
        switch (item.kind) {
          case ExamItemKind.audioToCharacter:
          case ExamItemKind.fillBlank:
          case ExamItemKind.passageFill:
            expect(item.answer, source.hanzi);
          case ExamItemKind.characterToMeaning:
            expect(item.answer, source.shortDefinition);
          case ExamItemKind.characterToPinyin:
          case ExamItemKind.dictation:
            expect(item.answer, source.pinyin);
          case ExamItemKind.toneChoice:
            // The key is the source's own syllable, in the source's own tone — the
            // app chooses neither, it only respells them.
            expect(PinyinUtils.stripTone(item.answer),
                PinyinUtils.stripTone(source.pinyin));
            expect(PinyinUtils.toneFromSyllable(item.answer),
                PinyinUtils.toneFromSyllable(source.pinyin));
            // Every option is that same syllable — a minimal pair, which is what
            // makes the item about tone rather than about reading.
            for (final String option in item.options) {
              expect(PinyinUtils.stripTone(option),
                  PinyinUtils.stripTone(source.pinyin));
            }
          case ExamItemKind.orderTokens:
            final List<String> tokens = item.answer.split(' ');
            expect(tokens, isNotEmpty);
            for (final String token in tokens) {
              expect(source.sentence, contains(token),
                  reason: 'the key is the sentence\'s own words, in its order');
            }
            expect(item.options.toSet(), tokens.toSet(),
                reason: 'the words to arrange are the sentence\'s own words');
          case ExamItemKind.grammarError:
            // Three sentences the app did not touch, and one it did.
            final List<String> others = item.options
                .where((String option) => option != item.answer)
                .toList();
            expect(others.length, ExamBuilder.optionCount - 1);
            for (final String sentence in others) {
              expect(allSentences, contains(sentence),
                  reason:
                      'the untouched options are the pool\'s own sentences');
            }
            expect(
                allSentences,
                contains(item.answer
                    .replaceAll('不不', '不')
                    .replaceAll('很很', '很')
                    .replaceAll('的的', '的')),
                reason: 'the broken option is one of them, altered');
        }
      }
    });

    test('never offers a second correct answer', () {
      // 词0 appears twice with two readings, exactly as HSK lists 只 as zhī/zhǐ.
      final List<ExamWord> words = <ExamWord>[
        const ExamWord(
            id: 'a', hanzi: '词0', pinyin: 'ci0', definition: 'first'),
        const ExamWord(
            id: 'b', hanzi: '词0', pinyin: 'zzz', definition: 'other'),
        for (int i = 1; i < 20; i++)
          ExamWord(id: 'w$i', hanzi: '词$i', pinyin: 'ci$i', definition: 'm$i'),
      ];

      final ExamPaper built = ExamBuilder.buildFrom(
        blueprint: ExamBlueprint.forLevel(1)!,
        words: words,
        seed: 7,
      )!;

      for (final ExamItem item in built.items.where((ExamItem item) =>
          item.kind == ExamItemKind.characterToPinyin && item.hanzi == '词0')) {
        expect(item.options, isNot(contains('zzz')),
            reason: 'the other reading of the same character is also correct');
      }
    });

    test('the same seed builds the same paper', () {
      expect(
        paper(seed: 42).items.map((ExamItem item) => item.hanzi).toList(),
        paper(seed: 42).items.map((ExamItem item) => item.hanzi).toList(),
      );
    });

    test('a kind the data cannot support is dropped and counted', () {
      // No sentences: `fillBlank` cannot be built, so the paper is thinner and
      // says so rather than inventing a sentence.
      final ExamPaper without = paper();
      expect(without.dropped, greaterThan(0));
      expect(
        without.items
            .where((ExamItem item) => item.kind == ExamItemKind.fillBlank),
        isEmpty,
      );

      final ExamPaper with_ = paper(seed: 1, withSentences: true);
      final List<ExamItem> blanks = with_.items
          .where((ExamItem item) => item.kind == ExamItemKind.fillBlank)
          .toList();
      expect(blanks, isNotEmpty);
      for (final ExamItem item in blanks) {
        expect(item.sentence, contains('＿＿'));
        expect(item.sentence, isNot(contains(item.answer)));
      }
    });

    test('a paper survives being stored and read back', () {
      final ExamPaper built = paper(seed: 3);
      final ExamPaper? restored = ExamPaper.fromJson(built.toJson());

      expect(restored, isNotNull);
      expect(restored!.totalItems, built.totalItems);
      expect(restored.level, built.level);
      expect(restored.passMark, built.passMark);
      expect(restored.dropped, built.dropped);
      expect(
        restored.items.map((ExamItem item) => item.answer).toList(),
        built.items.map((ExamItem item) => item.answer).toList(),
        reason: 'the key is frozen with the paper, or a retake is meaningless',
      );
    });
  });

  group('grading', () {
    ExamPaper built({int seed = 5}) => ExamBuilder.buildFrom(
          blueprint: ExamBlueprint.forLevel(1)!,
          words: pool(withSentences: true),
          seed: seed,
        )!;

    test('all correct passes at 100%', () {
      final ExamPaper exam = built();
      final Map<int, String> answers = <int, String>{
        for (int i = 0; i < exam.items.length; i++) i: exam.items[i].answer,
      };
      final ExamReport report = ExamGrader.grade(paper: exam, answers: answers);

      expect(report.correct, report.total);
      expect(report.scorePercent, 100);
      expect(report.passed, isTrue);
      expect(report.missed, isEmpty);
    });

    test('a blank counts as wrong, and the report lists it', () {
      final ExamPaper exam = built();
      final Map<int, String> answers = <int, String>{
        for (int i = 1; i < exam.items.length; i++) i: exam.items[i].answer,
      };
      final ExamReport report = ExamGrader.grade(paper: exam, answers: answers);

      expect(report.correct, report.total - 1);
      expect(report.answered, report.total - 1);
      expect(report.missed.single.hanzi, exam.items.first.hanzi);
    });

    test('half right is below the pass mark, and the sections add up', () {
      final ExamPaper exam = built();
      final Map<int, String> answers = <int, String>{
        for (int i = 0; i < exam.items.length; i += 2) i: exam.items[i].answer,
      };
      final ExamReport report = ExamGrader.grade(paper: exam, answers: answers);

      expect(report.passMark, 0.6, reason: "HSK's own threshold");
      expect(report.passed, isFalse);
      expect(
        report.sections
            .fold(0, (int sum, ExamSectionResult s) => sum + s.total),
        report.total,
      );
      expect(
        report.sections
            .fold(0, (int sum, ExamSectionResult s) => sum + s.correct),
        report.correct,
      );
    });
  });

  group('the tutor may propose a paper, never write one', () {
    const TutorContext noDecks = TutorContext();

    test('a level in the message proposes that paper', () {
      final TutorReply reply = LocalTutor.compose(
        message: 'give me an HSK 3 exam',
        context: noDecks,
        l10n: enL10n,
      );

      final TutorMake make = reply.makes.single;
      expect(make.kind, TutorMakeKind.examPaper);
      expect(make.level, 3);
      expect(make.items, ExamBlueprint.forLevel(3)!.totalItems);
      expect(reply.say, contains('HSK 3'));
    });

    test('no level asks for the level instead of guessing', () {
      final TutorReply reply = LocalTutor.compose(
        message: 'make me a test',
        context: noDecks,
        l10n: enL10n,
      );

      expect(reply.makes, isEmpty);
      expect(reply.ask!.question, enL10n.targetHskLevel);
      expect(reply.ask!.options.first.value, 'HSK 1 exam',
          reason: 'tapping an option sends a message that will be understood');
    });
  });

  group('an exam from any deck', () {
    List<Flashcard> cards({int count = 12, bool withSentences = false}) =>
        <Flashcard>[
          for (int i = 0; i < count; i++)
            Flashcard(
              id: 'card$i',
              deckId: 'tones',
              hanzi: '词$i',
              pinyin: 'ci$i',
              definition: 'meaning $i; second sense',
              hskLevel: 3,
              strokePaths: const <String>[],
              sourceSentence: withSentences ? '我很好，这是词$i。' : null,
              modeStats: const <StudyMode, ReviewStats>{},
            ),
        ];

    Set<String> setOf(Iterable<String> values) => values.toSet();

    test('every item and every option comes from that deck alone', () {
      final List<Flashcard> source = cards(withSentences: true);
      final ExamPaper? paper = ExamBuilder.buildFromCards(
        cards: source,
        deckName: 'Tones',
        seed: 4,
      );

      expect(paper, isNotNull);
      expect(paper!.isFromDeck, isTrue);
      expect(paper.deckId, 'tones');
      expect(paper.deckName, 'Tones');

      final Set<String> hanzi =
          setOf(source.map((Flashcard card) => card.hanzi));
      final Set<String> pinyin =
          setOf(source.map((Flashcard card) => card.pinyin));
      final Set<String> meanings = setOf(source
          .map((Flashcard card) => card.definition.split(';').first.trim()));

      for (final ExamItem item in paper.items) {
        // The kinds whose "options" are the deck's own vocabulary are held to the
        // vocabulary rule: neither the key nor a distractor may be a word the deck
        // never taught.
        final Set<String>? taught = switch (item.kind) {
          ExamItemKind.audioToCharacter ||
          ExamItemKind.fillBlank ||
          ExamItemKind.passageFill =>
            hanzi,
          ExamItemKind.characterToPinyin || ExamItemKind.dictation => pinyin,
          ExamItemKind.characterToMeaning => meanings,
          // A tone item's options are the same syllable in four tones: the deck's
          // own syllable, respelled — so the syllable must be one it taught.
          ExamItemKind.toneChoice =>
            setOf(source.map((Flashcard card) => card.pinyin))
                .map(PinyinUtils.stripTone)
                .toSet(),
          // Arranging a sentence and judging four sentences are not vocabulary
          // choices: their rule is that every character shown is one the learner's
          // own deck contains, in a word or in a sentence.
          ExamItemKind.orderTokens || ExamItemKind.grammarError => null,
        };
        // The key, and every option, must be something the deck taught. A tone item
        // respells the syllable it taught, so it is held to that syllable.
        if (taught != null) {
          if (item.kind == ExamItemKind.toneChoice) {
            expect(taught, contains(PinyinUtils.stripTone(item.answer)));
          } else {
            expect(taught, contains(item.answer),
                reason: '${item.kind.name} key');
          }
        }
        if (taught == null) {
          final Set<String> deckChars = <String>{
            for (final Flashcard card in source) ...card.hanzi.split(''),
            for (final Flashcard card in source)
              if (card.sourceSentence != null)
                ...card.sourceSentence!.split(''),
          };
          final List<String> shown = <String>[
            item.sentence ?? '',
            ...item.options,
          ];
          for (final String text in shown) {
            for (final String char in text.split('')) {
              if (RegExp(r'[\u4e00-\u9fff]').hasMatch(char)) {
                expect(deckChars, contains(char),
                    reason:
                        '${item.kind.name} showed "$char", which the deck never '
                        'contained');
              }
            }
          }
          continue;
        }
        for (final String option in item.options) {
          expect(taught, contains(option),
              reason:
                  '${item.kind.name} offered "$option", which the deck never '
                  'taught');
        }
      }
    });

    test('a small deck makes a short exam, not a paper full of holes', () {
      final ExamPaper? paper = ExamBuilder.buildFromCards(
        cards: cards(count: 9, withSentences: true),
        deckName: 'Tones',
        seed: 2,
      );

      expect(paper, isNotNull);
      expect(paper!.totalItems, lessThanOrEqualTo(9));
      expect(paper.totalItems,
          greaterThanOrEqualTo(ExamBlueprint.minimumVocabulary));
      expect(paper.dropped, lessThan(3),
          reason: 'sized to the deck, so almost every slot can be filled');
      expect(paper.totalMinutes, lessThan(20));
    });

    test('four cards are not an exam', () {
      expect(ExamBuilder.buildFromCards(cards: cards(count: 4)), isNull);
      expect(ExamBlueprint.forDeck(vocabularySize: 4), isNull);
      expect(ExamBlueprint.forDeck(vocabularySize: 5), isNotNull);
    });

    test('the paper keeps its deck when it is stored', () {
      final ExamPaper built = ExamBuilder.buildFromCards(
          cards: cards(), deckName: 'Tones', seed: 1)!;
      final ExamPaper? restored = ExamPaper.fromJson(built.toJson());

      expect(restored!.isFromDeck, isTrue);
      expect(restored.deckId, 'tones');
      expect(restored.deckName, 'Tones');
    });

    test('the model may pick the deck, and an invented one cannot resolve', () {
      const TutorContext context = TutorContext(
        decks: <TutorDeckSummary>[
          TutorDeckSummary(
              id: 'tones', name: 'Tones', cardCount: 12, dueCount: 0),
        ],
      );

      final TutorReply? ok = TutorEnvelopeParser.parse(
        '{"say":"Sure.","make":[{"kind":"examPaper","deckId":"tones"}]}',
        context: context,
        allowedHanzi: const <String>{},
      );
      expect(ok!.makes.single.kind, TutorMakeKind.examPaper);
      expect(ok.makes.single.deckId, 'tones');

      final TutorReply? invented = TutorEnvelopeParser.parse(
        '{"say":"Sure.","make":[{"kind":"examPaper","deckId":"not-my-deck"}]}',
        context: context,
        allowedHanzi: const <String>{},
      );
      expect(invented!.makes, isEmpty);
    });
  });

  group('the model may only choose the source', () {
    const TutorContext noDecks = TutorContext();

    test('a level becomes the bundled paper', () {
      final TutorReply? reply = TutorEnvelopeParser.parse(
        '{"say":"Sure.","make":[{"kind":"examPaper","level":4}]}',
        context: noDecks,
        allowedHanzi: const <String>{},
      );
      expect(reply!.makes.single.kind, TutorMakeKind.examPaper);
      expect(reply.makes.single.level, 4);
    });

    test('a level outside 1-6 is refused, and so is a key the model offers',
        () {
      final TutorReply? bad = TutorEnvelopeParser.parse(
        '{"say":"Sure.","make":[{"kind":"examPaper","level":9,'
        '"items":10,"key":"whatever"}]}',
        context: noDecks,
        allowedHanzi: const <String>{},
      );
      expect(bad!.makes, isEmpty);
      expect(bad.say, 'Sure.');
    });
  });

  /// The kinds added after the first four. Each one exists because the app can build
  /// *and grade* it from its own data, and these are the tests that hold that claim
  /// up: the key is derived, the alternatives come from the same source, and an item
  /// that cannot be built is not shown at all.
  group('the newer item kinds', () {
    /// Words with real tone-marked pinyin and breakable sentences, so every kind can
    /// build: every sentence carries 很, which the corruption rules can double.
    List<ExamWord> rich() => <ExamWord>[
          for (int i = 0; i < 24; i++)
            ExamWord(
              id: 'r$i',
              hanzi: '字$i',
              pinyin: <String>['mā', 'má', 'mǎ', 'mà'][i % 4],
              definition: 'meaning $i',
              sentence: '他很好$i。',
            ),
        ];

    /// A paper of one kind, so a test is about the item and not about which slot the
    /// real blueprint happened to give it. Null when the pool cannot carry the kind
    /// at all — a section that cannot be built is absent, not empty.
    ExamPaper? kindPaper(
      ExamItemKind kind,
      List<ExamWord> words, {
      String? passage,
      int slots = 6,
      int seed = 5,
    }) =>
        ExamBuilder.buildFrom(
          blueprint: ExamBlueprint(
            id: 'test-kinds-v1',
            level: 3,
            sections: <ExamSectionPlan>[
              ExamSectionPlan(
                kind: ExamSectionKind.reading,
                items: slots,
                minutes: 5,
                kinds: <ExamItemKind>[kind],
              ),
            ],
          ),
          words: words,
          seed: seed,
          passage: passage,
        );

    List<ExamItem> itemsOf(ExamPaper paper, ExamItemKind kind) =>
        paper.items.where((ExamItem item) => item.kind == kind).toList();

    /// All the paper holds, for a failure message that says what it did contain.
    String what(ExamPaper paper) => paper.items
        .map((ExamItem item) => '${item.kind.name}:${item.hanzi}')
        .join(', ');

    /// Graded in isolation: whether this one item was missed.
    bool missed(ExamPaper paper, ExamItem item, String answer) =>
        ExamGrader.grade(paper: paper, answers: <int, String>{
          paper.items.toList().indexOf(item): answer,
        }).missed.contains(item);

    test('a tone item is one syllable in four tones, keyed to the word\'s own',
        () {
      final List<ExamItem> tones = itemsOf(
          kindPaper(ExamItemKind.toneChoice, rich())!, ExamItemKind.toneChoice);
      expect(tones, isNotEmpty);

      for (final ExamItem item in tones) {
        expect(item.options.length, 4);
        expect(item.options.toSet().length, 4, reason: 'four distinct tones');
        // Every option is the *same* syllable: that is what makes the item about
        // tone rather than about reading a character.
        final Set<String> bases =
            item.options.map(PinyinUtils.stripTone).toSet();
        expect(bases.length, 1);
        expect(bases.single, PinyinUtils.stripTone(item.pinyin!));
        expect(item.options, contains(item.answer));
        expect(item.answer, item.pinyin,
            reason: 'the key is the word\'s pinyin');
      }
    });

    test('a word that states no tone carries no tone item', () {
      final ExamPaper? paper = kindPaper(ExamItemKind.toneChoice, <ExamWord>[
        for (int i = 0; i < 24; i++)
          ExamWord(id: 'n$i', hanzi: '字$i', pinyin: 'ma', definition: 'm$i'),
      ]);
      expect(paper, isNull,
          reason: 'a word that states no tone cannot key a tone question, so a '
              'paper of this kind alone is not a paper at all');
    });

    test('dictation has no options, and grades either way of writing a tone',
        () {
      final List<ExamWord> words = <ExamWord>[
        const ExamWord(
            id: 'd',
            hanzi: '好',
            pinyin: 'hǎo',
            definition: 'good',
            sentence: '他很好。'),
        for (int i = 0; i < 23; i++)
          ExamWord(
              id: 'x$i',
              hanzi: '字$i',
              pinyin: 'mǎ',
              definition: 'm$i',
              sentence: '他很好$i。'),
      ];
      final ExamPaper paper = kindPaper(ExamItemKind.dictation, words)!;
      final List<ExamItem> dictated = itemsOf(paper, ExamItemKind.dictation);
      expect(dictated, isNotEmpty, reason: 'the paper held: ${what(paper)}');

      // The key is each word's own authored pinyin — the builder draws the words
      // (and their order) from the source, so this is checked per item, not by
      // assuming which word came first.
      final Map<String, String> source = <String, String>{
        for (final ExamWord word in words) word.hanzi: word.pinyin,
      };
      for (final ExamItem item in dictated) {
        expect(item.answer, source[item.hanzi],
            reason: 'the key is the word\'s own pinyin');
        expect(item.options, isEmpty,
            reason: 'there is nothing to choose between');
      }

      // One item is enough for the grading rules, and every one of them is asked.
      final ExamItem item = dictated.first;
      final String marked = item.answer;
      final String base = PinyinUtils.stripTone(marked);
      final int tone = PinyinUtils.toneFromSyllable(marked);
      expect(tone, inInclusiveRange(1, 4), reason: 'a tone item needs a tone');

      expect(missed(paper, item, '$base$tone'), isFalse,
          reason: 'a tone number is a tone');
      expect(missed(paper, item, marked), isFalse, reason: 'so is a tone mark');
      expect(missed(paper, item, marked.toUpperCase()), isFalse,
          reason: 'case does not decide a key');
      expect(missed(paper, item, base), isTrue,
          reason: 'a missing tone is a wrong answer');
      // A different tone on the same syllable: the minimal pair, marked and read.
      final int other = tone == 1 ? 2 : 1;
      expect(
          missed(paper, item, PinyinUtils.convertNumericToMarks('$base$other')),
          isTrue,
          reason: 'so is the wrong tone');
    });
    test('word order keys the sentence\'s own order, out of its own words', () {
      final ExamPaper paper =
          kindPaper(ExamItemKind.orderTokens, rich(), slots: 4)!;
      final List<ExamItem> order = itemsOf(paper, ExamItemKind.orderTokens);
      expect(order, isNotEmpty);

      for (final ExamItem item in order) {
        final List<String> tokens = item.answer.split(' ');
        expect(tokens.length, greaterThan(1));
        expect(item.options.toSet(), tokens.toSet(),
            reason: 'the words to arrange are the sentence\'s own words');
        expect(item.options, isNot(equals(tokens)),
            reason: 'and they are not handed over already in order');
        expect(item.sentence, isNotNull, reason: 'the answer, for the report');

        expect(missed(paper, item, item.answer), isFalse);
        // The same words, a different order: the words are right, the answer is not.
        final List<String> swapped = List<String>.from(tokens);
        final String first = swapped[0];
        swapped[0] = swapped[1];
        swapped[1] = first;
        expect(missed(paper, item, swapped.join(' ')), isTrue);
      }
    });

    test('a grammar item is three sentences the app kept and one it broke', () {
      final ExamPaper paper =
          kindPaper(ExamItemKind.grammarError, rich(), slots: 4)!;
      final List<ExamItem> errors = itemsOf(paper, ExamItemKind.grammarError);
      expect(errors, isNotEmpty);

      final Set<String> corpus = <String>{
        for (final ExamWord word in rich())
          if (word.sentence != null) word.sentence!,
      };

      for (final ExamItem item in errors) {
        expect(item.options.length, ExamBuilder.optionCount);
        expect(item.options.toSet().length, ExamBuilder.optionCount);
        expect(item.options, contains(item.answer));
        for (final String option in item.options) {
          if (option != item.answer) {
            expect(corpus, contains(option),
                reason: 'the untouched options are the pool\'s own sentences');
          }
        }
        expect(corpus, isNot(contains(item.answer)),
            reason: 'the key is the one the app altered');
        expect(corpus, contains(item.sentence),
            reason: 'and the report shows the sentence as it should be');
        // The alteration is always a doubled particle: something no reader can
        // defend, which is what makes the item keyable at all.
        expect(
          item.answer.contains('很很') ||
              item.answer.contains('不不') ||
              item.answer.contains('的的'),
          isTrue,
        );
      }
    });

    test('a passage item blanks a word the passage actually has', () {
      final List<ExamWord> words = <ExamWord>[
        for (final String hanzi in <String>['我', '喝', '茶', '他', '好'])
          ExamWord(
              id: hanzi,
              hanzi: hanzi,
              pinyin: 'mǎ',
              definition: hanzi,
              sentence: '我很好。'),
        ...rich(),
      ];

      // A section of just this kind, so the test is about the item and not about
      // which slot the section plan happened to give it.
      ExamPaper passagePaper({String? passage}) => kindPaper(
            ExamItemKind.passageFill,
            words,
            passage: passage,
            slots: 4,
            seed: 5,
          )!;

      // Nothing handed over: the pool's own sentences are the text, because the app
      // blanks words in text it already had rather than writing one.
      for (final ExamItem item
          in itemsOf(passagePaper(), ExamItemKind.passageFill)) {
        expect(item.sentence, contains('＿＿'));
        expect(item.options, contains(item.answer));
        expect(item.options.toSet().length, ExamBuilder.optionCount);
      }

      // A passage handed over is the text that gets blanked, and only a word it
      // contains can be the key.
      const String passage = '我喝茶。他喝茶，我也喝茶。';
      final List<ExamItem> handed =
          itemsOf(passagePaper(passage: passage), ExamItemKind.passageFill);
      expect(handed, isNotEmpty);
      for (final ExamItem item in handed) {
        expect(item.sentence, contains('＿＿'));
        expect(passage, contains(item.answer));
        expect(item.options, contains(item.answer));
      }
    });
  });
}
