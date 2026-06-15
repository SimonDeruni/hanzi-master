import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../providers/story_controller.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../flashcards/presentation/widgets/word_detail_dialog.dart';

class StoryReaderScreen extends ConsumerStatefulWidget {
  final StoryBlueprint blueprint;
  final int hskLevel;

  const StoryReaderScreen({
    super.key,
    required this.blueprint,
    required this.hskLevel,
  });

  @override
  ConsumerState<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends ConsumerState<StoryReaderScreen> {
  bool _showPinyin = true;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  bool _isSaved = true; // By default assume saved unless it's a new custom

  @override
  void initState() {
    super.initState();
    _initTts();
    
    // Determine if it's a custom unsaved story
    if (widget.blueprint.id.startsWith('custom_')) {
       // Since the new task requires explicit saving, we might treat custom as unsaved
       // For now, let's just assume it's saved.
       _isSaved = false; 
    }

    Future(() {
      if (mounted) {
        ref.read(storyControllerProvider.notifier).loadOrGenerateStory(widget.blueprint, widget.hskLevel);
      }
    });
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
    final state = ref.watch(storyControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: Text('${widget.blueprint.title} (HSK ${widget.hskLevel})', style: const TextStyle(fontFamily: 'NotoSerifSC')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (!_isSaved && state.currentStory != null) ...[
             TextButton.icon(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                label: const Text("Discard", style: TextStyle(color: Colors.redAccent)),
                onPressed: () async {
                   final controller = ref.read(storyControllerProvider.notifier);
                   await controller.deleteCustomStory(widget.blueprint);
                   if (context.mounted) {
                     Navigator.pop(context);
                   }
                },
             ),
             TextButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                onPressed: () {
                   setState(() { _isSaved = true; });
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Story saved to Library!")));
                },
             ),
          ]
        ],
      ),
      body: state.isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.indigo),
                  const SizedBox(height: 24),
                  const Text("Generating story via DeepSeek...", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text("HSK ${widget.hskLevel} vocabulary", style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : state.error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text("Failed to generate story:\n${state.error}", textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(storyControllerProvider.notifier).loadOrGenerateStory(widget.blueprint, widget.hskLevel);
                          },
                          child: const Text("Try Again"),
                        ),
                      ],
                    ),
                  ),
                )
              : state.currentStory == null
                  ? const Center(child: Text("Story not found."))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Thematic Cover Art
                          Container(
                            height: 200,
                            margin: const EdgeInsets.only(bottom: 32),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.indigo.shade400, Colors.purple.shade400],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.withValues(alpha: 0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: -20,
                                  bottom: -20,
                                  child: Icon(
                                    Icons.auto_stories,
                                    size: 150,
                                    color: Colors.white.withValues(alpha: 0.15),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.auto_awesome, color: Colors.white, size: 48),
                                      const SizedBox(height: 12),
                                      Text(
                                        "A Tale of HSK ${widget.hskLevel}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...state.currentStory!.sentences.map((sentence) {
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
                          }).toList(),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
      bottomNavigationBar: state.currentStory != null && !state.isLoading && state.error == null
          ? Container(
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
                      onPressed: () => _showFullTranslation(context, AiStory(sentences: state.currentStory!.sentences)),
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
                      onPressed: () => _togglePlay(AiStory(sentences: state.currentStory!.sentences)),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
