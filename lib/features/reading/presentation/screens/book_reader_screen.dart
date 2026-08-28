import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

enum BookPinyinMode { all, ghost, none }

class BookReaderScreen extends ConsumerStatefulWidget {
  final BookModel book;
  final List<BookChapter> chapters;
  final int initialChapterIndex;
  final bool autoStartAudiobook;
  final bool autoStartHumanAudio;

  const BookReaderScreen({
    super.key,
    required this.book,
    required this.chapters,
    required this.initialChapterIndex,
    this.autoStartAudiobook = false,
    this.autoStartHumanAudio = false,
  });

  @override
  ConsumerState<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends ConsumerState<BookReaderScreen> {
  late int _currentIndex;
  BookPinyinMode _pinyinMode = BookPinyinMode.all;
  final Set<int> _revealedTranslations = {};
  double _fontSize = 20.0;
  final ScrollController _scrollController = ScrollController();

  // Neural Audiobook State
  bool _isAudiobookActive = false;
  bool _isAudiobookPlaying = false;
  int _currentAudioSentenceIndex = 0;
  StreamSubscription? _audioCompleteSub;

  // Open-Source Human Voice Stream State (Archive.org)
  bool _isStreamingHumanAudio = false;
  bool _isHumanAudioPlaying = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialChapterIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _saveProgress();
        if (widget.autoStartAudiobook) {
          _startAudiobook();
        } else if (widget.autoStartHumanAudio && widget.book.audioStreamUrl != null) {
          _startHumanAudioStream();
        }
      }
    });

    _audioCompleteSub = ref.read(audioServiceProvider).onPlayerComplete.listen((_) {
      if (_isAudiobookActive && _isAudiobookPlaying && mounted) {
        _onSentenceAudioFinished();
      } else if (_isStreamingHumanAudio && mounted) {
        setState(() => _isHumanAudioPlaying = false);
      }
    });
  }

  @override
  void dispose() {
    _audioCompleteSub?.cancel();
    _stopAudiobook();
    _stopHumanAudioStream();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAudiobook() {
    _stopHumanAudioStream();
    HapticsManager.medium();
    setState(() {
      _isAudiobookActive = true;
      _isAudiobookPlaying = true;
      _currentAudioSentenceIndex = 0;
    });
    _playSentenceAt(_currentAudioSentenceIndex);
  }

  void _stopAudiobook() {
    ref.read(audioServiceProvider).stop();
    if (mounted) {
      setState(() {
        _isAudiobookActive = false;
        _isAudiobookPlaying = false;
      });
    }
  }

  void _togglePlayPauseAudiobook() {
    HapticsManager.light();
    if (_isAudiobookPlaying) {
      ref.read(audioServiceProvider).stop();
      setState(() => _isAudiobookPlaying = false);
    } else {
      setState(() => _isAudiobookPlaying = true);
      _playSentenceAt(_currentAudioSentenceIndex);
    }
  }

  void _startHumanAudioStream() async {
    if (widget.book.audioStreamUrl == null) return;
    _stopAudiobook();
    HapticsManager.medium();
    setState(() {
      _isStreamingHumanAudio = true;
      _isHumanAudioPlaying = true;
    });
    final success = await ref.read(audioServiceProvider).playStreamUrl(widget.book.audioStreamUrl!);
    if (!success && mounted) {
      setState(() {
        _isStreamingHumanAudio = false;
        _isHumanAudioPlaying = false;
      });
      _startAudiobook();
    }
  }

  void _stopHumanAudioStream() {
    ref.read(audioServiceProvider).stop();
    if (mounted) {
      setState(() {
        _isStreamingHumanAudio = false;
        _isHumanAudioPlaying = false;
      });
    }
  }

  void _togglePlayPauseHumanAudio() async {
    HapticsManager.light();
    if (_isHumanAudioPlaying) {
      ref.read(audioServiceProvider).stop();
      setState(() => _isHumanAudioPlaying = false);
    } else {
      if (widget.book.audioStreamUrl != null) {
        setState(() => _isHumanAudioPlaying = true);
        final success = await ref.read(audioServiceProvider).playStreamUrl(widget.book.audioStreamUrl!);
        if (!success && mounted) {
          setState(() {
            _isStreamingHumanAudio = false;
            _isHumanAudioPlaying = false;
          });
          _startAudiobook();
        }
      }
    }
  }

  void _playSentenceAt(int sentenceIdx) {
    final chapter = widget.chapters[_currentIndex];
    if (sentenceIdx >= 0 && sentenceIdx < chapter.sentences.length) {
      setState(() => _currentAudioSentenceIndex = sentenceIdx);
      final text = chapter.sentences[sentenceIdx].chinese;
      ref.read(audioServiceProvider).playSentence(text);
    }
  }

  void _onSentenceAudioFinished() {
    final chapter = widget.chapters[_currentIndex];
    if (_currentAudioSentenceIndex < chapter.sentences.length - 1) {
      Future.delayed(const Duration(milliseconds: 350), () {
        if (_isAudiobookActive && _isAudiobookPlaying && mounted) {
          _playSentenceAt(_currentAudioSentenceIndex + 1);
        }
      });
    } else {
      // Finished chapter
      if (_currentIndex < widget.chapters.length - 1) {
        Future.delayed(const Duration(milliseconds: 800), () {
          if (_isAudiobookActive && _isAudiobookPlaying && mounted) {
            _goToNextChapter();
            _startAudiobook();
          }
        });
      } else {
        _stopAudiobook();
      }
    }
  }

  void _audiobookPrevSentence() {
    if (_currentAudioSentenceIndex > 0) {
      HapticsManager.selection();
      _playSentenceAt(_currentAudioSentenceIndex - 1);
    }
  }

  void _audiobookNextSentence() {
    final chapter = widget.chapters[_currentIndex];
    if (_currentAudioSentenceIndex < chapter.sentences.length - 1) {
      HapticsManager.selection();
      _playSentenceAt(_currentAudioSentenceIndex + 1);
    }
  }

  void _saveProgress() {
    final chapterNumber = widget.chapters[_currentIndex].chapterIndex;
    final fraction = widget.chapters.isNotEmpty
        ? ((_currentIndex + 1) / widget.chapters.length).clamp(0.0, 1.0)
        : 1.0;
    ref.read(bookRepositoryProvider).saveReadingProgress(
      bookId: widget.book.id,
      chapterIndex: chapterNumber,
      percentage: fraction,
    );
    Future.microtask(() {
      if (mounted) {
        ref.invalidate(inProgressBooksProvider);
      }
    });
  }

  void _goToPreviousChapter() {
    if (_currentIndex > 0) {
      HapticsManager.medium();
      setState(() {
        _currentIndex--;
        _revealedTranslations.clear();
      });
      _scrollToTop();
      _saveProgress();
    }
  }

  void _goToNextChapter() {
    if (_currentIndex < widget.chapters.length - 1) {
      HapticsManager.medium();
      setState(() {
        _currentIndex++;
        _revealedTranslations.clear();
      });
      _scrollToTop();
      _saveProgress();
    }
  }

  void _jumpToChapter(int targetIdx) {
    if (targetIdx >= 0 && targetIdx < widget.chapters.length) {
      HapticsManager.medium();
      setState(() {
        _currentIndex = targetIdx;
        _revealedTranslations.clear();
      });
      _scrollToTop();
      _saveProgress();
    }
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _toggleBookmark() async {
    HapticsManager.heavy();
    final chapter = widget.chapters[_currentIndex];
    final snippet = chapter.sentences.isNotEmpty ? chapter.sentences.first : null;
    final snippetZh = snippet?.chinese ?? chapter.title;
    final snippetEn = snippet?.english ?? chapter.titleEn;

    final repo = ref.read(bookRepositoryProvider);
    final existing = repo.getBookmarks(widget.book.id);
    final isAlreadyBookmarked = existing.any((b) => b.chapterIndex == chapter.chapterIndex);

    if (isAlreadyBookmarked) {
      final target = existing.firstWhere((b) => b.chapterIndex == chapter.chapterIndex);
      await repo.removeBookmark(target.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('书签已移除 · Bookmark removed'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      final newBm = BookmarkModel(
        id: '${widget.book.id}_bm_${DateTime.now().millisecondsSinceEpoch}',
        bookId: widget.book.id,
        chapterIndex: chapter.chapterIndex,
        sentenceIndex: 0,
        snippetChinese: snippetZh,
        snippetEnglish: snippetEn,
        createdAt: DateTime.now(),
      );
      await repo.saveBookmark(newBm);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('已添加书签 · Bookmark added: 第${chapter.chapterIndex}回'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
    setState(() {});
  }

  void _openBookmarksDrawer(BuildContext context, bool isDark, Color cardBg, Color primaryText) {
    HapticsManager.selection();
    final repo = ref.read(bookRepositoryProvider);
    final bookmarks = repo.getBookmarks(widget.book.id);

    showModalBottomSheet(
      context: context,
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
                        color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                        leading: CircleAvatar(
                          backgroundColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                          child: Text(
                            '${bm.chapterIndex}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
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
                          icon: const Icon(Icons.delete_outline, size: 18, color: Colors.redAccent),
                          onPressed: () async {
                            await repo.removeBookmark(bm.id);
                            if (ctx.mounted) Navigator.of(ctx).pop();
                            if (context.mounted) {
                              _openBookmarksDrawer(context, isDark, cardBg, primaryText);
                            }
                          },
                        ),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _jumpToChapter(bm.chapterIndex - 1);
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

  void _openChapterDrawer(BuildContext context, bool isDark, Color cardBg, Color primaryText) {
    HapticsManager.selection();
    showModalBottomSheet(
      context: context,
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
                                ? (isDark ? Colors.amber.withValues(alpha: 0.15) : const Color(0xFFF2ECE1))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isCurrent
                                  ? (isDark ? Colors.amber.shade500 : const Color(0xFF8B0000))
                                  : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.04)),
                            ),
                          ),
                          child: ListTile(
                            dense: true,
                            leading: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCurrent
                                    ? (isDark ? Colors.amber.shade600 : const Color(0xFF8B0000))
                                    : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
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
                                        : (isDark ? Colors.white70 : Colors.black87),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              ch.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                                color: primaryText,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                ch.titleEn,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
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

  void _showAudioModeSelector(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    HapticsManager.light();
    showModalBottomSheet(
      context: context,
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
              Text(
                '选择听书伴读模式 · Audio Mode',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Choose how you want to listen to this classical work.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              // Option 1: Open Human Stream (Archive.org)
              Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF9F5EC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? Colors.amber.shade700.withValues(alpha: 0.5) : const Color(0xFFD4AF37),
                    width: 1.2,
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.amber.withValues(alpha: 0.2) : const Color(0xFF8B0000).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.podcasts, color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000)),
                  ),
                  title: Text(
                    '🎙️ 评书与真人原声 · Open Human Voice',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: primaryText,
                    ),
                  ),
                  subtitle: Text(
                    'Streaming open public-domain recording from Internet Archive (Archive.org).',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _startHumanAudioStream();
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Option 2: Synchronized Neural Reader
              Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.blue.withValues(alpha: 0.2) : Colors.indigo.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.graphic_eq, color: isDark ? Colors.blue.shade300 : Colors.indigo.shade700),
                  ),
                  title: Text(
                    '⚡ 智能逐句伴读 · Synchronized Neural Reader',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: primaryText,
                    ),
                  ),
                  subtitle: Text(
                    'Sentence-by-sentence reading with real-time text highlight and word lookup.',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _startAudiobook();
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
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);

    final chapter = widget.chapters[_currentIndex];
    final repo = ref.read(bookRepositoryProvider);
    final bookmarks = repo.getBookmarks(widget.book.id);
    final isCurrentBookmarked = bookmarks.any((b) => b.chapterIndex == chapter.chapterIndex);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Text(
              widget.book.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryText,
              ),
            ),
            Text(
              'Chapter ${chapter.chapterIndex} of ${widget.chapters.length}',
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
          ],
        ),
        actions: [
          // Audiobook Mode Toggle
          IconButton(
            icon: Icon(
              (_isAudiobookActive || _isStreamingHumanAudio) ? Icons.headphones : Icons.headphones_outlined,
              size: 22,
              color: (_isAudiobookActive || _isStreamingHumanAudio)
                  ? (isDark ? Colors.amber.shade400 : const Color(0xFF8B0000))
                  : primaryText,
            ),
            tooltip: 'Audiobook & Read-Aloud',
            onPressed: () {
              if (_isAudiobookActive) {
                _stopAudiobook();
              } else if (_isStreamingHumanAudio) {
                _stopHumanAudioStream();
              } else {
                if (widget.book.audioStreamUrl != null) {
                  _showAudioModeSelector(context, isDark, cardBg, primaryText);
                } else {
                  _startAudiobook();
                }
              }
            },
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
            tooltip: 'Bookmark Chapter',
            onPressed: _toggleBookmark,
          ),
          // Bookmarks List
          IconButton(
            icon: Icon(Icons.bookmarks_outlined, size: 20, color: primaryText),
            tooltip: 'View Bookmarks',
            onPressed: () => _openBookmarksDrawer(context, isDark, cardBg, primaryText),
          ),
          // Table of Contents Drawer
          IconButton(
            icon: Icon(Icons.format_list_bulleted, size: 22, color: primaryText),
            tooltip: 'Table of Contents',
            onPressed: () => _openChapterDrawer(context, isDark, cardBg, primaryText),
          ),
          // Pinyin Toggle
          IconButton(
            icon: Icon(
              _pinyinMode == BookPinyinMode.all
                  ? Icons.spellcheck
                  : (_pinyinMode == BookPinyinMode.ghost ? Icons.visibility : Icons.visibility_off),
              size: 22,
              color: primaryText,
            ),
            tooltip: 'Toggle Pinyin',
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
          // Font Size Adjust
          IconButton(
            icon: Icon(Icons.text_fields, size: 22, color: primaryText),
            tooltip: 'Adjust Font Size',
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
          // Chapter Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chapter Header
                  Center(
                    child: Column(
                      children: [
                        Text(
                          chapter.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
                            letterSpacing: 1.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (chapter.titleEn.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            chapter.titleEn,
                            style: TextStyle(
                              fontSize: 13.5,
                              color: isDark ? Colors.white70 : Colors.black87,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Sentences
                  ...chapter.sentences.asMap().entries.map((entry) {
                    final index = entry.key;
                    final sentence = entry.value;
                    final isRevealed = _revealedTranslations.contains(index);
                    final isAudioActiveSentence = _isAudiobookActive && _currentAudioSentenceIndex == index;

                    return GestureDetector(
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
                              ? (isDark ? Colors.amber.shade900.withValues(alpha: 0.28) : const Color(0xFFFFF6D8))
                              : (isRevealed
                                  ? (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03))
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(12),
                          border: isAudioActiveSentence
                              ? Border.all(
                                  color: isDark ? Colors.amber.shade400 : const Color(0xFFD4AF37),
                                  width: 1.5,
                                )
                              : (isRevealed
                                  ? Border.all(color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06))
                                  : null),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row: Pinyin & Audio Button
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _pinyinMode != BookPinyinMode.none && sentence.pinyin.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            sentence.pinyin,
                                            style: TextStyle(
                                              fontSize: _fontSize * 0.65,
                                              color: _pinyinMode == BookPinyinMode.ghost
                                                  ? (isDark ? Colors.white30 : Colors.black26)
                                                  : (isDark ? Colors.amber.shade200 : Colors.indigo.shade700),
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: Icon(
                                    Icons.volume_up_outlined,
                                    size: 18,
                                    color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
                                  ),
                                  onPressed: () {
                                    HapticsManager.light();
                                    ref.read(audioServiceProvider).playSentence(sentence.chinese);
                                  },
                                ),
                              ],
                            ),

                            // Chinese Characters with Tap-to-Lookup
                            Wrap(
                              spacing: 1,
                              runSpacing: 4,
                              children: sentence.chinese.characters.map((char) {
                                final isPunctuation = RegExp(r'[，。！？、“”‘’：；《》（）—…\s]').hasMatch(char);
                                return GestureDetector(
                                  onTap: () {
                                    if (!isPunctuation) {
                                      HapticsManager.light();
                                      showQuickLook(context, char);
                                    }
                                  },
                                  child: Text(
                                    char,
                                    style: TextStyle(
                                      fontSize: _fontSize,
                                      color: primaryText,
                                      fontWeight: FontWeight.w500,
                                      height: 1.4,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            // English Translation (Tap to reveal)
                            if (isRevealed && sentence.english.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  sentence.english,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
                                    fontStyle: FontStyle.italic,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Neural Audiobook Floating Controls Bar
          if (_isAudiobookActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2824) : const Color(0xFFF9F5EC),
                border: Border(
                  top: BorderSide(
                    color: isDark ? Colors.amber.shade700.withValues(alpha: 0.4) : const Color(0xFFD4AF37).withValues(alpha: 0.6),
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
              child: Row(
                children: [
                  Icon(
                    Icons.graphic_eq,
                    size: 20,
                    color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Audiobook: Sentence ${_currentAudioSentenceIndex + 1} / ${chapter.sentences.length}',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: primaryText,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_previous, size: 22),
                    color: primaryText,
                    onPressed: _currentAudioSentenceIndex > 0 ? _audiobookPrevSentence : null,
                  ),
                  IconButton(
                    icon: Icon(
                      _isAudiobookPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      size: 32,
                      color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
                    ),
                    onPressed: _togglePlayPauseAudiobook,
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, size: 22),
                    color: primaryText,
                    onPressed: _currentAudioSentenceIndex < chapter.sentences.length - 1 ? _audiobookNextSentence : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    color: isDark ? Colors.white54 : Colors.black45,
                    onPressed: _stopAudiobook,
                  ),
                ],
              ),
            ),

          // Archive.org Open Human Voice Stream Floating Bar
          if (_isStreamingHumanAudio)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E2430) : const Color(0xFFEDF3FC),
                border: Border(
                  top: BorderSide(
                    color: isDark ? Colors.blue.shade600.withValues(alpha: 0.5) : Colors.indigo.shade300,
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.blue.withValues(alpha: 0.25) : Colors.indigo.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.podcasts,
                      size: 18,
                      color: isDark ? Colors.blue.shade300 : Colors.indigo.shade700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🎙️ 真人原声流 · Archive.org Stream',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.blue.shade200 : Colors.indigo.shade900,
                          ),
                        ),
                        Text(
                          '${widget.book.title} · ${widget.book.author}',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isHumanAudioPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      size: 32,
                      color: isDark ? Colors.blue.shade300 : Colors.indigo.shade700,
                    ),
                    onPressed: _togglePlayPauseHumanAudio,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    color: isDark ? Colors.white54 : Colors.black45,
                    onPressed: _stopHumanAudioStream,
                  ),
                ],
              ),
            ),

          // Bottom Chapter Navigation Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cardBg,
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
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
                    label: const Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.white12 : Colors.black12,
                      foregroundColor: primaryText,
                      elevation: 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _openChapterDrawer(context, isDark, cardBg, primaryText),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.list_alt, size: 14, color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000)),
                          const SizedBox(width: 4),
                          Text(
                            'Chapter ${_currentIndex + 1} of ${widget.chapters.length}',
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
                    onPressed: _currentIndex < widget.chapters.length - 1 ? _goToNextChapter : null,
                    label: const Text('Next'),
                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.amber.shade700 : const Color(0xFF1A1A1B),
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
