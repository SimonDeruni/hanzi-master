import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/stats_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/stats_state.dart';

/// Builds a card whose reading stats are what the assertions describe.
Flashcard _card({
  required String hanzi,
  String deckId = 'hsk1',
  int attempts = 0,
  int successes = 0,
  int interval = 0,
  int streak = 0,
  DateTime? lastAttempt,
  DateTime? introduced,
  Map<StudyMode, ReviewStats>? extraModes,
}) {
  final ReviewStats reading = ReviewStats(
    nextReviewDate: DateTime.now(),
    interval: interval,
    easeFactor: 2.5,
    streak: streak,
    attempts: attempts,
    successCount: successes,
    lastAttemptDate: lastAttempt,
    introducedAt: introduced,
  );
  return Flashcard(
    id: 'card-$hanzi',
    deckId: deckId,
    hanzi: hanzi,
    pinyin: 'pin',
    definition: 'def',
    hskLevel: 1,
    strokePaths: const <String>[],
    modeStats: <StudyMode, ReviewStats>{
      StudyMode.reading: reading,
      ...?extraModes,
    },
  );
}

class _FakeFlashcardController extends FlashcardController {
  _FakeFlashcardController(this.cards);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;
}

ProviderContainer _containerWith(List<Flashcard> cards) {
  final ProviderContainer container = ProviderContainer(
    overrides: <Override>[
      flashcardControllerProvider
          .overrideWith(() => _FakeFlashcardController(cards)),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('userStats deck insight', () {
    test('scopes every number to the deck and counts the week', () async {
      final DateTime today = DateTime.now();
      final DateTime twoDaysAgo = today.subtract(const Duration(days: 2));

      final ProviderContainer container = _containerWith(<Flashcard>[
        // Practised hard and often, recently introduced.
        _card(
          hanzi: '难',
          attempts: 9,
          successes: 2,
          interval: 3,
          streak: 1,
          lastAttempt: twoDaysAgo,
          introduced: twoDaysAgo,
          extraModes: <StudyMode, ReviewStats>{
            StudyMode.speaking: ReviewStats(
              nextReviewDate: today,
              interval: 2,
              easeFactor: 2.5,
              streak: 1,
              attempts: 6,
              successCount: 5,
              lastAttemptDate: twoDaysAgo,
              introducedAt: twoDaysAgo,
            ),
          },
        ),
        // Graduated long ago.
        _card(
          hanzi: '易',
          attempts: 6,
          successes: 6,
          interval: 40,
          streak: 7,
          lastAttempt: today.subtract(const Duration(days: 30)),
          introduced: today.subtract(const Duration(days: 60)),
        ),
        // Never touched.
        _card(hanzi: '新'),
        // Different deck: must not leak in.
        _card(hanzi: '别', deckId: 'hsk2', attempts: 4, successes: 1),
      ]);

      // The controller's cards arrive asynchronously; wait for them, or the
      // provider reports the empty state.
      await container.read(flashcardControllerProvider.future);

      final StatsState stats =
          container.read(userStatsProvider(deckId: 'hsk1'));

      expect(stats.total, 3);
      expect(stats.totalReviews, 21); // 9 reading + 6 speaking + 6 reading
      expect(stats.introducedThisWeek, 1);
      // Only 难 was touched in the last seven days: 易 graduated a month ago.
      expect(stats.reviewedThisWeek, 1);
      expect(stats.longestIntervalDays, 40);
      expect(stats.averageAttempts, closeTo(7.0, 0.01));

      // Retention is per mode, not per card: the modes differ wildly here.
      expect(stats.accuracyByMode[StudyMode.reading],
          closeTo((8 / 15) * 100, 0.01));
      expect(
          stats.accuracyByMode[StudyMode.speaking], closeTo(5 / 6 * 100, 0.01));
      // A mode nobody has practised reports zero attempts, so the UI can say so.
      expect(stats.attemptsByMode[StudyMode.listening], 0);

      // "Tricky" is sorted by attempts, so the expensive word leads even though
      // it is not the least accurate one.
      expect(stats.trickyWords.first.hanzi, '难');
      expect(stats.trickyWords.first.accuracy, closeTo(7 / 15, 0.01));
      // "Strongest" lists only words that graduated (interval > 0), longest
      // interval first: 易 at 40 days, then 难 at 3.
      expect(stats.strongestWords.first.hanzi, '易');
      expect(stats.strongestWords.first.intervalDays, 40);
      expect(
        stats.strongestWords.map((WordInsight w) => w.hanzi).toList(),
        <String>['易', '难'],
      );
      // The untouched card never shows up in either list.
      for (final WordInsight word in stats.trickyWords) {
        expect(word.hanzi, isNot('新'));
      }
    });

    test('an empty deck reports zeros instead of throwing', () async {
      final ProviderContainer container = _containerWith(<Flashcard>[]);
      await container.read(flashcardControllerProvider.future);
      final StatsState stats =
          container.read(userStatsProvider(deckId: 'hsk1'));

      expect(stats.total, 0);
      expect(stats.masteryRatio, 0);
      expect(stats.trickyWords, isEmpty);
      expect(stats.strongestWords, isEmpty);
      expect(stats.upcomingReviews.length, 7);
    });
  });
}
