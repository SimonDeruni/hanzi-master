import '../entities/review_stats.dart';

enum ReviewRating {
  again(0),
  hard(2),
  good(4),
  easy(5);

  const ReviewRating(this.grade);

  final int grade;

  factory ReviewRating.fromGrade(int grade) {
    if (grade >= 5) return ReviewRating.easy;
    if (grade >= 3) return ReviewRating.good;
    if (grade >= 2) return ReviewRating.hard;
    return ReviewRating.again;
  }
}

class ReviewScheduler {
  const ReviewScheduler._();

  static ReviewStats schedule({
    required ReviewStats stats,
    required ReviewRating rating,
    required DateTime reviewedAt,
  }) {
    final grade = rating.grade;
    var interval = stats.interval;
    var streak = stats.streak;

    if (grade >= 3) {
      if (streak == 0) {
        interval = 0;
      } else if (streak == 1) {
        interval = rating == ReviewRating.easy ? 4 : 1;
      } else if (streak == 2) {
        interval = rating == ReviewRating.easy ? 10 : 6;
      } else {
        interval = (interval * stats.easeFactor).round().clamp(1, 36500);
      }
      streak++;
    } else if (streak > 5) {
      interval = (interval * 0.5).round().clamp(1, 36500);
      streak = (streak * 0.5).floor();
    } else {
      interval = 0;
      streak = 0;
    }

    final easeFactor =
        (stats.easeFactor + (0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02)))
            .clamp(1.3, double.infinity)
            .toDouble();

    return stats.copyWith(
      nextReviewDate: reviewedAt.add(Duration(days: interval)),
      interval: interval,
      easeFactor: easeFactor,
      streak: streak,
      attempts: stats.attempts + 1,
      lastAttemptDate: reviewedAt,
      successCount: grade >= 3 ? stats.successCount + 1 : stats.successCount,
      lastScore: grade.toDouble(),
      introducedAt: stats.introducedAt ?? reviewedAt,
    );
  }
}
