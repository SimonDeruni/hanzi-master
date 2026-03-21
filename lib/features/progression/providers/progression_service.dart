import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ScholarRank {
  novice('Novice', 0),
  apprentice('Apprentice', 500),
  artisan('Artisan', 2000),
  master('Master', 5000),
  grandmaster('Grandmaster', 10000);

  final String title;
  final int requiredPoints;
  const ScholarRank(this.title, this.requiredPoints);

  static ScholarRank fromPoints(int points) {
    if (points >= grandmaster.requiredPoints) return grandmaster;
    if (points >= master.requiredPoints) return master;
    if (points >= artisan.requiredPoints) return artisan;
    if (points >= apprentice.requiredPoints) return apprentice;
    return novice;
  }
}

class ProgressionState {
  final int inkPoints;
  final int currentStreak;
  final DateTime? lastLessonDate;
  final ScholarRank rank;

  ProgressionState({
    required this.inkPoints,
    required this.currentStreak,
    this.lastLessonDate,
  }) : rank = ScholarRank.fromPoints(inkPoints);

  ProgressionState copyWith({
    int? inkPoints,
    int? currentStreak,
    DateTime? lastLessonDate,
  }) {
    return ProgressionState(
      inkPoints: inkPoints ?? this.inkPoints,
      currentStreak: currentStreak ?? this.currentStreak,
      lastLessonDate: lastLessonDate ?? this.lastLessonDate,
    );
  }
}

class ProgressionService extends StateNotifier<ProgressionState> {
  static const _pointsKey = 'progression_ink_points';
  static const _streakKey = 'progression_streak';
  static const _lastLessonKey = 'progression_last_lesson_date';

  ProgressionService() : super(ProgressionState(inkPoints: 0, currentStreak: 0)) {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final points = prefs.getInt(_pointsKey) ?? 0;
    final streak = prefs.getInt(_streakKey) ?? 0;
    
    final lastLessonIso = prefs.getString(_lastLessonKey);
    DateTime? lastLesson;
    if (lastLessonIso != null) {
      lastLesson = DateTime.tryParse(lastLessonIso);
    }

    // Streak logic check on load
    int validatedStreak = streak;
    if (lastLesson != null) {
      final now = DateTime.now();
      final difference = DateTime(now.year, now.month, now.day)
          .difference(DateTime(lastLesson.year, lastLesson.month, lastLesson.day))
          .inDays;
      
      if (difference > 1) {
        // Streak broken
        validatedStreak = 0;
        await prefs.setInt(_streakKey, 0);
      }
    }

    state = ProgressionState(
      inkPoints: points,
      currentStreak: validatedStreak,
      lastLessonDate: lastLesson,
    );
  }

  Future<void> addInkPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final newPoints = state.inkPoints + points;
    
    // Check if a day has passed since last lesson to increment streak
    int newStreak = state.currentStreak;
    final now = DateTime.now();
    DateTime? newLastLesson = state.lastLessonDate;

    if (state.lastLessonDate == null) {
      newStreak = 1;
      newLastLesson = now;
    } else {
      final difference = DateTime(now.year, now.month, now.day)
          .difference(DateTime(state.lastLessonDate!.year, state.lastLessonDate!.month, state.lastLessonDate!.day))
          .inDays;
          
      if (difference == 1) {
        newStreak += 1;
        newLastLesson = now;
      } else if (difference > 1) {
        newStreak = 1;
        newLastLesson = now;
      } else if (difference == 0) {
        // Same day, update last lesson time but don't increment streak
        newLastLesson = now;
      }
    }

    await prefs.setInt(_pointsKey, newPoints);
    await prefs.setInt(_streakKey, newStreak);
    if (newLastLesson != null) {
      await prefs.setString(_lastLessonKey, newLastLesson.toIso8601String());
    }

    state = state.copyWith(
      inkPoints: newPoints,
      currentStreak: newStreak,
      lastLessonDate: newLastLesson,
    );
  }
}

final progressionProvider = StateNotifierProvider<ProgressionService, ProgressionState>((ref) {
  return ProgressionService();
});
