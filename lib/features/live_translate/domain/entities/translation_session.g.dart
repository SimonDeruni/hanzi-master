// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranslationMessageAdapter extends TypeAdapter<TranslationMessage> {
  @override
  final int typeId = 20;

  @override
  TranslationMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranslationMessage(
      text: fields[0] as String,
      isUser: fields[1] as bool,
      timestamp: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TranslationMessage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.isUser)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TranslationSessionAdapter extends TypeAdapter<TranslationSession> {
  @override
  final int typeId = 21;

  @override
  TranslationSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranslationSession(
      id: fields[0] as String,
      modeName: fields[1] as String,
      date: fields[2] as DateTime,
      messages: (fields[3] as List).cast<TranslationMessage>(),
    );
  }

  @override
  void write(BinaryWriter writer, TranslationSession obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.modeName)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
