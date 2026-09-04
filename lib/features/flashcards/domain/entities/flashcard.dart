import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'review_stats.dart';
import 'study_mode.dart';
import '../logic/review_scheduler.dart';

class Flashcard extends Equatable {
  final String id;
  final String deckId;
  final String hanzi;
  final String pinyin;
  final String definition;

  /// Language of [definition] when it is known by the data source.
  ///
  /// Saved/custom flashcards leave this null and continue through the normal
  /// translation fallback. Global dictionary results set it so already
  /// localized definitions are not translated a second time.
  final String? definitionLanguage;

  /// Global dictionary provenance. Null for user-created/local cards.
  final int? dictionaryWordId;
  final String? englishDefinition;
  final int? localizedDefinitionQuality;
  final bool isExpansionEligible;
  final String? sourceDefinitionHash;
  final int hskLevel;
  final List<String> strokePaths;
  final List<List<Offset>> medianPaths;
  final bool isFlipped;

  // --- Mode Specific SRS Stats ---
  final Map<StudyMode, ReviewStats> modeStats;

  // --- Global Metadata ---
  final int inkPoints; // 🖌️ XP System

  // --- Context Nodes ---
  final String? sourceSentence;
  final String? sourceContext;

  const Flashcard({
    required this.id,
    this.deckId = 'default',
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    this.definitionLanguage,
    this.dictionaryWordId,
    this.englishDefinition,
    this.localizedDefinitionQuality,
    this.isExpansionEligible = false,
    this.sourceDefinitionHash,
    required this.hskLevel,
    required this.strokePaths,
    this.medianPaths = const [],
    this.isFlipped = false,
    required this.modeStats,
    this.inkPoints = 0,
    this.sourceSentence,
    this.sourceContext,
  });

  @override
  List<Object?> get props => [
        id,
        deckId,
        hanzi,
        pinyin,
        definition,
        definitionLanguage,
        dictionaryWordId,
        englishDefinition,
        localizedDefinitionQuality,
        isExpansionEligible,
        sourceDefinitionHash,
        hskLevel,
        strokePaths,
        medianPaths,
        isFlipped,
        modeStats,
        inkPoints,
        sourceSentence,
        sourceContext
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

  /// Returns the global mastery level across all available study modes (Reading, Writing, etc.)
  double get globalMasteryLevel {
    if (modeStats.isEmpty) return 0.0;
    double sum = 0;
    for (final stats in modeStats.values) {
      sum += stats.masteryLevel;
    }
    return sum / modeStats.length;
  }

  /// Applies the app's scheduling policy.
  /// Expected grades: 0 (Again), 2 (Hard), 4 (Good), 5 (Easy).
  Flashcard processReview(int grade, StudyMode mode, {DateTime? reviewedAt}) {
    final stats = getStatsForMode(mode);
    final updatedStats = ReviewScheduler.schedule(
      stats: stats,
      rating: ReviewRating.fromGrade(grade),
      reviewedAt: reviewedAt ?? DateTime.now(),
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
    String? definitionLanguage,
    int? dictionaryWordId,
    String? englishDefinition,
    int? localizedDefinitionQuality,
    bool? isExpansionEligible,
    String? sourceDefinitionHash,
    int? hskLevel,
    List<String>? strokePaths,
    List<List<Offset>>? medianPaths,
    bool? isFlipped,
    Map<StudyMode, ReviewStats>? modeStats,
    int? inkPoints,
    String? sourceSentence,
    String? sourceContext,
  }) {
    return Flashcard(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      hanzi: hanzi ?? this.hanzi,
      pinyin: pinyin ?? this.pinyin,
      definition: definition ?? this.definition,
      definitionLanguage: definitionLanguage ?? this.definitionLanguage,
      dictionaryWordId: dictionaryWordId ?? this.dictionaryWordId,
      englishDefinition: englishDefinition ?? this.englishDefinition,
      localizedDefinitionQuality:
          localizedDefinitionQuality ?? this.localizedDefinitionQuality,
      isExpansionEligible: isExpansionEligible ?? this.isExpansionEligible,
      sourceDefinitionHash: sourceDefinitionHash ?? this.sourceDefinitionHash,
      hskLevel: hskLevel ?? this.hskLevel,
      strokePaths: strokePaths ?? this.strokePaths,
      medianPaths: medianPaths ?? this.medianPaths,
      isFlipped: isFlipped ?? this.isFlipped,
      modeStats: modeStats ?? this.modeStats,
      inkPoints: inkPoints ?? this.inkPoints,
      sourceSentence: sourceSentence ?? this.sourceSentence,
      sourceContext: sourceContext ?? this.sourceContext,
    );
  }
}
