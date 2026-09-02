import '../entities/review_stats.dart';
import 'review_scheduler.dart';

class SrsLogic {
  /// Calculates the new SRS scheduling stats for a mode.
  /// Note: Attempts and Success counts are handled by the caller before passing here.
  static ReviewStats reviewCard(ReviewStats stats, int rating) {
    return ReviewScheduler.schedule(
      stats: stats,
      rating: ReviewRating.fromGrade(rating),
      reviewedAt: DateTime.now(),
    );
  }
}
