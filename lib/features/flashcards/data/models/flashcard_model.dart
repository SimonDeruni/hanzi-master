import 'dart:convert';
import 'dart:ui';
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
  final int? inkPoints; // 🖌️ XP System (Audit 5 consistency fix)

  @HiveField(17)
  final String? deckId;

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
      pinyin: pinyin,
      definition: definition,
      hskLevel: hskLevel,
      strokePaths: strokePaths,
      medianPaths: medians,
      nextReviewDate: nextReviewDate,
      interval: interval,
      easeFactor: easeFactor,
      streak: streak,
      lastScore: lastScore ?? 0.0,
      attempts: attempts ?? 0,
      lastAttemptDate: lastAttemptDate,
      successCount: successCount ?? 0,
      isFlipped: isFlipped ?? false,
      inkPoints: inkPoints ?? 0,
    );
  }

  static FlashcardModel fromEntity(Flashcard card) {
    String? jsonStr;
    if (card.medianPaths.isNotEmpty) {
      final encoded = card.medianPaths.map((stroke) {
        return stroke.map((Offset p) => {'x': p.dx, 'y': p.dy}).toList();
      }).toList();
      jsonStr = json.encode(encoded);
    }

    return FlashcardModel(
      id: card.id,
      deckId: card.deckId,
      hanzi: card.hanzi,
      pinyin: card.pinyin,
      definition: card.definition,
      hskLevel: card.hskLevel,
      strokePaths: card.strokePaths,
      medianPathsJson: jsonStr,
      nextReviewDate: card.nextReviewDate,
      interval: card.interval,
      easeFactor: card.easeFactor,
      streak: card.streak,
      lastScore: card.lastScore,
      attempts: card.attempts,
      lastAttemptDate: card.lastAttemptDate,
      successCount: card.successCount,
      isFlipped: card.isFlipped,
      inkPoints: card.inkPoints,
    );
  }

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      id: json['uuid'] ?? json['id'] ?? '', 
      hanzi: json['hanzi'] ?? '',
      pinyin: json['pinyin'] ?? '',
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
