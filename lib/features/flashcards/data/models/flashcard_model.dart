import 'dart:convert';
import 'dart:ui';
import 'package:hive/hive.dart';
import '../../domain/entities/flashcard.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import '../../domain/entities/study_mode.dart';
import '../../domain/entities/review_stats.dart';
import 'review_stats_model.dart';
part 'flashcard_model.g.dart';

@HiveType(typeId: 0)
class FlashcardModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String hanzi;

  @HiveField(2)
  final String pinyin;

  @HiveField(3)
  final String definition;

  @HiveField(4)
  final int hskLevel;

  @HiveField(5)
  final DateTime nextReviewDate;

  @HiveField(6)
  final int interval;

  @HiveField(7)
  final double easeFactor;

  @HiveField(8)
  final int streak;

  @HiveField(9)
  final List<String> strokePaths;
  
  @HiveField(10)
  final double? lastScore;
  
  @HiveField(11)
  final int? attempts;
  
  @HiveField(12)
  final DateTime? lastAttemptDate;
  
  @HiveField(13)
  final int? successCount;

  @HiveField(14)
  final String? medianPathsJson;

  @HiveField(15)
  final bool? isFlipped;

  @HiveField(16)
  final int? inkPoints;

  @HiveField(17)
  final String? deckId;

  // --- New Mode-Specific Stats ---
  @HiveField(18)
  final ReviewStatsModel? calligraphyStats;

  @HiveField(19)
  final ReviewStatsModel? readingStats;

  @HiveField(20)
  final ReviewStatsModel? recallStats;

  @HiveField(21)
  final ReviewStatsModel? speakingStats;

  @HiveField(22)
  final ReviewStatsModel? listeningStats;

  FlashcardModel({
    required this.id,
    this.deckId = 'default',
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
    this.medianPathsJson,
    this.isFlipped = false,
    this.inkPoints = 0,
    this.calligraphyStats,
    this.readingStats,
    this.recallStats,
    this.speakingStats,
    this.listeningStats,
  });

  Flashcard toEntity() {
    List<List<Offset>> medians = [];
    if (medianPathsJson != null && medianPathsJson!.isNotEmpty) {
      try {
        final List<dynamic> decoded = json.decode(medianPathsJson!);
        medians = decoded.map((stroke) {
          final List<dynamic> pointsList = stroke as List;
          return pointsList.map((point) {
            if (point is Map) {
              final x = (point['x'] ?? 0).toDouble();
              final y = (point['y'] ?? 0).toDouble();
              return Offset(x, y);
            }
            return Offset.zero;
          }).toList();
        }).toList();
      } catch (e) {
        medians = [];
      }
    }

    return Flashcard(
      id: id,
      deckId: deckId ?? 'default',
      hanzi: hanzi,
      pinyin: PinyinUtils.convertNumericToMarks(pinyin),
      definition: definition,
      hskLevel: hskLevel,
      strokePaths: strokePaths,
      medianPaths: medians,
      isFlipped: isFlipped ?? false,
      modeStats: _buildModeStats(),
      inkPoints: inkPoints ?? 0,
    );
  }

  Map<StudyMode, ReviewStats> _buildModeStats() {
    final map = <StudyMode, ReviewStats>{};

    // Helper to create legacy stats
    ReviewStats buildLegacyStats() {
      return ReviewStats(
        nextReviewDate: nextReviewDate,
        interval: interval,
        easeFactor: easeFactor,
        streak: streak,
        lastScore: lastScore ?? 0.0,
        attempts: attempts ?? 0,
        lastAttemptDate: lastAttemptDate,
        successCount: successCount ?? 0,
      );
    }

    // Default legacy data goes to reading
    map[StudyMode.reading] = readingStats?.toEntity() ?? buildLegacyStats();
    
    if (calligraphyStats != null) map[StudyMode.calligraphy] = calligraphyStats!.toEntity();
    if (recallStats != null) map[StudyMode.recall] = recallStats!.toEntity();
    if (speakingStats != null) map[StudyMode.speaking] = speakingStats!.toEntity();
    if (listeningStats != null) map[StudyMode.listening] = listeningStats!.toEntity();

    return map;
  }

  static FlashcardModel fromEntity(Flashcard flashcard) {
    String? mediansJson;
    if (flashcard.medianPaths.isNotEmpty) {
      final List<dynamic> encodableMedians = flashcard.medianPaths.map((stroke) {
        return stroke.map((offset) => {'x': offset.dx, 'y': offset.dy}).toList();
      }).toList();
      mediansJson = json.encode(encodableMedians);
    }

    // Grab legacy fields from reading mode for backward compatibility if needed, or just use reading stats
    final readingStats = flashcard.getStatsForMode(StudyMode.reading);

    return FlashcardModel(
      id: flashcard.id,
      deckId: flashcard.deckId,
      hanzi: flashcard.hanzi,
      pinyin: flashcard.pinyin,
      definition: flashcard.definition,
      hskLevel: flashcard.hskLevel,
      strokePaths: flashcard.strokePaths,
      nextReviewDate: readingStats.nextReviewDate,
      interval: readingStats.interval,
      easeFactor: readingStats.easeFactor,
      streak: readingStats.streak,
      lastScore: readingStats.lastScore,
      attempts: readingStats.attempts,
      lastAttemptDate: readingStats.lastAttemptDate,
      successCount: readingStats.successCount,
      medianPathsJson: mediansJson,
      isFlipped: flashcard.isFlipped,
      inkPoints: flashcard.inkPoints,
      calligraphyStats: flashcard.modeStats.containsKey(StudyMode.calligraphy) 
          ? ReviewStatsModel.fromEntity(flashcard.modeStats[StudyMode.calligraphy]!) : null,
      readingStats: ReviewStatsModel.fromEntity(readingStats),
      recallStats: flashcard.modeStats.containsKey(StudyMode.recall) 
          ? ReviewStatsModel.fromEntity(flashcard.modeStats[StudyMode.recall]!) : null,
      speakingStats: flashcard.modeStats.containsKey(StudyMode.speaking) 
          ? ReviewStatsModel.fromEntity(flashcard.modeStats[StudyMode.speaking]!) : null,
      listeningStats: flashcard.modeStats.containsKey(StudyMode.listening) 
          ? ReviewStatsModel.fromEntity(flashcard.modeStats[StudyMode.listening]!) : null,
    );
  }

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      id: json['uuid'] ?? json['id'] ?? '', 
      hanzi: json['hanzi'] ?? '',
      pinyin: PinyinUtils.convertNumericToMarks(json['pinyin'] ?? ''),
      definition: json['definition'] ?? '',
      hskLevel: 1,
      strokePaths: [],
      nextReviewDate: DateTime.now(), 
      interval: 0,
      easeFactor: 2.5,
      streak: 0,
      inkPoints: 0,
    );
  }
}
