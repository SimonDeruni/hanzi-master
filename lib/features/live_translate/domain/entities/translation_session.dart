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

  @HiveField(3)
  final String sideId;

  @HiveField(4)
  final String language;

  TranslationMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
    this.sideId = 'a',
    this.language = 'English',
  }) : timestamp = timestamp ?? DateTime.now();

  TranslationMessage copyWith({String? text}) {
    return TranslationMessage(
      text: text ?? this.text,
      isUser: isUser,
      timestamp: timestamp,
      sideId: sideId,
      language: language,
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

  @HiveField(4)
  final String sideALanguage;

  @HiveField(5)
  final String sideBLanguage;

  TranslationSession({
    required this.id,
    required this.modeName,
    required this.date,
    required this.messages,
    this.sideALanguage = 'English',
    this.sideBLanguage = 'Mandarin',
  });
}
