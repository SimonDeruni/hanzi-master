import 'dart:async';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/features/reading/domain/entities/graded_story.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

final storyProvider = FutureProvider.family<AiStory, ({String deckId, String deckName, String vocabString, bool force})>((ref, args) async {
  final gemini = ref.read(geminiServiceProvider);
  return await gemini.generateStory(args.deckId, args.deckName, args.vocabString.split(','), forceRegenerate: args.force);
});

enum _PinyinMode { all, ghost, none }

class StoryModeScreen extends ConsumerStatefulWidget {
  final Deck deck;
  final List<Flashcard> cards;

  const StoryModeScreen({super.key, required this.deck, required this.cards});

  @override
  ConsumerState<StoryModeScreen> createState() => _StoryModeScreenState();
}

class _StoryModeScreenState extends ConsumerState<StoryModeScreen> {
  bool _forceRegenerate = false;
  _PinyinMode _pinyinMode = _PinyinMode.all;
  final Set<int> _translatedSentences = {};
  bool _isPlaying = false;
  bool _isPaused = false;
  int? _playingSentenceIndex;
  int _playingStartOffset = -1;
  int _playingEndOffset = -1;
  StreamSubscription? _boundarySub;
  bool _isSaved = false;

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _initTts();
  }

  Future<void> _initTts() async {
    final audioService = ref.read(audioServiceProvider);

    audioService.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _isPaused = false;
          _playingSentenceIndex = null;
          _playingStartOffset = -1;
          _playingEndOffset = -1;
        });
      }
    });

    _boundarySub = audioService.onWordBoundary.listen((boundary) {
      if (mounted) {
        setState(() {
          int start = -1;
          int length = 0;

          if (boundary.containsKey('TextOffset')) {
            start = boundary['TextOffset'];
            length = boundary['WordLength'] ?? 1;
          } else if (boundary['text'] != null) {
            final textObj = boundary['text'];
            start = textObj['TextOffset'] ?? -1;
            length = textObj['Length'] ?? 1;
          }

          if (start >= 0) {
            _playingStartOffset = start;
            _playingEndOffset = start + length;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _boundarySub?.cancel();
    ref.read(audioServiceProvider).stop();
    super.dispose();
  }

  Future<void> _togglePlay(AiStory story, {bool stop = false}) async {
    final audioService = ref.read(audioServiceProvider);
    if (stop) {
      await audioService.stop();
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _isPaused = false;
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
        });
      }
    } else {
      if (!_isPaused || _playingSentenceIndex == null) {
        if (mounted) {
          setState(() {
            _playingSentenceIndex = _currentPage;
            _playingStartOffset = -1;
            _playingEndOffset = -1;
          });
        }
        final text = story.sentences[_currentPage].chinese;
        final success = await audioService.playSentence(text);
        if (mounted) {
          setState(() {
            _isPlaying = success;
            _isPaused = !success;
            if (!success) _playingSentenceIndex = null;
          });
        }
      } else {
        final text = story.sentences[_currentPage].chinese;
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
            if (!success) _playingSentenceIndex = null;
          });
        }
      }
    }
  }

  Future<void> _saveStory(AiStory story) async {
    final gradedStory = GradedStory(
      id: 'deck_${widget.deck.id}_${DateTime.now().millisecondsSinceEpoch}',
      title: widget.deck.localizedName(context),
      category: 'Deck Story',
      hskLevel: 0,
      sentences: story.sentences,
      generatedAt: DateTime.now(),
      sourceDeckId: widget.deck.id,
      sourceDeckName: widget.deck.localizedName(context),
    );
    await ref.read(storyRepositoryProvider).saveStory(gradedStory);
    if (mounted) {
      setState(() => _isSaved = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.storySavedToLibrary)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vocabString = widget.cards.map((c) => c.hanzi).join(',');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final flashcards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
    final dueWords = flashcards
        .where((c) => c.isDue(StudyMode.reading))
        .map((c) => c.hanzi)
        .toSet();

    final asyncStory = ref.watch(storyProvider((
      deckId: widget.deck.id,
      deckName: widget.deck.localizedName(context),
      vocabString: vocabString,
      force: _forceRegenerate,
    )));

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.aiStory,
          style: TextStyle(fontFamily: 'NotoSerifSC', color: isDark ? Colors.white : Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (asyncStory.hasValue && !_isSaved)
            TextButton.icon(
              icon: const Icon(Icons.bookmark_outline),
              label: Text(AppLocalizations.of(context)!.save),
              onPressed: () => _saveStory(asyncStory.value!),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Generate New Story",
            onPressed: () {
              setState(() {
                _forceRegenerate = true;
                _isSaved = false;
              });
              ref.invalidate(storyProvider);
            },
          ),
        ],
        bottom: asyncStory.hasValue
            ? PreferredSize(
                preferredSize: const Size.fromHeight(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: (_currentPage + 1) / asyncStory.value!.sentences.length,
                      backgroundColor: isDark ? Colors.white12 : Colors.black12,
                      valueColor: AlwaysStoppedAnimation(isDark ? Colors.white38 : Colors.black38),
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: asyncStory.when(
        data: (story) {
          if (_forceRegenerate) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => _forceRegenerate = false);
            });
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sentence ${_currentPage + 1} of ${story.sentences.length}',
                      style: TextStyle(fontSize: 13, color: isDark ? Colors.white38 : Colors.black38),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pinyinMode = _pinyinMode == _PinyinMode.all
                              ? _PinyinMode.ghost
                              : _pinyinMode == _PinyinMode.ghost
                                  ? _PinyinMode.none
                                  : _PinyinMode.all;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _pinyinMode == _PinyinMode.all
                              ? '拼音'
                              : _pinyinMode == _PinyinMode.ghost
                                  ? '幻拼'
                                  : '无拼',
                          style: TextStyle(
                            fontFamily: 'NotoSerifSC',
                            fontSize: 13,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: story.sentences.length,
                  onPageChanged: (page) {
                    setState(() => _currentPage = page);
                  },
                  itemBuilder: (context, index) {
                    final sentence = story.sentences[index];
                    final isTranslated = _translatedSentences.contains(index);
                    final isPlaying = _playingSentenceIndex == index;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0) ...[
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    isDark ? const Color(0xFF3A2E2A) : const Color(0xFFE8E0D0),
                                    isDark ? const Color(0xFF2A2D34) : const Color(0xFFD0C8B8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Icon(Icons.auto_stories, size: 48, color: isDark ? Colors.white38 : Colors.black38),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF252529) : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 16.0,
                                  children: () {
                                    int charIndex = 0;
                                    return sentence.words.map((word) {
                                      final wordStart = charIndex;
                                      charIndex += word.hanzi.length;
                                      final wordEnd = charIndex;

                                      final isBeingSpoken = isPlaying &&
                                          _playingStartOffset >= 0 &&
                                          wordStart >= _playingStartOffset &&
                                          wordEnd <= _playingEndOffset;
                                      final isDue = dueWords.contains(word.hanzi);
                                      final isPunctuation = RegExp(r'[^\w\s\u4e00-\u9fa5]', unicode: true).hasMatch(word.hanzi) || word.hanzi.trim().isEmpty;

                                      if (isPunctuation) {
                                        return Padding(
                                          key: ValueKey('punct_$wordStart'),
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
                                        key: ValueKey('word_$wordStart'),
                                        onTap: () => showQuickLook(context, word.hanzi, contextText: sentence.chinese),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              word.hanzi,
                                              style: TextStyle(
                                                fontFamily: 'NotoSerifSC',
                                                fontSize: 28,
                                                fontWeight: isDue ? FontWeight.w900 : FontWeight.w600,
                                                color: isBeingSpoken
                                                    ? Colors.orange
                                                    : isDue
                                                        ? const Color(0xFFD4AF37)
                                                        : (isDark ? Colors.white : Colors.black87),
                                              ),
                                            ),
                                            if (_pinyinMode != _PinyinMode.none && (_pinyinMode == _PinyinMode.all || isBeingSpoken))
                                              Text(
                                                word.pinyin,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: isBeingSpoken
                                                      ? Colors.orange.shade300
                                                      : Colors.blueAccent,
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    }).toList();
                                  }(),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isTranslated) {
                                            _translatedSentences.remove(index);
                                          } else {
                                            _translatedSentences.add(index);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.translate,
                                          size: 18,
                                          color: isTranslated
                                              ? Colors.blueAccent
                                              : (isDark ? Colors.white54 : Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (isTranslated) ...[
                                  const SizedBox(height: 12),
                                  Divider(color: isDark ? Colors.white12 : Colors.black12),
                                  const SizedBox(height: 12),
                                  Text(
                                    sentence.english,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      color: isDark ? Colors.white70 : Colors.black87,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.purple),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.geminiFlashIsStructuring,
                style: TextStyle(
                  fontFamily: 'NotoSerifSC',
                  fontSize: 18,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.usingYourDecksVocabulary, style: const TextStyle(color: Colors.grey)),
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
                  child: Text(AppLocalizations.of(context)!.tryAgain),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: asyncStory.hasValue && !asyncStory.hasError
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
                      icon: Icon(
                        _isPlaying ? Icons.stop : Icons.play_arrow,
                        size: 20,
                      ),
                      label: Text(_isPlaying ? "Stop" : "Play"),
                      style: TextButton.styleFrom(
                        foregroundColor: _isPlaying ? Colors.red : Colors.purple,
                      ),
                      onPressed: () => _togglePlay(asyncStory.value!, stop: _isPlaying),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.translate, size: 20),
                      label: const Text("Translate"),
                      style: TextButton.styleFrom(
                        foregroundColor: isDark ? Colors.white70 : Colors.black87,
                      ),
                      onPressed: () {
                        final story = asyncStory.value!;
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) {
                            final fullEnglish = story.sentences.map((s) => s.english).join('\n\n');
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
                                  ),
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
                                          AppLocalizations.of(context)!.fullTranslation,
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
                      },
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
