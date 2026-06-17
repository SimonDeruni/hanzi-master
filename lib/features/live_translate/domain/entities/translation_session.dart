import 'package:hive/hive.dart';

part 'translation_session.g.dart';

@HiveType(typeId: 20)
class TranslationMessage extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final bool isUser;

  @HiveField(2)
  final DateTime timestamp;

  TranslationMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  TranslationMessage copyWith({String? text}) {
    return TranslationMessage(
      text: text ?? this.text,
      isUser: isUser,
      timestamp: timestamp,
    );
  }
}

@HiveType(typeId: 21)
class TranslationSession extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String modeName;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final List<TranslationMessage> messages;

  TranslationSession({
    required this.id,
    required this.modeName,
    required this.date,
    required this.messages,
  });
}
