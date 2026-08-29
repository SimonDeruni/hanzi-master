import '../models/youtube_video.dart';

/// Extracts an explicit episode number from common English and Chinese titles.
int? extractEpisodeNumber(String title) {
  final patterns = [
    RegExp(
      r'(?:^|[^A-Za-z0-9])EP(?:ISODE)?\s*[-_:]?\s*(\d{1,3})(?!\d)',
      caseSensitive: false,
    ),
    RegExp(
      r'(?:^|[^A-Za-z0-9])E\s*[-_:]?\s*(\d{1,3})(?!\d)',
      caseSensitive: false,
    ),
    RegExp(r'第\s*(\d{1,3})\s*集'),
  ];

  for (final pattern in patterns) {
    final match = pattern.firstMatch(title);
    final episodeNumber = int.tryParse(match?.group(1) ?? '');
    if (episodeNumber != null && episodeNumber > 0) {
      return episodeNumber;
    }
  }
  return null;
}

/// Returns episodes in chronological order when their titles provide enough
/// numbering evidence. Collections without reliable numbering keep source order.
List<YoutubeVideo> orderShowEpisodes(List<YoutubeVideo> episodes) {
  final indexedEpisodes = episodes.indexed
      .map(
        (entry) => _IndexedEpisode(
          index: entry.$1,
          video: entry.$2,
          episodeNumber: extractEpisodeNumber(entry.$2.title),
        ),
      )
      .toList();

  final numberedCount =
      indexedEpisodes.where((entry) => entry.episodeNumber != null).length;
  if (numberedCount < 2) {
    return List<YoutubeVideo>.of(episodes);
  }

  indexedEpisodes.sort((a, b) {
    final aNumber = a.episodeNumber;
    final bNumber = b.episodeNumber;
    if (aNumber == null && bNumber == null) {
      return a.index.compareTo(b.index);
    }
    if (aNumber == null) return 1;
    if (bNumber == null) return -1;

    final numberComparison = aNumber.compareTo(bNumber);
    return numberComparison != 0
        ? numberComparison
        : a.index.compareTo(b.index);
  });

  return indexedEpisodes.map((entry) => entry.video).toList();
}

/// Counts entries that identify themselves as episodes, falling back to the
/// declared collection size when titles do not contain reliable numbering.
int deriveEpisodeCount(Iterable<String> titles, int declaredCount) {
  final episodeNumbers =
      titles.map(extractEpisodeNumber).whereType<int>().toSet();
  return episodeNumbers.length >= 2 ? episodeNumbers.length : declaredCount;
}

class _IndexedEpisode {
  final int index;
  final YoutubeVideo video;
  final int? episodeNumber;

  const _IndexedEpisode({
    required this.index,
    required this.video,
    required this.episodeNumber,
  });
}
