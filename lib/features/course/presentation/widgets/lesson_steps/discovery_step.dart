import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/speech_service.dart';
import 'package:hanzi_master/core/services/echo_hall_service.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/core/services/speech_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

class DiscoveryStep extends ConsumerStatefulWidget {
  final Flashcard card;
  final VoidCallback onComplete;
  
  const DiscoveryStep({super.key, required this.card, required this.onComplete});

  @override
  ConsumerState<DiscoveryStep> createState() => _DiscoveryStepState();
}

class _DiscoveryStepState extends ConsumerState<DiscoveryStep> with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  String _transcription = "";
  String _feedback = "";
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        ref.read(audioServiceProvider).playCharacter(widget.card.hanzi);
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    final speechService = ref.read(speechServiceProvider);
    
    if (_isRecording) {
      await speechService.stopListening();
      setState(() => _isRecording = false);
    } else {
      setState(() {
        _isRecording = true;
        _feedback = "The Scholar listens...";
        _transcription = "";
      });

      await speechService.startListening(
        onResult: (text) async {
          setState(() {
            _isRecording = false;
            _transcription = text;
          });
          _generateFeedback(text);
        },
      );
    }
  }

  Future<void> _generateFeedback(String text) async {
    setState(() => _feedback = "Consulting the scrolls...");
    
    // Simple confidence heuristic (mocked for demo as confidence is not easily exposed via stt simple api)
    final isMatch = text.contains(widget.card.hanzi) || text.toLowerCase().contains(widget.card.pinyin.toLowerCase());
    final confidence = isMatch ? 0.9 : 0.4;

    final feedback = await ref.read(echoHallServiceProvider).getPronunciationFeedback(
      widget.card.hanzi,
      text,
      confidence,
    );

    if (mounted) {
      setState(() => _feedback = feedback);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("DISCOVERY", style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        
        // Large Hanzi
        Text(
          widget.card.hanzi,
          style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1B)),
        ),
        
        // Pinyin
        const SizedBox(height: 16),
        PinyinText(
          text: widget.card.pinyin,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        
        const SizedBox(height: 24),
        
        // Audio & Microphone Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => ref.read(audioServiceProvider).playCharacter(widget.card.hanzi),
              icon: const Icon(Icons.volume_up, size: 40, color: Color(0xFF1A1A1B)),
            ),
            const SizedBox(width: 40),
            GestureDetector(
              onTap: _toggleRecording,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isRecording ? Colors.red.withValues(alpha: 0.2 + (_pulseController.value * 0.3)) : const Color(0xFFFDFCF0),
                      shape: BoxShape.circle,
                      border: Border.all(color: _isRecording ? Colors.red : const Color(0xFF1A1A1B), width: 2),
                      boxShadow: _isRecording ? [
                        BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 10 * _pulseController.value, spreadRadius: 5 * _pulseController.value)
                      ] : null,
                    ),
                    child: Icon(
                      _isRecording ? Icons.mic : Icons.mic_none,
                      size: 40,
                      color: _isRecording ? Colors.red : const Color(0xFF1A1A1B),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // AI Feedback Area
        const SizedBox(height: 32),
        if (_feedback.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDFCF0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1A1A1B).withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  if (_transcription.isNotEmpty)
                    Text('"$_transcription"', style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                    _feedback,
                    style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A1B), height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

        const Spacer(),

        // Continue Button
        Padding(
          padding: const EdgeInsets.all(32),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: widget.onComplete,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A1B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("START LEARNING", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFDFCF0), letterSpacing: 1.2)),
            ),
          ),
        ),
      ],
    );
  }
}
