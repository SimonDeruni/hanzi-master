import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/audio_quota_service.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';

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
  ConsumerState<AudiobookPlayerScreen> createState() => _AudiobookPlayerScreenState();
}

class _AudiobookPlayerScreenState extends ConsumerState<AudiobookPlayerScreen> {
  late int _currentChapterIndex;
  late int _currentSentenceIndex;
  bool _isPlaying = true;
  double _playbackSpeed = 1.0;
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? _audioCompleteSub;

  // Sleep Timer State
  Timer? _sleepTimer;
  int? _sleepSecondsRemaining;
  bool _stopAtEndOfChapter = false;

  @override
  void initState() {
    super.initState();
    _currentChapterIndex = widget.initialChapterIndex.clamp(0, widget.chapters.length - 1);
    _currentSentenceIndex = widget.initialSentenceIndex;

    final audioService = ref.read(audioServiceProvider);
    _audioCompleteSub = audioService.onPlayerComplete.listen((_) {
      if (_isPlaying && mounted) {
        _onSentenceFinished();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _playSentenceAt(_currentSentenceIndex);
        _scrollToSentence(_currentSentenceIndex, animate: false);
      }
    });
  }

  @override
  void dispose() {
    _sleepTimer?.cancel();
    _audioCompleteSub?.cancel();
    _saveProgress();
    ref.read(audioServiceProvider).stop();
    _scrollController.dispose();
    super.dispose();
  }

  void _saveProgress() {
    if (widget.chapters.isEmpty) return;
    final chapter = widget.chapters[_currentChapterIndex];
    final fraction = ((_currentChapterIndex + 1) / widget.chapters.length).clamp(0.0, 1.0);
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

  void _playSentenceAt(int sentenceIdx) {
    final chapter = widget.chapters[_currentChapterIndex];
    if (sentenceIdx >= 0 && sentenceIdx < chapter.sentences.length) {
      setState(() {
        _currentSentenceIndex = sentenceIdx;
        _isPlaying = true;
      });
      _saveProgress();
      _scrollToSentence(sentenceIdx);

      final text = chapter.sentences[sentenceIdx].chinese;
      ref.read(audioServiceProvider).playSentence(text);

      // Pre-fetch next sentence in background
      if (sentenceIdx + 1 < chapter.sentences.length) {
        final nextText = chapter.sentences[sentenceIdx + 1].chinese;
        ref.read(audioServiceProvider).prefetchSentence(nextText);
      }
    }
  }

  void _onSentenceFinished() {
    final chapter = widget.chapters[_currentChapterIndex];
    if (_currentSentenceIndex < chapter.sentences.length - 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_isPlaying && mounted) {
          _playSentenceAt(_currentSentenceIndex + 1);
        }
      });
    } else {
      // Chapter complete
      if (_stopAtEndOfChapter) {
        setState(() {
          _isPlaying = false;
          _stopAtEndOfChapter = false;
        });
        ref.read(audioServiceProvider).stop();
        return;
      }

      if (_currentChapterIndex < widget.chapters.length - 1) {
        Future.delayed(const Duration(milliseconds: 700), () {
          if (_isPlaying && mounted) {
            setState(() {
              _currentChapterIndex++;
              _currentSentenceIndex = 0;
            });
            _playSentenceAt(0);
          }
        });
      } else {
        setState(() => _isPlaying = false);
        ref.read(audioServiceProvider).stop();
      }
    }
  }

  void _togglePlayPause() {
    HapticsManager.light();
    if (_isPlaying) {
      ref.read(audioServiceProvider).stop();
      setState(() => _isPlaying = false);
    } else {
      _playSentenceAt(_currentSentenceIndex);
    }
  }

  void _prevSentence() {
    if (_currentSentenceIndex > 0) {
      HapticsManager.selection();
      _playSentenceAt(_currentSentenceIndex - 1);
    }
  }

  void _nextSentence() {
    final chapter = widget.chapters[_currentChapterIndex];
    if (_currentSentenceIndex < chapter.sentences.length - 1) {
      HapticsManager.selection();
      _playSentenceAt(_currentSentenceIndex + 1);
    }
  }

  void _scrollToSentence(int index, {bool animate = true}) {
    if (!_scrollController.hasClients) return;
    // Approximate sentence card height is ~110px
    final targetOffset = (index * 110.0 - 150.0).clamp(0.0, _scrollController.position.maxScrollExtent);
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

    if (minutes != null) {
      _sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_sleepSecondsRemaining != null && _sleepSecondsRemaining! > 0) {
          if (mounted) setState(() => _sleepSecondsRemaining = _sleepSecondsRemaining! - 1);
        } else {
          timer.cancel();
          setState(() {
            _isPlaying = false;
            _sleepSecondsRemaining = null;
            _stopAtEndOfChapter = false;
          });
          ref.read(audioServiceProvider).stop();
        }
      });
    }
  }

  void _showSleepTimerModal(BuildContext context) {
    HapticsManager.light();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E22),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
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
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.bedtime, size: 20, color: Colors.amber.shade300),
                  const SizedBox(width: 8),
                  const Text(
                    'Sleep Timer',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSleepTile(ctx, 'Off', null, isSelected: _sleepSecondsRemaining == null && !_stopAtEndOfChapter),
              _buildSleepTile(ctx, '15 Minutes', 15, isSelected: _sleepSecondsRemaining != null && _sleepSecondsRemaining! <= 15 * 60 && _sleepSecondsRemaining! > 0),
              _buildSleepTile(ctx, '30 Minutes', 30, isSelected: _sleepSecondsRemaining != null && _sleepSecondsRemaining! > 15 * 60 && _sleepSecondsRemaining! <= 30 * 60),
              _buildSleepTile(ctx, '45 Minutes', 45, isSelected: _sleepSecondsRemaining != null && _sleepSecondsRemaining! > 30 * 60 && _sleepSecondsRemaining! <= 45 * 60),
              _buildSleepTile(ctx, 'End of Current Chapter', null, isEndOfChapter: true, isSelected: _stopAtEndOfChapter),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSleepTile(BuildContext ctx, String label, int? minutes, {bool isEndOfChapter = false, bool isSelected = false}) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
        size: 18,
        color: isSelected ? Colors.amber.shade400 : Colors.white38,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.amber.shade300 : Colors.white,
        ),
      ),
      onTap: () {
        Navigator.of(ctx).pop();
        _setSleepTimer(minutes, endOfChapter: isEndOfChapter);
      },
    );
  }

  void _showQuotaDetailsSheet(BuildContext context, AudioQuotaService quota) {
    HapticsManager.light();
    final usedRatio = (quota.usedSeconds / AudioQuotaService.weeklyAllowanceSeconds).clamp(0.0, 1.0);
    final percentUsed = (usedRatio * 100).round();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E22),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
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
                    color: Colors.white24,
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
                      color: Colors.amber.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.graphic_eq, size: 20, color: Colors.amber.shade300),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Voice Engine & Allowance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Studio HD vs. Unlimited Standard Voice',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.white54,
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
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    quota.hasQuotaRemaining ? Colors.amber.shade400 : Colors.grey,
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
                      color: Colors.amber.shade300,
                    ),
                  ),
                  Text(
                    '$percentUsed% used of 4.0h',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.all_inclusive, size: 16, color: Colors.amber),
                        SizedBox(width: 6),
                        Text(
                          'Standard Voice is 100% Unlimited & Free',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• Studio HD Voice: 4.0 hours per week of ultra-realistic Azure Neural narration (resets Monday at 00:00).\n• Standard Voice: Unlimited, free on-device voice that never runs out and plays completely offline.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: Colors.white70,
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

  void _showChapterPicker(BuildContext context) {
    HapticsManager.light();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E22),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Chapter',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.chapters.length,
                  itemBuilder: (ctx, idx) {
                    final ch = widget.chapters[idx];
                    final isCurrent = idx == _currentChapterIndex;
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      leading: Text(
                        'Ch ${ch.chapterIndex}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isCurrent ? Colors.amber.shade300 : Colors.white38,
                        ),
                      ),
                      title: Text(
                        ch.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent ? Colors.amber.shade300 : Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        ch.titleEn,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                      ),
                      onTap: () {
                        Navigator.of(ctx).pop();
                        setState(() {
                          _currentChapterIndex = idx;
                          _currentSentenceIndex = 0;
                        });
                        _playSentenceAt(0);
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
    final quota = ref.watch(audioQuotaServiceProvider);
    final chapter = widget.chapters[_currentChapterIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF121113),
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
                    const Color(0xFF8B0000).withValues(alpha: 0.25),
                    Colors.amber.shade900.withValues(alpha: 0.12),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down, size: 28, color: Colors.white),
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
                              widget.book.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'NotoSerifSC',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showChapterPicker(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      chapter.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        color: Colors.amber.shade300,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(Icons.arrow_drop_down, size: 16, color: Colors.amber.shade300),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Sleep Timer Button
                      IconButton(
                        icon: Icon(
                          (_sleepSecondsRemaining != null || _stopAtEndOfChapter) ? Icons.bedtime : Icons.bedtime_outlined,
                          size: 22,
                          color: (_sleepSecondsRemaining != null || _stopAtEndOfChapter) ? Colors.amber.shade400 : Colors.white70,
                        ),
                        onPressed: () => _showSleepTimerModal(context),
                      ),
                    ],
                  ),
                ),

                const Divider(color: Colors.white12, height: 1),

                // Spotify-Lyrics Live Sentences Stream
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                    itemCount: chapter.sentences.length,
                    itemBuilder: (context, idx) {
                      final sentence = chapter.sentences[idx];
                      final isActive = idx == _currentSentenceIndex;

                      return GestureDetector(
                        onTap: () {
                          HapticsManager.selection();
                          _playSentenceAt(idx);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.amber.shade900.withValues(alpha: 0.22)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isActive
                                  ? Colors.amber.shade400.withValues(alpha: 0.6)
                                  : Colors.transparent,
                              width: 1.2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Pinyin
                              Text(
                                sentence.pinyin,
                                style: TextStyle(
                                  fontSize: isActive ? 13 : 11,
                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                  color: isActive
                                      ? Colors.amber.shade200
                                      : Colors.white.withValues(alpha: 0.35),
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Chinese Characters (Glowing Calligraphy)
                              Text(
                                sentence.chinese,
                                style: TextStyle(
                                  fontSize: isActive ? 21 : 16.5,
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                                  color: isActive
                                      ? Colors.amber.shade100
                                      : Colors.white.withValues(alpha: 0.45),
                                  fontFamily: 'NotoSerifSC',
                                  height: 1.4,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              if (sentence.english.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                Text(
                                  sentence.english,
                                  style: TextStyle(
                                    fontSize: isActive ? 13 : 11.5,
                                    fontStyle: FontStyle.italic,
                                    color: isActive
                                        ? Colors.white.withValues(alpha: 0.85)
                                        : Colors.white.withValues(alpha: 0.3),
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
                    color: const Color(0xFF1A191C),
                    border: Border(
                      top: BorderSide(
                        color: Colors.amber.shade700.withValues(alpha: 0.3),
                        width: 1.2,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Voice Engine Badge & Progress Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => _showQuotaDetailsSheet(context, quota),
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: quota.hasQuotaRemaining
                                    ? Colors.amber.withValues(alpha: 0.15)
                                    : Colors.white10,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: quota.hasQuotaRemaining
                                      ? Colors.amber.withValues(alpha: 0.4)
                                      : Colors.white24,
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    quota.hasQuotaRemaining ? Icons.auto_awesome : Icons.all_inclusive,
                                    size: 11,
                                    color: quota.hasQuotaRemaining ? Colors.amber.shade300 : Colors.white70,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    quota.hasQuotaRemaining
                                        ? 'Studio HD: ${quota.remainingHours.toStringAsFixed(1)}h left'
                                        : 'Unlimited Standard Voice',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: quota.hasQuotaRemaining ? Colors.amber.shade300 : Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Icon(Icons.info_outline, size: 10, color: Colors.white.withValues(alpha: 0.4)),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Sentence ${_currentSentenceIndex + 1} of ${chapter.sentences.length}',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Transport Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Speed Button
                          TextButton(
                            onPressed: _cyclePlaybackSpeed,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              '${_playbackSpeed}x',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade300,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.skip_previous_rounded, size: 30, color: Colors.white),
                            onPressed: _currentSentenceIndex > 0 ? _prevSentence : null,
                          ),

                          // Big Play / Pause Button
                          GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.amber.shade400, Colors.amber.shade700],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                size: 34,
                                color: const Color(0xFF1A1A1B),
                              ),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.skip_next_rounded, size: 30, color: Colors.white),
                            onPressed: _currentSentenceIndex < chapter.sentences.length - 1 ? _nextSentence : null,
                          ),

                          // Text Reader Switcher
                          IconButton(
                            icon: const Icon(Icons.menu_book_rounded, size: 22, color: Colors.white70),
                            tooltip: 'Return to Reader',
                            onPressed: () => Navigator.of(context).pop(),
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
