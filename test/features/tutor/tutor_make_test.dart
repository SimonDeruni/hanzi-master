/// The four newer things a `make` can produce, and the rule each one obeys.
///
/// `docs/AI_TUTOR_CONCEPT.md` §4.3 says the model chooses *what* and the app builds
/// it. These tests hold the second half of that up for the newer kinds:
///
///  * a **review sprint** takes no arguments at all, because what is due is a fact
///    the app owns;
///  * a **reading pack** chooses its topic from the app's catalogue, reads the story
///    out of the cache before it ever writes one, and derives every question from
///    the text it saved;
///  * a story whose words the app cannot key still makes a pack — just no questions;
///  * and a paper built from a learner's mistakes can only ever ask about those
///    mistakes.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/exam/data/exam_builder.dart';
import 'package:hanzi_master/features/exam/data/exam_store.dart';
import 'package:hanzi_master/features/exam/data/hsk_lexicon.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_word.dart';
import 'package:hanzi_master/features/reading/domain/entities/graded_story.dart';
import 'package:hanzi_master/features/reading/presentation/providers/story_controller.dart';
import 'package:hanzi_master/features/tutor/data/reading_pack_builder.dart';
import 'package:hanzi_master/features/tutor/data/tutor_envelope_parser.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_make_result.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';

/// A story source with neither Hive nor a network behind it: [saved] is the cache,
/// [writes] counts how often the model would have been asked to write.
class _FakeSource implements StoryPackSource {
  _FakeSource({this.saved});

  GradedStory? saved;
  int writes = 0;
  bool throwOnLatest = false;

  @override
  Future<GradedStory?> read(String storyId) async => saved;

  @override
  Future<GradedStory> write(StoryBlueprint blueprint, int level) async {
    writes++;
    final GradedStory story = saved ?? await _level1Story(blueprint, level);
    saved = story;
    return story;
  }

  @override
  Future<GradedStory?> latest(int level) async {
    if (throwOnLatest) throw StateError('no store');
    return saved != null && saved!.hskLevel == level ? saved : null;
  }
}

GradedStory _story(StoryBlueprint blueprint, int level) => GradedStory(
      id: CachedStorySource.storyIdOf(blueprint, level),
      title: blueprint.title,
      category: blueprint.category,
      hskLevel: level,
      sentences: const <AiSentence>[],
      generatedAt: DateTime(2026, 2, 10),
    );

StoryBlueprint _anyBlueprint() => const StoryBlueprint(
      id: 'test_story',
      title: 'Test',
      topic: 'anything',
      category: 'Daily Life',
      imageUrl: '',
      tags: <String>[],
    );

/// A story made of **real** HSK 1 words and **real** HSK 1 sentences, so a pack's
/// comprehension paper is derived from data the app actually ships rather than from
/// Chinese written for a test.
Future<GradedStory> _level1Story(StoryBlueprint blueprint, int level) async {
  final List<ExamWord> words = await HskLexicon.level(1);
  final List<ExamWord> withSentences =
      words.where((ExamWord word) => word.canFillBlank).take(5).toList();
  final List<ExamWord> plain = words.take(10).toList();

  return GradedStory(
    id: CachedStorySource.storyIdOf(blueprint, level),
    title: blueprint.title,
    category: blueprint.category,
    hskLevel: level,
    sentences: <AiSentence>[
      for (final ExamWord word in withSentences)
        AiSentence(
            chinese: word.sentence!, english: '', words: const <AiWord>[]),
      for (final ExamWord word in plain)
        AiSentence(chinese: word.hanzi, english: '', words: const <AiWord>[]),
    ],
    generatedAt: DateTime(2026, 2, 10),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('the parser accepts the two newer sources, and only what it can check',
      () {
    const TutorContext context = TutorContext(learnerLevel: 2);

    TutorMake? first(String json) {
      final TutorReply? reply = TutorEnvelopeParser.parse(
        json,
        context: context,
        allowedHanzi: const <String>{},
      );
      return reply == null || reply.makes.isEmpty ? null : reply.makes.first;
    }

    test('a reading pack is a level, and a level the app knows', () {
      final TutorMake? ok =
          first('{"say":"Sure.","make":[{"kind":"readingPack","level":3}]}');
      expect(ok, isNotNull);
      expect(ok!.kind, TutorMakeKind.readingPack);
      expect(ok.level, 3);

      // No level named: the learner's own, which the context carries.
      expect(
          first('{"say":"Sure.","make":[{"kind":"readingPack"}]}')!.level, 2);

      // A level the app has no vocabulary for cannot become a pack.
      expect(first('{"say":"Sure.","make":[{"kind":"readingPack","level":9}]}'),
          isNull);
    });

    test('a review sprint takes no arguments, and its cap only shrinks it', () {
      final TutorMake? sprint =
          first('{"say":"Sure.","make":[{"kind":"reviewSprint"}]}');
      expect(sprint!.kind, TutorMakeKind.reviewSprint);
      expect(sprint.items, 20, reason: 'a default, not a request');

      final TutorMake? capped =
          first('{"say":"Sure.","make":[{"kind":"reviewSprint","items":5}]}');
      expect(capped!.items, 5);

      // An absurd cap is clamped: nothing a proposal says can make it enormous.
      final TutorMake? huge = first(
          '{"say":"Sure.","make":[{"kind":"reviewSprint","items":9999}]}');
      expect(huge!.items, lessThanOrEqualTo(60));
    });
  });

  group('a reading pack', () {
    const TutorMake pack =
        TutorMake(kind: TutorMakeKind.readingPack, level: 1, items: 0);

    test('reads the cache before it ever writes one', () async {
      // Already on the device: the model is never asked, so the pack opens with no
      // network at all.
      final _FakeSource cached = _FakeSource(saved: _story(_anyBlueprint(), 1));
      final TutorMakeResult result = await ReadingPackBuilder.create(
        make: pack,
        source: cached,
        exams: ExamStore(),
        catalogueChoice: 0,
      );

      expect(result.status, TutorMakeStatus.createdReadingPack);
      expect(cached.writes, 0, reason: 'the cache is the first answer');
      expect(result.blueprintId, isNotNull);
      expect(result.storyId, contains('_hsk1'));
      expect(result.hskLevel, 1);
    });

    test('writes one when nothing is cached, and derives questions from it',
        () async {
      final _FakeSource source = _FakeSource();
      final TutorMakeResult result = await ReadingPackBuilder.create(
        make: pack,
        source: source,
        exams: ExamStore(),
        catalogueChoice: 0,
      );

      expect(source.writes, 1, reason: 'written once, then cached');
      expect(result.status, TutorMakeStatus.createdReadingPack);
      expect(result.paperId, isNotNull,
          reason: 'a story of real HSK 1 words can carry questions');
      expect(result.itemCount, greaterThan(0));
      expect(result.title, isNotEmpty);
    });

    test('a story it cannot key is still a pack, with no questions', () async {
      final _FakeSource source = _FakeSource(
        saved: GradedStory(
          id: 'x_hsk1',
          title: 'Story',
          category: 'Daily Life',
          hskLevel: 1,
          // Not one character the app has vocabulary for.
          sentences: <AiSentence>[
            AiSentence(chinese: '〇◎◇', english: '', words: const <AiWord>[]),
          ],
          generatedAt: DateTime(2026, 2, 10),
        ),
      );
      final TutorMakeResult result = await ReadingPackBuilder.create(
        make: pack,
        source: source,
        exams: ExamStore(),
        catalogueChoice: 0,
      );

      expect(result.status, TutorMakeStatus.createdReadingPack);
      expect(result.paperId, isNull,
          reason: 'no key, no questions — and no easy ones either');
      expect(result.itemCount, 0);
    });

    test('a level the app has no vocabulary for is refused', () async {
      final TutorMakeResult result = await ReadingPackBuilder.create(
        make: const TutorMake(
            kind: TutorMakeKind.readingPack, level: 9, items: 0),
        source: _FakeSource(),
        exams: ExamStore(),
        catalogueChoice: 0,
      );
      expect(result.status, TutorMakeStatus.failed);
    });
  });

  group('a paper\'s passage', () {
    test('is the newest story at that level, and null when there is none',
        () async {
      final _FakeSource source = _FakeSource();
      final GradedStory story = await _level1Story(_anyBlueprint(), 1);
      source.saved = story;

      final String? passage = await ReadingPackBuilder.passageFor(
        level: 1,
        source: source,
      );
      expect(passage, isNotNull);
      expect(passage, ReadingPackBuilder.storyText(story));

      expect(
          await ReadingPackBuilder.passageFor(level: 4, source: source), isNull,
          reason: 'a story at another level is not this level\'s passage');

      // A store that cannot answer is answered with "no passage": a paper without
      // passage items is a thinner paper, not a broken one.
      source.throwOnLatest = true;
      expect(await ReadingPackBuilder.passageFor(level: 1, source: source),
          isNull);
    });

    test('the questions are only ever about words the passage contains',
        () async {
      // The rule the pack applies, exercised on the app's real HSK 1 data: the pool
      // is the bundled vocabulary filtered to the story, the passage is the story,
      // and no item may step outside either.
      final GradedStory story = await _level1Story(_anyBlueprint(), 1);
      final String text = ReadingPackBuilder.storyText(story);
      final List<ExamWord> inStory = (await HskLexicon.level(1))
          .where((ExamWord word) => text.contains(word.hanzi))
          .toList();
      expect(inStory.length,
          greaterThanOrEqualTo(ExamBlueprint.minimumVocabulary));

      final ExamPaper paper = ExamBuilder.buildFrom(
        blueprint: ExamBlueprint.forDeck(vocabularySize: inStory.length)!,
        words: inStory,
        passage: text,
      )!;

      for (final ExamItem item in paper.items) {
        expect(text, contains(item.hanzi),
            reason: '${item.kind.name} asked about a word outside the story');
      }
      final ExamItem blank = paper.items
          .firstWhere((ExamItem item) => item.kind == ExamItemKind.passageFill);
      expect(blank.sentence, contains('＿＿'));
      expect(text, contains(blank.answer));
    });
  });

  group('a paper built from the mistakes', () {
    test('can only ask about the words that were missed', () async {
      final List<ExamWord> missed = (await HskLexicon.level(1))
          .take(8)
          .map((ExamWord word) => ExamWord.fromItem(ExamItem(
                kind: ExamItemKind.characterToMeaning,
                hanzi: word.hanzi,
                pinyin: word.pinyin,
                definition: word.shortDefinition,
                answer: word.shortDefinition,
                options: const <String>['a', 'b', 'c', 'd'],
              )))
          .toList();

      final ExamBlueprint blueprint =
          ExamBlueprint.forDeck(vocabularySize: missed.length)!;
      final ExamPaper paper =
          ExamBuilder.buildFrom(blueprint: blueprint, words: missed)!;

      expect(paper.items, isNotEmpty);
      final Set<String> taught =
          missed.map((ExamWord word) => word.hanzi).toSet();
      for (final ExamItem item in paper.items) {
        expect(taught, contains(item.hanzi),
            reason: 'the retake asked about a word the learner never missed');
      }
    });

    test('an item recovers the word it asked about, sentence and all', () {
      const ExamWord source = ExamWord(
        id: 'w',
        hanzi: '茶',
        pinyin: 'chá',
        definition: 'tea',
        sentence: '我喝茶。',
      );
      final ExamWord recovered = ExamWord.fromItem(ExamItem(
        kind: ExamItemKind.fillBlank,
        hanzi: source.hanzi,
        pinyin: source.pinyin,
        definition: source.definition,
        sentence: source.sentence,
        answer: source.hanzi,
        options: const <String>['茶', 'a', 'b', 'c'],
      ));

      expect(recovered.hanzi, source.hanzi);
      expect(recovered.pinyin, source.pinyin);
      expect(recovered.definition, source.definition);
      expect(recovered.canFillBlank, isTrue,
          reason: 'so a retake can still ask a gap-fill about it');
    });
  });
}
