import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_session_summary.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/progression/domain/study_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

final studyProgressServiceProvider = Provider<StudyProgressService>((ref) {
  return StudyProgressService(ref.watch(sharedPreferencesProvider));
});

final studyProgressProvider = FutureProvider<StudyProgress>((ref) {
  return ref.watch(studyProgressServiceProvider).loadProgress();
});

class StudyProgressService {
  StudyProgressService(this._preferences, {DateTime Function()? now})
      : _now = now ?? DateTime.now;

  static const _historyKey = 'completed_study_sessions_v1';
  static const _retentionDays = 90;

  final SharedPreferences _preferences;
  final DateTime Function() _now;

  Future<bool> recordCompletedSession(StudySessionSummary summary) async {
    final records = _readRecords();
    final id = _recordId(summary.startedAt, summary.completedAt);
    if (records.any(
        (record) => _recordId(record.startedAt, record.completedAt) == id)) {
      return false;
    }

    records.add(StudySessionRecord(
      mode: summary.mode,
      startedAt: summary.startedAt,
      completedAt: summary.completedAt,
      uniqueCards: summary.uniqueCards,
      totalAttempts: summary.totalAttempts,
      correctAttempts: summary.correctAttempts,
    ));
    final cutoff = _dateOnly(_now()).subtract(
      const Duration(days: _retentionDays),
    );
    records.removeWhere((record) => record.completedAt.isBefore(cutoff));
    records.sort((a, b) => a.completedAt.compareTo(b.completedAt));
    return _preferences.setString(
      _historyKey,
      jsonEncode(records.map(_toJson).toList()),
    );
  }

  Future<StudyProgress> loadProgress({DateTime? now}) async {
    final localNow = (now ?? _now()).toLocal();
    final today = _dateOnly(localNow);
    final thisWeekStart = today.subtract(Duration(days: today.weekday - 1));
    final nextWeekStart = thisWeekStart.add(const Duration(days: 7));
    final previousWeekStart = thisWeekStart.subtract(const Duration(days: 7));
    final records = _readRecords();

    final historyStreak = calculateCalendarStreak(records, localNow);
    return StudyProgress(
      todayCards: records
          .where((record) => _sameDate(record.completedAt, today))
          .fold(0, (sum, record) => sum + record.uniqueCards),
      dailyCardGoal: StudyProgress.defaultDailyCardGoal,
      currentStreak: historyStreak > _validLegacyStreak(localNow)
          ? historyStreak
          : _validLegacyStreak(localNow),
      thisWeek: _period(records, thisWeekStart, nextWeekStart),
      previousWeek: _period(records, previousWeekStart, thisWeekStart),
    );
  }

  int _validLegacyStreak(DateTime now) {
    final count = _preferences.getInt('streak_count') ?? 0;
    final encodedDate = _preferences.getString('last_study_date');
    if (count == 0 || encodedDate == null) return 0;
    final lastStudy = DateTime.tryParse(encodedDate)?.toLocal();
    if (lastStudy == null) return 0;
    final lastDay = _dateOnly(lastStudy);
    final today = _dateOnly(now);
    return lastDay == today ||
            lastDay == today.subtract(const Duration(days: 1))
        ? count
        : 0;
  }

  static int calculateCalendarStreak(
    Iterable<StudySessionRecord> records,
    DateTime now,
  ) {
    final activeDays = records
        .map((record) => _dateOnly(record.completedAt.toLocal()))
        .toSet();
    if (activeDays.isEmpty) return 0;

    var cursor = _dateOnly(now.toLocal());
    if (!activeDays.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
      if (!activeDays.contains(cursor)) return 0;
    }

    var streak = 0;
    while (activeDays.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  List<StudySessionRecord> _readRecords() {
    final encoded = _preferences.getString(_historyKey);
    if (encoded == null) return [];
    try {
      final values = jsonDecode(encoded) as List<dynamic>;
      return values
          .map((value) => _fromJson(Map<String, dynamic>.from(value as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static ProgressPeriod _period(
    Iterable<StudySessionRecord> records,
    DateTime start,
    DateTime end,
  ) {
    final selected = records.where((record) {
      final completed = record.completedAt.toLocal();
      return !completed.isBefore(start) && completed.isBefore(end);
    }).toList();
    return ProgressPeriod(
      sessionCount: selected.length,
      cardsStudied: selected.fold(0, (sum, record) => sum + record.uniqueCards),
      totalAttempts:
          selected.fold(0, (sum, record) => sum + record.totalAttempts),
      correctAttempts:
          selected.fold(0, (sum, record) => sum + record.correctAttempts),
      duration: selected.fold(
        Duration.zero,
        (sum, record) => sum + record.duration,
      ),
      activeDays: selected
          .map((record) => _dateOnly(record.completedAt.toLocal()))
          .toSet()
          .length,
    );
  }

  static Map<String, Object> _toJson(StudySessionRecord record) => {
        'mode': record.mode.name,
        'startedAt': record.startedAt.toIso8601String(),
        'completedAt': record.completedAt.toIso8601String(),
        'uniqueCards': record.uniqueCards,
        'totalAttempts': record.totalAttempts,
        'correctAttempts': record.correctAttempts,
      };

  static StudySessionRecord _fromJson(Map<String, dynamic> json) {
    final modeName = json['mode'] as String?;
    return StudySessionRecord(
      mode: StudyMode.values.firstWhere(
        (mode) => mode.name == modeName,
        orElse: () => StudyMode.reading,
      ),
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: DateTime.parse(json['completedAt'] as String),
      uniqueCards: json['uniqueCards'] as int? ?? 0,
      totalAttempts: json['totalAttempts'] as int? ?? 0,
      correctAttempts: json['correctAttempts'] as int? ?? 0,
    );
  }

  static String _recordId(DateTime startedAt, DateTime completedAt) =>
      '${startedAt.toIso8601String()}|${completedAt.toIso8601String()}';

  static DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  static bool _sameDate(DateTime first, DateTime second) {
    final local = first.toLocal();
    return local.year == second.year &&
        local.month == second.month &&
        local.day == second.day;
  }
}
