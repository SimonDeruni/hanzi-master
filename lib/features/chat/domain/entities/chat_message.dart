import '../../../../core/models/pronunciation_grade.dart';

enum ChatRole { user, scholar }

class ChatMessage {
  final String id;
  final String content;
  final String? pinyin;
  final String? english;
  final Map<String, dynamic>? suggestion;
  final ChatRole role;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    this.pinyin,
    this.english,
    this.suggestion,
    required this.role,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'pinyin': pinyin,
    'english': english,
    'suggestion': suggestion,
    'role': role.name,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'],
    content: json['content'],
    pinyin: json['pinyin'],
    english: json['english'],
    suggestion: json['suggestion'],
    role: ChatRole.values.byName(json['role']),
    timestamp: DateTime.parse(json['timestamp']),
  );
}

class GradedChatMessage extends ChatMessage {
  final PronunciationGrade? grade;
  final String? audioPath;

  GradedChatMessage({
    required super.id,
    required super.content,
    super.pinyin,
    super.english,
    super.suggestion,
    required super.role,
    required super.timestamp,
    this.grade,
    this.audioPath,
  });

  GradedChatMessage copyWith({
    PronunciationGrade? grade,
    String? audioPath,
  }) {
    return GradedChatMessage(
      id: id,
      content: content,
      pinyin: pinyin,
      english: english,
      suggestion: suggestion,
      role: role,
      timestamp: timestamp,
      grade: grade ?? this.grade,
      audioPath: audioPath ?? this.audioPath,
    );
  }
}
