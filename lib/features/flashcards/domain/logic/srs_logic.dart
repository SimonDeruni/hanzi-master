import '../entities/flashcard.dart';

class SrsLogic {
  /// Calculates the new SRS scheduling stats for a card.
  /// Note: Attempts and Success counts are handled by the caller before passing here.
  static Flashcard reviewCard(Flashcard card, int rating) {
    int interval = card.interval;
    double easeFactor = card.easeFactor;
    int streak = card.streak;

    // 1. Calculate Streak and Interval based on rating (SM-2 simplified)
    if (rating >= 3) {
      if (streak == 0) {
        interval = 1;
      } else if (streak == 1) {
        interval = 6;
      } else {
        interval = (interval * easeFactor).round();
      }
      streak++;
    } else {
      // --- SOFT FAIL / LEECH PROTECTION ---
      if (streak > 5) {
        // Soft Fail: Mature cards only lose 50% of their interval
        interval = (interval * 0.5).round();
        if (interval < 1) interval = 1;
        // Reduce streak partially to allow for quicker recovery
        streak = (streak * 0.5).floor();
      } else {
        // Hard Fail: Reset for new cards or already struggling cards
        streak = 0;
        interval = 1;
      }
    }

    // 2. Adjust Ease Factor
    easeFactor = easeFactor + (0.1 - (5 - rating) * (0.08 + (5 - rating) * 0.02));
    if (easeFactor < 1.3) easeFactor = 1.3;

    // 3. Set next review date
    final nextReview = DateTime.now().add(Duration(days: interval));

    return card.copyWith(
      nextReviewDate: nextReview,
      interval: interval,
      easeFactor: easeFactor,
      streak: streak,
    );
  }
}