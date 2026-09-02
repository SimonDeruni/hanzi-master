import 'package:equatable/equatable.dart';

class ReviewStats extends Equatable {
  final DateTime nextReviewDate;
  final int interval;
  final double easeFactor;
  final int streak;

  // Performance Tracking
  final double lastScore;
  final int attempts;
  final DateTime? lastAttemptDate;
  final int successCount;
  final DateTime? introducedAt;

  const ReviewStats({
    required this.nextReviewDate,
    required this.interval,
    required this.easeFactor,
    required this.streak,
    this.lastScore = 0.0,
    this.attempts = 0,
    this.lastAttemptDate,
    this.successCount = 0,
    this.introducedAt,
  });

  ReviewStats copyWith({
    DateTime? nextReviewDate,
    int? interval,
    double? easeFactor,
    int? streak,
    double? lastScore,
    int? attempts,
    DateTime? lastAttemptDate,
    int? successCount,
    DateTime? introducedAt,
  }) {
    return ReviewStats(
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      interval: interval ?? this.interval,
      easeFactor: easeFactor ?? this.easeFactor,
      streak: streak ?? this.streak,
      lastScore: lastScore ?? this.lastScore,
      attempts: attempts ?? this.attempts,
      lastAttemptDate: lastAttemptDate ?? this.lastAttemptDate,
      successCount: successCount ?? this.successCount,
      introducedAt: introducedAt ?? this.introducedAt,
    );
  }

  factory ReviewStats.initial() {
    return ReviewStats(
      nextReviewDate: DateTime.now(),
      interval: 0,
      easeFactor: 2.5,
      streak: 0,
    );
  }

  @override
  List<Object?> get props => [
        nextReviewDate,
        interval,
        easeFactor,
        streak,
        lastScore,
        attempts,
        lastAttemptDate,
        successCount,
        introducedAt
      ];

  bool get isMastered => interval >= 14 || streak >= 5;
  bool get isNew => attempts == 0;
  bool get isLearning => attempts > 0 && !isMastered;
  bool get isDue => isDueAt(DateTime.now());

  bool isDueAt(DateTime now) {
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return nextReviewDate.isBefore(tomorrow);
  }

  double get masteryLevel => (streak / 5.0).clamp(0.0, 1.0);
}
