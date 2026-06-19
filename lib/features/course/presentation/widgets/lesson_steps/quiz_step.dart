import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';

enum QuizMode { recognition, pinyin }

class QuizStep extends ConsumerStatefulWidget {
  final Flashcard targetCard;
  final List<Flashcard> distractors;
  final QuizMode mode;
  final VoidCallback onComplete;

  const QuizStep({
    super.key,
    required this.targetCard,
    required this.distractors,
    required this.mode,
    required this.onComplete,
  });

  @override
  ConsumerState<QuizStep> createState() => _QuizStepState();
}

class _QuizStepState extends ConsumerState<QuizStep> {
  late List<Flashcard> _options;
  Flashcard? _selectedCard;
  bool _isAnswered = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    // Combine target + distractors and shuffle
    _options = [widget.targetCard, ...widget.distractors]..shuffle();
  }

  void _handleSelection(Flashcard card) {
    if (_isAnswered) return;

    setState(() {
      _selectedCard = card;
      _isAnswered = true;
      _isCorrect = card.id == widget.targetCard.id;
    });

    if (_isCorrect) {
      HapticsManager.success();
      ref.read(audioServiceProvider).playCorrectSfx();
      Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) ref.read(audioServiceProvider).playCharacter(widget.targetCard.hanzi);
      });
      Future.delayed(const Duration(seconds: 1), widget.onComplete);
    } else {
      HapticsManager.error();
      ref.read(audioServiceProvider).playWrongSfx();
      // In a real app, we might force them to try again or penalize score
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
           setState(() {
             _isAnswered = false;
             _selectedCard = null;
           });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isRecognition = widget.mode == QuizMode.recognition;
    final String question = isRecognition 
        ? "Select the character for:\n\"${widget.targetCard.definition.toUpperCase()}\""
        : "Select the Pinyin for:\n${widget.targetCard.hanzi}";

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Spacer(flex: 1),
          Text(
            question,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
            textAlign: TextAlign.center,
          ),
          if (!isRecognition) ...[
             const SizedBox(height: 16),
             Text(widget.targetCard.hanzi, style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
          ],
          const Spacer(flex: 2),
          
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: _options.map((option) => _buildOptionCard(option, isRecognition)).toList(),
          ),
          
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Widget _buildOptionCard(Flashcard option, bool isRecognition) {
    final bool isSelected = _selectedCard?.id == option.id;
    final bool isTarget = option.id == widget.targetCard.id;
    
    Color bgColor = Colors.white;
    Color borderColor = Colors.indigo.withValues(alpha: 0.1);

    if (_isAnswered) {
      if (isSelected) {
        bgColor = _isCorrect ? Colors.green.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2);
        borderColor = _isCorrect ? Colors.green : Colors.red;
      } else if (isTarget && !_isCorrect && isSelected) {
        // Show correct answer if they picked wrong (optional, usually kept hidden until second try)
      }
    }

    return GestureDetector(
      onTap: () => _handleSelection(option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Center(
            child: PinyinText(
              text: isRecognition ? option.hanzi : option.pinyin,
              style: TextStyle(
                fontSize: isRecognition ? 32 : 18,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ),
    );
  }
}
