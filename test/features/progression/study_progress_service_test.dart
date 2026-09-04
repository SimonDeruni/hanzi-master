import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_session_summary.dart';
import 'package:hanzi_master/features/progression/data/study_progress_service.dart';
import 'package:hanzi_master/features/progression/domain/study_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
  });

  test('records a completed session only once', () async {
    final now = DateTime(2026, 9, 3, 12);
    final service = StudyProgressService(preferences, now: () => now);
    final summary = _summary(DateTime(2026, 9, 3, 10), cards: 10);

    expect(await service.recordCompletedSession(summary), isTrue);
    expect(await service.recordCompletedSession(summary), isFalse);

    final progress = await service.loadProgress();
    expect(progress.todayCards, 10);
    expect(progress.thisWeek.sessionCount, 1);
  });

  test('aggregates this week and compares it with the previous week', () async {
    final service = StudyProgressService(
      preferences,
      now: () => DateTime(2026, 9, 3, 12),
    );
    await service.recordCompletedSession(
      _summary(DateTime(2026, 8, 26, 10), cards: 10),
    );
    await service.recordCompletedSession(
      _summary(DateTime(2026, 9, 1, 10), cards: 8),
    );
    await service.recordCompletedSession(
      _summary(DateTime(2026, 9, 3, 10), cards: 12),
    );

    final progress = await service.loadProgress();
    expect(progress.thisWeek.cardsStudied, 20);
    expect(progress.thisWeek.activeDays, 2);
    expect(progress.previousWeek.cardsStudied, 10);
    expect(progress.cardsChangePercent, 100);
  });

  test('calendar streak survives yesterday and uses date boundaries', () {
    final records = [
      _record(DateTime(2026, 3, 7, 23, 55)),
      _record(DateTime(2026, 3, 8, 0, 5)),
    ];

    expect(
      StudyProgressService.calculateCalendarStreak(
        records,
        DateTime(2026, 3, 9, 8),
      ),
      2,
    );
  });

  test('preserves a still-active legacy streak during migration', () async {
    SharedPreferences.setMockInitialValues({
      'streak_count': 7,
      'last_study_date': DateTime(2026, 9, 2, 23).toIso8601String(),
    });
    preferences = await SharedPreferences.getInstance();
    final service = StudyProgressService(
      preferences,
      now: () => DateTime(2026, 9, 3, 8),
    );

    expect((await service.loadProgress()).currentStreak, 7);
  });

  test('daily target is small and progress is capped', () async {
    final service = StudyProgressService(
      preferences,
      now: () => DateTime(2026, 9, 3, 12),
    );
    await service.recordCompletedSession(
      _summary(DateTime(2026, 9, 3, 10), cards: 15),
    );

    final progress = await service.loadProgress();
    expect(progress.dailyCardGoal, StudyProgress.defaultDailyCardGoal);
    expect(progress.dailyGoalProgress, 1);
  });
}

StudySessionSummary _summary(DateTime startedAt, {required int cards}) {
  return StudySessionSummary(
    mode: StudyMode.reading,
    startedAt: startedAt,
    completedAt: startedAt.add(const Duration(minutes: 5)),
    uniqueCards: cards,
    totalAttempts: cards,
    correctAttempts: cards - 2,
    newCards: 2,
    reviewCards: cards - 2,
    retryAttempts: 0,
    againCount: 0,
    hardCount: 2,
    goodCount: cards - 4,
    easyCount: 2,
    needsPractice: 0,
  );
}

StudySessionRecord _record(DateTime completedAt) => StudySessionRecord(
      mode: StudyMode.reading,
      startedAt: completedAt.subtract(const Duration(minutes: 5)),
      completedAt: completedAt,
      uniqueCards: 10,
      totalAttempts: 10,
      correctAttempts: 8,
    );
