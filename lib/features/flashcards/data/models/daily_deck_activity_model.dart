import 'package:hive/hive.dart';
import '../../domain/entities/daily_deck_activity.dart';

class DailyDeckActivityModel {
  const DailyDeckActivityModel({
    required this.deckId,
    required this.dayKey,
    required this.introducedCardIds,
    required this.reviewedCardIds,
    this.modeIntroductionKeys = const [],
    required this.updatedAt,
  });

  final String deckId;
  final String dayKey;
  final List<String> introducedCardIds;
  final List<String> reviewedCardIds;
  final List<String> modeIntroductionKeys;
  final DateTime updatedAt;

  DailyDeckActivity toEntity() => DailyDeckActivity(
        deckId: deckId,
        dayKey: dayKey,
        introducedCardIds: introducedCardIds.toSet(),
        reviewedCardIds: reviewedCardIds.toSet(),
        modeIntroductionKeys: modeIntroductionKeys.toSet(),
      );
}

class DailyDeckActivityModelAdapter
    extends TypeAdapter<DailyDeckActivityModel> {
  @override
  final int typeId = 4;

  @override
  DailyDeckActivityModel read(BinaryReader reader) {
    final fieldCount = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < fieldCount; i++) reader.readByte(): reader.read(),
    };
    return DailyDeckActivityModel(
      deckId: fields[0] as String,
      dayKey: fields[1] as String,
      introducedCardIds: List<String>.from(fields[2] as List? ?? const []),
      reviewedCardIds: List<String>.from(fields[3] as List? ?? const []),
      updatedAt:
          fields[4] as DateTime? ?? DateTime.fromMillisecondsSinceEpoch(0),
      modeIntroductionKeys: List<String>.from(fields[5] as List? ?? const []),
    );
  }

  @override
  void write(BinaryWriter writer, DailyDeckActivityModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.deckId)
      ..writeByte(1)
      ..write(obj.dayKey)
      ..writeByte(2)
      ..write(obj.introducedCardIds)
      ..writeByte(3)
      ..write(obj.reviewedCardIds)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.modeIntroductionKeys);
  }
}
