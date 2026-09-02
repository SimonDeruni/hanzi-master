import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/review_scheduler.dart';

void main() {
  final now = DateTime(2026, 8, 24, 12);

  ReviewStats stats({int streak = 0, int interval = 0}) => ReviewStats(
        nextReviewDate: now,
        interval: interval,
        easeFactor: 2.5,
        streak: streak,
      );

  group('ReviewScheduler', () {
    test('first successful review stays in learning today', () {
      final result = ReviewScheduler.schedule(
        stats: stats(),
        rating: ReviewRating.good,
        reviewedAt: now,
      );

      expect(result.interval, 0);
      expect(result.streak, 1);
      expect(result.attempts, 1);
      expect(result.successCount, 1);
      expect(result.introducedAt, now);
      expect(result.nextReviewDate, now);
    });

    test('failure resets a young card and preserves introduction date', () {
      final introducedAt = now.subtract(const Duration(days: 3));
      final result = ReviewScheduler.schedule(
        stats: stats(streak: 2, interval: 6).copyWith(
          introducedAt: introducedAt,
        ),
        rating: ReviewRating.again,
        reviewedAt: now,
      );

      expect(result.interval, 0);
      expect(result.streak, 0);
      expect(result.introducedAt, introducedAt);
      expect(result.lastAttemptDate, now);
    });

    test('easy rating advances the second learning step by four days', () {
      final result = ReviewScheduler.schedule(
        stats: stats(streak: 1),
        rating: ReviewRating.easy,
        reviewedAt: now,
      );

      expect(result.interval, 4);
      expect(result.nextReviewDate, now.add(const Duration(days: 4)));
    });
  });
}
