import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';

/// The book currently handed to the background audiobook engine.
///
/// The engine knows the sentence and the titles, but not the [BookModel] or its
/// chapters — the shell needs both to reopen the full-screen player from its Now
/// Playing bar without reloading the book.
class NowPlayingBook {
  const NowPlayingBook({required this.book, required this.chapters});

  final BookModel book;
  final List<BookChapter> chapters;
}

/// Published by `AudiobookPlayerScreen` when it hands the book to the engine.
final nowPlayingBookProvider = StateProvider<NowPlayingBook?>((ref) => null);

/// What the shell's Now Playing bar renders.
class NowPlayingInfo {
  const NowPlayingInfo({
    required this.playing,
    required this.bookTitle,
    required this.chapterTitle,
    required this.chapterIndex,
    required this.sentenceIndex,
  });

  final bool playing;
  final String bookTitle;
  final String chapterTitle;

  /// List index of the chapter (0-based), as held by the engine's tracks.
  final int chapterIndex;

  /// List index of the sentence within that chapter (0-based).
  final int sentenceIndex;
}

/// Re-emits whenever the engine's loaded sentence or play/pause state changes.
///
/// `AudiobookLocation` is emitted on configure, play, pause and stop, so one
/// subscription keeps the bar honest — including hiding it the instant the
/// engine is released.
final nowPlayingProvider = StreamProvider<NowPlayingInfo?>((ref) {
  final AudioService audio = ref.watch(audioServiceProvider);
  final StreamController<NowPlayingInfo?> controller =
      StreamController<NowPlayingInfo?>();

  void emit() {
    final AudiobookTrack? track = audio.currentTrack;
    if (!audio.isAudiobookLoaded || track == null) {
      controller.add(null);
      return;
    }
    controller.add(NowPlayingInfo(
      playing: audio.isAudiobookPlaying,
      bookTitle: track.bookTitle,
      chapterTitle: track.chapterTitle,
      chapterIndex: track.chapterIndex,
      sentenceIndex: track.sentenceIndex,
    ));
  }

  final StreamSubscription<AudiobookLocation> locationSub =
      audio.onAudiobookLocationChanged.listen((_) => emit());
  ref.onDispose(() {
    locationSub.cancel();
    controller.close();
  });

  emit();
  return controller.stream;
});
