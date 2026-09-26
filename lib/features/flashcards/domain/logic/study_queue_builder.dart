import '../entities/flashcard.dart';
import '../entities/study_mode.dart';

enum StudyQueueEmptyReason {
  deckEmpty,
  dailyLimitReached,
  caughtUp,
  noEligibleCards,
}

class StudyQueue {
  const StudyQueue({
    required this.cards,
    required this.cardIdsToIntroduce,
    required this.newlyReservedCardIds,
    required this.reviewCardIdsToReserve,
    required this.dueCount,
    required this.learningCount,
    required this.newCount,
    this.emptyReason,
    this.nextReviewDate,
  });

  final List<Flashcard> cards;
  final Set<String> cardIdsToIntroduce;
  final Set<String> newlyReservedCardIds;
  final Set<String> reviewCardIdsToReserve;
  final int dueCount;
  final int learningCount;
  final int newCount;
  final StudyQueueEmptyReason? emptyReason;
  final DateTime? nextReviewDate;
}

class StudyQueueBuilder {
  const StudyQueueBuilder._();

  static StudyQueue build({
    required List<Flashcard> cards,
    required StudyMode mode,
    required DateTime now,
    required int dailyNewLimit,
    required int dailyReviewLimit,
    Set<String>? introducedCardIds,
    Set<String>? reviewedCardIds,
    Set<String>? modeIntroducedCardIds,
  }) {
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day + 1);
    bool isToday(DateTime? value) =>
        value != null && !value.isBefore(start) && value.isBefore(end);

    final introducedToday = introducedCardIds ??
        cards
            .where((card) => card.modeStats.values.any(
                  (stats) => isToday(stats.introducedAt),
                ))
            .map((card) => card.id)
            .toSet();
    final reviewedToday = reviewedCardIds ??
        cards
            .where((card) =>
                !introducedToday.contains(card.id) &&
                card.modeStats.values.any(
                  (stats) => isToday(stats.lastAttemptDate),
                ))
            .map((card) => card.id)
            .toSet();

    final reviewAllowance = dailyReviewLimit < 0
        ? cards.length
        : (dailyReviewLimit - reviewedToday.length)
            .clamp(0, cards.length)
            .toInt();
    final newAllowance = dailyNewLimit < 0
        ? cards.length
        : (dailyNewLimit - introducedToday.length)
            .clamp(0, cards.length)
            .toInt();

    final due = cards.where((card) {
      final stats = card.getStatsForMode(mode);
      final isLearning = stats.interval <= 1;
      return !stats.isNew &&
          stats.nextReviewDate.isBefore(end) &&
          (isLearning || !reviewedToday.contains(card.id));
    }).toList()
      ..sort((a, b) {
        final aStats = a.getStatsForMode(mode);
        final bStats = b.getStatsForMode(mode);
        final aLearning = aStats.interval <= 1;
        final bLearning = bStats.interval <= 1;
        if (aLearning != bLearning) return aLearning ? -1 : 1;
        return aStats.nextReviewDate.compareTo(bStats.nextReviewDate);
      });
    final learningDue =
        due.where((card) => card.getStatsForMode(mode).interval <= 1).toList();
    final reviewDue = due
        .where((card) => card.getStatsForMode(mode).interval > 1)
        .take(reviewAllowance);
    final limitedDue = <Flashcard>[...learningDue, ...reviewDue];

    final alreadyIntroducedNew = <Flashcard>[];
    final neverIntroducedNew = <Flashcard>[];
    for (final card in cards) {
      if (!card.getStatsForMode(mode).isNew) continue;

      // Reserved today — in this mode or in another one — but never actually
      // studied. Reserving writes the day's `introducedCardIds` and this mode's
      // `modeIntroductionKeys`, never `attempts`, so such a card is *still*
      // `isNew` here. It must therefore stay in the queue as an
      // already-introduced card: dropping it made every card of an abandoned
      // session unreachable for the rest of the day, so a session left after its
      // first word served exactly that one word when it was reopened ("it stops
      // after only one card"). It carries no allowance either way — its quota
      // was spent when it was reserved — and its `introducedAt` is already
      // today, so it is not introduced a second time.
      final bool alreadyIntroduced = introducedToday.contains(card.id) ||
          (modeIntroducedCardIds?.contains(card.id) ?? false);
      if (alreadyIntroduced) {
        alreadyIntroducedNew.add(card);
      } else {
        neverIntroducedNew.add(card);
      }
    }
    final selectedNew = <Flashcard>[
      ...alreadyIntroducedNew,
      ...neverIntroducedNew.take(newAllowance),
    ];
    final idsToIntroduce = selectedNew
        .where((card) => !isToday(card.getStatsForMode(mode).introducedAt))
        .map((card) => card.id)
        .toSet();
    final newlyReservedIds =
        neverIntroducedNew.take(newAllowance).map((card) => card.id).toSet();
    final reservedReviewIds = reviewDue.map((card) => card.id).toSet();
    final queueCards = _interleave(limitedDue, selectedNew);

    DateTime? nextReviewDate;
    for (final card in cards) {
      final stats = card.getStatsForMode(mode);
      if (stats.isNew || stats.nextReviewDate.isBefore(end)) continue;
      if (nextReviewDate == null ||
          stats.nextReviewDate.isBefore(nextReviewDate)) {
        nextReviewDate = stats.nextReviewDate;
      }
    }

    StudyQueueEmptyReason? emptyReason;
    if (queueCards.isEmpty) {
      final hasBlockedNew = neverIntroducedNew.isNotEmpty && newAllowance == 0;
      final hasBlockedReview = due.any((card) =>
              card.getStatsForMode(mode).interval > 1 &&
              !reviewedToday.contains(card.id)) &&
          reviewAllowance == 0;
      emptyReason = cards.isEmpty
          ? StudyQueueEmptyReason.deckEmpty
          : hasBlockedNew || hasBlockedReview
              ? StudyQueueEmptyReason.dailyLimitReached
              : nextReviewDate != null
                  ? StudyQueueEmptyReason.caughtUp
                  : StudyQueueEmptyReason.noEligibleCards;
    }

    return StudyQueue(
      cards: queueCards,
      cardIdsToIntroduce: idsToIntroduce,
      newlyReservedCardIds: newlyReservedIds,
      reviewCardIdsToReserve: reservedReviewIds,
      dueCount: reviewDue.length,
      learningCount: learningDue.length,
      newCount: selectedNew.length,
      emptyReason: emptyReason,
      nextReviewDate: nextReviewDate,
    );
  }

  static List<Flashcard> _interleave(
    List<Flashcard> reviews,
    List<Flashcard> newCards,
  ) {
    if (reviews.isEmpty) return List.of(newCards);
    if (newCards.isEmpty) return List.of(reviews);

    final result = <Flashcard>[];
    var newIndex = 0;
    for (var reviewIndex = 0; reviewIndex < reviews.length; reviewIndex++) {
      result.add(reviews[reviewIndex]);
      final targetNewCount =
          ((reviewIndex + 1) * newCards.length / reviews.length).floor();
      while (newIndex < targetNewCount) {
        result.add(newCards[newIndex++]);
      }
    }
    result.addAll(newCards.skip(newIndex));
    return result;
  }
}
