import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The Provider to use in the UI
final streakProvider = StateNotifierProvider<StreakController, int>((ref) {
  return StreakController();
});

class StreakController extends StateNotifier<int> {
  StreakController() : super(0) {
    _loadStreak();
  }

  static const String _keyStreak = 'streak_count';
  static const String _keyLastDate = 'last_study_date';

  Future<void> _loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final streak = prefs.getInt(_keyStreak) ?? 0;
    final lastDateStr = prefs.getString(_keyLastDate);

    if (lastDateStr != null) {
      final lastDate = DateTime.parse(lastDateStr);
      final today = DateTime.now();
      
      // Calculate difference in days (ignoring time)
      final difference = _daysBetween(lastDate, today);

      if (difference == 0) {
        // Already studied today, keep streak
        state = streak;
      } else if (difference == 1) {
        // Studied yesterday, streak is safe
        state = streak;
      } else {
        // Missed more than 1 day, reset to 0
        state = 0;
        await prefs.setInt(_keyStreak, 0);
      }
    } else {
      state = 0;
    }
  }

  Future<void> incrementStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDateStr = prefs.getString(_keyLastDate);
    final today = DateTime.now();

    // If never studied, or studied yesterday (or earlier)
    if (lastDateStr == null || _daysBetween(DateTime.parse(lastDateStr), today) >= 1) {
       // Only increment if we haven't already incremented TODAY
       // (Logic: If difference is 0, we already studied today, so don't add +1 again)
       
       // Actually, simplified logic:
       // We only want to increase if the last recorded date wasn't today.
       bool alreadyStudiedToday = false;
       if (lastDateStr != null) {
         if (_daysBetween(DateTime.parse(lastDateStr), today) == 0) {
           alreadyStudiedToday = true;
         }
       }

       if (!alreadyStudiedToday) {
         final newStreak = state + 1;
         state = newStreak;
         await prefs.setInt(_keyStreak, newStreak);
         await prefs.setString(_keyLastDate, today.toIso8601String());
       }
    }
  }

  // Helper to check day difference
  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}