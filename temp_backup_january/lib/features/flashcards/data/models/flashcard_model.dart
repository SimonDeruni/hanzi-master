import 'package:hive/hive.dart';
import '../../domain/entities/flashcard.dart';
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
  final double lastScore;
  
  @HiveField(11)
  final int attempts;
  
  @HiveField(12)
  final DateTime? lastAttemptDate;
  
  @HiveField(13)
  final int successCount;

  FlashcardModel({
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

  // Convert DB Model -> Pure Entity
  Flashcard toEntity() {
    return Flashcard(
      id: id,
      hanzi: hanzi,
      pinyin: pinyin,
      definition: definition,
      hskLevel: hskLevel,
      strokePaths: strokePaths,
      nextReviewDate: nextReviewDate,
      interval: interval,
      easeFactor: easeFactor,
      streak: streak,
      lastScore: lastScore,
      attempts: attempts,
      lastAttemptDate: lastAttemptDate,
      successCount: successCount,
    );
  }

  // Convert Pure Entity -> DB Model
  static FlashcardModel fromEntity(Flashcard card) {
    return FlashcardModel(
      id: card.id,
      hanzi: card.hanzi,
      pinyin: card.pinyin,
      definition: card.definition,
      hskLevel: card.hskLevel,
      strokePaths: card.strokePaths,
      nextReviewDate: card.nextReviewDate,
      interval: card.interval,
      easeFactor: card.easeFactor,
      streak: card.streak,
      lastScore: card.lastScore,
      attempts: card.attempts,
      lastAttemptDate: card.lastAttemptDate,
      successCount: card.successCount,
    );
  }
  // ---------------------------------------------------------
  // ADD THIS SECTION: Create Model from JSON (Import Logic)
  // ---------------------------------------------------------
  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      // We accept 'uuid' from the JSON, or 'id' as a backup
      id: json['uuid'] ?? json['id'] ?? '', 
      hanzi: json['hanzi'] ?? '',
      pinyin: json['pinyin'] ?? '',
      definition: json['definition'] ?? '',
      
      // DEFAULTS FOR NEW CARDS:
      hskLevel: 1, // We are importing the HSK 1 list
      strokePaths: [], // We will generate these later, start empty
      
      // SRS (Spaced Repetition) DEFAULTS:
      // The card is new, so it is due for review immediately
      nextReviewDate: DateTime.now(), 
      interval: 0,
      easeFactor: 2.5, // Standard starting ease factor (Sm2 algorithm)
      streak: 0,
    );
  }
}