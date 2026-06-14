import 'package:hive/hive.dart';
import '../../domain/entities/review_stats.dart';

part 'review_stats_model.g.dart';

@HiveType(typeId: 2)
class ReviewStatsModel extends HiveObject {
  @HiveField(0)
  final DateTime nextReviewDate;

  @HiveField(1)
  final int interval;

  @HiveField(2)
  final double easeFactor;

  @HiveField(3)
  final int streak;

  @HiveField(4)
  final double? lastScore;

  @HiveField(5)
  final int? attempts;

  @HiveField(6)
  final DateTime? lastAttemptDate;

  @HiveField(7)
  final int? successCount;

  ReviewStatsModel({
    required this.nextReviewDate,
    required this.interval,
    required this.easeFactor,
    required this.streak,
    this.lastScore = 0.0,
    this.attempts = 0,
    this.lastAttemptDate,
    this.successCount = 0,
  });

  factory ReviewStatsModel.fromEntity(ReviewStats stats) {
    return ReviewStatsModel(
      nextReviewDate: stats.nextReviewDate,
      interval: stats.interval,
      easeFactor: stats.easeFactor,
      streak: stats.streak,
      lastScore: stats.lastScore,
      attempts: stats.attempts,
      lastAttemptDate: stats.lastAttemptDate,
      successCount: stats.successCount,
    );
  }

  ReviewStats toEntity() {
    return ReviewStats(
      nextReviewDate: nextReviewDate,
      interval: interval,
      easeFactor: easeFactor,
      streak: streak,
      lastScore: lastScore ?? 0.0,
      attempts: attempts ?? 0,
      lastAttemptDate: lastAttemptDate,
      successCount: successCount ?? 0,
    );
  }
}
