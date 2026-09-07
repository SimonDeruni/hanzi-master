import 'package:lpinyin/lpinyin.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/audio_quota_service.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/logic/book_reading_progress.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/audiobook_player_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';
import 'package:hanzi_master/core/widgets/translated_text.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

enum BookPinyinMode { all, ghost, none }

class BookReaderScreen extends ConsumerStatefulWidget {
  final BookModel book;
  final List<BookChapter> chapters;
  final int initialChapterIndex;
  final int initialSentenceIndex;
  final bool autoStartAudiobook;

  const BookReaderScreen({
    super.key,
    required this.book,
    required this.chapters,
    required this.initialChapterIndex,
    this.initialSentenceIndex = 0,
    this.autoStartAudiobook = false,
  });

  @override
  ConsumerState<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends ConsumerState<BookReaderScreen>
    with WidgetsBindingObserver {
  final Map<String, List<_RubyToken>> _rubyCache = {};
  String? _quickLookSelectedKey;

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

  Future<void> _openAudiobookAtSentence(int sentenceIdx) async {
    _currentReadingSentenceIndex = _clampSentenceIndex(sentenceIdx);
    _saveProgress();
    await _stopAudiobook();
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AudiobookPlayerScreen(
          book: widget.book,
          chapters: widget.chapters,
          initialChapterIndex: _currentIndex,
          initialSentenceIndex: sentenceIdx,
        ),
      ),
    );
    if (!mounted) return;
    final progress = ref
        .read(bookRepositoryProvider)
        .getDetailedReadingProgress(widget.book.id);
    if (progress != null) {
      setState(() {
        _currentIndex =
            progress.chapterIndex.clamp(0, widget.chapters.length - 1);
        _currentReadingSentenceIndex =
            _clampSentenceIndex(progress.sentenceIndex);
        _anchorSentenceIndex = _currentReadingSentenceIndex;
        _mountedSentenceContexts.clear();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _restoreReadingPosition();
      });
    }
  }

  late int _currentIndex;
  BookPinyinMode _pinyinMode = BookPinyinMode.all;
  bool _showAllTranslations = true;
  final Set<int> _revealedTranslations = {};
  double _fontSize = 20.0;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _centerSliverKey = GlobalKey();
  final Map<int, BuildContext> _mountedSentenceContexts = {};
  int _anchorSentenceIndex = 0;
  int _currentReadingSentenceIndex = 0;
  Timer? _progressSaveDebounce;
  bool _isRestoringPosition = false;
  bool _positionUpdateScheduled = false;

  // Synchronized Neural Audiobook State
  bool _isAudiobookActive = false;
  bool _isAudiobookPlaying = false;
  int _currentAudioSentenceIndex = 0;
  int _audioRequestGeneration = 0;
  StreamSubscription? _audioCompleteSub;
  StreamSubscription? _audioErrorSub;

  // Sleep Timer State
  Timer? _sleepTimer;
  int? _sleepSecondsRemaining;
  bool _stopAtEndOfChapter = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentIndex =
        widget.initialChapterIndex.clamp(0, widget.chapters.length - 1);
    _currentReadingSentenceIndex =
        _clampSentenceIndex(widget.initialSentenceIndex);
    _anchorSentenceIndex = _currentReadingSentenceIndex;
    _scrollController.addListener(_handleReadingScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _restoreReadingPosition();
        // Do not call _saveProgress() here — _handleReadingScroll will
        // debounce-save once the scroll settles to the correct sentence.
        if (widget.autoStartAudiobook) {
          _startAudiobook();
        }
        // Show resume toast if restoring from a non-start position
        _showResumeToastIfRestored();
      }
    });

    final audioService = ref.read(audioServiceProvider);

    _audioCompleteSub = audioService.onPlayerComplete.listen((_) {
      if (_isAudiobookActive && _isAudiobookPlaying && mounted) {
        _onSentenceAudioFinished();
      }
    });
    _audioErrorSub = audioService.onPlaybackError.listen((_) {
      if (_isAudiobookActive && mounted) {
        setState(() {
          _isAudiobookActive = false;
          _isAudiobookPlaying = false;
        });
        _showPlaybackFailure();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _progressSaveDebounce?.cancel();
    _saveProgress();
    // Persist last reading session
    ref.read(bookRepositoryProvider).saveReadingSession(
          bookId: widget.book.id,
          chapterIndex: _currentIndex,
          sentenceIndex: _currentReadingSentenceIndex,
        );
    // Record reading event for streak
    ref.read(bookRepositoryProvider).recordReadingEvent();
    _sleepTimer?.cancel();
    _audioCompleteSub?.cancel();
    _audioErrorSub?.cancel();
    unawaited(ref.read(audioServiceProvider).stop());
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _progressSaveDebounce?.cancel();
      _saveProgress();
    }
  }

  int _clampSentenceIndex(int sentenceIndex) {
    final sentenceCount = widget.chapters[_currentIndex].sentences.length;
    if (sentenceCount == 0) return 0;
    return sentenceIndex.clamp(0, sentenceCount - 1);
  }

  void _registerSentenceContext(int index, BuildContext context) {
    _mountedSentenceContexts[index] = context;
    _scheduleReadingPositionUpdate();
  }

  void _unregisterSentenceContext(int index, BuildContext context) {
    if (identical(_mountedSentenceContexts[index], context)) {
      _mountedSentenceContexts.remove(index);
    }
  }

  void _scheduleReadingPositionUpdate() {
    if (_positionUpdateScheduled) return;
    _positionUpdateScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _positionUpdateScheduled = false;
      if (mounted) _handleReadingScroll();
    });
  }

  void _restoreReadingPosition() {
    _currentAudioSentenceIndex = _currentReadingSentenceIndex;
    _isRestoringPosition = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) {
        _isRestoringPosition = false;
        return;
      }
      final position = _scrollController.position;
      _scrollController.jumpTo(
        _currentReadingSentenceIndex == 0 ? position.minScrollExtent : 0,
      );
      _isRestoringPosition = false;
    });
  }

  void _showResumeToastIfRestored() {
    // Only show toast when restoring from a non-start position (chapter > 0 or sentence > 0)
    final isFromStart = _currentIndex == 0 && _currentReadingSentenceIndex == 0;
    if (isFromStart) return;

    final chapter = widget.chapters[_currentIndex];
    final chapterNum = chapter.chapterIndex;
    final sentNum =
        chapter.sentences.isEmpty ? 0 : _currentReadingSentenceIndex + 1;
    final totalChapters = widget.chapters.length;
    final totalSentences = chapter.sentences.length;

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.my_location_rounded,
                  size: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.amber.shade300
                      : const Color(0xFF8B0000)),
              const SizedBox(width: 8),
              Text(
                'Resumed: Ch.$chapterNum/$totalChapters, Sent.$sentNum/$totalSentences',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 80),
        ),
      );
    });
  }

  void _handleReadingScroll() {
    if (_isRestoringPosition || _mountedSentenceContexts.isEmpty) return;

    const readingLineY = 190.0;
    var visibleSentenceIndex = _currentReadingSentenceIndex;
    var closestDistance = double.infinity;
    for (final entry in _mountedSentenceContexts.entries) {
      final renderBox = entry.value.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) continue;
      final top = renderBox.localToGlobal(Offset.zero).dy;
      final bottom = top + renderBox.size.height;
      if (top <= readingLineY && bottom > readingLineY) {
        visibleSentenceIndex = entry.key;
        break;
      }
      final distance =
          top > readingLineY ? top - readingLineY : readingLineY - bottom;
      if (distance < closestDistance) {
        closestDistance = distance;
        visibleSentenceIndex = entry.key;
      }
    }

    if (visibleSentenceIndex == _currentReadingSentenceIndex) return;
    setState(() => _currentReadingSentenceIndex = visibleSentenceIndex);
    _progressSaveDebounce?.cancel();
    _progressSaveDebounce =
        Timer(const Duration(milliseconds: 500), _saveProgress);
  }

  Future<void> _startAudiobook() async {
    await _startAudiobookFrom(_currentReadingSentenceIndex);
  }

  Future<void> _startAudiobookFrom(int sentenceIdx) async {
    HapticsManager.medium();
    setState(() {
      _isAudiobookActive = true;
      _isAudiobookPlaying = true;
      _currentAudioSentenceIndex = sentenceIdx;
    });
    await _playSentenceAt(_currentAudioSentenceIndex);
  }

  Future<void> _openFullscreenAudiobookPlayer() async {
    HapticsManager.medium();
    _saveProgress();
    final initialSentenceIndex = _isAudiobookActive
        ? _currentAudioSentenceIndex
        : _currentReadingSentenceIndex;
    await _stopAudiobook();
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AudiobookPlayerScreen(
          book: widget.book,
          chapters: widget.chapters,
          initialChapterIndex: _currentIndex,
          initialSentenceIndex: initialSentenceIndex,
        ),
      ),
    );
    if (!mounted) return;
    final progress = ref
        .read(bookRepositoryProvider)
        .getDetailedReadingProgress(widget.book.id);
    if (progress != null) {
      setState(() {
        _currentIndex =
            progress.chapterIndex.clamp(0, widget.chapters.length - 1);
        _currentReadingSentenceIndex =
            _clampSentenceIndex(progress.sentenceIndex);
        _anchorSentenceIndex = _currentReadingSentenceIndex;
        _mountedSentenceContexts.clear();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _restoreReadingPosition();
      });
    }
  }

  Future<void> _stopAudiobook() async {
    ++_audioRequestGeneration;
    if (mounted) {
      setState(() {
        _isAudiobookActive = false;
        _isAudiobookPlaying = false;
      });
    }
    await ref.read(audioServiceProvider).stop();
  }

  Future<void> _togglePlayPauseAudiobook() async {
    HapticsManager.light();
    if (_isAudiobookPlaying) {
      await _stopAudiobook();
    } else {
      setState(() => _isAudiobookPlaying = true);
      await _playSentenceAt(_currentAudioSentenceIndex);
    }
  }

  Future<void> _playSentenceAt(int sentenceIdx) async {
    final chapter = widget.chapters[_currentIndex];
    if (sentenceIdx >= 0 && sentenceIdx < chapter.sentences.length) {
      final requestGeneration = ++_audioRequestGeneration;
      setState(() => _currentAudioSentenceIndex = sentenceIdx);
      final text = chapter.sentences[sentenceIdx].chinese;
      final voiceName = ref.read(settingsProvider).audiobookVoice;
      final started = await ref
          .read(audioServiceProvider)
          .playSentence(text, voiceName: voiceName);
      if (!mounted || requestGeneration != _audioRequestGeneration) return;
      if (!started) {
        setState(() {
          _isAudiobookActive = false;
          _isAudiobookPlaying = false;
        });
        _showPlaybackFailure();
        return;
      }

      // Pre-fetch the upcoming sentence in the background for 0ms transition gap
      if (sentenceIdx + 1 < chapter.sentences.length) {
        final nextText = chapter.sentences[sentenceIdx + 1].chinese;
        unawaited(ref
            .read(audioServiceProvider)
            .prefetchSentence(nextText, voiceName: voiceName));
      }
    }
  }

  void _showPlaybackFailure() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Audio could not start. Check your connection and device voice settings.'),
      ),
    );
  }

  Widget _buildCompactVoiceChip(bool isDark, AudioQuotaService quotaService) {
    final voice = ref.watch(settingsProvider).audiobookVoice;
    final hasQuota = quotaService.hasQuotaRemaining;
    final isLocal = voice == 'local' || !hasQuota;
    final accent = isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);

    return GestureDetector(
      onTap: () => _showVoicePickerSheet(context, isDark, quotaService),
      child: Tooltip(
        message: isLocal ? 'Local device voice' : 'Azure Neural: $voice',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isLocal
                  ? (isDark ? Colors.orange.shade700 : Colors.orange.shade400)
                  : accent.withValues(alpha: 0.4),
            ),
            color: isLocal
                ? (isDark
                    ? Colors.orange.shade900.withValues(alpha: 0.2)
                    : Colors.orange.shade50)
                : accent.withValues(alpha: 0.08),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.record_voice_over,
                size: 14,
                color: isLocal
                    ? (isDark ? Colors.orange.shade300 : Colors.orange.shade700)
                    : accent,
              ),
              const SizedBox(width: 3),
              Text(
                voice == 'local' ? 'Local' : voice,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: isLocal
                      ? (isDark
                          ? Colors.orange.shade300
                          : Colors.orange.shade700)
                      : accent,
                ),
              ),
              const SizedBox(width: 2),
              Icon(Icons.arrow_drop_down,
                  size: 14,
                  color: isLocal
                      ? (isDark
                          ? Colors.orange.shade300
                          : Colors.orange.shade700)
                      : accent),
            ],
          ),
        ),
      ),
    );
  }

  void _showVoicePickerSheet(
      BuildContext context, bool isDark, AudioQuotaService quotaService) {
    HapticsManager.light();
    final accent = isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);
    final cardBg = isDark ? const Color(0xFF1E1E22) : const Color(0xFFF5F2E4);
    final primaryText =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final hasQuota = quotaService.hasQuotaRemaining;
    final currentVoice = ref.read(settingsProvider).audiobookVoice;

    const voiceOptions = [
      ('Kore', 'Kore — Female, warm', 'zh-CN-XiaoxiaoNeural'),
      ('Aoede', 'Aoede — Female, cheerful', 'zh-CN-XiaoyiNeural'),
      ('Fenrir', 'Fenrir — Male, upbeat', 'zh-CN-YunxiNeural'),
      ('Charon', 'Charon — Male, news-style', 'zh-CN-YunyangNeural'),
      ('Puck', 'Puck — Male, sporty', 'zh-CN-YunjianNeural'),
      ('local', 'Local — On-device TTS', 'System voice'),
    ];

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
              Text(AppLocalizations.of(context)!.chooseVoice,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: primaryText)),
              if (!hasQuota)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 14, color: Colors.orange.shade400),
                      const SizedBox(width: 4),
                      Text(
                        'Weekly Azure quota reached — switching to local voice',
                        style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.orange.shade300
                                : Colors.orange.shade700),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              ...voiceOptions.map((opt) {
                final isSelected = currentVoice == opt.$1;
                final isAzure = opt.$1 != 'local';
                final disabled = isAzure && !hasQuota;
                return ListTile(
                  dense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  leading: Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    size: 20,
                    color: isSelected
                        ? accent
                        : (disabled
                            ? (isDark ? Colors.white24 : Colors.black26)
                            : (isDark ? Colors.white54 : Colors.black54)),
                  ),
                  title: Text(
                    opt.$2,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: disabled
                          ? (isDark ? Colors.white30 : Colors.black38)
                          : primaryText,
                    ),
                  ),
                  subtitle: isAzure
                      ? Text(
                          opt.$3,
                          style: TextStyle(
                            fontSize: 11,
                            color: disabled
                                ? (isDark ? Colors.white24 : Colors.black26)
                                : (isDark ? Colors.white38 : Colors.black45),
                          ),
                        )
                      : null,
                  trailing: disabled
                      ? Icon(Icons.lock,
                          size: 16,
                          color: isDark ? Colors.white24 : Colors.black26)
                      : null,
                  onTap: disabled
                      ? null
                      : () {
                          HapticsManager.selection();
                          ref
                              .read(settingsProvider.notifier)
                              .setAudiobookVoice(opt.$1);
                          Navigator.of(ctx).pop();
                        },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Future<void> _onSentenceAudioFinished() async {
    final chapter = widget.chapters[_currentIndex];
    if (_currentAudioSentenceIndex < chapter.sentences.length - 1) {
      unawaited(Future.delayed(const Duration(milliseconds: 350), () async {
        if (_isAudiobookActive && _isAudiobookPlaying && mounted) {
          await _playSentenceAt(_currentAudioSentenceIndex + 1);
        }
      }));
    } else {
      // Finished chapter
      if (_stopAtEndOfChapter) {
        await _stopAudiobook();
        if (mounted) setState(() => _stopAtEndOfChapter = false);
        return;
      }
      if (_currentIndex < widget.chapters.length - 1) {
        unawaited(Future.delayed(const Duration(milliseconds: 800), () async {
          if (_isAudiobookActive && _isAudiobookPlaying && mounted) {
            _goToNextChapter();
            await _startAudiobook();
          }
        }));
      } else {
        await _stopAudiobook();
      }
    }
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

    if (minutes != null) {
      _sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_sleepSecondsRemaining != null && _sleepSecondsRemaining! > 0) {
          if (mounted) {
            setState(
                () => _sleepSecondsRemaining = _sleepSecondsRemaining! - 1);
          }
        } else {
          timer.cancel();
          unawaited(_stopAudiobook());
          if (mounted) {
            setState(() {
              _sleepSecondsRemaining = null;
              _stopAtEndOfChapter = false;
            });
          }
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
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
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
                    '定时关闭 · Sleep Timer',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: primaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSleepTimerTile(ctx, 'Off', null, isDark, primaryText,
                  isSelected:
                      _sleepSecondsRemaining == null && !_stopAtEndOfChapter),
              _buildSleepTimerTile(ctx, '15 Minutes', 15, isDark, primaryText,
                  isSelected: _sleepSecondsRemaining != null &&
                      _sleepSecondsRemaining! <= 15 * 60 &&
                      _sleepSecondsRemaining! > 0),
              _buildSleepTimerTile(ctx, '30 Minutes', 30, isDark, primaryText,
                  isSelected: _sleepSecondsRemaining != null &&
                      _sleepSecondsRemaining! > 15 * 60 &&
                      _sleepSecondsRemaining! <= 30 * 60),
              _buildSleepTimerTile(ctx, '45 Minutes', 45, isDark, primaryText,
                  isSelected: _sleepSecondsRemaining != null &&
                      _sleepSecondsRemaining! > 30 * 60 &&
                      _sleepSecondsRemaining! <= 45 * 60),
              _buildSleepTimerTile(
                  ctx, 'End of Current Chapter', null, isDark, primaryText,
                  isEndOfChapter: true, isSelected: _stopAtEndOfChapter),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSleepTimerTile(BuildContext ctx, String label, int? minutes,
      bool isDark, Color primaryText,
      {bool isEndOfChapter = false, bool isSelected = false}) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
        size: 18,
        color: isSelected
            ? (isDark ? Colors.amber.shade400 : const Color(0xFF8B0000))
            : (isDark ? Colors.white38 : Colors.black38),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? (isDark ? Colors.amber.shade300 : const Color(0xFF8B0000))
              : primaryText,
        ),
      ),
      onTap: () {
        Navigator.of(ctx).pop();
        _setSleepTimer(minutes, endOfChapter: isEndOfChapter);
      },
    );
  }

  void _showQuotaDetailsSheet(BuildContext context, bool isDark, Color cardBg,
      Color primaryText, AudioQuotaService quota) {
    HapticsManager.light();
    final usedRatio =
        (quota.usedSeconds / AudioQuotaService.weeklyAllowanceSeconds)
            .clamp(0.0, 1.0);
    final percentUsed = (usedRatio * 100).round();

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
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
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
                      color: isDark
                          ? Colors.amber.withValues(alpha: 0.2)
                          : const Color(0xFF8B0000).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.graphic_eq,
                        size: 20,
                        color: isDark
                            ? Colors.amber.shade300
                            : const Color(0xFF8B0000)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Studio Voice Allowance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                      Text(
                        'Weekly High-Definition AI Recitation',
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
                    quota.hasQuotaRemaining
                        ? (isDark
                            ? Colors.amber.shade400
                            : const Color(0xFF8B0000))
                        : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${quota.remainingHours.toStringAsFixed(1)} hours remaining',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? Colors.amber.shade300
                          : const Color(0xFF8B0000),
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
                      : const Color(0xFFF9F5EC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.white12
                        : Colors.black.withValues(alpha: 0.06),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.refresh,
                            size: 16,
                            color: isDark ? Colors.white70 : Colors.black87),
                        const SizedBox(width: 6),
                        Text(
                          'Resets every Monday at 00:00',
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
                      'When your weekly 4-hour Studio allowance is used, the app automatically switches to On-Device Voice for unlimited, free listening without interruption.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: isDark ? Colors.white60 : Colors.black54,
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

  Future<void> _audiobookPrevSentence() async {
    if (_currentAudioSentenceIndex > 0) {
      HapticsManager.selection();
      await _playSentenceAt(_currentAudioSentenceIndex - 1);
    }
  }

  Future<void> _audiobookNextSentence() async {
    final chapter = widget.chapters[_currentIndex];
    if (_currentAudioSentenceIndex < chapter.sentences.length - 1) {
      HapticsManager.selection();
      await _playSentenceAt(_currentAudioSentenceIndex + 1);
    }
  }

  void _saveProgress() {
    if (widget.chapters.isEmpty) return;
    final chapterNumber = widget.chapters[_currentIndex].chapterIndex;
    final sentenceIndex = _isAudiobookActive
        ? _currentAudioSentenceIndex
        : _currentReadingSentenceIndex;
    final fraction = calculateBookReadingProgress(
      sentenceCounts:
          widget.chapters.map((chapter) => chapter.sentences.length).toList(),
      chapterIndex: _currentIndex,
      sentenceIndex: sentenceIndex,
    );
    ref
        .read(bookRepositoryProvider)
        .saveReadingProgress(
          bookId: widget.book.id,
          chapterIndex: chapterNumber,
          sentenceIndex: sentenceIndex,
          percentage: fraction,
        )
        .then((_) {
      if (mounted) {
        ref.invalidate(bookProgressProvider(widget.book.id));
        ref.invalidate(bookDetailedProgressProvider(widget.book.id));
        ref.invalidate(inProgressBooksProvider);
      }
    });
  }

  void _goToPreviousChapter() {
    if (_currentIndex > 0) {
      HapticsManager.medium();
      setState(() {
        _currentIndex--;
        _currentReadingSentenceIndex = 0;
        _currentAudioSentenceIndex = 0;
        _anchorSentenceIndex = 0;
        _mountedSentenceContexts.clear();
        _revealedTranslations.clear();
      });
      _restoreReadingPosition();
      _saveProgress();
    }
  }

  void _goToNextChapter() {
    if (_currentIndex < widget.chapters.length - 1) {
      HapticsManager.medium();
      setState(() {
        _currentIndex++;
        _currentReadingSentenceIndex = 0;
        _currentAudioSentenceIndex = 0;
        _anchorSentenceIndex = 0;
        _mountedSentenceContexts.clear();
        _revealedTranslations.clear();
      });
      _restoreReadingPosition();
      _saveProgress();
    }
  }

  void _jumpToChapter(int targetIdx, {int sentenceIndex = 0}) {
    if (targetIdx >= 0 && targetIdx < widget.chapters.length) {
      HapticsManager.medium();
      setState(() {
        _currentIndex = targetIdx;
        _currentReadingSentenceIndex = _clampSentenceIndex(sentenceIndex);
        _currentAudioSentenceIndex = _currentReadingSentenceIndex;
        _anchorSentenceIndex = _currentReadingSentenceIndex;
        _mountedSentenceContexts.clear();
        _revealedTranslations.clear();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (_currentReadingSentenceIndex == 0) {
          _scrollToTop();
        } else {
          _restoreReadingPosition();
        }
        _saveProgress();
      });
    }
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _toggleBookmark() async {
    HapticsManager.heavy();
    final chapter = widget.chapters[_currentIndex];
    final sentenceIndex = _clampSentenceIndex(_currentReadingSentenceIndex);
    final snippet =
        chapter.sentences.isNotEmpty ? chapter.sentences[sentenceIndex] : null;
    final snippetZh = snippet?.chinese ?? chapter.title;
    final snippetEn = snippet?.english ?? chapter.titleEn;

    final repo = ref.read(bookRepositoryProvider);
    final existing = repo.getBookmarks(widget.book.id);
    final isAlreadyBookmarked = existing.any(
      (b) =>
          b.chapterIndex == chapter.chapterIndex &&
          b.sentenceIndex == sentenceIndex,
    );

    if (isAlreadyBookmarked) {
      final target = existing.firstWhere(
        (b) =>
            b.chapterIndex == chapter.chapterIndex &&
            b.sentenceIndex == sentenceIndex,
      );
      await repo.removeBookmark(target.id);
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.bookmarkRemoved ?? "书签已移除 · Bookmark removed"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      final newBm = BookmarkModel(
        id: '${widget.book.id}_bm_${DateTime.now().millisecondsSinceEpoch}',
        bookId: widget.book.id,
        chapterIndex: chapter.chapterIndex,
        sentenceIndex: sentenceIndex,
        snippetChinese: snippetZh,
        snippetEnglish: snippetEn,
        createdAt: DateTime.now(),
      );
      await repo.saveBookmark(newBm);
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n != null
                ? "${l10n.bookmarkAdded}: 第${chapter.chapterIndex}回"
                : "已添加书签 · Bookmark added: 第${chapter.chapterIndex}回"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
    setState(() {});
  }

  void _openBookmarksDrawer(
      BuildContext context, bool isDark, Color cardBg, Color primaryText) {
    HapticsManager.selection();
    final repo = ref.read(bookRepositoryProvider);
    final bookmarks = repo.getBookmarks(widget.book.id);

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bookmarks,
                        size: 20,
                        color: isDark
                            ? Colors.amber.shade400
                            : const Color(0xFF8B0000),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '书签列表 · Bookmarks (${bookmarks.length})',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              const Divider(height: 16),
              if (bookmarks.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      '暂无书签。点击右上角书签图标可保存精彩章节。\nNo bookmarks yet. Tap the bookmark icon to save a passage.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  ),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: bookmarks.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (c, idx) {
                      final bm = bookmarks[idx];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 4),
                        leading: CircleAvatar(
                          backgroundColor: isDark
                              ? Colors.white10
                              : Colors.black.withValues(alpha: 0.05),
                          child: Text(
                            '${bm.chapterIndex}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.amber.shade300
                                  : const Color(0xFF8B0000),
                            ),
                          ),
                        ),
                        title: Text(
                          bm.snippetChinese,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryText,
                          ),
                        ),
                        subtitle: Text(
                          '第${bm.chapterIndex}回 · ${bm.createdAt.toLocal().toString().split('.')[0]}',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              size: 18, color: Colors.redAccent),
                          onPressed: () async {
                            await repo.removeBookmark(bm.id);
                            if (ctx.mounted) Navigator.of(ctx).pop();
                            if (context.mounted) {
                              _openBookmarksDrawer(
                                  context, isDark, cardBg, primaryText);
                            }
                          },
                        ),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _jumpToChapter(
                            bm.chapterIndex - 1,
                            sentenceIndex: bm.sentenceIndex,
                          );
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

  void _openChapterDrawer(
      BuildContext context, bool isDark, Color cardBg, Color primaryText) {
    HapticsManager.selection();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, scrollCtl) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '目录 · Table of Contents',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                      Text(
                        '${widget.chapters.length} Chapters',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollCtl,
                      itemCount: widget.chapters.length,
                      itemBuilder: (c, idx) {
                        final ch = widget.chapters[idx];
                        final isCurrent = idx == _currentIndex;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? (isDark
                                    ? Colors.amber.withValues(alpha: 0.15)
                                    : const Color(0xFFF2ECE1))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isCurrent
                                  ? (isDark
                                      ? Colors.amber.shade500
                                      : const Color(0xFF8B0000))
                                  : (isDark
                                      ? Colors.white10
                                      : Colors.black.withValues(alpha: 0.04)),
                            ),
                          ),
                          child: ListTile(
                            dense: true,
                            leading: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCurrent
                                    ? (isDark
                                        ? Colors.amber.shade600
                                        : const Color(0xFF8B0000))
                                    : (isDark
                                        ? Colors.white10
                                        : Colors.black.withValues(alpha: 0.05)),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${ch.chapterIndex}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isCurrent
                                        ? Colors.white
                                        : (isDark
                                            ? Colors.white70
                                            : Colors.black87),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              ch.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isCurrent
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                color: primaryText,
                              ),
                            ),
                            subtitle: FutureBuilder<String>(
                              future: LocalizedCatalogService.getChapterTitle(
                                chapterId: ch.id,
                                titleEn: ch.titleEn,
                                localizedTitles: ch.localizedTitles,
                                localeCode: Localizations.localeOf(context)
                                    .languageCode,
                              ),
                              builder: (context, snap) => Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  snap.data ?? ch.titleEn,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: isDark
                                        ? Colors.amber.shade300
                                        : const Color(0xFF8B0000),
                                  ),
                                ),
                              ),
                            ),
                            trailing: Text(
                              '${ch.sentences.length}句',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.white38 : Colors.black38,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(ctx).pop();
                              _jumpToChapter(idx);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);

    final chapter = widget.chapters[_currentIndex];
    final readingProgress = calculateBookReadingProgress(
      sentenceCounts:
          widget.chapters.map((item) => item.sentences.length).toList(),
      chapterIndex: _currentIndex,
      sentenceIndex: _currentReadingSentenceIndex,
    );
    final repo = ref.read(bookRepositoryProvider);
    final bookmarks = repo.getBookmarks(widget.book.id);
    final isCurrentBookmarked = bookmarks.any(
      (bookmark) =>
          bookmark.chapterIndex == chapter.chapterIndex &&
          bookmark.sentenceIndex == _currentReadingSentenceIndex,
    );

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: primaryText),
          onPressed: () {
            _saveProgress();
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          children: [
            Text(
              widget.book.localizedTitle(
                Localizations.localeOf(context).toLanguageTag(),
              ),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryText,
              ),
            ),
            Text(
              widget.book.category.contains('Poetry')
                  ? 'Classical Verse'
                  : 'Ch.${chapter.chapterIndex}/${widget.chapters.length} · Sent.${chapter.sentences.isEmpty ? 0 : _currentReadingSentenceIndex + 1}/${chapter.sentences.length}',
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
          ],
        ),
        actions: [
          // Audiobook Mode -> Fullscreen Spotify-Lyrics Player (for novels)
          if (!widget.book.category.contains('Poetry'))
            IconButton(
              icon: Icon(
                Icons.headphones_rounded,
                size: 22,
                color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
              ),
              tooltip: AppLocalizations.of(context)!.audiobookPlayer,
              onPressed: _openFullscreenAudiobookPlayer,
            ),
          // Bookmark Toggle
          IconButton(
            icon: Icon(
              isCurrentBookmarked ? Icons.bookmark : Icons.bookmark_border,
              size: 22,
              color: isCurrentBookmarked
                  ? (isDark ? Colors.amber.shade400 : const Color(0xFF8B0000))
                  : primaryText,
            ),
            tooltip: AppLocalizations.of(context)!.bookmarkChapter,
            onPressed: _toggleBookmark,
          ),
          // Bookmarks List
          IconButton(
            icon: Icon(Icons.bookmarks_outlined, size: 20, color: primaryText),
            tooltip: AppLocalizations.of(context)!.viewBookmarks,
            onPressed: () =>
                _openBookmarksDrawer(context, isDark, cardBg, primaryText),
          ),
          // Table of Contents Drawer
          IconButton(
            icon:
                Icon(Icons.format_list_bulleted, size: 22, color: primaryText),
            tooltip: AppLocalizations.of(context)!.tableOfContents,
            onPressed: () =>
                _openChapterDrawer(context, isDark, cardBg, primaryText),
          ),
          // Pinyin Toggle
          IconButton(
            icon: Icon(
              _pinyinMode == BookPinyinMode.all
                  ? Icons.spellcheck
                  : (_pinyinMode == BookPinyinMode.ghost
                      ? Icons.visibility
                      : Icons.visibility_off),
              size: 22,
              color: primaryText,
            ),
            tooltip: AppLocalizations.of(context)!.togglePinyin,
            onPressed: () {
              HapticsManager.light();
              setState(() {
                if (_pinyinMode == BookPinyinMode.all) {
                  _pinyinMode = BookPinyinMode.ghost;
                } else if (_pinyinMode == BookPinyinMode.ghost) {
                  _pinyinMode = BookPinyinMode.none;
                } else {
                  _pinyinMode = BookPinyinMode.all;
                }
              });
            },
          ),
          // English Translation Toggle
          IconButton(
            icon: Icon(
              Icons.translate_rounded,
              size: 20,
              color: _showAllTranslations
                  ? (isDark ? Colors.amber.shade400 : const Color(0xFF8B0000))
                  : primaryText.withValues(alpha: 0.6),
            ),
            tooltip: _showAllTranslations
                ? 'Hide English Translations'
                : 'Show English Translations',
            onPressed: () {
              HapticsManager.light();
              setState(() => _showAllTranslations = !_showAllTranslations);
            },
          ),
          // Font Size Adjust
          IconButton(
            icon: Icon(Icons.text_fields, size: 22, color: primaryText),
            tooltip: AppLocalizations.of(context)!.adjustFontSize,
            onPressed: () {
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
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Semantics(
            label:
                'Reading progress ${(readingProgress * 100).round()} percent',
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.chapterXOfY(
                          chapter.chapterIndex,
                          widget.chapters.length,
                        ),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: primaryText.withValues(alpha: 0.62),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '·',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryText.withValues(alpha: 0.45),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sentence ${chapter.sentences.isEmpty ? 0 : _currentReadingSentenceIndex + 1} of ${chapter.sentences.length}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: primaryText.withValues(alpha: 0.55),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${(readingProgress * 100).round()}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.amber.shade300
                              : const Color(0xFF8B0000),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: readingProgress,
                      minHeight: 4,
                      backgroundColor: isDark ? Colors.white12 : Colors.black12,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDark
                            ? Colors.amber.shade400
                            : const Color(0xFF8B0000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Chapter Content
          Expanded(
            child: Builder(
              builder: (context) {
                Widget buildChapterHeader() {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          chapter.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.amber.shade300
                                : const Color(0xFF8B0000),
                            letterSpacing: 1.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (chapter.titleEn.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          FutureBuilder<String>(
                            future: LocalizedCatalogService.getChapterTitle(
                              chapterId: chapter.id,
                              titleEn: chapter.titleEn,
                              localizedTitles: chapter.localizedTitles,
                              localeCode:
                                  Localizations.localeOf(context).languageCode,
                            ),
                            builder: (context, snap) => Text(
                              snap.data ?? chapter.titleEn,
                              style: TextStyle(
                                fontSize: 13.5,
                                color: isDark ? Colors.white70 : Colors.black87,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                Widget buildSentence(int index) {
                  final sentence = chapter.sentences[index];
                  final isRevealed = _revealedTranslations.contains(index);
                  final isAudioActiveSentence =
                      _isAudiobookActive && _currentAudioSentenceIndex == index;

                  return _MountedSentence(
                    key: ValueKey('${chapter.id}:$index'),
                    index: index,
                    onMount: _registerSentenceContext,
                    onUnmount: _unregisterSentenceContext,
                    child: GestureDetector(
                      onTap: () {
                        HapticsManager.light();
                        setState(() {
                          if (isRevealed) {
                            _revealedTranslations.remove(index);
                          } else {
                            _revealedTranslations.add(index);
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isAudioActiveSentence
                              ? (isDark
                                  ? Colors.amber.shade900
                                      .withValues(alpha: 0.28)
                                  : const Color(0xFFFFF6D8))
                              : (isRevealed
                                  ? (isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : Colors.black.withValues(alpha: 0.03))
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(12),
                          border: isAudioActiveSentence
                              ? Border.all(
                                  color: isDark
                                      ? Colors.amber.shade400
                                      : const Color(0xFFD4AF37),
                                  width: 1.5,
                                )
                              : (isRevealed
                                  ? Border.all(
                                      color: isDark
                                          ? Colors.white10
                                          : Colors.black
                                              .withValues(alpha: 0.06))
                                  : null),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row: Audio Button & Actions
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sentence ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? Colors.white30
                                        : Colors.black26,
                                  ),
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: Icon(
                                    Icons.volume_up_outlined,
                                    size: 20,
                                    color: isDark
                                        ? Colors.amber.shade300
                                        : const Color(0xFF8B0000),
                                  ),
                                  tooltip: AppLocalizations.of(context)!
                                      .listenInAudiobookMode,
                                  onPressed: () {
                                    HapticsManager.medium();
                                    _openAudiobookAtSentence(index);
                                  },
                                ),
                              ],
                            ),

                            // Ruby Chinese Characters & Pinyin Alignment
                            Wrap(
                              spacing: 3,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children:
                                  _getRubyTokens(sentence.chinese).map((token) {
                                if (token.isPunctuation) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: _pinyinMode != BookPinyinMode.none
                                            ? _fontSize * 0.6
                                            : 0),
                                    child: Text(
                                      token.char,
                                      style: TextStyle(
                                        fontSize: _fontSize,
                                        color: isAudioActiveSentence
                                            ? (isDark
                                                ? Colors.amber.shade200
                                                : const Color(0xFF8B0000))
                                            : primaryText,
                                        fontFamily: 'NotoSerifSC',
                                      ),
                                    ),
                                  );
                                }

                                final tokenKey =
                                    '${index}_${token.hanziIndex}_${token.char}';
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
                                      presentation:
                                          QuickLookPresentation.readingPopover,
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
                                        if (_quickLookSelectedKey == tokenKey) {
                                          _quickLookSelectedKey = null;
                                        }
                                      });
                                    }
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isQuickLookSelected
                                          ? (isDark
                                              ? const Color(0xFF6366F1)
                                                  .withValues(alpha: 0.35)
                                              : const Color(0xFF4F46E5)
                                                  .withValues(alpha: 0.16))
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: isQuickLookSelected
                                            ? (isDark
                                                ? const Color(0xFF818CF8)
                                                : const Color(0xFF4F46E5))
                                            : Colors.transparent,
                                        width: isQuickLookSelected ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Tone-marked Pinyin directly above Hanzi
                                        if (_pinyinMode != BookPinyinMode.none)
                                          Text(
                                            token.pinyin,
                                            style: TextStyle(
                                              fontSize: _fontSize * 0.55,
                                              fontWeight: isQuickLookSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                              color: isQuickLookSelected
                                                  ? (isDark
                                                      ? const Color(0xFFA5B4FC)
                                                      : const Color(0xFF3730A3))
                                                  : (_pinyinMode ==
                                                          BookPinyinMode.ghost
                                                      ? (isDark
                                                          ? Colors.white30
                                                          : Colors.black26)
                                                      : (isAudioActiveSentence
                                                          ? (isDark
                                                              ? Colors.amber
                                                                  .shade200
                                                              : const Color(
                                                                  0xFF8B0000))
                                                          : (isDark
                                                              ? Colors.white70
                                                              : const Color(
                                                                  0xFF5A4D41)))),
                                              height: 1.1,
                                            ),
                                          ),
                                        const SizedBox(height: 2),
                                        // Chinese Hanzi Character
                                        Text(
                                          token.char,
                                          style: TextStyle(
                                            fontSize: _fontSize,
                                            fontWeight: (isQuickLookSelected ||
                                                    isAudioActiveSentence)
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            color: isQuickLookSelected
                                                ? (isDark
                                                    ? Colors.white
                                                    : const Color(0xFF1E1B4B))
                                                : (isAudioActiveSentence
                                                    ? (isDark
                                                        ? Colors.amber.shade300
                                                        : const Color(
                                                            0xFF8B0000))
                                                    : primaryText),
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

                            // English Translation (Global toggle or tap to reveal)
                            if (_showAllTranslations || isRevealed)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: sentence.english.isNotEmpty
                                    ? Text(
                                        sentence.english,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isAudioActiveSentence
                                              ? (isDark
                                                  ? Colors.amber.shade300
                                                  : const Color(0xFF8B0000))
                                              : (isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF5A4D41)),
                                          fontStyle: FontStyle.italic,
                                          height: 1.3,
                                        ),
                                      )
                                    : TranslatedText(
                                        sentence.chinese,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isAudioActiveSentence
                                              ? (isDark
                                                  ? Colors.amber.shade300
                                                  : const Color(0xFF8B0000))
                                              : (isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF5A4D41)),
                                          fontStyle: FontStyle.italic,
                                          height: 1.3,
                                        ),
                                      ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                final precedingChildCount = _anchorSentenceIndex + 1;
                return CustomScrollView(
                  key: ValueKey('${chapter.id}:$_anchorSentenceIndex'),
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  center: _centerSliverKey,
                  anchor: 0.08,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, reverseIndex) {
                            final sentenceIndex =
                                _anchorSentenceIndex - reverseIndex - 1;
                            if (sentenceIndex >= 0) {
                              return buildSentence(sentenceIndex);
                            }
                            return buildChapterHeader();
                          },
                          childCount: precedingChildCount,
                        ),
                      ),
                    ),
                    SliverPadding(
                      key: _centerSliverKey,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, childIndex) => buildSentence(
                            _anchorSentenceIndex + childIndex,
                          ),
                          childCount:
                              chapter.sentences.length - _anchorSentenceIndex,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Neural Audiobook Floating Controls Bar
          if (_isAudiobookActive)
            Builder(
              builder: (context) {
                final quotaService = ref.watch(audioQuotaServiceProvider);
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2824)
                        : const Color(0xFFF9F5EC),
                    border: Border(
                      top: BorderSide(
                        color: isDark
                            ? Colors.amber.shade700.withValues(alpha: 0.4)
                            : const Color(0xFFD4AF37).withValues(alpha: 0.6),
                        width: 1.2,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.graphic_eq,
                            size: 20,
                            color: isDark
                                ? Colors.amber.shade400
                                : const Color(0xFF8B0000),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _showQuotaDetailsSheet(context,
                                  isDark, cardBg, primaryText, quotaService),
                              behavior: HitTestBehavior.opaque,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Sentence ${_currentAudioSentenceIndex + 1} / ${chapter.sentences.length}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryText,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        quotaService.hasQuotaRemaining
                                            ? 'Studio Voice: ${quotaService.remainingHours.toStringAsFixed(1)}h left this week'
                                            : 'On-Device Voice (4h weekly used)',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          color: quotaService.hasQuotaRemaining
                                              ? (isDark
                                                  ? Colors.amber.shade300
                                                  : const Color(0xFF8B0000))
                                              : (isDark
                                                  ? Colors.white54
                                                  : Colors.black54),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Icon(
                                        Icons.info_outline,
                                        size: 11,
                                        color: quotaService.hasQuotaRemaining
                                            ? (isDark
                                                ? Colors.amber.shade300
                                                    .withValues(alpha: 0.7)
                                                : const Color(0xFF8B0000)
                                                    .withValues(alpha: 0.7))
                                            : (isDark
                                                ? Colors.white38
                                                : Colors.black38),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Voice quick-select chip
                          _buildCompactVoiceChip(isDark, quotaService),
                          // Sleep Timer Button
                          IconButton(
                            icon: Icon(
                              (_sleepSecondsRemaining != null ||
                                      _stopAtEndOfChapter)
                                  ? Icons.bedtime
                                  : Icons.bedtime_outlined,
                              size: 20,
                              color: (_sleepSecondsRemaining != null ||
                                      _stopAtEndOfChapter)
                                  ? (isDark
                                      ? Colors.amber.shade400
                                      : const Color(0xFF8B0000))
                                  : (isDark ? Colors.white60 : Colors.black54),
                            ),
                            tooltip: AppLocalizations.of(context)!.sleepTimer,
                            onPressed: () => _showSleepTimerModal(
                                context, isDark, cardBg, primaryText),
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_previous, size: 22),
                            color: primaryText,
                            onPressed: _currentAudioSentenceIndex > 0
                                ? _audiobookPrevSentence
                                : null,
                          ),
                          IconButton(
                            icon: Icon(
                              _isAudiobookPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              size: 32,
                              color: isDark
                                  ? Colors.amber.shade400
                                  : const Color(0xFF8B0000),
                            ),
                            onPressed: _togglePlayPauseAudiobook,
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next, size: 22),
                            color: primaryText,
                            onPressed: _currentAudioSentenceIndex <
                                    chapter.sentences.length - 1
                                ? _audiobookNextSentence
                                : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.open_in_full_rounded,
                                size: 18),
                            color: isDark
                                ? Colors.amber.shade300
                                : const Color(0xFF8B0000),
                            tooltip: AppLocalizations.of(context)!
                                .spotifyStylePlayer,
                            onPressed: _openFullscreenAudiobookPlayer,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            color: isDark ? Colors.white54 : Colors.black45,
                            onPressed: _stopAudiobook,
                          ),
                        ],
                      ),
                    ], // Column.children
                  ), // Column
                );
              },
            ),

          // Bottom Chapter Navigation Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cardBg,
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? Colors.white12
                      : Colors.black.withValues(alpha: 0.06),
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _currentIndex > 0 ? _goToPreviousChapter : null,
                    icon: const Icon(Icons.arrow_back_ios, size: 14),
                    label: Text(AppLocalizations.of(context)!.previous),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.white12 : Colors.black12,
                      foregroundColor: primaryText,
                      elevation: 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _openChapterDrawer(
                        context, isDark, cardBg, primaryText),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white10
                            : Colors.black.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.list_alt,
                              size: 14,
                              color: isDark
                                  ? Colors.amber.shade300
                                  : const Color(0xFF8B0000)),
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context)!.chapterXOfY(
                              _currentIndex + 1,
                              widget.chapters.length,
                            ),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _currentIndex < widget.chapters.length - 1
                        ? _goToNextChapter
                        : null,
                    label: Text(AppLocalizations.of(context)!.next),
                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? Colors.amber.shade700
                          : const Color(0xFF1A1A1B),
                      foregroundColor: Colors.white,
                      elevation: 0,
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

class _MountedSentence extends StatefulWidget {
  final int index;
  final Widget child;
  final void Function(int index, BuildContext context) onMount;
  final void Function(int index, BuildContext context) onUnmount;

  const _MountedSentence({
    super.key,
    required this.index,
    required this.child,
    required this.onMount,
    required this.onUnmount,
  });

  @override
  State<_MountedSentence> createState() => _MountedSentenceState();
}

class _MountedSentenceState extends State<_MountedSentence> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onMount(widget.index, context);
    });
  }

  @override
  void didUpdateWidget(covariant _MountedSentence oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      oldWidget.onUnmount(oldWidget.index, context);
      widget.onMount(widget.index, context);
    }
  }

  @override
  void dispose() {
    widget.onUnmount(widget.index, context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
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
