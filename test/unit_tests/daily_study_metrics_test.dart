import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/daily_deck_activity.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/daily_study_metrics.dart';

import 'study_ahead_queue_builder_test.dart' show card;

void main() {
  test('combines persisted daily activity with due and forecast counts', () {
    final now = DateTime(2026, 9, 2, 18);
    final metrics = DailyStudyMetrics.calculate(
      cards: [
        card('due', DateTime(2026, 9, 2)),
        card('tomorrow', DateTime(2026, 9, 3)),
        card('later', DateTime(2026, 9, 5)),
      ],
      activity: const DailyDeckActivity(
        deckId: 'deck',
        dayKey: '2026-09-02',
        introducedCardIds: {'new'},
        reviewedCardIds: {'reviewed'},
      ),
      mode: StudyMode.reading,
      now: now,
    );

    expect(metrics.introducedToday, 1);
    expect(metrics.reviewedToday, 1);
    expect(metrics.dueNow, 1);
    expect(metrics.futureReviews, 2);
    expect(metrics.forecast[1], 1);
    expect(metrics.forecast[3], 1);
  });
}
