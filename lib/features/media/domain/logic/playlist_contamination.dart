const defaultShortVideoThreshold = Duration(minutes: 13);

enum PlaylistContamination {
  onlyShortVideos('only_short_videos'),
  containsShortVideos('contains_short_videos'),
  noShortVideos('no_short_videos'),
  incomplete('incomplete'),
  unknown('unknown');

  const PlaylistContamination(this.jsonValue);

  final String jsonValue;
}

enum ShortVideoEvidence {
  highlight('highlight'),
  replay('replay'),
  trailerOrPromo('trailer_or_promo'),
  otherShort('other_short');

  const ShortVideoEvidence(this.jsonValue);

  final String jsonValue;
}

Duration? parseYoutubeDuration(String value) {
  final match = RegExp(
    r'^P(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?)?$',
    caseSensitive: false,
  ).firstMatch(value.trim());
  if (match == null) return null;

  final hasComponent = match.groups([1, 2, 3, 4]).any((part) => part != null);
  if (!hasComponent) return null;

  int component(int group) => int.tryParse(match.group(group) ?? '') ?? 0;

  return Duration(
    days: component(1),
    hours: component(2),
    minutes: component(3),
    seconds: component(4),
  );
}

bool isShortVideo(
  Duration duration, {
  Duration threshold = defaultShortVideoThreshold,
}) {
  return duration < threshold;
}

ShortVideoEvidence qualifyShortVideoTitle(String title) {
  final normalized = title.toLowerCase();

  if (_containsAny(normalized, const [
    'highlight',
    'highlights',
    '精彩',
    '高光',
    '名场面',
    '精华',
  ])) {
    return ShortVideoEvidence.highlight;
  }
  if (_containsAny(normalized, const [
    'replay',
    '回放',
    '重播',
  ])) {
    return ShortVideoEvidence.replay;
  }
  if (_containsAny(normalized, const [
    'trailer',
    'teaser',
    'preview',
    'promo',
    '预告',
    '片花',
    '花絮',
    '幕后',
    '特辑',
    'bts',
  ])) {
    return ShortVideoEvidence.trailerOrPromo;
  }
  return ShortVideoEvidence.otherShort;
}

PlaylistContamination classifyPlaylist({
  required int shortVideoCount,
  required int longVideoCount,
  required int unresolvedVideoCount,
}) {
  if (shortVideoCount < 0 || longVideoCount < 0 || unresolvedVideoCount < 0) {
    throw ArgumentError('Video counts cannot be negative.');
  }

  final resolvedCount = shortVideoCount + longVideoCount;
  if (resolvedCount == 0) return PlaylistContamination.unknown;

  if (unresolvedVideoCount > 0) {
    if (shortVideoCount > 0 && longVideoCount > 0) {
      return PlaylistContamination.containsShortVideos;
    }
    return PlaylistContamination.incomplete;
  }
  if (shortVideoCount == 0) return PlaylistContamination.noShortVideos;
  if (longVideoCount == 0) return PlaylistContamination.onlyShortVideos;
  return PlaylistContamination.containsShortVideos;
}

String formatVideoDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  final minuteText = minutes.toString().padLeft(hours > 0 ? 2 : 1, '0');
  final secondText = seconds.toString().padLeft(2, '0');
  return hours > 0
      ? '$hours:$minuteText:$secondText'
      : '$minuteText:$secondText';
}

bool _containsAny(String value, List<String> terms) {
  return terms.any(value.contains);
}
