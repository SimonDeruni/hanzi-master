import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/now_playing_provider.dart';
import 'package:hanzi_master/features/reading/presentation/screens/audiobook_player_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

/// Sticky transport bar for background audiobook playback.
///
/// Sits above the shell's bottom navigation whenever an audiobook is loaded, so
/// leaving the reader (or the full-screen player while it is playing) no longer
/// strands playback with no in-app control — the OS media notification stays the
/// out-of-app surface. It hides itself the moment the engine is released, and it
/// is deliberately quiet: one accent tile, the book and its position, a
/// play/pause toggle and a stop.
class NowPlayingBar extends ConsumerWidget {
  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final NowPlayingInfo? info = ref.watch(nowPlayingProvider).valueOrNull;
    if (info == null) return const SizedBox.shrink();

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final Color cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final Color ink = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final Color accent =
        isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);
    final Color hairline =
        isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06);

    return Material(
      color: cardBg,
      child: InkWell(
        onTap: () => _openPlayer(context, ref),
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: hairline)),
          ),
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.headphones_rounded, size: 19, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.bookTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _positionLabel(ref, l10n, info),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: ink.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  info.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 24,
                  color: ink,
                ),
                tooltip: info.playing ? l10n.pause : l10n.play,
                onPressed: () => _togglePlayPause(ref, info.playing),
              ),
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: ink.withValues(alpha: 0.55),
                ),
                tooltip: l10n.stop,
                onPressed: () => _stop(ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// "Chapter 4 of 120 · Sentence 1 of 228", matching the reader's header.
  String _positionLabel(
    WidgetRef ref,
    AppLocalizations l10n,
    NowPlayingInfo info,
  ) {
    final NowPlayingBook? playing = ref.watch(nowPlayingBookProvider);
    if (playing == null || playing.chapters.isEmpty) {
      return info.chapterTitle;
    }
    final int index = info.chapterIndex.clamp(0, playing.chapters.length - 1);
    final BookChapter chapter = playing.chapters[index];
    return '${l10n.chapterXOfY(chapter.chapterIndex, playing.chapters.length)}'
        ' · '
        '${l10n.sentenceXOfY(info.sentenceIndex + 1, chapter.sentences.length)}';
  }

  void _togglePlayPause(WidgetRef ref, bool playing) {
    HapticsManager.light();
    final AudioService audio = ref.read(audioServiceProvider);
    unawaited(playing ? audio.pause() : audio.play());
  }

  void _stop(WidgetRef ref) {
    HapticsManager.medium();
    unawaited(ref.read(audioServiceProvider).stop());
  }

  /// Reopens the full-screen player at the sentence the engine is on.
  void _openPlayer(BuildContext context, WidgetRef ref) {
    final NowPlayingBook? playing = ref.read(nowPlayingBookProvider);
    final NowPlayingInfo? info = ref.read(nowPlayingProvider).valueOrNull;
    if (playing == null || info == null) return;

    HapticsManager.light();
    Navigator.of(context).push(
      SwipeBackRoute(
        builder: (BuildContext context) => AudiobookPlayerScreen(
          book: playing.book,
          chapters: playing.chapters,
          initialChapterIndex: info.chapterIndex,
          initialSentenceIndex: info.sentenceIndex,
        ),
      ),
    );
  }
}
