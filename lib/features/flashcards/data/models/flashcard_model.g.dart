// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashcardModelAdapter extends TypeAdapter<FlashcardModel> {
  @override
  final int typeId = 0;

  @override
  FlashcardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlashcardModel(
      id: fields[0] as String,
      deckId: fields[17] as String?,
      hanzi: fields[1] as String,
      pinyin: fields[2] as String,
      definition: fields[3] as String,
      hskLevel: fields[4] as int,
      strokePaths: (fields[9] as List).cast<String>(),
      nextReviewDate: fields[5] as DateTime,
      interval: fields[6] as int,
      easeFactor: fields[7] as double,
      streak: fields[8] as int,
      lastScore: fields[10] as double?,
      attempts: fields[11] as int?,
      lastAttemptDate: fields[12] as DateTime?,
      successCount: fields[13] as int?,
      medianPathsJson: fields[14] as String?,
      isFlipped: fields[15] as bool?,
      inkPoints: fields[16] as int?,
      calligraphyStats: fields[18] as ReviewStatsModel?,
      readingStats: fields[19] as ReviewStatsModel?,
      recallStats: fields[20] as ReviewStatsModel?,
      speakingStats: fields[21] as ReviewStatsModel?,
      listeningStats: fields[22] as ReviewStatsModel?,
    );
  }

  @override
  void write(BinaryWriter writer, FlashcardModel obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hanzi)
      ..writeByte(2)
      ..write(obj.pinyin)
      ..writeByte(3)
      ..write(obj.definition)
      ..writeByte(4)
      ..write(obj.hskLevel)
      ..writeByte(5)
      ..write(obj.nextReviewDate)
      ..writeByte(6)
      ..write(obj.interval)
      ..writeByte(7)
      ..write(obj.easeFactor)
      ..writeByte(8)
      ..write(obj.streak)
      ..writeByte(9)
      ..write(obj.strokePaths)
      ..writeByte(10)
      ..write(obj.lastScore)
      ..writeByte(11)
      ..write(obj.attempts)
      ..writeByte(12)
      ..write(obj.lastAttemptDate)
      ..writeByte(13)
      ..write(obj.successCount)
      ..writeByte(14)
      ..write(obj.medianPathsJson)
      ..writeByte(15)
      ..write(obj.isFlipped)
      ..writeByte(16)
      ..write(obj.inkPoints)
      ..writeByte(17)
      ..write(obj.deckId)
      ..writeByte(18)
      ..write(obj.calligraphyStats)
      ..writeByte(19)
      ..write(obj.readingStats)
      ..writeByte(20)
      ..write(obj.recallStats)
      ..writeByte(21)
      ..write(obj.speakingStats)
      ..writeByte(22)
      ..write(obj.listeningStats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashcardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
