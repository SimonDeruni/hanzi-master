import 'dart:async';

import 'package:hive/hive.dart';

import '../../domain/entities/daily_deck_activity.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/entities/study_mode.dart';
import '../../domain/logic/study_queue_builder.dart';
import '../../domain/repositories/study_activity_repository.dart';
import '../models/daily_deck_activity_model.dart';

class StudyActivityRepositoryImpl implements StudyActivityRepository {
  StudyActivityRepositoryImpl(this._box);

  final Box<DailyDeckActivityModel> _box;

  // Hive operations are atomic individually, but queue reservation is a
  // read/compute/write transaction. Serialize those transactions in-process.
  static Future<void> _transactionTail = Future<void>.value();

  static String dayKey(DateTime value) {
    final local = value.toLocal();
    String two(int part) => part.toString().padLeft(2, '0');
    return '${local.year}-${two(local.month)}-${two(local.day)}'
        '@${local.timeZoneOffset.inMinutes}';
  }

  String _key(String deckId, DateTime now) => '$deckId|${dayKey(now)}';

  Future<T> _transaction<T>(Future<T> Function() action) async {
    final previous = _transactionTail;
    final gate = Completer<void>();
    _transactionTail = gate.future;
    await previous;
    try {
      return await action();
    } finally {
      gate.complete();
    }
  }

  DailyDeckActivityModel _legacyActivity(
    String deckId,
    List<Flashcard> cards,
    DateTime now,
  ) {
    final localNow = now.toLocal();
    final start = DateTime(localNow.year, localNow.month, localNow.day);
    final end = DateTime(localNow.year, localNow.month, localNow.day + 1);
    bool isToday(DateTime? value) =>
        value != null && !value.isBefore(start) && value.isBefore(end);

    final introduced = cards
        .where((card) => card.modeStats.values.any(
              (stats) => isToday(stats.introducedAt),
            ))
        .map((card) => card.id)
        .toSet();
    final reviewed = cards
        .where((card) =>
            !introduced.contains(card.id) &&
            card.modeStats.values.any(
              (stats) => isToday(stats.lastAttemptDate),
            ))
        .map((card) => card.id)
        .toSet();
    final modeKeys = <String>{};
    for (final card in cards) {
      for (final entry in card.modeStats.entries) {
        if (isToday(entry.value.introducedAt)) {
          modeKeys.add('${entry.key.name}:${card.id}');
        }
      }
    }

    return DailyDeckActivityModel(
      deckId: deckId,
      dayKey: dayKey(now),
      introducedCardIds: introduced.toList()..sort(),
      reviewedCardIds: reviewed.toList()..sort(),
      modeIntroductionKeys: modeKeys.toList()..sort(),
      updatedAt: now,
    );
  }

  Future<DailyDeckActivityModel> _loadOrSeed(
    String deckId,
    List<Flashcard> cards,
    DateTime now,
  ) async {
    final key = _key(deckId, now);
    final existing = _box.get(key);
    if (existing != null) return existing;
    final seeded = _legacyActivity(deckId, cards, now);
    await _box.put(key, seeded);
    return seeded;
  }

  @override
  Future<DailyDeckActivity> activityForDay({
    required String deckId,
    required List<Flashcard> cards,
    required DateTime now,
  }) {
    return _transaction(() async {
      return (await _loadOrSeed(deckId, cards, now)).toEntity();
    });
  }

  @override
  Future<StudyQueue> reserveQueue({
    required String deckId,
    required List<Flashcard> cards,
    required StudyMode mode,
    required DateTime now,
    required int dailyNewLimit,
    required int dailyReviewLimit,
  }) {
    return _transaction(() async {
      final activity = await _loadOrSeed(deckId, cards, now);
      final queue = StudyQueueBuilder.build(
        cards: cards,
        mode: mode,
        now: now,
        dailyNewLimit: dailyNewLimit,
        dailyReviewLimit: dailyReviewLimit,
        introducedCardIds: activity.introducedCardIds.toSet(),
        reviewedCardIds: activity.reviewedCardIds.toSet(),
        modeIntroducedCardIds: activity.modeIntroductionKeys
            .where((key) => key.startsWith('${mode.name}:'))
            .map((key) => key.substring(mode.name.length + 1))
            .toSet(),
      );

      final introduced = activity.introducedCardIds.toSet()
        ..addAll(queue.newlyReservedCardIds);
      final reviewed = activity.reviewedCardIds.toSet()
        ..addAll(queue.reviewCardIdsToReserve);
      final modeKeys = activity.modeIntroductionKeys.toSet()
        ..addAll(queue.cardIdsToIntroduce.map((id) => '${mode.name}:$id'));
      await _box.put(
        _key(deckId, now),
        DailyDeckActivityModel(
          deckId: deckId,
          dayKey: dayKey(now),
          introducedCardIds: introduced.toList()..sort(),
          reviewedCardIds: reviewed.toList()..sort(),
          modeIntroductionKeys: modeKeys.toList()..sort(),
          updatedAt: now,
        ),
      );
      return queue;
    });
  }

  @override
  Future<void> recordReview({
    required String deckId,
    required String cardId,
    required DateTime reviewedAt,
  }) {
    return _transaction(() async {
      final key = _key(deckId, reviewedAt);
      final existing = _box.get(key);
      final reviewed = existing?.reviewedCardIds.toSet() ?? <String>{};
      if (!reviewed.add(cardId)) return;
      await _box.put(
        key,
        DailyDeckActivityModel(
          deckId: deckId,
          dayKey: dayKey(reviewedAt),
          introducedCardIds: existing?.introducedCardIds ?? const [],
          reviewedCardIds: reviewed.toList()..sort(),
          modeIntroductionKeys: existing?.modeIntroductionKeys ?? const [],
          updatedAt: reviewedAt,
        ),
      );
    });
  }
}
