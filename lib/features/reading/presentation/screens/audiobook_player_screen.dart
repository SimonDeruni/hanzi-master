import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/audio_quota_service.dart';
import 'package:hanzi_master/core/services/local_tts_voice.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/logic/book_reading_progress.dart';
import 'package:hanzi_master/features/reading/domain/logic/spoken_text_highlight.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/core/widgets/translated_text.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class AudiobookPlayerScreen extends ConsumerStatefulWidget {
  final BookModel book;
  final List<BookChapter> chapters;
  final int initialChapterIndex;
  final int initialSentenceIndex;

  const AudiobookPlayerScreen({
    super.key,
    required this.book,
    required this.chapters,
    this.initialChapterIndex = 0,
    this.initialSentenceIndex = 0,
  });

  @override
  ConsumerState<AudiobookPlayerScreen> createState() =>
      _AudiobookPlayerScreenState();
}

class _AudiobookPlayerScreenState extends ConsumerState<AudiobookPlayerScreen>
    with WidgetsBindingObserver {
  late int _currentChapterIndex;
  late int _currentSentenceIndex;
  int _currentSpokenCharIndex = 0;
  int _currentSpokenCharEnd = 1;
  int _totalDurationMs = 0;
  bool _isPlaying = true;
  int _audioRequestGeneration = 0;
  double _playbackSpeed = 1.0;
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? _audioCompleteSub;
  StreamSubscription? _positionSub;
  StreamSubscription? _durationSub;
  StreamSubscription? _errorSub;
  StreamSubscription? _wordBoundarySub;
  LocalTtsVoice? _localVoice;

  // Cache for parsed ruby sentence tokens (Chinese char + Pinyin syllable)
  final Map<String, List<_RubyToken>> _rubyCache = {};

  // Translation display toggle
  bool _showTranslations = true;

  // Selected character key for Quick Look highlight
  String? _quickLookSelectedKey;

  // Sleep Timer State
  Timer? _sleepTimer;
  int? _sleepSecondsRemaining;
  bool _stopAtEndOfChapter = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentChapterIndex =
        widget.initialChapterIndex.clamp(0, widget.chapters.length - 1);
    _currentSentenceIndex = widget.initialSentenceIndex;

    final audioService = ref.read(audioServiceProvider);

    _audioCompleteSub =
        audioService.onAudiobookLocationChanged.listen((location) {
      if (!mounted) return;
      final changed = location.chapterIndex != _currentChapterIndex ||
          location.sentenceIndex != _currentSentenceIndex;
      setState(() {
        _currentChapterIndex = location.chapterIndex;
        _currentSentenceIndex = location.sentenceIndex;
        _isPlaying = location.playing;
        if (changed) {
          _currentSpokenCharIndex = 0;
          _currentSpokenCharEnd = 1;
          _totalDurationMs = 0;
        }
      });
      if (changed) {
        _saveProgress();
        _scrollToSentence(location.sentenceIndex);
      }
    });

    _durationSub = audioService.onDurationChanged.listen((duration) {
      if (mounted && duration.inMilliseconds > 0) {
        setState(() {
          _totalDurationMs = duration.inMilliseconds;
        });
      }
    });

    _positionSub = audioService.onPositionChanged.listen((position) {
      if (mounted && _isPlaying) {
        _updateSpokenCharIndex(position.inMilliseconds);
      }
    });

    _wordBoundarySub = audioService.onWordBoundary.listen((boundary) {
      if (!mounted || !_isPlaying || widget.chapters.isEmpty) return;
      final chapter = widget.chapters[_currentChapterIndex];
      if (_currentSentenceIndex >= chapter.sentences.length) return;
      final start = boundary['TextOffset'];
      final length = boundary['WordLength'];
      if (start is! int || length is! int || length <= 0) return;
      final range = spokenHanziRangeForOffsets(
        chapter.sentences[_currentSentenceIndex].chinese,
        start,
        start + length,
      );
      if (range == null) return;
      setState(() {
        _currentSpokenCharIndex = range.start;
        _currentSpokenCharEnd = range.end;
      });
    });

    _errorSub = audioService.onPlaybackError.listen((_) {
      if (mounted && _isPlaying) {
        setState(() => _isPlaying = false);
        _showPlaybackFailure();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(_refreshLocalVoice());
        unawaited(_configureAndStartAudiobook());
        _scrollToSentence(_currentSentenceIndex, animate: false);
      }
    });
  }

  Future<void> _configureAndStartAudiobook() async {
    final audioService = ref.read(audioServiceProvider);
    final localeCode = Localizations.localeOf(context).toLanguageTag();
    final tracks = <AudiobookTrack>[];
    for (var chapterIndex = 0;
        chapterIndex < widget.chapters.length;
        chapterIndex++) {
      final chapter = widget.chapters[chapterIndex];
      for (var sentenceIndex = 0;
          sentenceIndex < chapter.sentences.length;
          sentenceIndex++) {
        final sentence = chapter.sentences[sentenceIndex];
        tracks.add(AudiobookTrack(
          id: '${widget.book.id}:${chapter.id}:$sentenceIndex',
          sentence: sentence.chinese,
          translation: sentence.english,
          bookTitle: widget.book.localizedTitle(localeCode),
          author: widget.book.author,
          chapterTitle: await LocalizedCatalogService.getChapterTitle(
            titleEn: chapter.titleEn,
            localeCode: localeCode,
            localizedTitles: chapter.localizedTitles,
          ),
          chapterIndex: chapterIndex,
          sentenceIndex: sentenceIndex,
        ));
      }
    }
    final voiceName = ref.read(settingsProvider).audiobookVoice;
    await audioService.init();
    await audioService.configureAudiobook(
      tracks: tracks,
      chapterIndex: _currentChapterIndex,
      sentenceIndex: _currentSentenceIndex,
      voiceName: voiceName,
    );
    if (!mounted) return;
    await _playSentenceAt(_currentSentenceIndex);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sleepTimer?.cancel();
    _audioCompleteSub?.cancel();
    _positionSub?.cancel();
    _durationSub?.cancel();
    _errorSub?.cancel();
    _wordBoundarySub?.cancel();
    _saveProgress();
    // Persist last reading session (audiobook)
    ref.read(bookRepositoryProvider).saveReadingSession(
          bookId: widget.book.id,
          chapterIndex: _currentChapterIndex,
          sentenceIndex: _currentSentenceIndex,
          wasAudiobook: true,
        );
    // Record reading event for streak
    ref.read(bookRepositoryProvider).recordReadingEvent();
    ++_audioRequestGeneration;
    unawaited(ref.read(audioServiceProvider).stop());
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshLocalVoice());
    }
  }

  Future<void> _refreshLocalVoice() async {
    final voice =
        await ref.read(audioServiceProvider).refreshPreferredLocalVoice();
    if (mounted) setState(() => _localVoice = voice);
  }

  void _saveProgress() {
    if (widget.chapters.isEmpty) return;
    final chapter = widget.chapters[_currentChapterIndex];
    final fraction =
        ((_currentChapterIndex + 1) / widget.chapters.length).clamp(0.0, 1.0);
    ref.read(bookRepositoryProvider).saveReadingProgress(
          bookId: widget.book.id,
          chapterIndex: chapter.chapterIndex,
          sentenceIndex: _currentSentenceIndex,
          percentage: fraction,
        );
    Future.microtask(() {
      if (mounted) {
        ref.invalidate(inProgressBooksProvider);
      }
    });
  }

  List<_RubyToken> _getRubyTokens(String chinese) {
    if (_rubyCache.containsKey(chinese)) {
      return _rubyCache[chinese]!;
    }

    final pinyinString = PinyinHelper.getPinyinE(
      chinese,
      separator: ' ',
      format: PinyinFormat.WITH_TONE_MARK,
    );
    final pinyinList =
        pinyinString.split(' ').where((s) => s.isNotEmpty).toList();

    final tokens = <_RubyToken>[];
    int pinyinIdx = 0;
    int hanziIdx = 0;
    const punctuation = {
      '，',
      '。',
      '！',
      '？',
      '、',
      '“',
      '”',
      '‘',
      '’',
      '：',
      '；',
      '《',
      '》',
      '（',
      '）',
      '—',
      '…',
      ' ',
      '\n',
      '\r',
      '\t',
      ',',
      '!',
      '?',
      '.',
      ':',
      ';',
      "'",
      '"',
      '(',
      ')',
      '[',
      ']',
      '{',
      '}'
    };

    for (final char in chinese.characters) {
      final isPunctuation =
          punctuation.contains(char) || RegExp(r'^\d+$').hasMatch(char);
      if (isPunctuation) {
        tokens.add(_RubyToken(
            char: char, pinyin: '', isPunctuation: true, hanziIndex: -1));
      } else {
        final pinyin =
            pinyinIdx < pinyinList.length ? pinyinList[pinyinIdx] : '';
        tokens.add(_RubyToken(
            char: char,
            pinyin: pinyin,
            isPunctuation: false,
            hanziIndex: hanziIdx));
        pinyinIdx++;
        hanziIdx++;
      }
    }

    _rubyCache[chinese] = tokens;
    return tokens;
  }

  void _updateSpokenCharIndex(int positionMs) {
    if (widget.chapters.isEmpty) return;
    final chapter = widget.chapters[_currentChapterIndex];
    if (_currentSentenceIndex >= chapter.sentences.length) return;

    final sentence = chapter.sentences[_currentSentenceIndex];
    final tokens = _getRubyTokens(sentence.chinese);
    final hanziTokens = tokens.where((t) => !t.isPunctuation).toList();

    if (hanziTokens.isEmpty) return;

    // Estimate duration if stream duration is not yet available (~220ms per character in classical recitation)
    final totalMs =
        _totalDurationMs > 0 ? _totalDurationMs : (hanziTokens.length * 220);
    final fraction = (positionMs / totalMs).clamp(0.0, 1.0);
    final targetIndex = (fraction * hanziTokens.length)
        .floor()
        .clamp(0, hanziTokens.length - 1);

    if (targetIndex != _currentSpokenCharIndex) {
      setState(() {
        _currentSpokenCharIndex = targetIndex;
        _currentSpokenCharEnd = targetIndex + 1;
      });
    }
  }

  Future<void> _playSentenceAt(int sentenceIdx) async {
    final chapter = widget.chapters[_currentChapterIndex];
    if (sentenceIdx >= 0 && sentenceIdx < chapter.sentences.length) {
      final requestGeneration = ++_audioRequestGeneration;
      setState(() {
        _currentSentenceIndex = sentenceIdx;
        _currentSpokenCharIndex = 0;
        _currentSpokenCharEnd = 1;
        _totalDurationMs = 0;
        _isPlaying = true;
      });
      _saveProgress();
      _scrollToSentence(sentenceIdx);

      final audioService = ref.read(audioServiceProvider);
      // Ensure audio service is initialized before first play
      await audioService.init();
      if (!mounted || requestGeneration != _audioRequestGeneration) return;

      final started =
          await audioService.playAudiobookAt(_currentChapterIndex, sentenceIdx);
      if (!mounted || requestGeneration != _audioRequestGeneration) return;
      if (!started) {
        setState(() => _isPlaying = false);
        _showPlaybackFailure();
        return;
      }
    }
  }

  Future<void> _togglePlayPause() async {
    HapticsManager.light();
    if (_isPlaying) {
      ++_audioRequestGeneration;
      setState(() => _isPlaying = false);
      await ref.read(audioServiceProvider).stop();
    } else {
      await _playSentenceAt(_currentSentenceIndex);
    }
  }

  void _showPlaybackFailure() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            AppLocalizations.of(context)!.audio_could_not_start_check_your),
      ),
    );
  }

  Widget _buildVoicePickerRow(bool isDark, Color cardBg, Color primaryText,
      Color secondaryText, Color activeAccent, AudioQuotaService quota) {
    final settings = ref.watch(settingsProvider);
    final currentVoice = settings.audiobookVoice;
    final hasQuota = quota.hasQuotaRemaining;

    final localQuality = _localVoice?.qualityLabel;
    final voiceOptions = [
      ('Kore', 'Kore', 'Female, warm'),
      ('Aoede', 'Aoede', 'Female, cheerful'),
      ('Fenrir', 'Fenrir', 'Male, upbeat'),
      ('Charon', 'Charon', 'Male, news-style'),
      ('Puck', 'Puck', 'Male, sporty'),
      (
        'local',
        localQuality == null ? 'Local' : 'Local $localQuality',
        _localVoice == null
            ? 'System on-device Mandarin voice'
            : '${_localVoice!.name} — $localQuality on-device voice'
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(Icons.record_voice_over_outlined,
              size: 15, color: secondaryText.withValues(alpha: 0.7)),
          const SizedBox(width: 5),
          Text(AppLocalizations.of(context)!.voice,
              style: TextStyle(
                  fontSize: 11,
                  color: secondaryText,
                  fontWeight: FontWeight.w600)),
          const SizedBox(width: 6),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: voiceOptions.map((opt) {
                  final isSelected = currentVoice == opt.$1;
                  final isAzure = opt.$1 != 'local';
                  final disabled = isAzure && !hasQuota && !isSelected;
                  final labelColor = disabled
                      ? (isDark ? Colors.white24 : Colors.black26)
                      : isSelected
                          ? activeAccent
                          : secondaryText;
                  final bgColor = isSelected
                      ? activeAccent.withValues(alpha: isDark ? 0.2 : 0.12)
                      : Colors.transparent;
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: GestureDetector(
                      onTap: disabled
                          ? null
                          : () {
                              HapticsManager.selection();
                              ref
                                  .read(settingsProvider.notifier)
                                  .setAudiobookVoice(opt.$1);
                              ref
                                  .read(audioServiceProvider)
                                  .setAudiobookVoice(opt.$1);
                              unawaited(_playSentenceAt(_currentSentenceIndex));
                            },
                      child: Tooltip(
                        message: disabled
                            ? '${opt.$2} — Azure quota exhausted'
                            : isAzure
                                ? '${opt.$2} (Azure) — ${opt.$3}'
                                : 'Local on-device TTS',
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? activeAccent.withValues(alpha: 0.5)
                                  : (disabled
                                      ? Colors.transparent
                                      : (isDark
                                          ? Colors.white12
                                          : Colors.black12)),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                opt.$2,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: labelColor,
                                ),
                              ),
                              if (disabled && isAzure)
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Icon(Icons.lock,
                                      size: 10, color: labelColor),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            padding: EdgeInsets.zero,
            tooltip: 'Improve the local voice',
            onPressed: () => _showLocalVoiceHelp(
                context, isDark, cardBg, primaryText, secondaryText),
            icon: Icon(Icons.info_outline_rounded,
                size: 16, color: secondaryText),
          ),
          // Quota indicator badge
          if (hasQuota)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: isDark ? 0.2 : 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.withValues(alpha: 0.4)),
              ),
              child: Text(
                '${quota.remainingHours.toStringAsFixed(1)}h',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color:
                        isDark ? Colors.green.shade300 : Colors.green.shade700),
              ),
            )
          else
            GestureDetector(
              onTap: () => _showQuotaDetailsSheet(
                  context, quota, isDark, cardBg, primaryText),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: isDark ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Colors.orange.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        size: 12,
                        color: isDark
                            ? Colors.orange.shade300
                            : Colors.orange.shade700),
                    const SizedBox(width: 3),
                    Text(
                      'Local',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.orange.shade300
                              : Colors.orange.shade700),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showLocalVoiceHelp(BuildContext context, bool isDark, Color cardBg,
      Color primaryText, Color secondaryText) {
    final voice = _localVoice;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: cardBg,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Higher-quality offline Mandarin',
                  style: TextStyle(
                      color: primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                voice == null
                    ? 'SinoSpark is using the system Mandarin voice.'
                    : 'Currently using ${voice.name} (${voice.qualityLabel}).',
                style: TextStyle(color: primaryText, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                'On iPhone or iPad, open Settings → Accessibility → Spoken Content → Voices → Chinese → Mandarin Chinese, then download an Enhanced or Premium voice. Return here and SinoSpark will select the best installed voice automatically.',
                style:
                    TextStyle(color: secondaryText, fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 10),
              Text(
                'Apple manages these downloads in Settings, so the app cannot install them directly. Availability and download size vary by iOS version and device.',
                style:
                    TextStyle(color: secondaryText, fontSize: 12, height: 1.35),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _prevSentence() async {
    if (_currentSentenceIndex > 0) {
      HapticsManager.selection();
      await _playSentenceAt(_currentSentenceIndex - 1);
    }
  }

  Future<void> _nextSentence() async {
    final chapter = widget.chapters[_currentChapterIndex];
    if (_currentSentenceIndex < chapter.sentences.length - 1) {
      HapticsManager.selection();
      await _playSentenceAt(_currentSentenceIndex + 1);
    }
  }

  Future<void> _switchToReadingMode() async {
    HapticsManager.medium();
    _saveProgress();
    ++_audioRequestGeneration;
    setState(() => _isPlaying = false);
    await ref.read(audioServiceProvider).stop();
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      SwipeBackPageRoute(
        builder: (_) => BookReaderScreen(
          book: widget.book,
          chapters: widget.chapters,
          initialChapterIndex: _currentChapterIndex,
          initialSentenceIndex: _currentSentenceIndex,
        ),
      ),
    );
  }

  void _scrollToSentence(int index, {bool animate = true}) {
    if (!_scrollController.hasClients) return;
    final targetOffset = (index * 130.0 - 140.0)
        .clamp(0.0, _scrollController.position.maxScrollExtent);
    if (animate) {
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuart,
      );
    } else {
      _scrollController.jumpTo(targetOffset);
    }
  }

  void _cyclePlaybackSpeed() {
    HapticsManager.selection();
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.25;
      } else if (_playbackSpeed == 1.25) {
        _playbackSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        _playbackSpeed = 0.75;
      } else {
        _playbackSpeed = 1.0;
      }
    });
  }

  void _setSleepTimer(int? minutes, {bool endOfChapter = false}) {
    _sleepTimer?.cancel();
    setState(() {
      _stopAtEndOfChapter = endOfChapter;
      if (minutes != null) {
        _sleepSecondsRemaining = minutes * 60;
      } else {
        _sleepSecondsRemaining = null;
      }
    });
    ref.read(audioServiceProvider).setStopAtChapterEnd(endOfChapter);

    if (minutes != null) {
      _sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_sleepSecondsRemaining != null && _sleepSecondsRemaining! > 0) {
          if (mounted) {
            setState(
                () => _sleepSecondsRemaining = _sleepSecondsRemaining! - 1);
          }
        } else {
          timer.cancel();
          setState(() {
            _isPlaying = false;
            _sleepSecondsRemaining = null;
            _stopAtEndOfChapter = false;
          });
          unawaited(ref.read(audioServiceProvider).stop());
        }
      });
    }
  }

  void _showSleepTimerModal(
      BuildContext context, bool isDark, Color cardBg, Color primaryText) {
    HapticsManager.light();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.15),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.bedtime,
                      size: 20,
                      color: isDark
                          ? Colors.amber.shade300
                          : const Color(0xFF8B0000)),
                  const SizedBox(width: 8),
                  Text(
                    'Sleep Timer',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: primaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSleepTile(ctx, 'Off', null, primaryText,
                  isSelected:
                      _sleepSecondsRemaining == null && !_stopAtEndOfChapter,
                  isDark: isDark),
              _buildSleepTile(ctx, '15 Minutes', 15, primaryText,
                  isSelected: _sleepSecondsRemaining != null &&
                      _sleepSecondsRemaining! <= 15 * 60 &&
                      _sleepSecondsRemaining! > 0,
                  isDark: isDark),
              _buildSleepTile(ctx, '30 Minutes', 30, primaryText,
                  isSelected: _sleepSecondsRemaining != null &&
                      _sleepSecondsRemaining! > 15 * 60 &&
                      _sleepSecondsRemaining! <= 30 * 60,
                  isDark: isDark),
              _buildSleepTile(ctx, '45 Minutes', 45, primaryText,
                  isSelected: _sleepSecondsRemaining != null &&
                      _sleepSecondsRemaining! > 30 * 60 &&
                      _sleepSecondsRemaining! <= 45 * 60,
                  isDark: isDark),
              _buildSleepTile(ctx, 'End of Current Chapter', null, primaryText,
                  isEndOfChapter: true,
                  isSelected: _stopAtEndOfChapter,
                  isDark: isDark),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSleepTile(
      BuildContext ctx, String label, int? minutes, Color primaryText,
      {bool isEndOfChapter = false,
      bool isSelected = false,
      required bool isDark}) {
    final accent = isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
        size: 18,
        color: isSelected ? accent : (isDark ? Colors.white38 : Colors.black26),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? accent : primaryText,
        ),
      ),
      onTap: () {
        Navigator.of(ctx).pop();
        _setSleepTimer(minutes, endOfChapter: isEndOfChapter);
      },
    );
  }

  void _showQuotaDetailsSheet(BuildContext context, AudioQuotaService quota,
      bool isDark, Color cardBg, Color primaryText) {
    HapticsManager.light();
    final usedRatio =
        (quota.usedSeconds / AudioQuotaService.weeklyAllowanceSeconds)
            .clamp(0.0, 1.0);
    final percentUsed = (usedRatio * 100).round();
    final accent = isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.15),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.graphic_eq, size: 20, color: accent),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Voice Engine & Allowance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                      Text(
                        'Studio HD vs. Unlimited Standard Voice',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (1.0 - usedRatio).clamp(0.0, 1.0),
                  minHeight: 10,
                  backgroundColor: isDark ? Colors.white12 : Colors.black12,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    quota.hasQuotaRemaining ? accent : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${quota.remainingHours.toStringAsFixed(1)} Studio HD hours remaining',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                  Text(
                    '$percentUsed% used of 4.0h',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isDark ? Colors.white12 : Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.all_inclusive, size: 16, color: accent),
                        const SizedBox(width: 6),
                        Text(
                          'Standard Voice is 100% Unlimited & Free',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: primaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '• Studio HD Voice: 4.0 hours per week of ultra-realistic Azure Neural recitation (resets Monday at 00:00).\n• Standard Voice: Unlimited, free on-device voice that never runs out and plays completely offline.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChapterPicker(
      BuildContext context, bool isDark, Color cardBg, Color primaryText) {
    HapticsManager.light();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.selectChapter,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.chapters.length,
                  itemBuilder: (ctx, idx) {
                    final ch = widget.chapters[idx];
                    final isCurrent = idx == _currentChapterIndex;
                    final accent = isDark
                        ? Colors.amber.shade300
                        : const Color(0xFF8B0000);
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      leading: Text(
                        '${ch.chapterIndex}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isCurrent
                              ? accent
                              : (isDark ? Colors.white38 : Colors.black38),
                        ),
                      ),
                      title: Text(
                        ch.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent ? accent : primaryText,
                        ),
                      ),
                      subtitle: FutureBuilder<String>(
                        future: LocalizedCatalogService.getChapterTitle(
                          chapterId: ch.id,
                          titleEn: ch.titleEn,
                          localizedTitles: ch.localizedTitles,
                          localeCode:
                              Localizations.localeOf(context).languageCode,
                        ),
                        builder: (context, snap) => Text(
                          snap.data ?? ch.titleEn,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white54 : Colors.black45,
                          ),
                        ),
                      ),
                      onTap: () async {
                        Navigator.of(ctx).pop();
                        setState(() {
                          _currentChapterIndex = idx;
                          _currentSentenceIndex = 0;
                          _currentSpokenCharIndex = 0;
                        });
                        await _playSentenceAt(0);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quota = ref.watch(audioQuotaServiceProvider);
    final chapter = widget.chapters[_currentChapterIndex];

    // Theme Palette (Zen & Ink Calligraphic Colors)
    final scaffoldBg =
        isDark ? const Color(0xFF121113) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : const Color(0xFFF5F2E4);
    final primaryText =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final secondaryText = isDark ? Colors.white54 : const Color(0xFF7A7067);
    final activeAccent =
        isDark ? Colors.amber.shade300 : const Color(0xFF8B0000);
    final activeBg = isDark
        ? Colors.amber.shade900.withValues(alpha: 0.25)
        : const Color(0xFFF7EBD9);
    final activeBorder = isDark
        ? Colors.amber.shade400.withValues(alpha: 0.6)
        : const Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Stack(
        children: [
          // Ambient Glow Background
          Positioned(
            top: -100,
            left: -50,
            right: -50,
            height: 350,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: [
                    isDark
                        ? const Color(0xFF8B0000).withValues(alpha: 0.25)
                        : const Color(0xFFC85A32).withValues(alpha: 0.12),
                    isDark
                        ? Colors.amber.shade900.withValues(alpha: 0.12)
                        : const Color(0xFFE8DCC4).withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top Action & Title Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_down,
                            size: 28, color: primaryText),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      // Book Cover Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CalligraphicBookCover(
                          book: widget.book,
                          width: 32,
                          height: 44,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.book.localizedTitle(
                                Localizations.localeOf(context).toLanguageTag(),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryText,
                                fontFamily: 'NotoSerifSC',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showChapterPicker(
                                  context, isDark, cardBg, primaryText),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: FutureBuilder<String>(
                                      future: LocalizedCatalogService
                                          .getChapterTitle(
                                        titleEn: chapter.titleEn,
                                        localeCode:
                                            Localizations.localeOf(context)
                                                .toLanguageTag(),
                                        localizedTitles:
                                            chapter.localizedTitles,
                                      ),
                                      builder: (context, snapshot) => Text(
                                        snapshot.data ?? chapter.titleEn,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: activeAccent,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(Icons.arrow_drop_down,
                                      size: 16, color: activeAccent),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Reading Mode Switcher Button
                      TextButton.icon(
                        icon: Icon(Icons.auto_stories_rounded,
                            size: 16, color: activeAccent),
                        label: Text(
                          'Read',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: activeAccent,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          backgroundColor: activeAccent.withValues(alpha: 0.12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: activeAccent.withValues(alpha: 0.35)),
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: _switchToReadingMode,
                      ),
                      const SizedBox(width: 4),
                      // Translation Toggle Button
                      IconButton(
                        icon: Icon(
                          Icons.translate_rounded,
                          size: 20,
                          color: _showTranslations
                              ? activeAccent
                              : secondaryText.withValues(alpha: 0.5),
                        ),
                        tooltip: _showTranslations
                            ? AppLocalizations.of(context)!
                                .hideEnglishTranslations
                            : AppLocalizations.of(context)!
                                .showEnglishTranslations,
                        onPressed: () {
                          HapticsManager.light();
                          setState(
                              () => _showTranslations = !_showTranslations);
                        },
                      ),
                      // Sleep Timer Button
                      IconButton(
                        icon: Icon(
                          (_sleepSecondsRemaining != null ||
                                  _stopAtEndOfChapter)
                              ? Icons.bedtime
                              : Icons.bedtime_outlined,
                          size: 22,
                          color: (_sleepSecondsRemaining != null ||
                                  _stopAtEndOfChapter)
                              ? activeAccent
                              : secondaryText,
                        ),
                        onPressed: () => _showSleepTimerModal(
                            context, isDark, cardBg, primaryText),
                      ),
                    ],
                  ),
                ),

                // Chapter & Book Progress Bar
                Builder(builder: (context) {
                  final totalSentences = chapter.sentences.length;
                  final chapterProgress = totalSentences > 0
                      ? (_currentSentenceIndex + 1) / totalSentences
                      : 0.0;
                  final allSentenceCounts =
                      widget.chapters.map((c) => c.sentences.length).toList();
                  final bookProgress = calculateBookReadingProgress(
                    sentenceCounts: allSentenceCounts,
                    chapterIndex: _currentChapterIndex,
                    sentenceIndex: _currentSentenceIndex,
                  );
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Sentence ${_currentSentenceIndex + 1} / $totalSentences',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: secondaryText,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Book ${(bookProgress * 100).round()}%',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: activeAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: chapterProgress,
                            minHeight: 3,
                            backgroundColor:
                                isDark ? Colors.white10 : Colors.black12,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(activeAccent),
                          ),
                        ),
                        const SizedBox(height: 3),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: bookProgress,
                            minHeight: 2,
                            backgroundColor:
                                isDark ? Colors.white10 : Colors.black12,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              activeAccent.withValues(alpha: 0.45),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  );
                }),

                // Spotify-Lyrics Live Sentences Stream with Ruby Pinyin Alignment
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                    itemCount: chapter.sentences.length,
                    itemBuilder: (context, idx) {
                      final sentence = chapter.sentences[idx];
                      final isActive = idx == _currentSentenceIndex;
                      final tokens = _getRubyTokens(sentence.chinese);

                      return GestureDetector(
                        onTap: () async {
                          HapticsManager.selection();
                          await _playSentenceAt(idx);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: isActive ? activeBg : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  isActive ? activeBorder : Colors.transparent,
                              width: 1.2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Ruby Chinese Character & Pinyin Alignment
                              Wrap(
                                spacing: 4,
                                runSpacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: tokens.map((token) {
                                  if (token.isPunctuation) {
                                    return Text(
                                      token.char,
                                      style: TextStyle(
                                        fontSize: isActive ? 20 : 16,
                                        color: isActive
                                            ? primaryText
                                            : (isDark
                                                ? Colors.white38
                                                : Colors.black38),
                                        fontFamily: 'NotoSerifSC',
                                      ),
                                    );
                                  }

                                  // Check if this specific character is currently being spoken
                                  final isCharSpoken = isActive &&
                                      token.hanziIndex >=
                                          _currentSpokenCharIndex &&
                                      token.hanziIndex < _currentSpokenCharEnd;
                                  final isPastChar = isActive &&
                                      token.hanziIndex <
                                          _currentSpokenCharIndex;
                                  final tokenKey =
                                      '${idx}_${token.hanziIndex}_${token.char}';
                                  final isQuickLookSelected =
                                      _quickLookSelectedKey == tokenKey;

                                  return GestureDetector(
                                    onTapDown: (details) async {
                                      HapticsManager.light();
                                      setState(() {
                                        _quickLookSelectedKey = tokenKey;
                                      });
                                      await showQuickLook(
                                        context,
                                        token.char,
                                        presentation: QuickLookPresentation
                                            .readingPopover,
                                        anchorPosition: details.globalPosition,
                                        onDismiss: () {
                                          if (mounted) {
                                            setState(() {
                                              if (_quickLookSelectedKey ==
                                                  tokenKey) {
                                                _quickLookSelectedKey = null;
                                              }
                                            });
                                          }
                                        },
                                      );
                                      if (mounted) {
                                        setState(() {
                                          if (_quickLookSelectedKey ==
                                              tokenKey) {
                                            _quickLookSelectedKey = null;
                                          }
                                        });
                                      }
                                    },
                                    behavior: HitTestBehavior.opaque,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 150),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: isQuickLookSelected
                                            ? (isDark
                                                ? const Color(0xFF6366F1)
                                                    .withValues(alpha: 0.35)
                                                : const Color(0xFF4F46E5)
                                                    .withValues(alpha: 0.16))
                                            : (isCharSpoken
                                                ? (isDark
                                                    ? Colors.amber.shade700
                                                        .withValues(alpha: 0.5)
                                                    : const Color(0xFFD4AF37)
                                                        .withValues(
                                                            alpha: 0.35))
                                                : Colors.transparent),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: isQuickLookSelected
                                              ? (isDark
                                                  ? const Color(0xFF818CF8)
                                                  : const Color(0xFF4F46E5))
                                              : (isCharSpoken
                                                  ? (isDark
                                                      ? Colors.amber.shade300
                                                      : const Color(0xFF8B0000))
                                                  : Colors.transparent),
                                          width: isQuickLookSelected ? 1.5 : 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Pinyin syllable directly above Hanzi
                                          Text(
                                            token.pinyin,
                                            style: TextStyle(
                                              fontSize: isActive ? 12.5 : 10.5,
                                              fontWeight:
                                                  (isQuickLookSelected ||
                                                          isCharSpoken)
                                                      ? FontWeight.bold
                                                      : FontWeight.w500,
                                              color: isQuickLookSelected
                                                  ? (isDark
                                                      ? const Color(0xFFA5B4FC)
                                                      : const Color(0xFF3730A3))
                                                  : (isCharSpoken
                                                      ? (isDark
                                                          ? Colors
                                                              .amber.shade200
                                                          : const Color(
                                                              0xFF8B0000))
                                                      : (isActive
                                                          ? (isPastChar
                                                              ? (isDark
                                                                  ? Colors
                                                                      .white70
                                                                  : const Color(
                                                                      0xFF4A4036))
                                                              : (isDark
                                                                  ? Colors
                                                                      .white38
                                                                  : const Color(
                                                                      0xFF8C827A)))
                                                          : (isDark
                                                              ? Colors.white24
                                                              : const Color(
                                                                  0xFFA89F95)))),
                                              height: 1.1,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          // Chinese Hanzi Character
                                          Text(
                                            token.char,
                                            style: TextStyle(
                                              fontSize: isActive ? 22 : 17,
                                              fontWeight:
                                                  (isQuickLookSelected ||
                                                          isCharSpoken)
                                                      ? FontWeight.bold
                                                      : (isActive
                                                          ? FontWeight.w600
                                                          : FontWeight.w500),
                                              color: isQuickLookSelected
                                                  ? (isDark
                                                      ? Colors.white
                                                      : const Color(0xFF1E1B4B))
                                                  : (isCharSpoken
                                                      ? (isDark
                                                          ? Colors
                                                              .amber.shade100
                                                          : const Color(
                                                              0xFF8B0000))
                                                      : (isActive
                                                          ? (isPastChar
                                                              ? primaryText
                                                              : (isDark
                                                                  ? Colors
                                                                      .white70
                                                                  : const Color(
                                                                      0xFF333333)))
                                                          : (isDark
                                                              ? Colors.white38
                                                              : const Color(
                                                                  0xFF8C827A)))),
                                              fontFamily: 'NotoSerifSC',
                                              height: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              // English Translation
                              if (_showTranslations) ...[
                                const SizedBox(height: 8),
                                sentence.english.isNotEmpty
                                    ? Text(
                                        sentence.english,
                                        style: TextStyle(
                                          fontSize: isActive ? 13 : 11.5,
                                          fontStyle: FontStyle.italic,
                                          color: isActive
                                              ? (isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF4A4036))
                                              : (isDark
                                                  ? Colors.white38
                                                  : const Color(0xFF7A7067)),
                                          height: 1.3,
                                        ),
                                      )
                                    : TranslatedText(
                                        sentence.chinese,
                                        style: TextStyle(
                                          fontSize: isActive ? 13 : 11.5,
                                          fontStyle: FontStyle.italic,
                                          color: isActive
                                              ? (isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF4A4036))
                                              : (isDark
                                                  ? Colors.white38
                                                  : const Color(0xFF7A7067)),
                                          height: 1.3,
                                        ),
                                      ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Glassmorphic Player Console
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1A191C)
                        : const Color(0xFFFAF7EE),
                    border: Border(
                      top: BorderSide(
                        color: isDark
                            ? Colors.amber.shade700.withValues(alpha: 0.3)
                            : const Color(0xFFDCD6C4),
                        width: 1.2,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Voice Engine, Quota Badge & Voice Selection Pills
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => _showQuotaDetailsSheet(
                                context, quota, isDark, cardBg, primaryText),
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: quota.hasQuotaRemaining
                                    ? activeAccent.withValues(alpha: 0.15)
                                    : (isDark
                                        ? Colors.white10
                                        : Colors.black.withValues(alpha: 0.05)),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: quota.hasQuotaRemaining
                                      ? activeAccent.withValues(alpha: 0.4)
                                      : (isDark
                                          ? Colors.white24
                                          : Colors.black12),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    quota.hasQuotaRemaining
                                        ? Icons.auto_awesome
                                        : Icons.all_inclusive,
                                    size: 11,
                                    color: quota.hasQuotaRemaining
                                        ? activeAccent
                                        : secondaryText,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    quota.hasQuotaRemaining
                                        ? 'Studio HD: ${quota.remainingHours.toStringAsFixed(1)}h'
                                        : 'Standard Voice',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: quota.hasQuotaRemaining
                                          ? activeAccent
                                          : secondaryText,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Icon(Icons.info_outline,
                                      size: 10,
                                      color:
                                          secondaryText.withValues(alpha: 0.6)),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Sentence ${_currentSentenceIndex + 1} of ${chapter.sentences.length}',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: secondaryText,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Voice Selection Chips in Bottom Console
                      _buildVoicePickerRow(isDark, cardBg, primaryText,
                          secondaryText, activeAccent, quota),

                      const SizedBox(height: 10),

                      // Transport Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Speed Button
                          TextButton(
                            onPressed: _cyclePlaybackSpeed,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              '${_playbackSpeed}x',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: activeAccent,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: Icon(Icons.skip_previous_rounded,
                                size: 30, color: primaryText),
                            onPressed: _currentSentenceIndex > 0
                                ? _prevSentence
                                : null,
                          ),

                          // Big Play / Pause Button
                          GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isDark
                                      ? [
                                          Colors.amber.shade400,
                                          Colors.amber.shade700
                                        ]
                                      : [
                                          const Color(0xFF8B0000),
                                          const Color(0xFF6B0000)
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: (isDark
                                            ? Colors.amber
                                            : const Color(0xFF8B0000))
                                        .withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                _isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 34,
                                color: isDark
                                    ? const Color(0xFF1A1A1B)
                                    : Colors.white,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: Icon(Icons.skip_next_rounded,
                                size: 30, color: primaryText),
                            onPressed: _currentSentenceIndex <
                                    chapter.sentences.length - 1
                                ? _nextSentence
                                : null,
                          ),

                          // Text Reader Switcher
                          IconButton(
                            icon: Icon(Icons.menu_book_rounded,
                                size: 22, color: activeAccent),
                            tooltip: AppLocalizations.of(context)!.readingMode,
                            onPressed: _switchToReadingMode,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RubyToken {
  final String char;
  final String pinyin;
  final bool isPunctuation;
  final int hanziIndex;

  const _RubyToken({
    required this.char,
    required this.pinyin,
    required this.isPunctuation,
    required this.hanziIndex,
  });
}
