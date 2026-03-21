import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'flashcard_controller.dart';
import 'stats_state.dart';

part 'stats_controller.g.dart';

@riverpod
StatsState userStats(UserStatsRef ref) {
  final cardsAsync = ref.watch(flashcardControllerProvider);
  
  return cardsAsync.maybeWhen(
    data: (cards) {
      int total = cards.length;
      int mastered = 0;
      int learned = 0;
      int successCount = 0;
      int totalAttempts = 0;

      for (var card in cards) {
        if (card.isMastered) {
          mastered++;
        } else if (card.isLearning) {
          learned++;
        }
        successCount += card.successCount;
        totalAttempts += card.attempts;
      }

      double overallAccuracy = totalAttempts > 0 
          ? (successCount / totalAttempts) * 100 
          : 0.0;

      return StatsState(
        total: total,
        mastered: mastered,
        learning: learned,
        newCards: (total - mastered - learned).toInt(),
        accuracy: overallAccuracy,
      );
    },
    orElse: () => StatsState.empty(),
  );
}
