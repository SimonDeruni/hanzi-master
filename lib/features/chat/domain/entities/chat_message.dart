enum ChatRole { user, scholar }

class ChatMessage {
  final String id;
  final String content;
  final String? pinyin;
  final ChatRole role;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    this.pinyin,
    required this.role,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'pinyin': pinyin,
    'role': role.name,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'],
    content: json['content'],
    pinyin: json['pinyin'],
    role: ChatRole.values.byName(json['role']),
    timestamp: DateTime.parse(json['timestamp']),
  );
}
