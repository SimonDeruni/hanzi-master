/// A reading pack: a graded story, plus the questions its own words can carry.
///
/// This is the first `make` that needs the model to *write* something, so the
/// division of labour matters more here than anywhere else (§4.3):
///
///  * the model chooses **only the level** — the topic comes from the app's own
///    story catalogue, so no free text from a reply ever reaches a prompt;
///  * the story is written once and cached on the device under the reading
///    library's own id scheme, so reopening a pack needs no network at all;
///  * every question is derived from the text that was saved, with its key drawn
///    from the bundled vocabulary for that level — and the story itself is the
///    passage the gap-fill items are asked about.
///
/// That last point is the reason a reading pack earns its keep beyond reading
/// practice: it is also where a paper's `passageFill` items finally get a real
/// passage instead of example sentences stitched together.
library;

import 'dart:math';

import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/exam/data/exam_builder.dart';
import 'package:hanzi_master/features/exam/data/exam_store.dart';
import 'package:hanzi_master/features/exam/data/hsk_lexicon.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_word.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/features/reading/domain/entities/graded_story.dart';
import 'package:hanzi_master/features/reading/presentation/providers/story_controller.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_make_result.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';

/// Where a reading pack's story comes from: the device's cache first, the model
/// only when the cache is empty.
///
/// An interface rather than the repository itself, for two reasons: the part worth
/// testing — *which* words become questions — then needs neither Hive nor a network
/// call, and the read-before-write rule has exactly one owner.
abstract interface class StoryPackSource {
  Future<GradedStory?> read(String storyId);

  Future<GradedStory> write(StoryBlueprint blueprint, int level);

  /// The newest story the learner already has at [level], if any.
  Future<GradedStory?> latest(int level);
}

/// The app's implementation: `StoryRepository` for the cache, `GeminiService` for
/// the writing.
///
/// It uses the reader's own id scheme (`<blueprint>_hsk<level>`), so a story the
/// learner already read is never written twice, and a pack the tutor makes opens
/// instantly in the reader.
class CachedStorySource implements StoryPackSource {
  const CachedStorySource({required this.stories, required this.gemini});

  final StoryRepository stories;
  final GeminiService gemini;

  static String storyIdOf(StoryBlueprint blueprint, int level) =>
      '${blueprint.id}_hsk$level';

  @override
  Future<GradedStory?> read(String storyId) => stories.getStory(storyId);

  @override
  Future<GradedStory> write(StoryBlueprint blueprint, int level) async {
    final AiStory written = await gemini.generateGradedStory(
      blueprint.topic,
      blueprint.category,
      level,
    );
    final GradedStory story = GradedStory(
      id: storyIdOf(blueprint, level),
      title: blueprint.title,
      category: blueprint.category,
      hskLevel: level,
      sentences: written.sentences,
      generatedAt: DateTime.now(),
    );
    await stories.saveStory(story);
    return story;
  }

  @override
  Future<GradedStory?> latest(int level) async {
    final List<GradedStory> all = await stories.getAllStories();
    final List<GradedStory> atLevel = all
        .where((GradedStory story) =>
            story.hskLevel == level &&
            ReadingPackBuilder.storyText(story).trim().isNotEmpty)
        .toList()
      ..sort((GradedStory a, GradedStory b) =>
          b.generatedAt.compareTo(a.generatedAt));
    return atLevel.isEmpty ? null : atLevel.first;
  }
}

abstract final class ReadingPackBuilder {
  /// The story as one passage: its sentences in order, exactly as the reader shows
  /// them. This is the text every question is built against.
  static String storyText(GradedStory story) =>
      story.sentences.map((AiSentence sentence) => sentence.chinese).join();

  /// Makes a reading pack for [make]'s level.
  ///
  /// [catalogueChoice] pins which of the app's story topics is used, which is how
  /// the tests ask for a known one; in the app it is left to chance so two packs
  /// are not always the same story.
  static Future<TutorMakeResult> create({
    required TutorMake make,
    required StoryPackSource source,
    required ExamStore exams,
    int? catalogueChoice,
    Random? random,
  }) async {
    final int? level = make.level;
    // The level is the model's only real input, so it is the only one that can be
    // wrong — and it is checked against the app's own list of levels.
    if (level == null || ExamBlueprint.forLevel(level) == null) {
      return const TutorMakeResult.failed();
    }

    const List<StoryBlueprint> catalogue = StoryController.defaultBlueprints;
    if (catalogue.isEmpty) return const TutorMakeResult.failed();
    final int index =
        catalogueChoice ?? (random ?? Random()).nextInt(catalogue.length);
    final StoryBlueprint blueprint =
        catalogue[index.clamp(0, catalogue.length - 1)];

    try {
      final String storyId = CachedStorySource.storyIdOf(blueprint, level);
      // Cache first: a story the learner has already read is a story the app
      // already has, and reopening a pack must work with no network at all.
      final GradedStory story =
          await source.read(storyId) ?? await source.write(blueprint, level);

      final String text = storyText(story);
      final ExamPaper? paper =
          await _comprehension(level: level, text: text, exams: exams);

      return TutorMakeResult.createdReadingPack(
        storyId: storyId,
        blueprintId: blueprint.id,
        title: story.title.trim().isNotEmpty ? story.title : blueprint.title,
        hskLevel: level,
        paperId: paper?.id,
        itemCount: paper?.totalItems ?? 0,
      );
    } catch (_) {
      // A story that could not be written is a pack that does not exist, and the
      // reply words that plainly rather than pretending (§11.3).
      return const TutorMakeResult.failed();
    }
  }

  /// The questions: asked about the story's **own** words, with the key drawn from
  /// the bundled vocabulary for that level and the story itself as the passage.
  ///
  /// Null when the story cannot carry any — a story whose words the app cannot key
  /// gets no questions rather than easy ones, and the pack is still a pack.
  static Future<ExamPaper?> _comprehension({
    required int level,
    required String text,
    required ExamStore exams,
  }) async {
    if (text.trim().isEmpty) return null;

    final List<ExamWord> levelWords = await HskLexicon.level(level);
    final List<ExamWord> inStory =
        levelWords.where((ExamWord word) => text.contains(word.hanzi)).toList();
    if (inStory.length < ExamBlueprint.minimumVocabulary) return null;

    final ExamBlueprint? blueprint =
        ExamBlueprint.forDeck(vocabularySize: inStory.length);
    if (blueprint == null) return null;

    final ExamPaper? paper = ExamBuilder.buildFrom(
      blueprint: blueprint,
      words: inStory,
      passage: text,
    );
    if (paper == null) return null;

    await exams.savePaper(paper);
    return paper;
  }

  /// A passage for an ordinary **paper**: the newest story the learner already has
  /// at [level], or null when they have none.
  ///
  /// This is how a level paper's gap-fill items stop being example sentences
  /// stitched together and start being a text the learner can actually read. Null
  /// is the honest answer when there is no story: the paper simply has no passage
  /// section, exactly as it has none when the source cannot carry one.
  static Future<String?> passageFor({
    required int level,
    required StoryPackSource source,
  }) async {
    try {
      final GradedStory? story = await source.latest(level);
      if (story == null) return null;
      final String text = storyText(story);
      return text.trim().isEmpty ? null : text;
    } catch (_) {
      return null;
    }
  }
}
