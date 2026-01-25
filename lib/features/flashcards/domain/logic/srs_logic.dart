import '../entities/flashcard.dart';

class SrsLogic {
  
  // This function takes a card + your rating (1-4) and calculates the NEW stats
  static Flashcard reviewCard(Flashcard card, int rating) {
    int newInterval;
    double newEaseFactor;
    int newStreak;

    // Rating Mapping:
    // 1 = Again (Fail)
    // 2 = Hard
    // 3 = Good
    // 4 = Easy

    if (rating == 1) {
      // If you failed, reset progress
      newInterval = 0;
      newStreak = 0;
      newEaseFactor = card.easeFactor; // Keep ease factor same
    } else {
      // If you passed (2, 3, or 4)
      
      // 1. Calculate new Interval (Days until next review)
      if (card.streak == 0) {
        newInterval = 1;
      } else if (card.streak == 1) {
        newInterval = 6;
      } else {
        newInterval = (card.interval * card.easeFactor).round();
      }

      // 2. Adjust Ease Factor (How strictly we grade this card)
      // The math below is the standard SM-2 formula
      newEaseFactor = card.easeFactor + (0.1 - (5 - rating) * (0.08 + (5 - rating) * 0.02));
      if (newEaseFactor < 1.3) newEaseFactor = 1.3; // Minimum limit

      newStreak = card.streak + 1;
    }

    // 3. Calculate the actual Date
    // If interval is 0 (Again), review it in 1 minute (effectively "now")
    // Otherwise, review it in X days.
    final now = DateTime.now();
    final nextReview = rating == 1 
        ? now.add(const Duration(minutes: 1)) 
        : now.add(Duration(days: newInterval));

    // Return the updated card with new stats
    return card.copyWith(
      nextReviewDate: nextReview,
      interval: newInterval,
      easeFactor: newEaseFactor,
      streak: newStreak,
    );
  }
}