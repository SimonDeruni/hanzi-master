import 'package:equatable/equatable.dart';
import '../../../../core/services/gemini_service.dart';

class GradedStory extends Equatable {
  final String id;
  final String title;
  final String category; // e.g. "Mythology", "Daily Life"
  final int hskLevel;
  final List<AiSentence> sentences;
  final DateTime generatedAt;
  final String? sourceDeckId;
  final String? sourceDeckName;

  const GradedStory({
    required this.id,
    required this.title,
    required this.category,
    required this.hskLevel,
    required this.sentences,
    required this.generatedAt,
    this.sourceDeckId,
    this.sourceDeckName,
  });

  factory GradedStory.fromJson(Map<String, dynamic> json) {
    return GradedStory(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      hskLevel: json['hskLevel'] as int? ?? 1,
      sentences: (json['sentences'] as List<dynamic>?)
              ?.map((e) => AiSentence.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      generatedAt: json['generatedAt'] != null
          ? DateTime.parse(json['generatedAt'] as String)
          : DateTime.now(),
      sourceDeckId: json['sourceDeckId'] as String?,
      sourceDeckName: json['sourceDeckName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'hskLevel': hskLevel,
      'sentences': sentences.map((s) => s.toJson()).toList(),
      'generatedAt': generatedAt.toIso8601String(),
      if (sourceDeckId != null) 'sourceDeckId': sourceDeckId,
      if (sourceDeckName != null) 'sourceDeckName': sourceDeckName,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        hskLevel,
        sentences,
        generatedAt,
        sourceDeckId,
        sourceDeckName,
      ];
}
