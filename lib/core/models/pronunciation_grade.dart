class PronunciationGrade {
  final int? score; // nullable — null means not assessed
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
      score: (json['score'] is int || json['score'] is num) ? (json['score'] as num).toInt() : null,
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
  final String? english; // English translation/meaning
  final int expectedTone; // 1-5
  final int actualTone; // 1-5
  final bool isCorrect;
  final bool isPartial; // Tone wrong but base syllable understood
  final int wordScore; // Individual word score (0-100)
  final String feedback;

  SyllableGrade({
    required this.word,
    required this.pinyin,
    this.english,
    required this.expectedTone,
    required this.actualTone,
    required this.isCorrect,
    this.isPartial = false,
    required this.wordScore,
    required this.feedback,
  });

  /// Color logic: green = correct, yellow = partial, red = wrong
  WordGradeLevel get gradeLevel {
    if (isCorrect) return WordGradeLevel.correct;
    if (isPartial) return WordGradeLevel.partial;
    return WordGradeLevel.wrong;
  }

  factory SyllableGrade.fromJson(Map<String, dynamic> json) {
    final rawScore = json['wordScore'] ?? json['accuracyScore'] ?? json['accuracy'];
    final score = (rawScore is int || rawScore is num) ? (rawScore as num).toInt() : 0;
    return SyllableGrade(
      word: json['word'] ?? '',
      pinyin: json['pinyin'] ?? '',
      english: json['english'],
      expectedTone: json['expectedTone'] ?? 0,
      actualTone: json['actualTone'] ?? 0,
      isCorrect: json['isCorrect'] ?? false,
      isPartial: json['isPartial'] ?? false,
      wordScore: score,
      feedback: json['feedback'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'pinyin': pinyin,
      'english': english,
      'expectedTone': expectedTone,
      'actualTone': actualTone,
      'isCorrect': isCorrect,
      'isPartial': isPartial,
      'wordScore': wordScore,
      'feedback': feedback,
    };
  }
}

enum WordGradeLevel { correct, partial, wrong }