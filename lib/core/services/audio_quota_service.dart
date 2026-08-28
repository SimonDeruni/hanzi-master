import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final audioQuotaServiceProvider = Provider<AudioQuotaService>((ref) {
  return AudioQuotaService();
});

/// Manages the 4-Hour Weekly Fair-Use Studio Voice Quota for Azure Neural TTS.
/// Auto-resets every Monday at 00:00 (ISO Week calculation).
class AudioQuotaService {
  static const String _prefWeekKey = 'studio_audio_week_key';
  static const String _prefUsedSecondsKey = 'studio_audio_used_seconds';

  /// 4.0 Hours = 14,400 seconds of Studio Voice per week
  static const int weeklyAllowanceSeconds = 4 * 3600;

  SharedPreferences? _prefs;
  int _cachedUsedSeconds = 0;
  String _cachedWeekKey = '';
  bool _isInitialized = false;

  AudioQuotaService();

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      _prefs = await SharedPreferences.getInstance();
      _cachedWeekKey = _prefs?.getString(_prefWeekKey) ?? '';
      _cachedUsedSeconds = _prefs?.getInt(_prefUsedSecondsKey) ?? 0;

      final currentWeek = getIsoWeekKey(DateTime.now());
      if (_cachedWeekKey != currentWeek) {
        // New week started: reset quota
        _cachedWeekKey = currentWeek;
        _cachedUsedSeconds = 0;
        await _prefs?.setString(_prefWeekKey, _cachedWeekKey);
        await _prefs?.setInt(_prefUsedSecondsKey, _cachedUsedSeconds);
      }
      _isInitialized = true;
    } catch (e) {
      debugPrint('[AudioQuotaService] Init failed: $e');
    }
  }

  /// Calculates the ISO 8601 week key (e.g. '2026-W35') for weekly auto-reset.
  static String getIsoWeekKey(DateTime date) {
    final thursday = date.subtract(Duration(days: (date.weekday - 4)));
    final jan4 = DateTime(thursday.year, 1, 4);
    final firstThursday = jan4.subtract(Duration(days: (jan4.weekday - 4)));
    final weekNumber = 1 + ((thursday.difference(firstThursday).inDays) / 7).round();
    final weekStr = weekNumber.toString().padLeft(2, '0');
    return '${thursday.year}-W$weekStr';
  }

  /// Whether the user has remaining Studio Voice quota for the current week.
  bool get hasQuotaRemaining {
    _ensureCurrentWeek();
    return _cachedUsedSeconds < weeklyAllowanceSeconds;
  }

  /// Remaining Studio Audio hours for this week (e.g. 3.5).
  double get remainingHours {
    _ensureCurrentWeek();
    final remainingSeconds = (weeklyAllowanceSeconds - _cachedUsedSeconds).clamp(0, weeklyAllowanceSeconds);
    return remainingSeconds / 3600.0;
  }

  /// Remaining Studio Audio minutes for this week.
  int get remainingMinutes {
    _ensureCurrentWeek();
    final remainingSeconds = (weeklyAllowanceSeconds - _cachedUsedSeconds).clamp(0, weeklyAllowanceSeconds);
    return (remainingSeconds / 60.0).round();
  }

  /// Total seconds used this week.
  int get usedSeconds {
    _ensureCurrentWeek();
    return _cachedUsedSeconds;
  }

  /// Records speech consumption based on synthesized text.
  /// Standard Mandarin speaking rate is ~190 characters per minute (0.315s per char).
  Future<void> recordSpeech(String text) async {
    await init();
    _ensureCurrentWeek();

    // Chinese characters + punctuation speaking duration estimation
    final estimatedSeconds = (text.length * 0.315).ceil().clamp(1, 60);
    _cachedUsedSeconds += estimatedSeconds;

    try {
      await _prefs?.setInt(_prefUsedSecondsKey, _cachedUsedSeconds);
    } catch (e) {
      debugPrint('[AudioQuotaService] Failed to save used seconds: $e');
    }
  }

  /// Manually reset quota (for unit tests / dev tools).
  @visibleForTesting
  void resetQuotaForTesting() {
    _cachedUsedSeconds = 0;
    _cachedWeekKey = getIsoWeekKey(DateTime.now());
  }

  /// Manually add used seconds (for testing).
  @visibleForTesting
  void addUsedSecondsForTesting(int seconds) {
    _cachedUsedSeconds += seconds;
  }

  void _ensureCurrentWeek() {
    final currentWeek = getIsoWeekKey(DateTime.now());
    if (_cachedWeekKey.isNotEmpty && _cachedWeekKey != currentWeek) {
      _cachedWeekKey = currentWeek;
      _cachedUsedSeconds = 0;
      _prefs?.setString(_prefWeekKey, _cachedWeekKey);
      _prefs?.setInt(_prefUsedSecondsKey, _cachedUsedSeconds);
    }
  }
}
