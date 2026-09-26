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
      // The Main Library also owns the cards saved without a deck
      // (`deckId == ''`), which `deck_detail_screen` and
      // `FlashcardController.getCardsForDeck` both accept. Omitting that fallback
      // made a deck's statistics disagree with the deck's own card list.
      final filtered = deckId != null
          ? cards
              .where((c) =>
                  c.deckId == deckId ||
                  (deckId == 'default' && c.deckId.isEmpty))
              .toList()
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

      int introducedThisWeek = 0;
      final List<WordInsight> insights = <WordInsight>[];

      for (final card in filtered) {
        // Word-level buckets: every mode is its own SRS track, so a word has
        // graduated once ANY track pushed it past the mastery threshold, and it
        // is "New Ink" only while no track has ever been attempted. Judging the
        // ring from Reading alone made a word with forty calligraphy attempts
        // read as new, while the retention card below counted every mode.
        bool cardMastered = false;
        bool cardTouched = false;

        int cardAttempts = 0;
        int cardSuccesses = 0;
        int cardInterval = 0;
        int cardStreak = 0;
        bool introducedRecently = false;

        for (final mode in StudyMode.values) {
          final s = card.getStatsForMode(mode);
          successCount += s.successCount;
          totalAttempts += s.attempts;
          modeSuccess[mode] = modeSuccess[mode]! + s.successCount;
          modeAttempts[mode] = modeAttempts[mode]! + s.attempts;

          if (s.attempts > 0) cardTouched = true;
          if (s.isMastered) cardMastered = true;

          cardAttempts += s.attempts;
          cardSuccesses += s.successCount;
          cardInterval = s.interval > cardInterval ? s.interval : cardInterval;
          cardStreak = s.streak > cardStreak ? s.streak : cardStreak;

          final DateTime? introduced = s.introducedAt;
          if (introduced != null && !introduced.isBefore(weekAgo)) {
            introducedRecently = true;
          }
        }

        if (cardMastered) {
          mastered++;
        } else if (cardTouched) {
          learned++;
        }

        if (introducedRecently) introducedThisWeek++;

        // The forecast counts REVIEW SLOTS — one per mode that is scheduled —
        // because that is what the week actually costs. Counting each word once
        // (by its earliest mode) turned "N Reviews" into a word count and hid two
        // thirds of a three-mode backlog.
        for (final mode in StudyMode.values) {
          final s = card.getStatsForMode(mode);
          if (s.attempts == 0) continue;
          final DateTime due = s.nextReviewDate;
          final int difference =
              DateTime(due.year, due.month, due.day).difference(today).inDays;
          // Beyond the seven-day window: not this week's problem.
          if (difference >= 7) continue;
          // Anything already past due lands in today's bar, which is also the
          // headline figure.
          upcomingReviews[difference < 0 ? 0 : difference]++;
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

      // The words worth looking at: the ones that keep costing the most (most
      // failed attempts, then the shakiest rate) and the ones that graduated
      // (longest interval, then longest streak).
      final List<WordInsight> tricky = List<WordInsight>.from(insights)
        ..sort((a, b) {
          final int byFailures = b.failures.compareTo(a.failures);
          if (byFailures != 0) return byFailures;
          final int byAccuracy = a.accuracy.compareTo(b.accuracy);
          if (byAccuracy != 0) return byAccuracy;
          return b.attempts.compareTo(a.attempts);
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
        // The headline is the first bar of the same forecast, so the number and
        // the chart can never tell two different stories.
        dueToday: upcomingReviews.first,
        nextSevenDays:
            upcomingReviews.fold<int>(0, (int sum, int day) => sum + day),
        introducedThisWeek: introducedThisWeek,
        totalReviews: totalAttempts,
        // Per practised word: dividing by the whole deck made an untouched
        // library look effortless.
        averageAttempts: insights.isEmpty ? 0 : totalAttempts / insights.length,
        trickyWords: tricky.take(5).toList(),
        strongestWords: strongest.take(5).toList(),
      );
    },
    orElse: () => StatsState.empty(),
  );
}
