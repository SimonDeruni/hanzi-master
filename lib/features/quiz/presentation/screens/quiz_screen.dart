import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import '../../domain/entities/quiz_question.dart';

class QuizScreen extends StatefulWidget {
  final List<Flashcard> availableCards;
  
  const QuizScreen({super.key, required this.availableCards});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<QuizQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isFinished = false;
  
  // Feedback state
  bool _hasAnswered = false;
  String? _selectedOptionId;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    if (widget.availableCards.length < 4) return;
    
    final random = Random();
    // Generate 10 questions or fewer
    final int count = min(10, widget.availableCards.length);
    final List<Flashcard> targets = List.from(widget.availableCards)..shuffle(random);
    
    for (int i = 0; i < count; i++) {
      final target = targets[i];
      // Pick 3 distractors
      final List<Flashcard> others = List.from(widget.availableCards)..removeWhere((c) => c.id == target.id);
      others.shuffle(random);
      final distractors = others.take(3).toList();
      
      final options = [target, ...distractors]..shuffle(random);
      final type = random.nextBool() ? QuizType.hanziToEnglish : QuizType.englishToHanzi;
      
      _questions.add(QuizQuestion(target: target, options: options, type: type));
    }
  }

  void _handleAnswer(Flashcard selected) {
    if (_hasAnswered) return;
    
    final question = _questions[_currentIndex];
    final correct = selected.id == question.target.id;
    
    setState(() {
      _hasAnswered = true;
      _selectedOptionId = selected.id;
      if (correct) _score++;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) {
        return;
      }
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _hasAnswered = false;
          _selectedOptionId = null;
        });
      } else {
        setState(() => _isFinished = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(), 
        body: const Center(child: Text("Not enough cards for a quiz! Need at least 4.")),
      );
    }

    if (_isFinished) {
      return _buildSummary();
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Question ${_currentIndex + 1}/${_questions.length}"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: CalligraphyBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Question Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)],
                ),
                child: Column(
                  children: [
                    Text(
                      question.isHanziToEnglish ? "What does this mean?" : "Which character is:",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question.questionText,
                      style: TextStyle(
                        fontSize: question.isHanziToEnglish ? 64 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Options
              ...question.options.map((opt) => _buildOption(opt, question)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(Flashcard option, QuizQuestion question) {
    final isSelected = _selectedOptionId == option.id;
    final isTarget = option.id == question.target.id;
    
    Color color = Colors.white;
    if (_hasAnswered) {
      if (isTarget) {
        color = Colors.green.shade100;
      } else if (isSelected && !isTarget) {
        color = Colors.red.shade100;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _handleAnswer(option),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
          ),
          child: Text(
            question.optionText(option),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Scaffold(
      body: CalligraphyBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Quiz Complete!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text("Score: $_score / ${_questions.length}", style: const TextStyle(fontSize: 24, color: Colors.indigo)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text("Return to Course", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
