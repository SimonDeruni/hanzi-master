class TranslationMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String sideId;
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
