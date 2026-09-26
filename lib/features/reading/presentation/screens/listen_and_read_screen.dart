import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/layout/zen_two_pane.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/screens/audiobook_player_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// The iPad **listen-and-read desk** (Part 2b of `docs/IPAD_ADAPTIVE_PLAN.md`):
/// the audiobook transport beside the matching book text, chapter-synced.
///
/// Both halves already exist and are keyed by the same pair — the player by
/// `(book, chapters)`, the reader by `(book, chapters)` — so this screen is
/// composition rather than a new engine. Two rules make it behave:
///
///  * **The audio is the clock.** The text follows the audio's chapter: a
///    location event that moves the chapter re-keys the reader pane onto it. The
///    reverse (text drives audio) would fight the transport and reset the
///    reader's scroll on every sentence.
///  * **Nothing stops the audiobook.** The phone path *replaces* the player with
///    the reader and stops playback on the way out; here the player keeps playing
///    in its own pane, which is the entire point of the screen.
///
/// The transport's own read button ([AudiobookPlayerScreen.onOpenTextPane])
/// becomes "put the text where the audio is right now" — the one explicit
/// catch-up action, useful after the learner has scrolled away.
///
/// Pushed only at `isExpanded` (see `_switchToReadingMode`), and
/// [ZenTwoPaneScaffold] degrades to the transport alone if the window cannot
/// hold both panes, so a phone or a narrow Split View slice never sees a crushed
/// pair.
class ListenAndReadScreen extends ConsumerStatefulWidget {
  const ListenAndReadScreen({
    super.key,
    required this.book,
    required this.chapters,
    this.initialChapterIndex = 0,
    this.initialSentenceIndex = 0,
  });

  final BookModel book;
  final List<BookChapter> chapters;
  final int initialChapterIndex;
  final int initialSentenceIndex;

  @override
  ConsumerState<ListenAndReadScreen> createState() =>
      _ListenAndReadScreenState();
}

class _ListenAndReadScreenState extends ConsumerState<ListenAndReadScreen> {
  /// Which chapter the text pane is showing — the audio's, once it moves.
  late int _chapterIndex;

  /// The audio's sentence, kept up to date on every location event but read
  /// only when the reader pane is re-keyed: re-keying per *sentence* would
  /// reset the reader's scroll while the learner is reading.
  int _audioSentenceIndex = 0;

  /// Bumped by a chapter change or an explicit "follow the audio" press; it is
  /// what re-keys the reader pane, so the pane is rebuilt on purpose and never
  /// as a side effect of an unrelated setState.
  int _readerEpoch = 0;

  @override
  void initState() {
    super.initState();
    _chapterIndex = widget.chapters.isEmpty
        ? 0
        : widget.initialChapterIndex.clamp(0, widget.chapters.length - 1);
    _audioSentenceIndex = math.max(0, widget.initialSentenceIndex);
  }

  void _onAudioLocation(int chapterIndex, int sentenceIndex) {
    _audioSentenceIndex = math.max(0, sentenceIndex);
    if (chapterIndex == _chapterIndex) return;
    if (chapterIndex < 0 || chapterIndex >= widget.chapters.length) return;
    setState(() {
      _chapterIndex = chapterIndex;
      _readerEpoch++;
    });
  }

  /// "Text, follow the audio": re-key the reader onto the spoken sentence.
  void _followAudio() {
    setState(() => _readerEpoch++);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? l10n = AppLocalizations.of(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color background =
        isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final Color primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final BookChapter chapter = widget.chapters[_chapterIndex];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.book.localizedTitle(
                Localizations.localeOf(context).toLanguageTag(),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryText,
              ),
            ),
            // The sync itself, visible: which chapter the text pane is on. Both
            // strings already exist, so the desk adds no localization debt.
            Text(
              l10n?.chapterXOfY(chapter.chapterIndex, widget.chapters.length) ??
                  '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: primaryText.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
      body: ZenTwoPaneScaffold(
        listPaneWidth: 400,
        backgroundColor: background,
        emptyDetail: const SizedBox.shrink(),
        listPane: AudiobookPlayerScreen(
          book: widget.book,
          chapters: widget.chapters,
          initialChapterIndex: _chapterIndex,
          initialSentenceIndex: _audioSentenceIndex,
          embedded: true,
          onLocationChanged: _onAudioLocation,
          onOpenTextPane: _followAudio,
        ),
        detailPane: BookReaderScreen(
          key: ValueKey<String>('reader-$_chapterIndex-$_readerEpoch'),
          book: widget.book,
          chapters: widget.chapters,
          initialChapterIndex: _chapterIndex,
          initialSentenceIndex: _audioSentenceIndex,
          embedded: true,
        ),
      ),
    );
  }
}
