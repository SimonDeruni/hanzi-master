import 'study_mode.dart';

class StudySessionSummary {
  const StudySessionSummary({
    required this.mode,
    required this.startedAt,
    required this.completedAt,
    required this.uniqueCards,
    required this.totalAttempts,
    required this.correctAttempts,
    required this.newCards,
    required this.reviewCards,
    required this.retryAttempts,
    required this.againCount,
    required this.hardCount,
    required this.goodCount,
    required this.easyCount,
    required this.needsPractice,
    this.studyAhead = false,
  });

  final StudyMode mode;
  final DateTime startedAt;
  final DateTime completedAt;
  final int uniqueCards;
  final int totalAttempts;
  final int correctAttempts;
  final int newCards;
  final int reviewCards;
  final int retryAttempts;
  final int againCount;
  final int hardCount;
  final int goodCount;
  final int easyCount;
  final int needsPractice;
  final bool studyAhead;

  double get accuracy =>
      totalAttempts == 0 ? 0 : correctAttempts / totalAttempts;

  Duration get duration => completedAt.difference(startedAt);
}
