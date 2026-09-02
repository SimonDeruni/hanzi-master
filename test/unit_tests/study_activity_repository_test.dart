import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/data/models/daily_deck_activity_model.dart';
import 'package:hanzi_master/features/flashcards/data/repositories/study_activity_repository_impl.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hive/hive.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory temporaryDirectory;
  late Box<DailyDeckActivityModel> box;
  late StudyActivityRepositoryImpl repository;

  setUp(() async {
    temporaryDirectory =
        await Directory.systemTemp.createTemp('activity-test-');
    Hive.init(temporaryDirectory.path);
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(DailyDeckActivityModelAdapter());
    }
    box = await Hive.openBox<DailyDeckActivityModel>('activity');
    repository = StudyActivityRepositoryImpl(box);
  });

  tearDown(() async {
    await Hive.close();
    await temporaryDirectory.delete(recursive: true);
  });

  Flashcard card(
    String id,
    DateTime now, {
    DateTime? introducedAt,
    DateTime? lastAttemptDate,
  }) {
    return Flashcard(
      id: id,
      deckId: 'deck-a',
      hanzi: '字',
      pinyin: 'zì',
      definition: id,
      hskLevel: 1,
      strokePaths: const [],
      modeStats: {
        StudyMode.reading: ReviewStats(
          nextReviewDate: now,
          interval: introducedAt == null ? 0 : 2,
          easeFactor: 2.5,
          streak: introducedAt == null ? 0 : 1,
          attempts: introducedAt == null ? 0 : 1,
          introducedAt: introducedAt,
          lastAttemptDate: lastAttemptDate,
        ),
      },
    );
  }

  test('round-trips activity through a reopened Hive box', () async {
    final now = DateTime(2026, 9, 1, 10);
    await repository.reserveQueue(
      deckId: 'deck-a',
      cards: [card('one', now)],
      mode: StudyMode.reading,
      now: now,
      dailyNewLimit: 1,
      dailyReviewLimit: 0,
    );

    await box.close();
    box = await Hive.openBox<DailyDeckActivityModel>('activity');
    repository = StudyActivityRepositoryImpl(box);
    final activity = await repository.activityForDay(
      deckId: 'deck-a',
      cards: const [],
      now: now,
    );

    expect(activity.introducedCardIds, {'one'});
    expect(activity.modeIntroductionKeys, {'reading:one'});
  });

  test('seeds first ledger from legacy card timestamps', () async {
    final now = DateTime(2026, 9, 1, 10);
    final activity = await repository.activityForDay(
      deckId: 'deck-a',
      cards: [
        card('introduced', now, introducedAt: DateTime(2026, 9, 1, 8)),
        card(
          'reviewed',
          now,
          introducedAt: DateTime(2026, 8, 1),
          lastAttemptDate: DateTime(2026, 9, 1, 9),
        ),
      ],
      now: now,
    );

    expect(activity.introducedCardIds, {'introduced'});
    expect(activity.reviewedCardIds, {'reviewed'});
    expect(activity.modeIntroductionKeys, {'reading:introduced'});
  });

  test('serializes concurrent reservations and enforces the shared limit',
      () async {
    final now = DateTime(2026, 9, 1, 10);
    final cards = [card('one', now), card('two', now), card('three', now)];

    final queues = await Future.wait([
      repository.reserveQueue(
        deckId: 'deck-a',
        cards: cards,
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 2,
        dailyReviewLimit: 0,
      ),
      repository.reserveQueue(
        deckId: 'deck-a',
        cards: cards,
        mode: StudyMode.reading,
        now: now,
        dailyNewLimit: 2,
        dailyReviewLimit: 0,
      ),
    ]);

    final reserved =
        queues.expand((queue) => queue.cards).map((card) => card.id);
    expect(reserved.toSet(), hasLength(2));
    expect(reserved.length, 2);
  });

  test('rolls allowance over at midnight and retains original deck activity',
      () async {
    final firstDay = DateTime(2026, 9, 1, 23, 59);
    final movedCard = card('one', firstDay);
    await repository.reserveQueue(
      deckId: 'deck-a',
      cards: [movedCard],
      mode: StudyMode.reading,
      now: firstDay,
      dailyNewLimit: 1,
      dailyReviewLimit: 0,
    );

    final nextDay = DateTime(2026, 9, 2, 0, 1);
    final nextQueue = await repository.reserveQueue(
      deckId: 'deck-b',
      cards: [movedCard.copyWith(deckId: 'deck-b')],
      mode: StudyMode.recall,
      now: nextDay,
      dailyNewLimit: 1,
      dailyReviewLimit: 0,
    );
    final originalActivity = await repository.activityForDay(
      deckId: 'deck-a',
      cards: const [],
      now: firstDay,
    );

    expect(nextQueue.cards.map((item) => item.id), ['one']);
    expect(originalActivity.introducedCardIds, {'one'});
  });
}
