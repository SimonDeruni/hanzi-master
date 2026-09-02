import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/study_ahead_queue_builder.dart';

Flashcard card(String id, DateTime due, {int attempts = 1}) => Flashcard(
      id: id,
      hanzi: '汉',
      pinyin: 'han',
      definition: id,
      hskLevel: 1,
      strokePaths: const [],
      modeStats: {
        StudyMode.reading: ReviewStats(
          nextReviewDate: due,
          interval: attempts == 0 ? 0 : 3,
          easeFactor: 2.5,
          streak: 1,
          attempts: attempts,
        ),
      },
    );

void main() {
  test('selects nearest future introduced reviews and respects limit', () {
    final now = DateTime(2026, 9, 2, 12);
    final result = StudyAheadQueueBuilder.build(
      cards: [
        card('later', DateTime(2026, 9, 5)),
        card('due', DateTime(2026, 9, 2)),
        card('new', DateTime(2026, 9, 3), attempts: 0),
        card('next', DateTime(2026, 9, 3)),
      ],
      mode: StudyMode.reading,
      now: now,
      limit: 1,
    );

    expect(result.map((card) => card.id), ['next']);
  });
}
