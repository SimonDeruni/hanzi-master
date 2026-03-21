import 'package:equatable/equatable.dart';

class Flashcard extends Equatable {
  final String id;
  final String hanzi;       // The Character (e.g., "猫")
  final String pinyin;      // The Pronunciation (e.g., "māo")
  final String definition;  // The Meaning
  final int hskLevel;       // Difficulty (1-6)
  final List<String> strokePaths; // The vector data for writing

  // --- SRS Stats ---
  final DateTime nextReviewDate;
  final int interval;
  final double easeFactor;
  final int streak;
  
  // --- Performance Tracking ---
  final double lastScore;        // Last attempt score (0-100)
  final int attempts;            // Total practice attempts
  final DateTime? lastAttemptDate; // When user last tried this card
  final int successCount;        // How many times scored > 80%

  const Flashcard({
    required this.id,
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    required this.hskLevel,
    required this.strokePaths,
    required this.nextReviewDate,
    required this.interval,
    required this.easeFactor,
    required this.streak,
    this.lastScore = 0.0,
    this.attempts = 0,
    this.lastAttemptDate,
    this.successCount = 0,
  });

  @override
  List<Object?> get props => [id, hanzi, pinyin, nextReviewDate, streak, lastScore, attempts];

  // --- Helpers for UI ---
  bool get isMastered => interval >= 14 || streak >= 5;
  bool get isNew => attempts == 0;
  bool get isLearning => attempts > 0 && !isMastered;

  // 📋 ADD THIS METHOD
  Flashcard copyWith({
    String? id,
    String? hanzi,
    String? pinyin,
    String? definition,
    int? hskLevel,
    List<String>? strokePaths,
    DateTime? nextReviewDate,
    int? interval,
    double? easeFactor,
    int? streak,
    double? lastScore,
    int? attempts,
    DateTime? lastAttemptDate,
    int? successCount,
  }) {
    return Flashcard(
      id: id ?? this.id,
      hanzi: hanzi ?? this.hanzi,
      pinyin: pinyin ?? this.pinyin,
      definition: definition ?? this.definition,
      hskLevel: hskLevel ?? this.hskLevel,
      strokePaths: strokePaths ?? this.strokePaths,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      interval: interval ?? this.interval,
      easeFactor: easeFactor ?? this.easeFactor,
      streak: streak ?? this.streak,
      lastScore: lastScore ?? this.lastScore,
      attempts: attempts ?? this.attempts,
      lastAttemptDate: lastAttemptDate ?? this.lastAttemptDate,
      successCount: successCount ?? this.successCount,
    );
  }
}