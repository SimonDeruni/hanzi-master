import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) => AnalyticsService());

class AnalyticsService {
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    debugPrint('[ANALYTICS] Mock Analytics successfully initialized.');
  }

  /// Log when a user views a specific screen
  Future<void> logScreenView(String screenName, {String? screenClass}) async {
    debugPrint('[ANALYTICS-SCREEN] $screenName');
  }

  /// Log a custom event with properties
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    debugPrint('[ANALYTICS-EVENT] $name | Params: $parameters');
  }

  /// Log API usage (specifically requested by business)
  Future<void> logApiUsage({
    required String apiName, 
    required String feature,
    int? tokensUsed,
    int? durationMs,
    bool success = true,
  }) async {
    await logEvent('api_request', parameters: {
      'api_name': apiName,
      'feature': feature,
      'success': success ? 1 : 0,
      if (tokensUsed != null) 'tokens': tokensUsed,
      if (durationMs != null) 'duration_ms': durationMs,
    });
  }

  /// Log Story Interactions
  Future<void> logStoryAction({
    required String action, // e.g., 'started', 'completed', 'character_tapped'
    required String storyId,
    required String storyLevel,
    String? extraData,
  }) async {
    await logEvent('story_$action', parameters: {
      'story_id': storyId,
      'hsk_level': storyLevel,
      if (extraData != null) 'extra_data': extraData,
    });
  }

  /// Log Study Session Interactions
  Future<void> logStudySession({
    required String action, // e.g., 'started', 'completed', 'card_reviewed'
    required String mode,
    String? deckId,
    int? cardCount,
  }) async {
    await logEvent('study_session_$action', parameters: {
      'study_mode': mode,
      if (deckId != null) 'deck_id': deckId,
      if (cardCount != null) 'card_count': cardCount,
    });
  }
}
