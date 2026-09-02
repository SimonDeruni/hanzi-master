import '../entities/daily_deck_activity.dart';
import '../entities/flashcard.dart';
import '../entities/study_mode.dart';
import '../logic/study_queue_builder.dart';

abstract class StudyActivityRepository {
  Future<StudyQueue> reserveQueue({
    required String deckId,
    required List<Flashcard> cards,
    required StudyMode mode,
    required DateTime now,
    required int dailyNewLimit,
    required int dailyReviewLimit,
  });

  Future<DailyDeckActivity> activityForDay({
    required String deckId,
    required List<Flashcard> cards,
    required DateTime now,
  });

  Future<void> recordReview({
    required String deckId,
    required String cardId,
    required DateTime reviewedAt,
  });
}
