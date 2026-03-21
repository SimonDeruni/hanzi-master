import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

enum QuizType {
  hanziToEnglish,
  englishToHanzi,
}

class QuizQuestion {
  final Flashcard target;
  final List<Flashcard> options;
  final QuizType type;

  QuizQuestion({
    required this.target,
    required this.options,
    required this.type,
  });
  
  bool get isHanziToEnglish => type == QuizType.hanziToEnglish;
  String get questionText => isHanziToEnglish ? target.hanzi : target.definition;
  
  String optionText(Flashcard card) => isHanziToEnglish ? card.definition : card.hanzi;
}
