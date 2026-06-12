import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

final storyProvider = FutureProvider.family<AiStory, ({String deckId, String deckName, List<String> vocab, bool force})>((ref, args) async {
  final gemini = ref.read(geminiServiceProvider);
  return await gemini.generateStory(args.deckId, args.deckName, args.vocab, forceRegenerate: args.force);
});

class StoryModeScreen extends ConsumerStatefulWidget {
  final Deck deck;
  final List<Flashcard> cards;

  const StoryModeScreen({super.key, required this.deck, required this.cards});

  @override
  ConsumerState<StoryModeScreen> createState() => _StoryModeScreenState();
}

class _StoryModeScreenState extends ConsumerState<StoryModeScreen> {
  bool _showPinyin = false;
  bool _showEnglish = false;
  bool _forceRegenerate = false;

  @override
  Widget build(BuildContext context) {
    final vocab = widget.cards.map((c) => c.hanzi).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final asyncStory = ref.watch(storyProvider((
      deckId: widget.deck.id, 
      deckName: widget.deck.name, 
      vocab: vocab,
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
          // Once generated, reset the force flag so a normal rebuild won't hit the API unless requested
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
                // Chinese Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.02),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    story.chinese,
                    style: TextStyle(
                      fontFamily: 'NotoSerifSC',
                      fontSize: 24,
                      height: 2.0,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Pinyin Toggle & Section
                SwitchListTile(
                  title: const Text("Show Pinyin", style: TextStyle(fontWeight: FontWeight.bold)),
                  value: _showPinyin,
                  activeColor: Colors.purple,
                  onChanged: (val) => setState(() => _showPinyin = val),
                  contentPadding: EdgeInsets.zero,
                ),
                if (_showPinyin)
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      story.pinyin,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.8,
                        color: isDark ? Colors.purple[200] : Colors.purple[800],
                      ),
                    ),
                  ),
                
                // English Toggle & Section
                SwitchListTile(
                  title: const Text("Show Translation", style: TextStyle(fontWeight: FontWeight.bold)),
                  value: _showEnglish,
                  activeColor: Colors.blue,
                  onChanged: (val) => setState(() => _showEnglish = val),
                  contentPadding: EdgeInsets.zero,
                ),
                if (_showEnglish)
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      story.english,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: isDark ? Colors.blue[200] : Colors.blue[800],
                      ),
                    ),
                  ),
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
                "DeepSeek is writing your story...",
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
    );
  }
}
