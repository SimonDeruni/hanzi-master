/// The exam against the **real** bundles, not an injected pool.
///
/// `exam_paper_test.dart` proves the builder's rules with data it controls. This
/// file proves the other half: that `assets/data/hsk*.json` still has the shape the
/// builder reads. The two failure modes are different — a rule regression versus a
/// silent asset change — and only this one catches "the exam got shorter because a
/// bundle was renamed".
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/exam/data/exam_builder.dart';
import 'package:hanzi_master/features/exam/data/hsk_lexicon.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_word.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(HskLexicon.reset);

  test('HSK 1 loads from its own two files, sentences included', () async {
    final List<ExamWord> words = await HskLexicon.level(1);

    expect(words, isNotEmpty, reason: 'assets/data/hsk1.json must parse');
    expect(words.map((ExamWord w) => w.id).toSet().length, words.length);
    for (final ExamWord word in words.take(20)) {
      expect(word.hanzi, isNotEmpty);
      expect(word.pinyin, isNotEmpty);
      expect(word.definition, isNotEmpty);
    }
    expect(words.where((ExamWord w) => w.canFillBlank), isNotEmpty,
        reason: 'hsk1_sentences.json is the only source of fillBlank items');
  });

  test('HSK 3 loads from its bundle', () async {
    final List<ExamWord> words = await HskLexicon.level(3);

    expect(words.length, greaterThan(100),
        reason: 'a level is hundreds of words');
    expect(words.where((ExamWord w) => w.canFillBlank), isEmpty,
        reason:
            'no sentences exist beyond HSK 1, and the builder must not pretend');
  });

  test('a real HSK 3 paper assembles, with a key for every item', () async {
    final ExamPaper? paper = await ExamBuilder.build(
        blueprint: ExamBlueprint.forLevel(3)!, seed: 11);

    expect(paper, isNotNull);
    expect(paper!.sections.length, 3,
        reason: 'HSK 3 has a writing section in the real paper, and dictation '
            'items can be built from the bundle\'s toned pinyin');
    expect(paper.totalItems, greaterThan(20));
    // HSK 3 has no sentences, so the kinds that need them are absent and the
    // sections are thinner than the blueprint asked for — and say so.
    expect(paper.dropped, greaterThan(0));

    for (final ExamItem item in paper.items) {
      // A dictation item is typed, not chosen: it has no options by design.
      if (item.kind == ExamItemKind.dictation) {
        expect(item.options, isEmpty);
        continue;
      }
      expect(item.options, contains(item.answer));
      expect(item.options.toSet().length, item.options.length);
    }
    expect(
      paper.items.map((ExamItem item) => item.hanzi).toSet().length,
      paper.items.length,
      reason:
          'one item per word: a paper should not ask about the same character '
          'twice',
    );
  });
}
