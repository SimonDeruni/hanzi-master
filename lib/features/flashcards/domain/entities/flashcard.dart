import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'review_stats.dart';
import 'study_mode.dart';

class Flashcard extends Equatable {
  final String id;
  final String deckId;
  final String hanzi;
  final String pinyin;
  final String definition;
  final int hskLevel;
  final List<String> strokePaths;
  final List<List<Offset>> medianPaths;
  final bool isFlipped;

  // --- Mode Specific SRS Stats ---
  final Map<StudyMode, ReviewStats> modeStats;

  // --- Global Metadata ---
  final int inkPoints; // 🖌️ XP System

  const Flashcard({
    required this.id,
    this.deckId = 'default',
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    required this.hskLevel,
    required this.strokePaths,
    this.medianPaths = const [],
    this.isFlipped = false,
    required this.modeStats,
    this.inkPoints = 0,
  });

  @override
  List<Object?> get props => [
    id, deckId, hanzi, pinyin, definition, hskLevel, strokePaths, medianPaths, 
    isFlipped, modeStats, inkPoints
  ];

  // --- Helpers for UI ---
  ReviewStats getStatsForMode(StudyMode mode) {
    return modeStats[mode] ?? ReviewStats.initial();
  }

  bool isMastered(StudyMode mode) => getStatsForMode(mode).isMastered;
  bool isNew(StudyMode mode) => getStatsForMode(mode).isNew;
  bool isLearning(StudyMode mode) => getStatsForMode(mode).isLearning;
  bool isDue(StudyMode mode) => getStatsForMode(mode).isDue;

  /// Returns a normalized mastery level from 0.0 to 1.0 based on the current streak for a mode.
  double masteryLevel(StudyMode mode) => getStatsForMode(mode).masteryLevel;

  /// Applies the SuperMemo-2 (SM-2) algorithm.
  /// Expected grades: 0 (Again), 2 (Hard), 4 (Good), 5 (Easy)
  Flashcard processReview(int grade, StudyMode mode) {
    final stats = getStatsForMode(mode);
    
    int newStreak;
    int newInterval;
    
    // SM-2 formula for ease factor
    double newEase = stats.easeFactor + (0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02));
    if (newEase < 1.3) newEase = 1.3;

    if (grade >= 3) {
      newStreak = stats.streak + 1;
      if (newStreak == 1) {
        newInterval = 1;
      } else if (newStreak == 2) {
        newInterval = 6;
      } else {
        newInterval = (stats.interval * newEase).round();
      }
    } else {
      newStreak = 0;
      newInterval = 1;
    }

    // Set the new review date
    final newNextReviewDate = DateTime.now().add(Duration(days: newInterval));

    final updatedStats = stats.copyWith(
      streak: newStreak,
      interval: newInterval,
      easeFactor: newEase,
      nextReviewDate: newNextReviewDate,
      attempts: stats.attempts + 1,
      lastAttemptDate: DateTime.now(),
      successCount: grade >= 3 ? stats.successCount + 1 : stats.successCount,
      lastScore: grade.toDouble(),
    );

    final newModeStats = Map<StudyMode, ReviewStats>.from(modeStats);
    newModeStats[mode] = updatedStats;

    return copyWith(
      modeStats: newModeStats,
      inkPoints: grade >= 3 ? inkPoints + 1 : inkPoints,
    );
  }

  Flashcard copyWith({
    String? id,
    String? deckId,
    String? hanzi,
    String? pinyin,
    String? definition,
    int? hskLevel,
    List<String>? strokePaths,
    List<List<Offset>>? medianPaths,
    bool? isFlipped,
    Map<StudyMode, ReviewStats>? modeStats,
    int? inkPoints,
  }) {
    return Flashcard(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      hanzi: hanzi ?? this.hanzi,
      pinyin: pinyin ?? this.pinyin,
      definition: definition ?? this.definition,
      hskLevel: hskLevel ?? this.hskLevel,
      strokePaths: strokePaths ?? this.strokePaths,
      medianPaths: medianPaths ?? this.medianPaths,
      isFlipped: isFlipped ?? this.isFlipped,
      modeStats: modeStats ?? this.modeStats,
      inkPoints: inkPoints ?? this.inkPoints,
    );
  }
}