import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/cross_reference_text.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';

class ContextStep extends ConsumerStatefulWidget {
  final Flashcard card;
  final VoidCallback onComplete;

  const ContextStep({
    super.key,
    required this.card,
    required this.onComplete,
  });

  @override
  ConsumerState<ContextStep> createState() => _ContextStepState();
}

class _ContextStepState extends ConsumerState<ContextStep> {
  String _sentence = "";
  String _pinyin = "";
  String _english = "";
  bool _isLoading = true;
  bool _isSuccess = false;
  int _currentStrokeIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSentenceData();
  }

  Future<void> _loadSentenceData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/hsk1_sentences.json');
      final List<dynamic> data = json.decode(jsonString);
      
      
      var entry = data.firstWhere(
        (item) => item['hanzi'] == widget.card.hanzi,
        orElse: () => null,
      );

      // --- HSK 2 BUNDLE HOOK ---
      if (entry == null) {
        try {
          final hsk2String = await rootBundle.loadString('assets/data/hsk2_bundle.json');
          final hsk2Bundle = json.decode(hsk2String);
          final sentences = hsk2Bundle['sentences'] ?? {};
          if (sentences.containsKey(widget.card.hanzi)) {
            final hsk2Sentences = sentences[widget.card.hanzi] as List;
            if (hsk2Sentences.isNotEmpty) {
              final s = hsk2Sentences.first;
              entry = {
                'example_sentence': s['hanzi'],
                'example_pinyin': s['pinyin'],
                'example_english': s['english'],
              };
            }
          }
        } catch (e) { /* ignore */ }
      }
      // -------------------------

      if (entry != null && entry['example_sentence'] != null) {
        if (mounted) {
          setState(() {
            _sentence = entry['example_sentence'];
            _pinyin = entry['example_pinyin'];
            _english = entry['example_english'];
            _isLoading = false;
          });
        }
      } else {
        // Fallback if not found
        if (mounted) {
          setState(() {
            _sentence = "这是一个${widget.card.hanzi}。";
            _pinyin = "Zhè shì yí gè ${widget.card.pinyin}.";
            _english = "This is a ${widget.card.definition.split(';').first}.";
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _sentence = "这是${widget.card.hanzi}。";
          _pinyin = "Zhè shì ${widget.card.pinyin}.";
          _english = "This is ${widget.card.definition.split(';').first}.";
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Replace the target hanzi with an underscore blank for the challenge
    final maskedSentence = _sentence.replaceAll(widget.card.hanzi, "___");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "STEP 6: CONTEXT",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 24),
        
        // The Sentence Challenge
        Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.brown.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              CrossReferenceText(
                _isSuccess ? _sentence : maskedSentence,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _isSuccess ? Colors.green.shade700 : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PinyinText(
                    text: _pinyin,
                    style: const TextStyle(fontSize: 18, color: Colors.indigo),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.volume_up, size: 20, color: Colors.indigo),
                    onPressed: () => ref.read(audioServiceProvider).playSentence(_sentence),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _english,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 48),
        
        // Drawing Area
        SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: DrawingCanvas(
                  key: ValueKey("context_${widget.card.id}"),
                  strokePaths: widget.card.strokePaths,
                  medianPaths: widget.card.medianPaths,
                  isFlipped: widget.card.isFlipped,
                  showAnimation: true, // ENABLED for visibility check
                  showReference: false, // NO ghost
                  showGuideLines: false, // NO start/end dots
                  strokeByStrokeMode: true, // MUST be true for manual indexing
                  currentStrokeIndex: _currentStrokeIndex,
                  showGrade: false,
                  autoActiveChar: false,
                  showControls: false,
                  autoCenter: false,
                  onStrokeComplete: (idx, size) {
                    HapticsManager.light();
                    final validStrokes = widget.card.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').toList();
                    if (_currentStrokeIndex < validStrokes.length - 1) {
                      setState(() => _currentStrokeIndex++);
                    } else {
                      setState(() => _isSuccess = true);
                      HapticsManager.success();
                      ref.read(audioServiceProvider).playCharacter(widget.card.hanzi);
                      Future.delayed(const Duration(milliseconds: 1500), widget.onComplete);
                    }
                  },
                ),
              ),
              if (_isSuccess)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(Icons.check_circle, color: Colors.green, size: 80),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
