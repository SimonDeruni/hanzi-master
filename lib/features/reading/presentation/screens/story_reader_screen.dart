import 'dart:async';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import '../providers/story_controller.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../../shared/widgets/quick_look_sheet.dart';
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
  bool _isPlaying = false;
  bool _isPaused = false;
  bool _isLoadingAudio = false;
  int? _playingSentenceIndex;
  int _playingStartOffset = -1;
  int _playingEndOffset = -1;
  StreamSubscription? _boundarySub;
  StreamSubscription<void>? _completionSub;
  bool _isSaved = true; // By default assume saved unless it's a new custom
  
  late PageController _pageController;
  int _currentPage = 0;

  Timer? _loadingTimer;
  int _loadingStep = 0;
  List<String> get _loadingMessages {
    if (widget.blueprint.id.startsWith('local_') || 
        widget.blueprint.id.startsWith('tang_poetry_') || 
        widget.blueprint.id.startsWith('mandarin_bean_')) {
      return [
        "Unrolling the scroll...",
        "Analyzing classical characters...",
        "Loading translations...",
        "Preparing reading interface...",
        "Finalizing details..."
      ];
    }
    return [
      "Drafting story outline...",
      "Selecting HSK vocabulary...",
      "Refining grammar...",
      "Translating and adding Pinyin...",
      "Finalizing story details..."
    ];
  }

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
        } else if (widget.blueprint.id.startsWith('custom_')) {
          ref.read(storyControllerProvider.notifier).loadOrGenerateStory(widget.blueprint, widget.hskLevel);
        } else if (widget.blueprint.id.startsWith('simplified_')) {
          // The simplification is already running in the background via story_controller.
          // We just wait for state.currentStory to be populated.
        } else if (widget.blueprint.id.startsWith('local_') || widget.blueprint.id.startsWith('tang_poetry_') || widget.blueprint.id.startsWith('http')) {
          ref.read(storyControllerProvider.notifier).fetchAndParseLocalStory(widget.blueprint, widget.hskLevel);
        } else {
          ref.read(storyControllerProvider.notifier).fetchAndParseFirebaseStory(widget.blueprint, widget.hskLevel);
        }
      }
    });

    _startLoadingTimer();
  }

  String _streamingText = "";
  bool _isStreaming = false;
  bool _streamFailed = false;
  String? _streamError;

  Future<void> _startStreamingStory() async {
    setState(() {
      _isStreaming = true;
      _streamingText = "";
      _streamFailed = false;
      _streamError = null;
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
        setState(() {
          _isStreaming = false;
        });
        
        await ref.read(storyControllerProvider.notifier).parseAndSaveCustomStory(
          widget.blueprint,
          _streamingText,
          widget.hskLevel
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _streamFailed = true;
          _streamError = e.toString();
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
    final audioService = ref.read(audioServiceProvider);
    // Warm up the audio service (cache dir, player) so first Play tap is fast
    await audioService.init();
    
    _completionSub = audioService.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _isPaused = false;
          _isLoadingAudio = false;
          _playingSentenceIndex = null;
          _playingStartOffset = -1;
          _playingEndOffset = -1;
        });
      }
    });

    _boundarySub = audioService.onWordBoundary.listen((boundary) {
      if (mounted) {
        setState(() {
          // Azure WordBoundary usually contains TextOffset and WordLength
          // If TextOffset is missing, we try to extract it from 'text' object
          int start = -1;
          int length = 0;
          
          if (boundary.containsKey('TextOffset')) {
            start = boundary['TextOffset'];
            length = boundary['WordLength'] ?? 1;
          } else if (boundary['text'] != null) {
            final textObj = boundary['text'];
            // Sometimes it's nested
            start = textObj['TextOffset'] ?? -1;
            length = textObj['Length'] ?? 1;
          }
          
          if (start >= 0) {
            _playingStartOffset = start;
            _playingEndOffset = start + length;
          } else if (boundary['text'] != null && boundary['text']['Text'] != null) {
              // Fallback: search for the word in the current sentence
              final word = boundary['text']['Text'] as String;
              if (_playingSentenceIndex != null) {
                final story = ref.read(storyControllerProvider).currentStory;
                if (story != null) {
                  final pageIndex = _playingSentenceIndex!;
                  final startIdx = pageIndex * 3;
                  final endIdx = (startIdx + 3).clamp(0, story.sentences.length);
                  final pageSentences = story.sentences.sublist(startIdx, endIdx);
                  final sentenceText = pageSentences.map((s) => s.chinese).join('');
                  
                  final searchStart = _playingEndOffset >= 0 ? _playingEndOffset : 0;
                  final idx = sentenceText.indexOf(word, searchStart);
                  if (idx != -1) {
                    _playingStartOffset = idx;
                    _playingEndOffset = idx + word.length;
                  }
                }
              }
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _pageController.dispose();
    _boundarySub?.cancel();
    _completionSub?.cancel();
    unawaited(ref.read(audioServiceProvider).stop());
    super.dispose();
  }

  void _togglePlay({bool stop = false}) async {
    final audioService = ref.read(audioServiceProvider);
    final story = ref.read(storyControllerProvider).currentStory;
    if (story == null) return;

    if (stop) {
      await audioService.stop();
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _isPaused = false;
          _isLoadingAudio = false;
          _playingSentenceIndex = null;
          _playingStartOffset = -1;
          _playingEndOffset = -1;
        });
      }
      return;
    }

    if (_isPlaying) {
      await audioService.stop();
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _isPaused = true;
          _isLoadingAudio = false;
        });
      }
    } else {
      // Show loading spinner immediately for visual feedback
      if (mounted) {
        setState(() {
          _isLoadingAudio = true;
        });
      }

      // Capture messenger before async gap to satisfy use_build_context_synchronously
      final messenger = ScaffoldMessenger.of(context);
      if (!_isPaused || _playingSentenceIndex == null) {
        // Start from beginning of the page
        if (mounted) {
          setState(() {
            _playingSentenceIndex = _currentPage;
            _playingStartOffset = -1;
            _playingEndOffset = -1;
          });
        }
        final startIdx = _currentPage * 3;
        final endIdx = (startIdx + 3).clamp(0, story.sentences.length);
        final pageSentences = story.sentences.sublist(startIdx, endIdx);
        final text = pageSentences.map((s) => s.chinese).join('');
        final success = await audioService.playSentence(text);
        if (mounted) {
          setState(() {
            _isPlaying = success;
            _isPaused = !success;
            _isLoadingAudio = false;
            if (!success) {
              _playingSentenceIndex = null;
              messenger.showSnackBar(
                const SnackBar(
                  content: Text('Audio unavailable — check your connection'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          });
        }
      } else {
        // Resume from pause
        final startIdx = _currentPage * 3;
        final endIdx = (startIdx + 3).clamp(0, story.sentences.length);
        final pageSentences = story.sentences.sublist(startIdx, endIdx);
        final text = pageSentences.map((s) => s.chinese).join('');
        // Since Azure TTS streams the full file, "resuming" mid-sentence is complex.
        // We will just replay the whole sentence for now for the premium experience.
        if (mounted) {
          setState(() {
            _playingStartOffset = -1;
            _playingEndOffset = -1;
          });
        }
        final success = await audioService.playSentence(text);
        if (mounted) {
          setState(() {
            _isPlaying = success;
            _isPaused = !success;
            _isLoadingAudio = false;
            if (!success) {
              _playingSentenceIndex = null;
              messenger.showSnackBar(
                const SnackBar(
                  content: Text('Audio unavailable — check your connection'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          });
        }
      }
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

    return PopScope(
      canPop: !_isPlaying,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await ref.read(audioServiceProvider).stop();
          if (!mounted) return;
          setState(() { _isPlaying = false; _isPaused = false; });
          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
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
                label: Text(AppLocalizations.of(context)!.discard, style: const TextStyle(color: Colors.redAccent)),
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
                            "Paragraph ${_currentPage + 1} of ${((state.currentStory!.sentences.length - 1) ~/ 3) + 1}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                          ),
                          Text(
                            "${((_currentPage + 1) / (((state.currentStory!.sentences.length - 1) ~/ 3) + 1) * 100).toInt()}%",
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
                          value: state.currentStory!.sentences.isEmpty ? 0 : (_currentPage + 1) / (((state.currentStory!.sentences.length - 1) ~/ 3) + 1),
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
      body: _isStreaming
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
                      if (!widget.blueprint.id.startsWith('local_') && 
                          !widget.blueprint.id.startsWith('tang_poetry_') && 
                          !widget.blueprint.id.startsWith('simplified_') && 
                          !widget.blueprint.id.startsWith('mandarin_bean_'))
                      if (widget.hskLevel > 0)
                        Text("HSK ${widget.hskLevel} vocabulary", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              : (_streamFailed && _streamError != null) || state.error != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 64, color: Colors.red),
                            const SizedBox(height: 16),
                            Text("Failed to generate story:\n${_streamError ?? state.error}", textAlign: TextAlign.center),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                if (_streamFailed) {
                                  setState(() {
                                    _streamFailed = false;
                                    _streamError = null;
                                  });
                                }
                                if (widget.blueprint.id.startsWith('custom_') && ref.read(storyControllerProvider).currentStory == null) {
                                  _startStreamingStory();
                                } else if (widget.blueprint.id.startsWith('custom_')) {
                                  ref.read(storyControllerProvider.notifier).loadOrGenerateStory(widget.blueprint, widget.hskLevel);
                                } else if (widget.blueprint.id.startsWith('local_') || widget.blueprint.id.startsWith('tang_poetry_') || widget.blueprint.id.startsWith('http')) {
                                  ref.read(storyControllerProvider.notifier).fetchAndParseLocalStory(widget.blueprint, widget.hskLevel);
                                } else {
                                  ref.read(storyControllerProvider.notifier).fetchAndParseFirebaseStory(widget.blueprint, widget.hskLevel);
                                }
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                              child: Text(AppLocalizations.of(context)!.tryAgain, style: const TextStyle(color: Colors.white)),
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
                          itemCount: ((state.currentStory!.sentences.length - 1) ~/ 3) + 1,
                          itemBuilder: (context, pageIndex) {
                            const sentencesPerPage = 3;
                            final startIdx = pageIndex * sentencesPerPage;
                            final endIdx = (startIdx + sentencesPerPage).clamp(0, state.currentStory!.sentences.length);
                            final pageSentences = state.currentStory!.sentences.sublist(startIdx, endIdx);

                            return SingleChildScrollView(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (pageIndex == 0) ...[
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
                                                  widget.hskLevel == 0 ? "A Custom Tale" : "A Tale of HSK ${widget.hskLevel}",
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

                                  // Card containing all sentences for this page
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
                                        for (int si = 0; si < pageSentences.length; si++) ...[
                                          if (si > 0) const Divider(height: 32),
                                          Builder(builder: (context) {
                                            final sentence = pageSentences[si];
                                            final globalIndex = startIdx + si;
                                            int currentStringOffset = 0;
                                            return Column(
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
                                                          final int wordStart = currentStringOffset;
                                                          final int wordEnd = currentStringOffset + word.hanzi.length;
                                                          currentStringOffset = wordEnd;

                                                          final isPunctuation = RegExp(r'[^\w\s\u4e00-\u9fa5]', unicode: true).hasMatch(word.hanzi) || word.hanzi.trim().isEmpty;
                                                          
                                                          final isSpeakingThisSentence = _playingSentenceIndex == pageIndex;
                                                          final isWordActive = isSpeakingThisSentence && _playingStartOffset >= 0 && wordStart <= _playingStartOffset && wordEnd > _playingStartOffset;

                                                          final textColor = isWordActive 
                                                              ? Colors.orange 
                                                              : (isDark ? Colors.white : Colors.black87);

                                                          if (isPunctuation) {
                                                            return Padding(
                                                              padding: const EdgeInsets.only(top: 8.0),
                                                              child: Text(
                                                                word.hanzi,
                                                                style: TextStyle(
                                                                  fontFamily: 'NotoSerifSC',
                                                                  fontSize: 26,
                                                                  color: textColor,
                                                                ),
                                                              ),
                                                            );
                                                          }

                                                          bool shouldShowPinyin = (_pinyinMode == PinyinMode.all);

                                                          return GestureDetector(
                                                            onTap: () => showQuickLook(context, word.hanzi, contextText: sentence.chinese),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text(
                                                                  word.hanzi,
                                                                  style: TextStyle(
                                                                    fontFamily: 'NotoSerifSC',
                                                                    fontSize: 28,
                                                                    fontWeight: dueWords.contains(word.hanzi) ? FontWeight.bold : FontWeight.w600,
                                                                    color: isWordActive ? Colors.orange : (dueWords.contains(word.hanzi) ? const Color(0xFFD4AF37) : textColor),
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
                                                          if (_translatedSentences.contains(globalIndex)) {
                                                            _translatedSentences.remove(globalIndex);
                                                          } else {
                                                            _translatedSentences.add(globalIndex);
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                if (_translatedSentences.contains(globalIndex))
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 12.0),
                                                    child: Container(
                                                      padding: const EdgeInsets.all(12),
                                                      decoration: BoxDecoration(
                                                        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.02),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      child: Text(
                                                        sentence.english,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: isDark ? Colors.white70 : Colors.black87,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          }),
                                        ],
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
                      icon: _isLoadingAudio
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.purple),
                            )
                          : Icon(_isPlaying ? Icons.stop : Icons.play_arrow, size: 20),
                      label: Text(_isLoadingAudio ? "Loading..." : (_isPlaying ? "Stop" : "Play")),
                      style: TextButton.styleFrom(foregroundColor: _isPlaying ? Colors.red : Colors.purple),
                      onPressed: _isLoadingAudio ? null : () => _togglePlay(),
                    ),
                  ],
                ),
              ),
            )
          : null,
      ),
    );
  }
}