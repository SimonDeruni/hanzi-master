import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/study_queue_builder.dart';

void main() {
  final now = DateTime(2026, 8, 24, 12);

  ReviewStats stats({
    int attempts = 0,
    int interval = 0,
    DateTime? due,
    DateTime? introducedAt,
    DateTime? lastAttemptDate,
  }) {
    return ReviewStats(
      nextReviewDate: due ?? now,
      interval: interval,
      easeFactor: 2.5,
      streak: attempts == 0 ? 0 : 1,
      attempts: attempts,
      introducedAt: introducedAt,
      lastAttemptDate: lastAttemptDate,
    );
  }

  Flashcard card(
    String id,
    ReviewStats reading, {
    ReviewStats? recall,
  }) {
    return Flashcard(
      id: id,
      deckId: 'deck',
      hanzi: id,
      pinyin: '',
      definition: '',
      hskLevel: 1,
      strokePaths: const [],
      modeStats: {
        StudyMode.reading: reading,
        if (recall != null) StudyMode.recall: recall,
      },
    );
  }

  List<String> ids(StudyQueue queue) =>
      queue.cards.map((item) => item.id).toList();

  group('StudyQueueBuilder', () {
    test('prioritizes learning and sorts other reviews oldest first', () {
      final queue = StudyQueueBuilder.build(
        cards: [
          card('recent', stats(attempts: 1, interval: 5, due: now)),
          card(
              'oldest',
              stats(
                  attempts: 1,
                  interval: 5,
                  due: now.subtract(const Duration(days: 4)))),
          card('learning', stats(attempts: 1, interval: 0, due: now)),
        ],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 0,
        dailyReviewLimit: 10,
      );

      expect(ids(queue), ['learning', 'oldest', 'recent']);
    });

    test('uses calendar-day due checks and excludes tomorrow', () {
      final queue = StudyQueueBuilder.build(
        cards: [
          card(
              'later-today',
              stats(
                  attempts: 1,
                  interval: 5,
                  due: DateTime(2026, 8, 24, 23, 59))),
          card('tomorrow',
              stats(attempts: 1, interval: 5, due: DateTime(2026, 8, 25))),
        ],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 0,
        dailyReviewLimit: 10,
      );

      expect(ids(queue), ['later-today']);
    });

    test('enforces remaining review quota across sessions', () {
      final queue = StudyQueueBuilder.build(
        cards: [
          card(
              'reviewed',
              stats(
                attempts: 2,
                interval: 5,
                due: now.subtract(const Duration(days: 4)),
                lastAttemptDate: DateTime(2026, 8, 24, 8),
              )),
          card('due-1', stats(attempts: 1, interval: 5, due: now)),
          card('due-2', stats(attempts: 1, interval: 5, due: now)),
        ],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 0,
        dailyReviewLimit: 2,
      );

      expect(queue.dueCount, 1);
      expect(ids(queue), ['due-1']);
    });

    test('learning cards remain eligible when review limit is zero', () {
      final queue = StudyQueueBuilder.build(
        cards: [
          card('learning', stats(attempts: 1, interval: 0, due: now)),
          card('review', stats(attempts: 1, interval: 5, due: now)),
        ],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 0,
        dailyReviewLimit: 0,
      );

      expect(ids(queue), ['learning']);
    });

    test('shares unique new-card quota across modes and sessions', () {
      final introduced = DateTime(2026, 8, 24, 9);
      final queue = StudyQueueBuilder.build(
        cards: [
          card('shared', stats(introducedAt: introduced), recall: stats()),
          card('new-1', stats(), recall: stats()),
          card('new-2', stats(), recall: stats()),
        ],
        mode: StudyMode.recall,
        now: now,
        dailyNewLimit: 2,
        dailyReviewLimit: 0,
      );

      expect(ids(queue), ['shared', 'new-1']);
      expect(queue.cardIdsToIntroduce, {'shared', 'new-1'});
    });

    test('resets new-card allowance on the next calendar day', () {
      final queue = StudyQueueBuilder.build(
        cards: [
          card('old', stats(introducedAt: DateTime(2026, 8, 23, 23, 59))),
          card('new', stats()),
        ],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 1,
        dailyReviewLimit: 0,
      );

      expect(ids(queue), ['old']);
      expect(queue.cardIdsToIntroduce, {'old'});
    });

    test('zero disables new cards and negative one is unlimited', () {
      final cards = [card('one', stats()), card('two', stats())];

      final disabled = StudyQueueBuilder.build(
        cards: cards,
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 0,
        dailyReviewLimit: 0,
      );
      final unlimited = StudyQueueBuilder.build(
        cards: cards,
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: -1,
        dailyReviewLimit: 0,
      );

      expect(disabled.cards, isEmpty);
      expect(ids(unlimited), ['one', 'two']);
    });

    test('interleaves new cards through reviews', () {
      final queue = StudyQueueBuilder.build(
        cards: [
          card('review-1', stats(attempts: 1, interval: 5, due: now)),
          card('review-2', stats(attempts: 1, interval: 5, due: now)),
          card('new-1', stats()),
          card('new-2', stats()),
        ],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 2,
        dailyReviewLimit: 2,
      );

      expect(ids(queue), ['review-1', 'new-1', 'review-2', 'new-2']);
    });

    test('reports queue composition and a daily-limit empty reason', () {
      final mixed = StudyQueueBuilder.build(
        cards: [
          card('learning', stats(attempts: 1, interval: 0, due: now)),
          card('review', stats(attempts: 1, interval: 5, due: now)),
          card('new', stats()),
        ],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 1,
        dailyReviewLimit: 1,
      );
      expect(mixed.learningCount, 1);
      expect(mixed.dueCount, 1);
      expect(mixed.newCount, 1);

      final limited = StudyQueueBuilder.build(
        cards: [card('new', stats())],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 1,
        dailyReviewLimit: 0,
        introducedCardIds: const {'already-used'},
      );
      expect(limited.cards, isEmpty);
      expect(limited.emptyReason, StudyQueueEmptyReason.dailyLimitReached);
    });

    test('reports caught up and the earliest future review', () {
      final tomorrow = DateTime(2026, 8, 25, 8);
      final later = DateTime(2026, 8, 26, 8);
      final queue = StudyQueueBuilder.build(
        cards: [
          card('later', stats(attempts: 1, interval: 5, due: later)),
          card('tomorrow', stats(attempts: 1, interval: 5, due: tomorrow)),
        ],
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 0,
        dailyReviewLimit: 10,
      );

      expect(queue.emptyReason, StudyQueueEmptyReason.caughtUp);
      expect(queue.nextReviewDate, tomorrow);
    });
  });
}
