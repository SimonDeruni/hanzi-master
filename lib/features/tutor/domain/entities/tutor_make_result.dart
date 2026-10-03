/// What happened when a `make` proposal was executed.
///
/// Every builder hands back one of these — including the paths that refuse,
/// because §11.3 makes a refusal a *result* the reply can word honestly, never an
/// exception the learner has to interpret.
library;

import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';

class TutorMakeResult {
  const TutorMakeResult._({
    required this.status,
    this.deck,
    this.paperId,
    this.title,
    this.itemCount = 0,
    this.poolSize = 0,
    this.storyId,
    this.blueprintId,
    this.hskLevel,
  });

  const TutorMakeResult.created(Deck deck, int itemCount)
      : this._(
            status: TutorMakeStatus.created, deck: deck, itemCount: itemCount);

  /// A paper: there is no deck yet, so the reply offers to sit it rather than to
  /// open a folder.
  const TutorMakeResult.createdPaper({
    required String paperId,
    required String title,
    required int itemCount,
  }) : this._(
          status: TutorMakeStatus.createdPaper,
          paperId: paperId,
          title: title,
          itemCount: itemCount,
        );

  /// A story, and — when the story's own words can carry questions — the paper
  /// that asks about it. The story is always the deliverable; the questions are a
  /// bonus the app only promises when it could build them.
  const TutorMakeResult.createdReadingPack({
    required String storyId,
    required String blueprintId,
    required String title,
    required int hskLevel,
    String? paperId,
    int itemCount = 0,
  }) : this._(
          status: TutorMakeStatus.createdReadingPack,
          storyId: storyId,
          blueprintId: blueprintId,
          title: title,
          hskLevel: hskLevel,
          paperId: paperId,
          itemCount: itemCount,
        );

  const TutorMakeResult.notEnoughCards(int poolSize)
      : this._(status: TutorMakeStatus.notEnoughCards, poolSize: poolSize);

  /// A review sprint with nothing to review: its own outcome, because "your cards
  /// are all done" is good news, not a failure.
  const TutorMakeResult.nothingDue()
      : this._(status: TutorMakeStatus.nothingDue);

  const TutorMakeResult.failed() : this._(status: TutorMakeStatus.failed);

  final TutorMakeStatus status;
  final Deck? deck;

  /// Set when what was created is a paper rather than a folder.
  final String? paperId;

  /// What to call the thing: a paper and a story have no deck to name them after.
  final String? title;

  final int itemCount;
  final int poolSize;

  /// A reading pack's story: its cache id, the catalogue blueprint it came from,
  /// and the level it was written for. The three together are enough to reopen it
  /// out of the library's own cache, with no second call to anything.
  final String? storyId;
  final String? blueprintId;
  final int? hskLevel;
}

enum TutorMakeStatus {
  created,
  createdPaper,
  createdReadingPack,
  notEnoughCards,
  nothingDue,
  failed,
}
