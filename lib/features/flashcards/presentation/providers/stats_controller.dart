import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/study_mode.dart';
import 'flashcard_controller.dart';
import 'stats_state.dart';

part 'stats_controller.g.dart';

@riverpod
StatsState userStats(UserStatsRef ref, {String? deckId}) {
  final cardsAsync = ref.watch(flashcardControllerProvider);

  return cardsAsync.maybeWhen(
    data: (cards) {
      final filtered = deckId != null
          ? cards.where((c) => c.deckId == deckId).toList()
          : cards;
      final int total = filtered.length;
      int mastered = 0;
      int learned = 0;
      int successCount = 0;
      int totalAttempts = 0;

      final Map<StudyMode, int> modeSuccess = {
        for (var e in StudyMode.values) e: 0
      };
      final Map<StudyMode, int> modeAttempts = {
        for (var e in StudyMode.values) e: 0
      };
      final List<int> upcomingReviews = List.filled(7, 0);

      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime weekAgo = today.subtract(const Duration(days: 6));

      int dueToday = 0;
      int introducedThisWeek = 0;
      int reviewedThisWeek = 0;
      int longestInterval = 0;
      final List<WordInsight> insights = <WordInsight>[];

      for (final card in filtered) {
        if (card.isMastered(StudyMode.reading)) {
          mastered++;
        } else if (card.isLearning(StudyMode.reading)) {
          learned++;
        }

        int cardAttempts = 0;
        int cardSuccesses = 0;
        int cardInterval = 0;
        int cardStreak = 0;
        bool introducedRecently = false;
        bool practisedRecently = false;

        for (final mode in StudyMode.values) {
          final s = card.getStatsForMode(mode);
          successCount += s.successCount;
          totalAttempts += s.attempts;
          modeSuccess[mode] = modeSuccess[mode]! + s.successCount;
          modeAttempts[mode] = modeAttempts[mode]! + s.attempts;

          cardAttempts += s.attempts;
          cardSuccesses += s.successCount;
          cardInterval = s.interval > cardInterval ? s.interval : cardInterval;
          cardStreak = s.streak > cardStreak ? s.streak : cardStreak;

          final DateTime? introduced = s.introducedAt;
          if (introduced != null && !introduced.isBefore(weekAgo)) {
            introducedRecently = true;
          }
          final DateTime? attempted = s.lastAttemptDate;
          if (attempted != null && !attempted.isBefore(weekAgo)) {
            practisedRecently = true;
          }
        }

        if (introducedRecently) introducedThisWeek++;
        if (practisedRecently) reviewedThisWeek++;
        if (cardInterval > longestInterval) longestInterval = cardInterval;

        // The nearest review across modes decides the word's workload slot.
        DateTime? earliestNextReview;
        bool dueNow = false;
        for (final mode in StudyMode.values) {
          final s = card.getStatsForMode(mode);
          if (s.attempts == 0) continue;
          if (earliestNextReview == null ||
              s.nextReviewDate.isBefore(earliestNextReview)) {
            earliestNextReview = s.nextReviewDate;
          }
          if (s.isDueAt(now)) dueNow = true;
        }
        if (dueNow) dueToday++;

        if (earliestNextReview != null) {
          final reviewDay = DateTime(earliestNextReview.year,
              earliestNextReview.month, earliestNextReview.day);
          final difference = reviewDay.difference(today).inDays;
          if (difference >= 0 && difference < 7) {
            upcomingReviews[difference]++;
          } else if (difference < 0) {
            // Due before today? Count as today
            upcomingReviews[0]++;
          }
        }

        if (cardAttempts > 0) {
          insights.add(WordInsight(
            hanzi: card.hanzi,
            pinyin: card.pinyin,
            definition: card.definition,
            attempts: cardAttempts,
            successes: cardSuccesses,
            intervalDays: cardInterval,
            streak: cardStreak,
          ));
        }
      }

      final double overallAccuracy =
          totalAttempts > 0 ? (successCount / totalAttempts) * 100 : 0.0;

      final Map<StudyMode, double> accuracyByMode = {};
      for (final mode in StudyMode.values) {
        accuracyByMode[mode] = modeAttempts[mode]! > 0
            ? (modeSuccess[mode]! / modeAttempts[mode]!) * 100
            : 0.0;
      }

      // The words worth looking at: the ones that keep resisting (many attempts,
      // low success) and the ones that graduated (long interval, long streak).
      final List<WordInsight> tricky = List<WordInsight>.from(insights)
        ..sort((a, b) {
          final int byAttempts = b.attempts.compareTo(a.attempts);
          if (byAttempts != 0) return byAttempts;
          return a.accuracy.compareTo(b.accuracy);
        });
      final List<WordInsight> strongest = List<WordInsight>.from(
        insights.where((WordInsight w) => w.intervalDays > 0),
      )..sort((a, b) {
          final int byInterval = b.intervalDays.compareTo(a.intervalDays);
          if (byInterval != 0) return byInterval;
          return b.streak.compareTo(a.streak);
        });

      return StatsState(
        total: total,
        mastered: mastered,
        learning: learned,
        newCards: (total - mastered - learned).toInt(),
        accuracy: overallAccuracy,
        accuracyByMode: accuracyByMode,
        upcomingReviews: upcomingReviews,
        attemptsByMode: modeAttempts,
        dueToday: dueToday,
        nextSevenDays:
            upcomingReviews.fold<int>(0, (int sum, int day) => sum + day),
        introducedThisWeek: introducedThisWeek,
        reviewedThisWeek: reviewedThisWeek,
        totalReviews: totalAttempts,
        averageAttempts: total > 0 ? totalAttempts / total : 0,
        longestIntervalDays: longestInterval,
        trickyWords: tricky.take(5).toList(),
        strongestWords: strongest.take(5).toList(),
      );
    },
    orElse: () => StatsState.empty(),
  );
}
