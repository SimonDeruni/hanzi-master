/// Lightweight replacement for youtube_explode_dart's Video type.
/// Built from YouTube Data API v3 JSON responses.
class YoutubeVideo {
  final String id;
  final String title;
  final String url;
  final Duration? duration;
  final String mediumThumbnailUrl;
  final String highThumbnailUrl;
  final DateTime? uploadDate;
  final String channelTitle;

  const YoutubeVideo({
    required this.id,
    required this.title,
    required this.url,
    this.duration,
    required this.mediumThumbnailUrl,
    required this.highThumbnailUrl,
    this.uploadDate,
    required this.channelTitle,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'] as Map<String, dynamic>? ?? {};
    final contentDetails =
        json['contentDetails'] as Map<String, dynamic>? ?? {};
    final thumbnails = snippet['thumbnails'] as Map<String, dynamic>? ?? {};

    final medium = thumbnails['medium'] as Map<String, dynamic>? ?? {};
    final high = thumbnails['high'] as Map<String, dynamic>? ?? {};

    // Parse duration from ISO 8601 format (e.g., "PT1H23M45S")
    Duration? duration;
    final durationStr = contentDetails['duration'] as String?;
    if (durationStr != null && durationStr.isNotEmpty) {
      duration = _parseDuration(durationStr);
    }

    // Parse upload date
    DateTime? uploadDate;
    final publishedAt = snippet['publishedAt'] as String?;
    if (publishedAt != null) {
      uploadDate = DateTime.tryParse(publishedAt);
    }

    // Handle both search results (id is a map with videoId) and playlist items
    // (id is a string, videoId is in snippet.resourceId.videoId)
    String videoId;
    if (json['id'] is Map) {
      // Search result: id = { "kind": "youtube#video", "videoId": "..." }
      videoId =
          (json['id'] as Map<String, dynamic>)['videoId'] as String? ?? '';
    } else if (json['id'] is String) {
      // Playlist item: id is the playlist item ID, real video ID is in snippet.resourceId
      final resourceId = snippet['resourceId'] as Map<String, dynamic>? ?? {};
      videoId = resourceId['videoId'] as String? ?? '';
    } else {
      videoId = '';
    }

    return YoutubeVideo(
      id: videoId,
      title: snippet['title'] as String? ?? 'Untitled',
      url: 'https://www.youtube.com/watch?v=$videoId',
      duration: duration,
      mediumThumbnailUrl: medium['url'] as String? ?? '',
      highThumbnailUrl:
          high['url'] as String? ?? (medium['url'] as String? ?? ''),
      uploadDate: uploadDate,
      channelTitle: snippet['channelTitle'] as String? ?? '',
    );
  }

  /// Parses ISO 8601 duration string (e.g., "PT1H23M45S", "PT5M30S", "PT45S").
  static Duration _parseDuration(String iso) {
    final match = RegExp(
      r'P(?:(\d+)D)?T?(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?',
    ).firstMatch(iso);

    if (match == null) return Duration.zero;

    final days = int.tryParse(match.group(1) ?? '') ?? 0;
    final hours = int.tryParse(match.group(2) ?? '') ?? 0;
    final minutes = int.tryParse(match.group(3) ?? '') ?? 0;
    final seconds = int.tryParse(match.group(4) ?? '') ?? 0;

    return Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'url': url,
        'duration': duration?.toString(),
        'mediumThumbnailUrl': mediumThumbnailUrl,
        'highThumbnailUrl': highThumbnailUrl,
        'uploadDate': uploadDate?.toIso8601String(),
        'channelTitle': channelTitle,
      };
}
