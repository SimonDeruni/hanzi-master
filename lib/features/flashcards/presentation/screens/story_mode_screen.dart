import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_quick_box.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/word_detail_dialog.dart';

final storyProvider = FutureProvider.family<AiStory, ({String deckId, String deckName, String vocabString, bool force})>((ref, args) async {
  final gemini = ref.read(geminiServiceProvider);
  return await gemini.generateStory(args.deckId, args.deckName, args.vocabString.split(','), forceRegenerate: args.force);
});

class StoryModeScreen extends ConsumerStatefulWidget {
  final Deck deck;
  final List<Flashcard> cards;

  const StoryModeScreen({super.key, required this.deck, required this.cards});

  @override
  ConsumerState<StoryModeScreen> createState() => _StoryModeScreenState();
}

class _StoryModeScreenState extends ConsumerState<StoryModeScreen> {
  bool _forceRegenerate = false;
  bool _showPinyin = true;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("zh-CN");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.setPitch(1.0);
    
    _flutterTts.setCompletionHandler(() {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _togglePlay(AiStory story) async {
    if (_isPlaying) {
      await _flutterTts.stop();
      if (mounted) setState(() => _isPlaying = false);
    } else {
      if (mounted) setState(() => _isPlaying = true);
      final text = story.sentences.map((s) => s.chinese).join(' ');
      await _flutterTts.speak(text);
    }
  }

  void _showFullTranslation(BuildContext context, AiStory story) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final fullEnglish = story.sentences.map((s) => s.english).join('\n\n');
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Full Translation",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      fullEnglish,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vocabString = widget.cards.map((c) => c.hanzi).join(',');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final asyncStory = ref.watch(storyProvider((
      deckId: widget.deck.id, 
      deckName: widget.deck.name, 
      vocabString: vocabString,
      force: _forceRegenerate
    )));

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: const Text("AI Story", style: TextStyle(fontFamily: 'NotoSerifSC')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Generate New Story",
            onPressed: () {
              setState(() {
                _forceRegenerate = true;
              });
              ref.invalidate(storyProvider);
            },
          ),
        ],
      ),
      body: asyncStory.when(
        data: (story) {
          if (_forceRegenerate) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => _forceRegenerate = false);
            });
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                // Render Sentences
                ...story.sentences.map((sentence) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 16.0,
                      children: sentence.words.map((word) {
                        final isPunctuation = RegExp(r'[^\w\s\u4e00-\u9fa5]', unicode: true).hasMatch(word.hanzi) || word.hanzi.trim().isEmpty;
                        
                        if (isPunctuation) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              word.hanzi,
                              style: TextStyle(
                                fontFamily: 'NotoSerifSC',
                                fontSize: 26,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          );
                        }

                        return GestureDetector(
                          onTap: () => WordDetailDialog.show(context, word, sentence),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                word.hanzi,
                                style: TextStyle(
                                  fontFamily: 'NotoSerifSC',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              if (_showPinyin)
                                Text(
                                  word.pinyin,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
                const SizedBox(height: 80), // Padding for bottom bar
              ],
            ),
          );
        },
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.purple),
              const SizedBox(height: 24),
              Text(
                "Gemini Flash is structuring your story...",
                style: TextStyle(
                  fontFamily: 'NotoSerifSC',
                  fontSize: 18,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              const Text("Using your deck's vocabulary", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        error: (e, st) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text("Failed to generate story:\n$e", textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _forceRegenerate = true);
                    ref.invalidate(storyProvider);
                  },
                  child: const Text("Try Again"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: asyncStory.hasValue && !asyncStory.hasError ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
          border: Border(top: BorderSide(color: isDark ? Colors.white12 : Colors.black12)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.translate, size: 20),
                label: const Text("Translate"),
                style: TextButton.styleFrom(foregroundColor: isDark ? Colors.white70 : Colors.black87),
                onPressed: () => _showFullTranslation(context, asyncStory.value!),
              ),
              TextButton.icon(
                icon: Icon(_showPinyin ? Icons.visibility : Icons.visibility_off, size: 20),
                label: const Text("Pinyin"),
                style: TextButton.styleFrom(foregroundColor: _showPinyin ? Colors.blueAccent : (isDark ? Colors.white70 : Colors.black87)),
                onPressed: () => setState(() => _showPinyin = !_showPinyin),
              ),
              TextButton.icon(
                icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow, size: 20),
                label: Text(_isPlaying ? "Stop" : "Play"),
                style: TextButton.styleFrom(foregroundColor: _isPlaying ? Colors.red : Colors.purple),
                onPressed: () => _togglePlay(asyncStory.value!),
              ),
            ],
          ),
        ),
      ) : null,
    );
  }
}
