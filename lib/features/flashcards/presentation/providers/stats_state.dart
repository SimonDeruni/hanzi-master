import 'package:equatable/equatable.dart';
import '../../domain/entities/study_mode.dart';

/// One word's performance, kept light so the stats screen can list the words a
/// learner actually needs to see (the hardest and the most durable) without
/// dragging whole flashcards through the widget tree.
class WordInsight extends Equatable {
  const WordInsight({
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    required this.attempts,
    required this.successes,
    required this.intervalDays,
    required this.streak,
  });

  final String hanzi;
  final String pinyin;
  final String definition;
  final int attempts;
  final int successes;
  final int intervalDays;
  final int streak;

  /// 0..1 across every mode this word has been practised in.
  double get accuracy => attempts == 0 ? 0 : successes / attempts;

  @override
  List<Object?> get props => [
        hanzi,
        pinyin,
        definition,
        attempts,
        successes,
        intervalDays,
        streak,
      ];
}

class StatsState extends Equatable {
  final int total;
  final int mastered;
  final int learning;
  final int newCards;
  final double accuracy;
  final Map<StudyMode, double> accuracyByMode;
  final List<int> upcomingReviews;

  // ── Deck insight (all derived from the cards that are already loaded) ──────
  /// How many words have been practised in each mode, so a bar can be honest
  /// about "you have never tried this one".
  final Map<StudyMode, int> attemptsByMode;

  /// Words whose next review falls today or earlier.
  final int dueToday;

  /// Sum of the seven-day forecast in [upcomingReviews].
  final int nextSevenDays;

  /// Words first introduced in the last seven days (`introducedAt`).
  final int introducedThisWeek;

  /// Words whose most recent attempt (any mode) was in the last seven days.
  final int reviewedThisWeek;

  /// Total graded attempts across every word and mode.
  final int totalReviews;

  /// Mean attempts per word — how much work each character has needed.
  final double averageAttempts;

  /// The longest interval any word has reached, in days.
  final int longestIntervalDays;

  /// Words that keep costing the most (most attempts, lowest accuracy first).
  final List<WordInsight> trickyWords;

  /// Words that have held up the longest (interval, then streak).
  final List<WordInsight> strongestWords;

  const StatsState({
    required this.total,
    required this.mastered,
    required this.learning,
    required this.newCards,
    required this.accuracy,
    required this.accuracyByMode,
    required this.upcomingReviews,
    this.attemptsByMode = const <StudyMode, int>{},
    this.dueToday = 0,
    this.nextSevenDays = 0,
    this.introducedThisWeek = 0,
    this.reviewedThisWeek = 0,
    this.totalReviews = 0,
    this.averageAttempts = 0,
    this.longestIntervalDays = 0,
    this.trickyWords = const <WordInsight>[],
    this.strongestWords = const <WordInsight>[],
  });

  /// Share of the deck that has graduated to long-term memory (0..1).
  double get masteryRatio => total == 0 ? 0 : mastered / total;

  factory StatsState.empty() {
    return const StatsState(
      total: 0,
      mastered: 0,
      learning: 0,
      newCards: 0,
      accuracy: 0.0,
      accuracyByMode: {},
      upcomingReviews: [0, 0, 0, 0, 0, 0, 0],
    );
  }

  @override
  List<Object?> get props => [
        total,
        mastered,
        learning,
        newCards,
        accuracy,
        accuracyByMode,
        upcomingReviews,
        attemptsByMode,
        dueToday,
        nextSevenDays,
        introducedThisWeek,
        reviewedThisWeek,
        totalReviews,
        averageAttempts,
        longestIntervalDays,
        trickyWords,
        strongestWords,
      ];
}
