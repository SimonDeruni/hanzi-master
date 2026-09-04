import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/flashcards/domain/entities/study_session_summary.dart';

final appRatingServiceProvider = Provider<AppRatingService>((ref) {
  return AppRatingService();
});

enum RatingPromptResult {
  sessionNotEligible,
  waitingForMoreSessions,
  alreadyRequested,
  unavailable,
  requested,
}

abstract class RatingPromptGateway {
  Future<bool> isAvailable();

  Future<void> requestReview();
}

class InAppReviewGateway implements RatingPromptGateway {
  InAppReviewGateway([InAppReview? inAppReview])
      : _inAppReview = inAppReview ?? InAppReview.instance;

  final InAppReview _inAppReview;

  @override
  Future<bool> isAvailable() => _inAppReview.isAvailable();

  @override
  Future<void> requestReview() => _inAppReview.requestReview();
}

class AppRatingService {
  AppRatingService({
    RatingPromptGateway? gateway,
    Future<SharedPreferences> Function()? preferences,
  })  : _gateway = gateway ?? InAppReviewGateway(),
        _preferences = preferences ?? SharedPreferences.getInstance;

  static const int qualifyingSessionsRequired = 3;
  static const int minimumCards = 10;
  static const double minimumAccuracy = 0.8;

  static const _qualifyingSessionsKey = 'app_rating_qualifying_sessions_v1';
  static const _requestRecordedKey = 'app_rating_request_recorded_v1';

  final RatingPromptGateway _gateway;
  final Future<SharedPreferences> Function() _preferences;

  Future<RatingPromptResult> registerCompletedSession(
    StudySessionSummary summary,
  ) async {
    if (summary.uniqueCards < minimumCards ||
        summary.accuracy < minimumAccuracy) {
      return RatingPromptResult.sessionNotEligible;
    }

    final preferences = await _preferences();
    if (preferences.getBool(_requestRecordedKey) ?? false) {
      return RatingPromptResult.alreadyRequested;
    }

    final qualifyingSessions =
        (preferences.getInt(_qualifyingSessionsKey) ?? 0) + 1;
    await preferences.setInt(_qualifyingSessionsKey, qualifyingSessions);

    if (qualifyingSessions < qualifyingSessionsRequired) {
      return RatingPromptResult.waitingForMoreSessions;
    }

    try {
      if (!await _gateway.isAvailable()) {
        return RatingPromptResult.unavailable;
      }

      // Record first so a rapid repeat action cannot trigger duplicate requests.
      await preferences.setBool(_requestRecordedKey, true);
      await _gateway.requestReview();
      return RatingPromptResult.requested;
    } catch (_) {
      // A rating prompt is optional UX and must never interrupt navigation.
      return RatingPromptResult.unavailable;
    }
  }
}
