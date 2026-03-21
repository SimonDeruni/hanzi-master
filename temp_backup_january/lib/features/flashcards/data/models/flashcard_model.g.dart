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
      hanzi: fields[1] as String,
      pinyin: fields[2] as String,
      definition: fields[3] as String,
      hskLevel: fields[4] as int,
      strokePaths: (fields[9] as List).cast<String>(),
      nextReviewDate: fields[5] as DateTime,
      interval: fields[6] as int,
      easeFactor: fields[7] as double,
      streak: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FlashcardModel obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.strokePaths);
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
