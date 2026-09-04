import 'package:equatable/equatable.dart';

class DictionaryExpansion extends Equatable {
  final String text;
  final String languageCode;
  final String modelVersion;
  final String promptVersion;
  final String sourceDefinitionHash;
  final bool fromSharedCache;

  const DictionaryExpansion({
    required this.text,
    required this.languageCode,
    required this.modelVersion,
    required this.promptVersion,
    required this.sourceDefinitionHash,
    required this.fromSharedCache,
  });

  factory DictionaryExpansion.fromJson(Map<String, dynamic> json) {
    final text = (json['text'] ?? json['expansion']) as String? ?? '';
    if (text.trim().isEmpty) {
      throw const FormatException('Dictionary expansion was empty');
    }
    return DictionaryExpansion(
      text: text.trim(),
      languageCode: json['languageCode'] as String? ?? '',
      modelVersion: json['modelVersion'] as String? ?? 'unknown',
      promptVersion: json['promptVersion'] as String? ?? 'unknown',
      sourceDefinitionHash: json['sourceDefinitionHash'] as String? ?? '',
      fromSharedCache: json['cached'] == true,
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'languageCode': languageCode,
        'modelVersion': modelVersion,
        'promptVersion': promptVersion,
        'sourceDefinitionHash': sourceDefinitionHash,
        'cached': fromSharedCache,
      };

  @override
  List<Object?> get props => [
        text,
        languageCode,
        modelVersion,
        promptVersion,
        sourceDefinitionHash,
        fromSharedCache,
      ];
}
