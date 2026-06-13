import 'package:equatable/equatable.dart';

class GradedStory extends Equatable {
  final String id;
  final String title;
  final String category; // e.g. "Mythology", "Daily Life"
  final int hskLevel;
  final String content; // The Chinese text
  final String englishTranslation; // Summary or full translation
  final DateTime generatedAt;

  const GradedStory({
    required this.id,
    required this.title,
    required this.category,
    required this.hskLevel,
    required this.content,
    required this.englishTranslation,
    required this.generatedAt,
  });

  factory GradedStory.fromJson(Map<String, dynamic> json) {
    return GradedStory(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      hskLevel: json['hskLevel'] as int? ?? 1,
      content: json['content'] as String? ?? '',
      englishTranslation: json['englishTranslation'] as String? ?? '',
      generatedAt: json['generatedAt'] != null
          ? DateTime.parse(json['generatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'hskLevel': hskLevel,
      'content': content,
      'englishTranslation': englishTranslation,
      'generatedAt': generatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        hskLevel,
        content,
        englishTranslation,
        generatedAt,
      ];
}
