import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_selection_sheet.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';

class ARResultScreen extends ConsumerStatefulWidget {
  final Uint8List imageBytes;
  final String hanzi;
  final String pinyin;
  final String meaning;
  final int hskLevel;

  const ARResultScreen({
    super.key,
    required this.imageBytes,
    required this.hanzi,
    required this.pinyin,
    required this.meaning,
    required this.hskLevel,
  });

  @override
  ConsumerState<ARResultScreen> createState() => _ARResultScreenState();
}

class _ARResultScreenState extends ConsumerState<ARResultScreen> {
  @override
  void initState() {
    super.initState();
    _playTts();
  }

  Future<void> _playTts() async {
    await ref.read(audioServiceProvider).playCharacter(widget.hanzi);
  }

  void _saveToDeck() {
    final card = Flashcard(
      id: '',
      hanzi: widget.hanzi,
      pinyin: widget.pinyin,
      definition: widget.meaning,
      hskLevel: widget.hskLevel,
      strokePaths: const [],
      modeStats: const {},
    );
    DeckSelectionSheet.show(context, card: card);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Image.memory(
              widget.imageBytes,
              fit: BoxFit.cover,
            ),
          ),
          
          // Gradient Overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                    isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          
          // Top Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          
          // Bottom Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 24, bottom: 48),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.hskLevel > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'HSK \${widget.hskLevel}',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  
                  GestureDetector(
                    onTap: _playTts,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.hanzi,
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.w900,
                            color: isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B),
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.volume_up,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  PinyinText(
                    text: widget.pinyin,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    widget.meaning,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  ElevatedButton.icon(
                    onPressed: _saveToDeck,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 64),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.bookmark_add, size: 28),
                    label: const Text(
                      "Save to Deck",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
