/// One teaching video, exactly as the official YouTube Data API describes it.
///
/// Deliberately thin, and deliberately not a transcript host: it carries the id,
/// the title, the channel that made it, a **link** to a thumbnail and a duration.
/// There is no field for captions, subtitles or audio, because the Tutorials tab
/// plays videos through YouTube's own player and never takes a copy of anything —
/// see `tutorials_repository.dart` for why that is the whole point.
library;

class TutorialVideo {
  const TutorialVideo({
    required this.id,
    required this.title,
    required this.channelTitle,
    required this.thumbnailUrl,
    this.duration,
  });

  final String id;
  final String title;

  /// Who made it. YouTube's terms require this next to the video, so it is a
  /// required field rather than an optional one.
  final String channelTitle;

  /// Served from `i.ytimg.com`, never re-hosted (re-hosting is not permitted).
  final String thumbnailUrl;

  final Duration? duration;

  /// The canonical watch page. Every card and the player offer this, because the
  /// app must always let the viewer leave for YouTube.
  String get watchUrl => 'https://www.youtube.com/watch?v=$id';

  /// The thumbnail URL for [id], built the way `show_repository.dart` builds it:
  /// straight at YouTube's own host.
  static String thumbnailFor(String id) =>
      'https://i.ytimg.com/vi/$id/hqdefault.jpg';

  /// Builds a video from a `videos.list` item (`part=snippet,contentDetails`).
  ///
  /// Returns `null` for an item the in-app player is not allowed to show — a
  /// video with `status.embeddable == false` would render a card that fails on
  /// tap, so it is dropped here instead.
  static TutorialVideo? fromApiItem(Map<String, dynamic> item) {
    final String id = item['id']?.toString() ?? '';
    if (id.isEmpty) return null;

    final Map<String, dynamic>? status =
        (item['status'] as Map?)?.cast<String, dynamic>();
    if (status != null && status['embeddable'] == false) return null;

    final Map<String, dynamic> snippet =
        ((item['snippet'] as Map?) ?? <String, dynamic>{})
            .cast<String, dynamic>();
    final String title = (snippet['title'] ?? '').toString();
    final String channel = (snippet['channelTitle'] ?? '').toString();
    if (title.isEmpty) return null;

    return TutorialVideo(
      id: id,
      title: title,
      channelTitle: channel,
      thumbnailUrl: thumbnailFor(id),
      duration: parseIsoDuration(
        ((item['contentDetails'] as Map?) ?? <String, dynamic>{})['duration']
            ?.toString(),
      ),
    );
  }

  /// Parses the API's ISO-8601 duration (`PT1H2M3S`) into a [Duration].
  ///
  /// Returns `null` rather than throwing on anything unexpected: a missing
  /// duration must cost the card its "12:34" label, not the whole shelf.
  static Duration? parseIsoDuration(String? value) {
    if (value == null || value.isEmpty) return null;
    final RegExpMatch? match = RegExp(
      r'^P(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?)?$',
    ).firstMatch(value);
    if (match == null) return null;

    final int days = int.tryParse(match.group(1) ?? '') ?? 0;
    final int hours = int.tryParse(match.group(2) ?? '') ?? 0;
    final int minutes = int.tryParse(match.group(3) ?? '') ?? 0;
    final int seconds = int.tryParse(match.group(4) ?? '') ?? 0;
    final Duration parsed = Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
    return parsed == Duration.zero ? null : parsed;
  }

  /// `m:ss`, or `h:mm:ss` once the video runs past an hour.
  String? get durationLabel {
    final Duration? value = duration;
    if (value == null) return null;
    final String two = (value.inSeconds % 60).toString().padLeft(2, '0');
    if (value.inHours > 0) {
      final String minutes =
          (value.inMinutes % 60).toString().padLeft(2, '0');
      return '${value.inHours}:$minutes:$two';
    }
    return '${value.inMinutes}:$two';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'channelTitle': channelTitle,
        'thumbnailUrl': thumbnailUrl,
        'durationSeconds': duration?.inSeconds,
      };

  static TutorialVideo? fromJson(Map<String, dynamic> json) {
    final String id = json['id']?.toString() ?? '';
    if (id.isEmpty) return null;
    final Object? seconds = json['durationSeconds'];
    return TutorialVideo(
      id: id,
      title: (json['title'] ?? '').toString(),
      channelTitle: (json['channelTitle'] ?? '').toString(),
      thumbnailUrl: (json['thumbnailUrl'] ?? thumbnailFor(id)).toString(),
      duration: seconds is int ? Duration(seconds: seconds) : null,
    );
  }
}
