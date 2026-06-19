import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/study_mode.dart';
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
      
      Map<StudyMode, int> modeSuccess = { for (var e in StudyMode.values) e : 0 };
      Map<StudyMode, int> modeAttempts = { for (var e in StudyMode.values) e : 0 };
      List<int> upcomingReviews = List.filled(7, 0);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      for (var card in cards) {
        if (card.isMastered(StudyMode.reading)) {
          mastered++;
        } else if (card.isLearning(StudyMode.reading)) {
          learned++;
        }
        
        for (final mode in StudyMode.values) {
          final s = card.getStatsForMode(mode);
          successCount += s.successCount;
          totalAttempts += s.attempts;
          modeSuccess[mode] = modeSuccess[mode]! + s.successCount;
          modeAttempts[mode] = modeAttempts[mode]! + s.attempts;
        }

        // Calculate upcoming reviews (only using reading mode's next review date for simplicity, or the earliest across modes)
        DateTime? earliestNextReview;
        for (final mode in StudyMode.values) {
          final s = card.getStatsForMode(mode);
          if (earliestNextReview == null || s.nextReviewDate.isBefore(earliestNextReview)) {
            earliestNextReview = s.nextReviewDate;
          }
        }
        
        if (earliestNextReview != null) {
            final reviewDay = DateTime(earliestNextReview.year, earliestNextReview.month, earliestNextReview.day);
            final difference = reviewDay.difference(today).inDays;
            if (difference >= 0 && difference < 7) {
                upcomingReviews[difference]++;
            } else if (difference < 0) {
                // Due before today? Count as today
                upcomingReviews[0]++;
            }
        }
      }

      double overallAccuracy = totalAttempts > 0 
          ? (successCount / totalAttempts) * 100 
          : 0.0;

      Map<StudyMode, double> accuracyByMode = {};
      for (final mode in StudyMode.values) {
        accuracyByMode[mode] = modeAttempts[mode]! > 0 
            ? (modeSuccess[mode]! / modeAttempts[mode]!) * 100 
            : 0.0;
      }

      return StatsState(
        total: total,
        mastered: mastered,
        learning: learned,
        newCards: (total - mastered - learned).toInt(),
        accuracy: overallAccuracy,
        accuracyByMode: accuracyByMode,
        upcomingReviews: upcomingReviews,
      );
    },
    orElse: () => StatsState.empty(),
  );
}
