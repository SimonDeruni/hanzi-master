import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

final reviewServiceProvider = Provider<ReviewService>((ref) {
  return ReviewService();
});

class ReviewService {
  static const String _sessionsKey = 'completed_sessions_count';
  static const String _promptedKey = 'has_been_prompted_for_review';
  static const int _targetSessions = 3;

  final InAppReview _inAppReview = InAppReview.instance;

  Future<void> registerSuccessfulSession() async {
    final prefs = await SharedPreferences.getInstance();
    
    final bool hasBeenPrompted = prefs.getBool(_promptedKey) ?? false;
    if (hasBeenPrompted) return;

    int sessions = prefs.getInt(_sessionsKey) ?? 0;
    sessions++;
    await prefs.setInt(_sessionsKey, sessions);

    if (sessions >= _targetSessions) {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
        await prefs.setBool(_promptedKey, true);
      }
    }
  }
}
