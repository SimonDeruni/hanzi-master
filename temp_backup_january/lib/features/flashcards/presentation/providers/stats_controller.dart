import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'flashcard_controller.dart';

// 1. THE DATA CLASS
class StudyStats {
  final int totalCards;
  final int learnedCards; // Cards with interval > 3 days
  final int masteredCards; // Cards with interval > 21 days
  final int dueToday;
  final double retentionRate; // Average ease factor

  StudyStats({
    required this.totalCards,
    required this.learnedCards,
    required this.masteredCards,
    required this.dueToday,
    required this.retentionRate,
  });
}

// 2. THE PROVIDER
final statsProvider = Provider<AsyncValue<StudyStats>>((ref) {
  final cardsAsync = ref.watch(flashcardControllerProvider);

  return cardsAsync.whenData((cards) {
    if (cards.isEmpty) {
      return StudyStats(totalCards: 0, learnedCards: 0, masteredCards: 0, dueToday: 0, retentionRate: 0);
    }

    int learned = 0;
    int mastered = 0;
    int due = 0;
    double totalEase = 0;

    final now = DateTime.now();

    for (var card in cards) {
      if (card.isLearning) learned++;
      if (card.isMastered) mastered++;
      if (card.nextReviewDate.isBefore(now)) due++;
      totalEase += card.easeFactor;
    }

    // Convert Ease Factor (2.5) to a percentage-like score (e.g. 85%)
    // Base ease is 2.5. Let's say 1.3 is failing (50%) and 3.0 is perfect (100%).
    // Simple math: (AvgEase / 3.0) * 100
    double avgEase = totalEase / cards.length;
    double retention = (avgEase / 2.5) * 100;
    if (retention > 100) retention = 100;

    return StudyStats(
      totalCards: cards.length,
      learnedCards: learned,
      masteredCards: mastered,
      dueToday: due,
      retentionRate: retention,
    );
  });
});