class PronunciationGrade {
  final int score; // 0 to 100
  final int accuracy;
  final int completeness;
  final int fluency;
  final String overallFeedback;
  final List<SyllableGrade> words;

  PronunciationGrade({
    required this.score,
    required this.accuracy,
    required this.completeness,
    required this.fluency,
    required this.overallFeedback,
    required this.words,
  });

  factory PronunciationGrade.fromJson(Map<String, dynamic> json) {
    return PronunciationGrade(
      score: json['score'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
      completeness: json['completeness'] ?? 0,
      fluency: json['fluency'] ?? 0,
      overallFeedback: json['overallFeedback'] ?? '',
      words: (json['words'] as List<dynamic>? ?? [])
          .map((w) => SyllableGrade.fromJson(w))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'accuracy': accuracy,
      'completeness': completeness,
      'fluency': fluency,
      'overallFeedback': overallFeedback,
      'words': words.map((w) => w.toJson()).toList(),
    };
  }
}

class SyllableGrade {
  final String word; // Hanzi
  final String pinyin; // Pinyin
  final int expectedTone; // 1-5
  final int actualTone; // 1-5
  final bool isCorrect;
  final String feedback;

  SyllableGrade({
    required this.word,
    required this.pinyin,
    required this.expectedTone,
    required this.actualTone,
    required this.isCorrect,
    required this.feedback,
  });

  factory SyllableGrade.fromJson(Map<String, dynamic> json) {
    return SyllableGrade(
      word: json['word'] ?? '',
      pinyin: json['pinyin'] ?? '',
      expectedTone: json['expectedTone'] ?? 0,
      actualTone: json['actualTone'] ?? 0,
      isCorrect: json['isCorrect'] ?? false,
      feedback: json['feedback'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'pinyin': pinyin,
      'expectedTone': expectedTone,
      'actualTone': actualTone,
      'isCorrect': isCorrect,
      'feedback': feedback,
    };
  }
}
