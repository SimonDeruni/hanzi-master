import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/app_rating_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_session_summary.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late _FakeRatingPromptGateway gateway;
  late AppRatingService service;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    gateway = _FakeRatingPromptGateway();
    service = AppRatingService(gateway: gateway);
  });

  test('does not count a short or low-accuracy session', () async {
    expect(
      await service.registerCompletedSession(_summary(cards: 9, correct: 9)),
      RatingPromptResult.sessionNotEligible,
    );
    expect(
      await service.registerCompletedSession(_summary(cards: 10, correct: 7)),
      RatingPromptResult.sessionNotEligible,
    );
    expect(gateway.requestCount, 0);
  });

  test('requests a review after the third qualifying session', () async {
    expect(
      await service.registerCompletedSession(_summary()),
      RatingPromptResult.waitingForMoreSessions,
    );
    expect(
      await service.registerCompletedSession(_summary()),
      RatingPromptResult.waitingForMoreSessions,
    );
    expect(
      await service.registerCompletedSession(_summary()),
      RatingPromptResult.requested,
    );
    expect(gateway.requestCount, 1);
  });

  test('never requests a second time after recording a request', () async {
    for (var index = 0;
        index < AppRatingService.qualifyingSessionsRequired;
        index++) {
      await service.registerCompletedSession(_summary());
    }

    expect(
      await service.registerCompletedSession(_summary()),
      RatingPromptResult.alreadyRequested,
    );
    expect(gateway.requestCount, 1);
  });

  test('can try again later when the native prompt is unavailable', () async {
    gateway.available = false;
    for (var index = 0;
        index < AppRatingService.qualifyingSessionsRequired;
        index++) {
      await service.registerCompletedSession(_summary());
    }
    expect(gateway.requestCount, 0);

    gateway.available = true;
    expect(
      await service.registerCompletedSession(_summary()),
      RatingPromptResult.requested,
    );
    expect(gateway.requestCount, 1);
  });

  test('platform failures do not escape into the completion flow', () async {
    gateway.throwWhenCheckingAvailability = true;

    RatingPromptResult? result;
    for (var index = 0;
        index < AppRatingService.qualifyingSessionsRequired;
        index++) {
      result = await service.registerCompletedSession(_summary());
    }

    expect(result, RatingPromptResult.unavailable);
    expect(gateway.requestCount, 0);
  });

  test('openStoreListing calls gateway to open store page', () async {
    await service.openStoreListing();
    expect(gateway.openStoreCount, 1);
  });

  test('milestone eligibility succeeds on first hit and prevents duplicate prompts', () async {
    expect(await service.checkMilestoneEligibility('streak_3'), isTrue);
    // Second check of same milestone must be false
    expect(await service.checkMilestoneEligibility('streak_3'), isFalse);
  });

  test('milestone eligibility is blocked if already requested review', () async {
    await service.requestReview();
    expect(gateway.requestCount, 1);
    expect(await service.checkMilestoneEligibility('streak_7'), isFalse);
  });

  test('onDismissSentiment initiates cooldown', () async {
    expect(await service.shouldShowSentimentPrompt(), isTrue);
    await service.onDismissSentiment();
    expect(await service.shouldShowSentimentPrompt(), isFalse);
  });
}

StudySessionSummary _summary({int cards = 10, int correct = 8}) {
  final startedAt = DateTime(2026, 9, 3, 10);
  return StudySessionSummary(
    mode: StudyMode.reading,
    startedAt: startedAt,
    completedAt: startedAt.add(const Duration(minutes: 5)),
    uniqueCards: cards,
    totalAttempts: 10,
    correctAttempts: correct,
    newCards: 2,
    reviewCards: cards - 2,
    retryAttempts: 0,
    againCount: 0,
    hardCount: 2,
    goodCount: 6,
    easyCount: 2,
    needsPractice: 0,
  );
}

class _FakeRatingPromptGateway implements RatingPromptGateway {
  bool available = true;
  bool throwWhenCheckingAvailability = false;
  int requestCount = 0;
  int openStoreCount = 0;

  @override
  Future<bool> isAvailable() async {
    if (throwWhenCheckingAvailability) throw StateError('platform unavailable');
    return available;
  }

  @override
  Future<void> requestReview() async => requestCount++;

  @override
  Future<void> openStoreListing({String? appStoreId}) async =>
      openStoreCount++;
}
