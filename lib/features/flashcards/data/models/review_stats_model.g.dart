// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_stats_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewStatsModelAdapter extends TypeAdapter<ReviewStatsModel> {
  @override
  final int typeId = 2;

  @override
  ReviewStatsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewStatsModel(
      nextReviewDate: fields[0] as DateTime,
      interval: fields[1] as int,
      easeFactor: fields[2] as double,
      streak: fields[3] as int,
      lastScore: fields[4] as double?,
      attempts: fields[5] as int?,
      lastAttemptDate: fields[6] as DateTime?,
      successCount: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewStatsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.nextReviewDate)
      ..writeByte(1)
      ..write(obj.interval)
      ..writeByte(2)
      ..write(obj.easeFactor)
      ..writeByte(3)
      ..write(obj.streak)
      ..writeByte(4)
      ..write(obj.lastScore)
      ..writeByte(5)
      ..write(obj.attempts)
      ..writeByte(6)
      ..write(obj.lastAttemptDate)
      ..writeByte(7)
      ..write(obj.successCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewStatsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
