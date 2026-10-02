import 'dart:async';
import 'package:hanzi_master/core/utils/network_failure.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/network_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/zen_ambient_service.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/widgets/translated_text.dart';
import 'package:hanzi_master/shared/widgets/zen_soundscape_sheet.dart';
import '../providers/story_controller.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../shared/widgets/quick_look_sheet.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';

/// Tone-marked pinyin for one story word, derived from the hanzi when the word
/// does not carry its own.
///
/// **Why this exists.** Story words arrive with `pinyin: ''` whenever the word
/// list was built locally: `GeminiService._deriveWords` makes one word per
/// character and documents that *"the reader derives pinyin from the hanzi
/// itself (`PinyinHelper`)"*. `BookReaderScreen` honours that contract in
/// `_getRubyTokens`; this reader printed `word.pinyin` straight out, so every
/// derived story showed a blank pinyin line in **every** pinyin mode — which is
/// why a deck story had no pinyin and no mode change ever brought it back.
///
/// A word that already carries pinyin keeps it: the model's answer is better
/// than a per-character guess for a multi-character word. The one exception is a
/// "pinyin" that merely echoes the gloss, a known model failure mode that the
/// transcript pipeline guards against the same way.
@visibleForTesting
String storyWordPinyin(String hanzi, String? pinyin, {String? echo}) {
  final String provided = (pinyin ?? '').trim();
  final bool echoesGloss =
      echo != null && provided.toLowerCase() == echo.trim().toLowerCase();
  if (provided.isNotEmpty && !echoesGloss) return provided;
  if (hanzi.isEmpty) return '';
  final String? cached = _storyPinyinCache[hanzi];
  if (cached != null) return cached;
  final String derived = _containsHanzi(hanzi)
      ? PinyinHelper.getPinyinE(
          hanzi,
          separator: ' ',
          format: PinyinFormat.WITH_TONE_MARK,
        ).trim()
      : '';
  _storyPinyinCache[hanzi] = derived;
  return derived;
}

/// Bounded in practice by the vocabulary of the stories actually opened, and
/// the same trade `BookReaderScreen._rubyCache` makes.
final Map<String, String> _storyPinyinCache = <String, String>{};

final RegExp _hanziRun = RegExp(r'[\u4e00-\u9fff]');

bool _containsHanzi(String text) => _hanziRun.hasMatch(text);


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

  /// Translations are **on** by default, the same contract the book reader keeps
  /// (`BookReaderScreen._showAllTranslations`). They used to be opt-in per
  /// sentence behind an unlabelled grey translate icon, so a freshly opened
  /// story showed none — "no translation" was the default state, not a bug in
  /// the data.
  bool _showAllTranslations = true;

  /// 17 → 20 → 24 → 28 → 17pt, the book reader's ladder. The surface used to
  /// hard-code 28pt hanzi, which is unwieldy on a phone and immovable on iPad.
  double _fontSize = 20.0;

  /// Revealed while the global toggle is off.
  final Set<int> _translatedSentences = {};

  /// Hidden again while the global toggle is on, so a tap on a sentence always
  /// does something visible. The book reader's `_showAllTranslations || isRevealed`
  /// makes its own per-sentence tap inert while the toolbar toggle is on.
  final Set<int> _hiddenTranslations = {};

  bool _isTranslationShown(int index) => _showAllTranslations
      ? !_hiddenTranslations.contains(index)
      : _translatedSentences.contains(index);
  String? _quickLookSelectedWordKey;
  bool _isPlaying = false;
  bool _isPaused = false;
  int? _playingSentenceIndex;
  int _playingStartOffset = -1;
  int _playingEndOffset = -1;
  StreamSubscription? _boundarySub;
  StreamSubscription<void>? _completionSub;
  bool _isSaved = true; // By default assume saved unless it's a new custom

  Timer? _loadingTimer;
  int _loadingStep = 0;
  List<String> get _loadingMessages {
    if (widget.blueprint.id.startsWith('local_') ||
        widget.blueprint.id.startsWith('tang_poetry_') ||
        widget.blueprint.id.startsWith('mandarin_bean_')) {
      return [
        AppLocalizations.of(context)!.unrollingTheScroll,
        AppLocalizations.of(context)!.analyzingClassicalCharacters,
        AppLocalizations.of(context)!.loadingTranslations,
        AppLocalizations.of(context)!.preparingReadingInterface,
        AppLocalizations.of(context)!.finalizingDetails
      ];
    }
    return [
      AppLocalizations.of(context)!.draftingStoryOutline,
      AppLocalizations.of(context)!.selectingHskVocabulary,
      AppLocalizations.of(context)!.refiningGrammar,
      AppLocalizations.of(context)!.translatingAndAddingPinyin,
      AppLocalizations.of(context)!.finalizingStoryDetails
    ];
  }

  /// Captured in `initState` because `ref` cannot be read from `dispose()`.
  /// Reading the providers inside `dispose` threw `Bad state: Cannot use "ref"
  /// after the widget was disposed`, so the audio engine was never actually
  /// stopped and the ambient soundscape never paused when a reader left a story
  /// — the cleanup line threw instead of running.
  late final AudioService _audioService;
  late final ZenAmbientService _ambientService;

  @override
  void initState() {
    super.initState();
    _audioService = ref.read(audioServiceProvider);
    _ambientService = ref.read(zenAmbientServiceProvider.notifier);
    _initTts();

    // Determine if it's a custom unsaved story
    if (widget.blueprint.id.startsWith('custom_')) {
      _isSaved = false;
    }

    Future(() {
      if (mounted) {
        if (widget.blueprint.id.startsWith('custom_') &&
            ref.read(storyControllerProvider).currentStory == null) {
          _startStreamingStory();
        } else if (widget.blueprint.id.startsWith('custom_')) {
          ref
              .read(storyControllerProvider.notifier)
              .loadOrGenerateStory(widget.blueprint, widget.hskLevel);
        } else if (widget.blueprint.id.startsWith('simplified_')) {
          // The simplification is already running in the background via story_controller.
          // We just wait for state.currentStory to be populated.
        } else if (widget.blueprint.id.startsWith('local_') ||
            widget.blueprint.id.startsWith('tang_poetry_') ||
            widget.blueprint.id.startsWith('http')) {
          ref
              .read(storyControllerProvider.notifier)
              .fetchAndParseLocalStory(widget.blueprint, widget.hskLevel);
        } else {
          ref
              .read(storyControllerProvider.notifier)
              .fetchAndParseFirebaseStory(widget.blueprint, widget.hskLevel);
        }
      }
    });

    _startLoadingTimer();
  }

  String _streamingText = "";
  bool _isStreaming = false;
  bool _streamFailed = false;
  String? _streamError;

  /// Whether the failure was a lost connection, so the panel can show the wifi
  /// glyph instead of a red alert.
  bool _streamErrorOffline = false;

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
      final flashcards =
          ref.read(flashcardControllerProvider).valueOrNull ?? [];
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
        final mastered = flashcards
            .where((c) => c.globalMasteryLevel >= 0.8)
            .map((c) => c.hanzi)
            .toList();
        final struggling = flashcards
            .where((c) => c.globalMasteryLevel < 0.5)
            .map((c) => c.hanzi)
            .toList();

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
      if (mounted) {}

      if (mounted) {
        setState(() {
          _isStreaming = false;
        });

        await ref
            .read(storyControllerProvider.notifier)
            .parseAndSaveCustomStory(
                widget.blueprint, _streamingText, widget.hskLevel);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _streamFailed = true;
          _streamErrorOffline = NetworkFailure.isOffline(e);
          _streamError =
              NetworkNotice.describe(context, e, fallback: e.toString());
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
          } else if (boundary['text'] != null &&
              boundary['text']['Text'] != null) {
            // Fallback: search for the word in the current sentence
            final word = boundary['text']['Text'] as String;
            if (_playingSentenceIndex != null) {
              final story = ref.read(storyControllerProvider).currentStory;
              if (story != null) {
                final pageIndex = _playingSentenceIndex!;
                final startIdx = pageIndex * 3;
                final endIdx = (startIdx + 3).clamp(0, story.sentences.length);
                final pageSentences = story.sentences.sublist(startIdx, endIdx);
                final sentenceText =
                    pageSentences.map((s) => s.chinese).join('');

                final searchStart =
                    _playingEndOffset >= 0 ? _playingEndOffset : 0;
                final idx = sentenceText.indexOf(word, searchStart);
                if (idx != -1) {
                  _playingStartOffset = idx;
                  _playingEndOffset = idx + word.length;
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
    _boundarySub?.cancel();
    _completionSub?.cancel();
    unawaited(_audioService.stop());
    unawaited(_ambientService.pause());
    super.dispose();
  }

  /// all → ghost → none → all, matching the book reader's toggle.
  void _cyclePinyinMode() {
    HapticsManager.light();
    setState(() {
      if (_pinyinMode == PinyinMode.all) {
        _pinyinMode = PinyinMode.ghost;
      } else if (_pinyinMode == PinyinMode.ghost) {
        _pinyinMode = PinyinMode.none;
      } else {
        _pinyinMode = PinyinMode.all;
      }
    });
  }

  void _cycleFontSize() {
    HapticsManager.light();
    setState(() {
      if (_fontSize == 17.0) {
        _fontSize = 20.0;
      } else if (_fontSize == 20.0) {
        _fontSize = 24.0;
      } else if (_fontSize == 24.0) {
        _fontSize = 28.0;
      } else {
        _fontSize = 17.0;
      }
    });
  }

  /// Flips one sentence's translation against the current global setting: it
  /// hides when the toolbar toggle is on and reveals when it is off.
  void _toggleSentenceTranslation(int index) {
    HapticsManager.light();
    setState(() {
      final Set<int> set =
          _showAllTranslations ? _hiddenTranslations : _translatedSentences;
      if (set.contains(index)) {
        set.remove(index);
      } else {
        set.add(index);
      }
    });
  }

  void _showSummary(BuildContext context, AiStory story) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    zenSheet(
      context,
      useRootNavigator: true,
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
                    // Flexible: "Summary" is much longer in several locales, and
                    // the close button must stay inside the sheet.
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.summary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
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
                      final sentencePinyin =
                          s.words.map((w) => w.pinyin).join(' ');
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
          setState(() {
            _isPlaying = false;
            _isPaused = false;
          });
          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        backgroundColor:
            isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        appBar: AppBar(
          // One line, never two. The toolbar must not outgrow a phone: this was
          // an unbounded two-line Text, so a long deck name plus the HSK prefix
          // could push the actions off the row — the exact failure the book
          // reader's toolbar comment documents.
          title: Text(
            widget.hskLevel == 0
                ? widget.blueprint.title
                : 'HSK ${widget.hskLevel}: ${widget.blueprint.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // Three reading toggles, then everything else one tap deeper — the
            // book reader's arrangement. This row used to be the ambient button
            // *plus* two labelled TextButtons for Discard/Save; on a 390dp phone
            // that pushed the actions over the back arrow.
            IconButton(
              icon: Icon(
                _pinyinMode == PinyinMode.all
                    ? Icons.spellcheck
                    : (_pinyinMode == PinyinMode.ghost
                        ? Icons.visibility
                        : Icons.visibility_off),
                size: 22,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              tooltip: AppLocalizations.of(context)!.togglePinyin,
              onPressed: _cyclePinyinMode,
            ),
            IconButton(
              icon: Icon(
                Icons.translate_rounded,
                size: 20,
                color: _showAllTranslations
                    ? (isDark ? Colors.amber.shade400 : const Color(0xFF8B0000))
                    : (isDark ? Colors.white70 : Colors.black87)
                        .withValues(alpha: 0.6),
              ),
              tooltip: _showAllTranslations
                  ? AppLocalizations.of(context)!.hideTranslation
                  : AppLocalizations.of(context)!.showTranslation,
              onPressed: () {
                HapticsManager.light();
                setState(() => _showAllTranslations = !_showAllTranslations);
              },
            ),
            // Ambient Soundscape Button
            Consumer(
              builder: (context, ref, _) {
                final ambient = ref.watch(zenAmbientServiceProvider);
                final isSoundscapeActive =
                    ambient.track != SoundscapeTrack.off && ambient.isPlaying;
                return IconButton(
                  icon: Icon(
                    isSoundscapeActive ? Icons.spa_rounded : Icons.spa_outlined,
                    size: 21,
                    color: isSoundscapeActive
                        ? (isDark
                            ? Colors.amber.shade400
                            : const Color(0xFF8B0000))
                        : (isDark ? Colors.white70 : Colors.black87),
                  ),
                  tooltip: AppLocalizations.of(context)?.ambientSoundscape ??
                      'Ambient Soundscape',
                  onPressed: () => ZenSoundscapeSheet.show(context),
                );
              },
            ),
            // Summary, type size, and — for a story not yet saved — the
            // save/discard pair, which used to be two extra toolbar buttons.
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_rounded,
                  size: 22, color: isDark ? Colors.white70 : Colors.black87),
              color: isDark ? const Color(0xFF1E1E22) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onSelected: (String action) async {
                switch (action) {
                  case 'summary':
                    _showSummary(
                      context,
                      AiStory(sentences: state.currentStory!.sentences),
                    );
                    return;
                  case 'font':
                    _cycleFontSize();
                    return;
                  case 'discard':
                    final controller =
                        ref.read(storyControllerProvider.notifier);
                    await controller.deleteCustomStory(widget.blueprint);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                    return;
                  case 'save':
                    setState(() => _isSaved = true);
                    ZenToast.success(context,
                        AppLocalizations.of(context)!.storySavedToLibrary);
                    return;
                }
              },
              itemBuilder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'summary',
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.article, size: 20),
                      title: Text(l10n.summary),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'font',
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.format_size, size: 20),
                      title: Text(
                          '${l10n.adjustFontSize}: ${_fontSize.round()} pt'),
                    ),
                  ),
                  if (!_isSaved && state.currentStory != null)
                    ...<PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'discard',
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.delete_outline,
                              size: 20, color: Colors.redAccent),
                          title: Text(l10n.discard,
                              style:
                                  const TextStyle(color: Colors.redAccent)),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'save',
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.save, size: 20),
                          title: Text(l10n.save),
                        ),
                      ),
                    ],
                ];
              },
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: SizedBox.shrink(),
          ),
        ),
        body: _isStreaming
            ? Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    _streamingText,
                    style: TextStyle(
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
                        const ZenLoader(color: Colors.indigo),
                        const SizedBox(height: 24),
                        AnimatedSwitcher(
                          duration: ZenMotion.of(context, ZenMotion.page),
                          child: Text(
                            _loadingMessages[_loadingStep],
                            key: ValueKey<int>(_loadingStep),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (!widget.blueprint.id.startsWith('local_') &&
                            !widget.blueprint.id.startsWith('tang_poetry_') &&
                            !widget.blueprint.id.startsWith('simplified_') &&
                            !widget.blueprint.id.startsWith('mandarin_bean_'))
                          if (widget.hskLevel > 0)
                            Text(
                                AppLocalizations.of(context)!
                                    .hsk_vocabulary(widget.hskLevel),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
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
                              Icon(
                                _streamErrorOffline
                                    ? Icons.wifi_off_rounded
                                    : Icons.error_outline,
                                size: 64,
                                color: _streamErrorOffline
                                    ? const Color(0xFFB8860B)
                                    : Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                  // Was a hardcoded English heading wrapped
                                  // around a raw exception; the heading is now
                                  // the translated key and the detail underneath
                                  // is the localized connection sentence when
                                  // that is what actually went wrong.
                                  AppLocalizations.of(context)!
                                      .failedToGenerateStory(
                                          _streamError ?? state.error ?? ''),
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  if (_streamFailed) {
                                    setState(() {
                                      _streamFailed = false;
                                      _streamError = null;
                                    });
                                  }
                                  if (widget.blueprint.id
                                          .startsWith('custom_') &&
                                      ref
                                              .read(storyControllerProvider)
                                              .currentStory ==
                                          null) {
                                    _startStreamingStory();
                                  } else if (widget.blueprint.id
                                      .startsWith('custom_')) {
                                    ref
                                        .read(storyControllerProvider.notifier)
                                        .loadOrGenerateStory(
                                            widget.blueprint, widget.hskLevel);
                                  } else if (widget.blueprint.id
                                          .startsWith('local_') ||
                                      widget.blueprint.id
                                          .startsWith('tang_poetry_') ||
                                      widget.blueprint.id.startsWith('http')) {
                                    ref
                                        .read(storyControllerProvider.notifier)
                                        .fetchAndParseLocalStory(
                                            widget.blueprint, widget.hskLevel);
                                  } else {
                                    ref
                                        .read(storyControllerProvider.notifier)
                                        .fetchAndParseFirebaseStory(
                                            widget.blueprint, widget.hskLevel);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo),
                                child: Text(
                                    AppLocalizations.of(context)!.tryAgain,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      )
                    : state.currentStory == null
                        ? Center(
                            child: Text(
                                AppLocalizations.of(context)!.storyNotFound))
                        : SingleChildScrollView(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Card containing all sentences
                                Container(
                                  padding: const EdgeInsets.all(24.0),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF222222)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    border: Border.all(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.black12),
                                  ),
                                  child: Builder(builder: (context) {
                                    int globalStringOffset = 0;
                                    List<Widget> sentenceWidgets = [];

                                    for (int si = 0;
                                        si <
                                            state
                                                .currentStory!.sentences.length;
                                        si++) {
                                      if (si > 0) {
                                        sentenceWidgets
                                            .add(const SizedBox(height: 24));
                                      }

                                      final sentence =
                                          state.currentStory!.sentences[si];
                                      final globalIndex = si;
                                      int currentStringOffset =
                                          globalStringOffset;

                                      sentenceWidgets.add(GestureDetector(
                                        // Tapping the sentence toggles its
                                        // translation, the way the book reader
                                        // does. This replaces the unlabelled
                                        // grey translate icon that used to sit
                                        // at the end of every line and was the
                                        // only way to see any English at all.
                                        onTap: () =>
                                            _toggleSentenceTranslation(
                                                globalIndex),
                                        child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                                  spacing: 8.0,
                                                  runSpacing: 16.0,
                                                  children: sentence.words
                                                      .map((word) {
                                                    final int wordStart =
                                                        currentStringOffset;
                                                    final int wordEnd =
                                                        currentStringOffset +
                                                            word.hanzi.length;
                                                    currentStringOffset =
                                                        wordEnd;

                                                    final isPunctuation =
                                                        RegExp(r'[^\w\s\u4e00-\u9fa5]',
                                                                    unicode:
                                                                        true)
                                                                .hasMatch(word
                                                                    .hanzi) ||
                                                            word.hanzi
                                                                .trim()
                                                                .isEmpty;

                                                    final isSpeakingThisSentence =
                                                        _isPlaying || _isPaused;
                                                    final isWordActive =
                                                        isSpeakingThisSentence &&
                                                            _playingStartOffset >=
                                                                0 &&
                                                            wordStart <=
                                                                _playingStartOffset &&
                                                            wordEnd >
                                                                _playingStartOffset;

                                                    final textColor =
                                                        isWordActive
                                                            ? Colors.orange
                                                            : (isDark
                                                                ? Colors.white
                                                                : Colors
                                                                    .black87);

                                                    if (isPunctuation) {
                                                      return Padding(
                                                        // Kept on the hanzi
                                                        // baseline once the
                                                        // pinyin line sits above
                                                        // it.
                                                        padding: EdgeInsets.only(
                                                            top: _pinyinMode ==
                                                                    PinyinMode
                                                                        .none
                                                                ? 0
                                                                : _fontSize *
                                                                        0.55 *
                                                                        1.1 +
                                                                    2),
                                                        child: Text(
                                                          word.hanzi,
                                                          style: TextStyle(
                                                            fontSize: _fontSize,
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    // Ghost mode renders the
                                                    // pinyin too, just dimmed.
                                                    // It was a no-op state that
                                                    // looked identical to
                                                    // `none`.
                                                    final bool shouldShowPinyin =
                                                        _pinyinMode !=
                                                            PinyinMode.none;

                                                    // Derived from the hanzi
                                                    // when the word carries none
                                                    // — see [storyWordPinyin].
                                                    final String wordPinyin =
                                                        storyWordPinyin(
                                                            word.hanzi,
                                                            word.pinyin,
                                                            echo: word.meaning);

                                                    final wordKey =
                                                        '${globalIndex}_${wordStart}_${word.hanzi}';
                                                    final isQuickLookSelected =
                                                        _quickLookSelectedWordKey ==
                                                            wordKey;

                                                    return GestureDetector(
                                                      onTapDown:
                                                          (details) async {
                                                        setState(() {
                                                          _quickLookSelectedWordKey =
                                                              wordKey;
                                                        });
                                                        await showQuickLook(
                                                          context,
                                                          word.hanzi,
                                                          contextText:
                                                              sentence.chinese,
                                                          presentation:
                                                              QuickLookPresentation
                                                                  .readingPopover,
                                                          anchorPosition: details
                                                              .globalPosition,
                                                          onDismiss: () {
                                                            if (mounted) {
                                                              setState(() {
                                                                if (_quickLookSelectedWordKey ==
                                                                    wordKey) {
                                                                  _quickLookSelectedWordKey =
                                                                      null;
                                                                }
                                                              });
                                                            }
                                                          },
                                                        );
                                                        if (mounted) {
                                                          setState(() {
                                                            if (_quickLookSelectedWordKey ==
                                                                wordKey) {
                                                              _quickLookSelectedWordKey =
                                                                  null;
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: ZenMotion.of(
                                                            context,
                                                            ZenMotion.swap),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 4,
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isQuickLookSelected
                                                              ? (isDark
                                                                  ? const Color(
                                                                          0xFF6366F1)
                                                                      .withValues(
                                                                          alpha:
                                                                              0.35)
                                                                  : const Color(
                                                                          0xFF4F46E5)
                                                                      .withValues(
                                                                          alpha:
                                                                              0.16))
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          border: Border.all(
                                                            color: isQuickLookSelected
                                                                ? (isDark
                                                                    ? const Color(
                                                                        0xFF818CF8)
                                                                    : const Color(
                                                                        0xFF4F46E5))
                                                                : Colors
                                                                    .transparent,
                                                            width:
                                                                isQuickLookSelected
                                                                    ? 1.5
                                                                    : 1,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            // Tone-marked pinyin
                                                            // *above* the
                                                            // character — the
                                                            // book reader's ruby
                                                            // alignment. It used
                                                            // to print below from
                                                            // `word.pinyin`, which
                                                            // is empty for every
                                                            // derived word, so it
                                                            // never showed.
                                                            if (shouldShowPinyin)
                                                              Text(
                                                                wordPinyin,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: _fontSize *
                                                                      0.55,
                                                                  fontWeight: isQuickLookSelected
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .w500,
                                                                  color: isQuickLookSelected
                                                                      ? (isDark
                                                                          ? const Color(
                                                                              0xFFA5B4FC)
                                                                          : const Color(
                                                                              0xFF3730A3))
                                                                      : (_pinyinMode ==
                                                                              PinyinMode.ghost
                                                                          ? (isDark
                                                                              ? Colors.white30
                                                                              : Colors.black26)
                                                                          : (isDark
                                                                              ? Colors.white70
                                                                              : const Color(0xFF5A4D41))),
                                                                  height: 1.1,
                                                                ),
                                                              ),
                                                            if (shouldShowPinyin)
                                                              const SizedBox(
                                                                  height: 2),
                                                            // Chinese Hanzi
                                                            // character.
                                                            Text(
                                                              word.hanzi,
                                                              style: TextStyle(
                                                                fontSize: _fontSize,
                                                                fontWeight: (isQuickLookSelected ||
                                                                        dueWords.contains(word
                                                                            .hanzi))
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .w600,
                                                                color: isQuickLookSelected
                                                                    ? (isDark
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xFF1E1B4B))
                                                                    : (isWordActive
                                                                        ? Colors
                                                                            .orange
                                                                        : (dueWords.contains(word.hanzi)
                                                                            ? const Color(0xFFD4AF37)
                                                                            : textColor)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                          // Shown by default — the book
                                          // reader's contract — and localized
                                          // through TranslatedText with the
                                          // story's own English as the
                                          // fallback.
                                          if (_isTranslationShown(
                                              globalIndex))
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TranslatedText(
                                                sentence.chinese,
                                                englishFallback: sentence
                                                        .english.isEmpty
                                                    ? null
                                                    : sentence.english,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: isDark
                                                      ? Colors.white70
                                                      : const Color(0xFF5A4D41),
                                                  fontStyle: FontStyle.italic,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ));
                                      globalStringOffset = currentStringOffset;
                                    }

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: sentenceWidgets,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
      ),
    );
  }
}
