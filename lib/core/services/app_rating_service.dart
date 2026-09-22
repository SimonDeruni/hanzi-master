import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/flashcards/domain/entities/study_session_summary.dart';
import '../../features/settings/presentation/screens/contact_screen.dart';
import '../../shared/routes/swipe_back_route.dart';
import '../../shared/widgets/zen_rating_sheet.dart';

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
  Future<void> openStoreListing({String? appStoreId});
}

class InAppReviewGateway implements RatingPromptGateway {
  InAppReviewGateway([InAppReview? inAppReview])
      : _inAppReview = inAppReview ?? InAppReview.instance;

  final InAppReview _inAppReview;

  @override
  Future<bool> isAvailable() => _inAppReview.isAvailable();

  @override
  Future<void> requestReview() => _inAppReview.requestReview();

  @override
  Future<void> openStoreListing({String? appStoreId}) =>
      _inAppReview.openStoreListing(appStoreId: appStoreId);
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
  static const int cooldownDays = 30;

  static const _qualifyingSessionsKey = 'app_rating_qualifying_sessions_v1';
  static const _requestRecordedKey = 'app_rating_request_recorded_v1';
  static const _lastPromptTimestampKey = 'app_rating_last_prompt_timestamp_v1';
  static const _userSentimentKey = 'app_rating_user_sentiment_v1';

  final RatingPromptGateway _gateway;
  final Future<SharedPreferences> Function() _preferences;

  /// Registers a completed study session. Preserves original 3-session rule
  /// for backwards compatibility and tests.
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

  /// Directly requests an in-app review via native store dialog.
  Future<bool> requestReview() async {
    try {
      if (await _gateway.isAvailable()) {
        final preferences = await _preferences();
        await preferences.setBool(_requestRecordedKey, true);
        await _gateway.requestReview();
        return true;
      }
    } catch (_) {}
    return false;
  }

  /// Opens the store listing page directly (e.g. from Settings screen).
  Future<void> openStoreListing({String? appStoreId}) async {
    try {
      if (await _gateway.isAvailable()) {
        await _gateway.openStoreListing(appStoreId: appStoreId);
      }
    } catch (_) {}
  }

  /// Checks whether the user is eligible to see the sentiment prompt.
  /// Enforces cooldown (30 days) and ensures users who already reviewed are not re-prompted.
  Future<bool> shouldShowSentimentPrompt() async {
    final preferences = await _preferences();
    final alreadyRequested = preferences.getBool(_requestRecordedKey) ?? false;
    if (alreadyRequested) return false;

    final lastPromptMs = preferences.getInt(_lastPromptTimestampKey) ?? 0;
    if (lastPromptMs > 0) {
      final lastPrompt = DateTime.fromMillisecondsSinceEpoch(lastPromptMs);
      final difference = DateTime.now().difference(lastPrompt);
      if (difference.inDays < cooldownDays) {
        return false;
      }
    }

    return true;
  }

  /// Checks if a specific milestone qualifies for showing the sentiment prompt.
  /// Valid milestones: 'streak_3', 'streak_7', 'streak_14', 'chapter_complete', 'study_mastery'.
  Future<bool> checkMilestoneEligibility(String milestone) async {
    if (!await shouldShowSentimentPrompt()) return false;

    final preferences = await _preferences();
    final milestoneKey = 'app_rating_milestone_hit_$milestone';
    final alreadyHit = preferences.getBool(milestoneKey) ?? false;
    if (alreadyHit) return false;

    // Mark milestone as evaluated
    await preferences.setBool(milestoneKey, true);
    return true;
  }

  /// Evaluates milestone eligibility and presents the calligraphic sentiment sheet if eligible.
  Future<void> triggerSentimentPromptIfEligible(
    BuildContext context, {
    required String trigger,
  }) async {
    final eligible = await checkMilestoneEligibility(trigger);
    if (!eligible) return;

    final preferences = await _preferences();
    await preferences.setInt(
      _lastPromptTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );

    if (context.mounted) {
      await ZenRatingSheet.show(context, trigger: trigger);
    }
  }

  /// Handles when a user taps "Yes, loving it!" (❤️):
  /// Records positive sentiment and launches the native Apple App Store review prompt.
  Future<void> onPositiveSentiment(
    BuildContext context, {
    String trigger = 'manual',
  }) async {
    final preferences = await _preferences();
    await preferences.setString(_userSentimentKey, 'positive');
    await preferences.setBool(_requestRecordedKey, true);

    try {
      if (await _gateway.isAvailable()) {
        await _gateway.requestReview();
      }
    } catch (_) {}
  }

  /// Handles when a user taps "Could be better" (💬):
  /// Records feedback sentiment and routes to private in-app support/feedback screen,
  /// completely avoiding negative public App Store reviews.
  Future<void> onNegativeSentiment(
    BuildContext context, {
    String trigger = 'manual',
  }) async {
    final preferences = await _preferences();
    await preferences.setString(_userSentimentKey, 'feedback_requested');

    if (context.mounted) {
      Navigator.of(context).push(
        SwipeBackRoute<void>(
          builder: (_) => const ContactScreen(),
        ),
      );
    }
  }

  /// Handles when a user dismisses or taps "Maybe later".
  Future<void> onDismissSentiment() async {
    final preferences = await _preferences();
    await preferences.setInt(
      _lastPromptTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }
}
