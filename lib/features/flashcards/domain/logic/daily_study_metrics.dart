import '../entities/daily_deck_activity.dart';
import '../entities/flashcard.dart';
import '../entities/study_mode.dart';

class DailyStudyMetrics {
  const DailyStudyMetrics({
    required this.introducedToday,
    required this.reviewedToday,
    required this.dueNow,
    required this.learningNow,
    required this.futureReviews,
    required this.forecast,
  });

  final int introducedToday;
  final int reviewedToday;
  final int dueNow;
  final int learningNow;
  final int futureReviews;
  final List<int> forecast;

  static DailyStudyMetrics calculate({
    required List<Flashcard> cards,
    required DailyDeckActivity activity,
    required StudyMode mode,
    required DateTime now,
    int forecastDays = 7,
  }) {
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final forecast = List<int>.filled(forecastDays, 0);
    var dueNow = 0;
    var learningNow = 0;
    var futureReviews = 0;

    for (final card in cards) {
      final stats = card.getStatsForMode(mode);
      if (stats.isNew) continue;
      if (stats.nextReviewDate.isBefore(tomorrow)) {
        dueNow++;
        if (stats.interval <= 1) learningNow++;
        continue;
      }
      futureReviews++;
      final reviewDay = DateTime(
        stats.nextReviewDate.year,
        stats.nextReviewDate.month,
        stats.nextReviewDate.day,
      );
      final day = reviewDay.difference(today).inDays;
      if (day >= 0 && day < forecastDays) forecast[day]++;
    }

    return DailyStudyMetrics(
      introducedToday: activity.introducedCardIds.length,
      reviewedToday: activity.reviewedCardIds.length,
      dueNow: dueNow,
      learningNow: learningNow,
      futureReviews: futureReviews,
      forecast: forecast,
    );
  }
}
