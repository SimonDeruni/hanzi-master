import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/zen_sound_service.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/zen_shake.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';

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

  /// Counts rejected answers; each bump plays one [ZenShake] on the wrong tile.
  int _rejections = 0;

  @override
  void initState() {
    super.initState();
    // Combine target + distractors and shuffle
    _options = [widget.targetCard, ...widget.distractors]..shuffle();
  }

  void _handleSelection(Flashcard card) {
    if (_isAnswered) return;

    final bool correct = card.id == widget.targetCard.id;
    setState(() {
      _selectedCard = card;
      _isAnswered = true;
      _isCorrect = correct;
      // Bumping this plays exactly one rejection on the tile they picked.
      if (!correct) _rejections++;
    });

    if (correct) {
      HapticsManager.success();
      ref.read(zenSoundServiceProvider).playCorrect();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          ref.read(audioServiceProvider).playCharacter(widget.targetCard.hanzi);
        }
      });
      Future.delayed(const Duration(seconds: 1), widget.onComplete);
    } else {
      // `ZenShake` owns the refusal haptic (it fires on the same `_rejections`
      // bump this branch makes), so this site must not buzz on top of it.
      ref.read(zenSoundServiceProvider).playWrong();
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Spacer(flex: 1),
          if (isRecognition) ...[
            const Text(
              'Select the character for:',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TranslatedDefinition(
              definition: widget.targetCard.definition,
              originalStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            const Text(
              'Select the Pinyin for:',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(widget.targetCard.hanzi,
                style:
                    const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
          ],
          const Spacer(flex: 2),
          GridView(
              gridDelegate: ZenGrid.tiles(
                  maxTileWidth: 170,
                  childAspectRatio: 1.2,
                  crossSpacing: 16,
                  mainSpacing: 16),
              shrinkWrap: true,
              children: _options
                  .map((option) => _buildOptionCard(option, isRecognition))
                  .toList()),
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
        bgColor = _isCorrect
            ? Colors.green.withValues(alpha: 0.2)
            : Colors.red.withValues(alpha: 0.2);
        borderColor = _isCorrect ? Colors.green : Colors.red;
      } else if (isTarget && !_isCorrect && isSelected) {
        // Show correct answer if they picked wrong (optional, usually kept hidden until second try)
      }
    }

    return ZenShake(
      // Only the rejected tile moves: the others keep trigger 0, and a tile that
      // stops being the rejected one falls back to 0 (increase-only, so silent).
      trigger: isSelected && !_isCorrect ? _rejections : 0,
      child: BouncingButton(
        onPressed: _isAnswered ? null : () => _handleSelection(option),
        child: AnimatedContainer(
          duration: ZenMotion.of(context, ZenMotion.swap),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
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
      ),
    );
  }
}
