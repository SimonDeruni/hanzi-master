import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';

class StudySessionRecord {
  const StudySessionRecord({
    required this.mode,
    required this.startedAt,
    required this.completedAt,
    required this.uniqueCards,
    required this.totalAttempts,
    required this.correctAttempts,
  });

  final StudyMode mode;
  final DateTime startedAt;
  final DateTime completedAt;
  final int uniqueCards;
  final int totalAttempts;
  final int correctAttempts;

  Duration get duration => completedAt.difference(startedAt);
}

class ProgressPeriod {
  const ProgressPeriod({
    required this.sessionCount,
    required this.cardsStudied,
    required this.totalAttempts,
    required this.correctAttempts,
    required this.duration,
    required this.activeDays,
  });

  final int sessionCount;
  final int cardsStudied;
  final int totalAttempts;
  final int correctAttempts;
  final Duration duration;
  final int activeDays;

  double get accuracy =>
      totalAttempts == 0 ? 0 : correctAttempts / totalAttempts;
}

class StudyProgress {
  const StudyProgress({
    required this.todayCards,
    required this.dailyCardGoal,
    required this.currentStreak,
    required this.thisWeek,
    required this.previousWeek,
  });

  static const defaultDailyCardGoal = 10;

  final int todayCards;
  final int dailyCardGoal;
  final int currentStreak;
  final ProgressPeriod thisWeek;
  final ProgressPeriod previousWeek;

  double get dailyGoalProgress =>
      (todayCards / dailyCardGoal).clamp(0, 1).toDouble();

  int? get cardsChangePercent {
    if (previousWeek.cardsStudied == 0) return null;
    return (((thisWeek.cardsStudied - previousWeek.cardsStudied) /
                previousWeek.cardsStudied) *
            100)
        .round();
  }
}
