import '../entities/flashcard.dart';
import '../entities/study_mode.dart';

class StudyAheadQueueBuilder {
  const StudyAheadQueueBuilder._();

  static List<Flashcard> build({
    required List<Flashcard> cards,
    required StudyMode mode,
    required DateTime now,
    required int limit,
  }) {
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final eligible = cards.where((card) {
      final stats = card.getStatsForMode(mode);
      return !stats.isNew && !stats.nextReviewDate.isBefore(tomorrow);
    }).toList()
      ..sort((a, b) => a
          .getStatsForMode(mode)
          .nextReviewDate
          .compareTo(b.getStatsForMode(mode).nextReviewDate));

    return eligible.take(limit < 0 ? eligible.length : limit).toList();
  }
}
