import 'dart:async';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import '../providers/story_controller.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../flashcards/presentation/widgets/word_detail_dialog.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/domain/entities/study_mode.dart';

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

enum PinyinMode { all, ghost, none }

class _StoryReaderScreenState extends ConsumerState<StoryReaderScreen> {
  PinyinMode _pinyinMode = PinyinMode.all;
  final Set<int> _translatedSentences = {};
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  bool _isSaved = true; // By default assume saved unless it's a new custom
  
  late PageController _pageController;
  int _currentPage = 0;

  Timer? _loadingTimer;
  int _loadingStep = 0;
  final List<String> _loadingMessages = [
    "Drafting story outline...",
    "Selecting HSK vocabulary...",
    "Refining grammar...",
    "Translating and adding Pinyin...",
    "Finalizing story details..."
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _initTts();
    
    // Determine if it's a custom unsaved story
    if (widget.blueprint.id.startsWith('custom_')) {
       _isSaved = false; 
    }

    Future(() {
      if (mounted) {
        if (widget.blueprint.id.startsWith('custom_') && ref.read(storyControllerProvider).currentStory == null) {
          _startStreamingStory();
        } else if (widget.blueprint.id.startsWith('assets/')) {
          ref.read(storyControllerProvider.notifier).fetchAndParseAssetStory(widget.blueprint, widget.hskLevel);
        } else {
          ref.read(storyControllerProvider.notifier).loadOrGenerateStory(widget.blueprint, widget.hskLevel);
        }
      }
    });

    _startLoadingTimer();
  }

  String _streamingText = "";
  bool _isStreaming = false;

  Future<void> _startStreamingStory() async {
    setState(() {
      _isStreaming = true;
      _streamingText = "";
    });

    try {
      final geminiService = ref.read(geminiServiceProvider);
      
      // Fetch due flashcards for stealth reviews
      final flashcards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
      final dueWords = flashcards
          .where((c) => c.isDue(StudyMode.reading))
          .map((c) => c.hanzi)
          .toList();
      
      // Shuffle to get a random subset so we don't always use the same 10 if there are many due
      dueWords.shuffle();
      final stealthVocab = dueWords.take(10).toList();

      List<String> masteredWords = [];
      List<String> strugglingWords = [];
      
      if (widget.hskLevel == 0) {
        // Flow State Engine: Collect subsets
        final mastered = flashcards.where((c) => c.globalMasteryLevel >= 0.8).map((c) => c.hanzi).toList();
        final struggling = flashcards.where((c) => c.globalMasteryLevel < 0.5).map((c) => c.hanzi).toList();
        
        mastered.shuffle();
        struggling.shuffle();
        
        masteredWords = mastered.take(50).toList();
        strugglingWords = struggling.take(20).toList();
      }

      final stream = geminiService.streamGradedStoryRawText(
        widget.blueprint.topic, 
        widget.blueprint.category, 
        widget.hskLevel,
        dueWords: stealthVocab,
        masteredWords: masteredWords,
        strugglingWords: strugglingWords,
      );

      await for (final chunk in stream) {
        if (mounted) {
          setState(() {
            _streamingText += chunk;
          });
        }
      }

      // Slot Machine Reveal
      if (mounted) {
        // We trigger the shake and sound
        final player = AudioPlayer();
        await player.play(AssetSource('audio/whoosh.wav'));
      }

      if (mounted) {
        await ref.read(storyControllerProvider.notifier).parseAndSaveCustomStory(
          widget.blueprint,
          _streamingText,
          widget.hskLevel
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error generating story: $e")));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isStreaming = false;
        });
      }
    }
  }

  void _startLoadingTimer() {
    _loadingTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _loadingStep = (_loadingStep + 1) % _loadingMessages.length;
        });
      }
    });
  }

  Future<void> _initTts() async {
    await    _flutterTts.setLanguage("zh-CN");
    _flutterTts.setSpeechRate(0.45);
    _flutterTts.setPitch(1.0);
    _flutterTts.setCompletionHandler(() {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _togglePlay(AiStory story) async {
    if (_isPlaying) {
      await _flutterTts.stop();
      if (mounted) setState(() => _isPlaying = false);
    } else {
      if (mounted) setState(() => _isPlaying = true);
      // Play only the current page's sentence instead of the whole story
      final text = story.sentences[_currentPage].chinese;
      await _flutterTts.speak(text);
    }
  }

  void _showSummary(BuildContext context, AiStory story) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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
                      "Summary",
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
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: story.sentences.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final s = story.sentences[index];
                      // Combine word pinyin to get sentence pinyin
                      final sentencePinyin = s.words.map((w) => w.pinyin).join(' ');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.chinese,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              sentencePinyin,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.white54 : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              s.english,
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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

    final flashcards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
    final dueWords = flashcards
        .where((c) => c.isDue(StudyMode.reading))
        .map((c) => c.hanzi)
        .toSet();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: Text(
          widget.hskLevel == 0 ? widget.blueprint.title : 'HSK ${widget.hskLevel}: ${widget.blueprint.title}',
          style: TextStyle(fontFamily: 'NotoSerifSC', color: isDark ? Colors.white : Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (!_isSaved && state.currentStory != null) ...[
             TextButton.icon(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                label: Text(AppLocalizations.of(context)!.discard, style: TextStyle(color: Colors.redAccent)),
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
                label: Text(AppLocalizations.of(context)!.save),
                onPressed: () {
                   setState(() { _isSaved = true; });
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.storySavedToLibrary)));
                },
             ),
          ]
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: state.currentStory != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Paragraph ${_currentPage + 1} of ${state.currentStory!.sentences.length}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                          ),
                          Text(
                            "${((_currentPage + 1) / state.currentStory!.sentences.length * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: state.currentStory!.sentences.isEmpty ? 0 : (_currentPage + 1) / state.currentStory!.sentences.length,
                          backgroundColor: isDark ? Colors.white12 : Colors.black12,
                          color: Colors.indigo,
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: _isStreaming || (state.isLoading && widget.blueprint.id.startsWith('custom_'))
          ? Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  _streamingText,
                  style: TextStyle(
                    fontFamily: 'NotoSerifSC',
                    fontSize: 28,
                    color: isDark ? Colors.white : Colors.black87,
                    height: 1.8,
                  ),
                ),
              ),
            )
          : state.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Colors.indigo),
                      const SizedBox(height: 24),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          _loadingMessages[_loadingStep],
                          key: ValueKey<int>(_loadingStep),
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                                if (widget.blueprint.id.startsWith('custom_')) {
                                  _startStreamingStory();
                                } else if (widget.blueprint.id.startsWith('assets/')) {
                                  ref.read(storyControllerProvider.notifier).fetchAndParseAssetStory(widget.blueprint, widget.hskLevel);
                                } else {
                                  ref.read(storyControllerProvider.notifier).loadOrGenerateStory(widget.blueprint, widget.hskLevel);
                                }
                              },
                              child: Text(AppLocalizations.of(context)!.tryAgain),
                            ),
                          ],
                        ),
                      ),
                    )
                  : state.currentStory == null
                      ? Center(child: Text(AppLocalizations.of(context)!.storyNotFound))
                      : PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                            HapticsManager.light();
                          },
                          itemCount: state.currentStory!.sentences.length,
                          itemBuilder: (context, index) {
                            var sentence = state.currentStory!.sentences[index];
                            return SingleChildScrollView(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (index == 0) ...[
                                    // Thematic Cover Art on the first page
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
                                  ],
                                  
                                  // Paragraph Card
                                  Container(
                                    padding: const EdgeInsets.all(24.0),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF222222) : Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                      border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
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

                                                  bool shouldShowPinyin = (_pinyinMode == PinyinMode.all);

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
                                                            fontWeight: dueWords.contains(word.hanzi) ? FontWeight.bold : FontWeight.w600,
                                                            color: dueWords.contains(word.hanzi) 
                                                                ? const Color(0xFFD4AF37) // Gold accent
                                                                : (isDark ? Colors.white : Colors.black87),
                                                          ),
                                                        ),
                                                        if (shouldShowPinyin)
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
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.language, color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  if (_translatedSentences.contains(index)) {
                                                    _translatedSentences.remove(index);
                                                  } else {
                                                    _translatedSentences.add(index);
                                                  }
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        if (_translatedSentences.contains(index))
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.02),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                sentence.english,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: isDark ? Colors.white70 : Colors.black87,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 80),
                                ],
                              ),
                            );
                          },
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
                      icon: const Icon(Icons.article, size: 20),
                      label: const Text("Summary"),
                      style: TextButton.styleFrom(foregroundColor: isDark ? Colors.white70 : Colors.black87),
                      onPressed: () => _showSummary(context, AiStory(sentences: state.currentStory!.sentences)),
                    ),
                    TextButton.icon(
                      icon: Icon(
                        _pinyinMode == PinyinMode.all ? Icons.visibility : 
                        _pinyinMode == PinyinMode.ghost ? Icons.visibility_outlined : Icons.visibility_off, 
                        size: 20
                      ),
                      label: Text(
                        _pinyinMode == PinyinMode.all ? "All Pinyin" :
                        _pinyinMode == PinyinMode.ghost ? "Ghost Pinyin" : "No Pinyin"
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: _pinyinMode != PinyinMode.none ? Colors.blueAccent : (isDark ? Colors.white70 : Colors.black87)
                      ),
                      onPressed: () {
                        setState(() {
                          if (_pinyinMode == PinyinMode.all) {
                            _pinyinMode = PinyinMode.ghost;
                          } else if (_pinyinMode == PinyinMode.ghost) {
                            _pinyinMode = PinyinMode.none;
                          } else {
                            _pinyinMode = PinyinMode.all;
                          }
                        });
                      },
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
