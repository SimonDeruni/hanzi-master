import 'dart:ui';
import 'package:equatable/equatable.dart';

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

  // --- SRS Stats ---
  final DateTime nextReviewDate;
  final int interval;
  final double easeFactor;
  final int streak;
  
  // --- Performance Tracking ---
  final double lastScore;
  final int attempts;
  final DateTime? lastAttemptDate;
  final int successCount;
  final int inkPoints; // 🖌️ XP System (Audit 5 consistency fix)

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
    required this.nextReviewDate,
    required this.interval,
    required this.easeFactor,
    required this.streak,
    this.lastScore = 0.0,
    this.attempts = 0,
    this.lastAttemptDate,
    this.successCount = 0,
    this.inkPoints = 0,
  });

  @override
  List<Object?> get props => [
    id, deckId, hanzi, pinyin, definition, hskLevel, strokePaths, medianPaths, 
    isFlipped, nextReviewDate, interval, easeFactor, streak, 
    lastScore, attempts, lastAttemptDate, successCount, inkPoints
  ];

  // --- Helpers for UI ---
  bool get isMastered => interval >= 14 || streak >= 5;
  bool get isNew => attempts == 0;
  bool get isLearning => attempts > 0 && !isMastered;

  /// Returns a normalized mastery level from 0.0 to 1.0 based on the current streak.
  /// A streak of 5 or more is considered 100% mastery for threshold purposes.
  double get masteryLevel => (streak / 5.0).clamp(0.0, 1.0);

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
    DateTime? nextReviewDate,
    int? interval,
    double? easeFactor,
    int? streak,
    double? lastScore,
    int? attempts,
    DateTime? lastAttemptDate,
    int? successCount,
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
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      interval: interval ?? this.interval,
      easeFactor: easeFactor ?? this.easeFactor,
      streak: streak ?? this.streak,
      lastScore: lastScore ?? this.lastScore,
      attempts: attempts ?? this.attempts,
      lastAttemptDate: lastAttemptDate ?? this.lastAttemptDate,
      successCount: successCount ?? this.successCount,
      inkPoints: inkPoints ?? this.inkPoints,
    );
  }
}