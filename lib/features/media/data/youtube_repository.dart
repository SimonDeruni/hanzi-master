import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../domain/models/youtube_video.dart';
import '../domain/models/video_transcript.dart';
import 'repositories/shows_data.dart';

final youtubeRepositoryProvider = Provider<YoutubeRepository>((ref) {
  return YoutubeRepository();
});

class YoutubeRepository {
  // In-memory cache: query → results with timestamp
  static final Map<String, _CachedResult> _cache = {};
  static const _cacheTtl = Duration(minutes: 10);

  // Cache for hasChineseCaptions results
  static final Map<String, _CachedBool> _captionCheckCache = {};
  static const _captionCheckCacheTtl = Duration(hours: 1);

  // Transcript cache
  static final Map<String, _CachedTranscript> _transcriptCache = {};
  static const _transcriptCacheTtl = Duration(hours: 1);

  /// Creates a fresh YoutubeExplode instance.
  YoutubeExplode _createYoutubeExplode() => YoutubeExplode();

  /// Searches YouTube for Chinese-language videos matching [query].
  /// Uses youtube_explode_dart (no API key / no quota).
  Future<List<YoutubeVideo>> searchVideos(String query) async {
    // Check cache first
    final cached = _cache[query];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheTtl) {
      debugPrint(
          '[YT Cache] Hit for "$query" → ${cached.videos.length} videos');
      return cached.videos;
    }

    final validVideos = <YoutubeVideo>[];

    try {
      final searchQuery = '$query 中文';
      final yt = _createYoutubeExplode();
      try {
        final results = await yt.search.search(searchQuery);
        final iterator = results.iterator;
        int processedCount = 0;

        while (processedCount < 20 && validVideos.length < 10) {
          Video video;
          try {
            if (!iterator.moveNext()) break;
            video = iterator.current;
          } catch (e) {
            debugPrint('[YT Search] Error parsing result item: $e');
            continue;
          }
          processedCount++;

          // Check for Chinese captions
          try {
            final manifest =
                await yt.videos.closedCaptions.getManifest(video.id);
            final hasChinese =
                manifest.tracks.any((t) => _isChineseLanguage(t.language.code));
            if (!hasChinese) continue;
          } catch (_) {
            // No captions available — skip
            continue;
          }

          validVideos.add(_videoToModel(video));
        }
      } finally {
        yt.close();
      }

      debugPrint('[YT Search] Found ${validVideos.length} videos for "$query"');
    } catch (e) {
      debugPrint('[YT Search] Error: $e. Falling back to local search.');
      final localResults = _localSearchFallback(query);
      if (localResults.isNotEmpty) {
        _cache[query] = _CachedResult(
          videos: localResults,
          timestamp: DateTime.now(),
        );
        return localResults;
      }
      // If local fallback also empty, return empty list rather than throwing
      return [];
    }

    if (validVideos.isNotEmpty) {
      _cache[query] = _CachedResult(
        videos: validVideos,
        timestamp: DateTime.now(),
      );
    }

    return validVideos;
  }

  /// Converts a youtube_explode_dart [Video] to our [YoutubeVideo] domain model.
  YoutubeVideo _videoToModel(Video video) {
    final thumbUrl = video.thumbnails.standardResUrl.isNotEmpty
        ? video.thumbnails.standardResUrl
        : video.thumbnails.mediumResUrl;
    final highUrl = video.thumbnails.maxResUrl.isNotEmpty
        ? video.thumbnails.maxResUrl
        : thumbUrl;

    return YoutubeVideo(
      id: video.id.value,
      title: video.title,
      url: 'https://www.youtube.com/watch?v=${video.id.value}',
      duration: video.duration,
      mediumThumbnailUrl: thumbUrl,
      highThumbnailUrl: highUrl,
      uploadDate: video.publishDate,
      channelTitle: video.author,
    );
  }

  /// Flattens and searches through local HardcodedShows as a no-network fallback.
  List<YoutubeVideo> _localSearchFallback(String query) {
    final results = <YoutubeVideo>[];
    // Strip common Chinese search suffixes we add ourselves
    final cleanQuery = query
        .replaceAll(RegExp(r'中国|中文|china|chinese'), '')
        .trim()
        .toLowerCase();
    final terms =
        cleanQuery.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();

    for (final show in HardcodedShows.data) {
      final showTitle = (show['title'] as String? ?? '').toLowerCase();
      final channelTitle = show['channelTitle'] as String? ?? '';
      final tags = (show['tags'] as List? ?? [])
          .map((t) => t.toString().toLowerCase())
          .toList();
      final episodes = show['episodes'] as List? ?? [];

      for (final ep in episodes) {
        final epMap = ep as Map<String, dynamic>;
        final epTitle = (epMap['title'] as String? ?? '').toLowerCase();

        bool matches = terms.isEmpty ||
            terms.any((t) =>
                showTitle.contains(t) ||
                epTitle.contains(t) ||
                tags.any((tag) => tag.contains(t)));

        if (matches) {
          results.add(YoutubeVideo(
            id: epMap['id'] as String? ?? '',
            title: '${show['title']} - ${epMap['title']}',
            url: 'https://www.youtube.com/watch?v=${epMap['id']}',
            duration: null,
            mediumThumbnailUrl: epMap['thumbnailUrl'] as String? ?? '',
            highThumbnailUrl: epMap['thumbnailUrl'] as String? ?? '',
            uploadDate: null,
            channelTitle: channelTitle,
          ));
        }
      }
    }

    debugPrint(
        '[YT Fallback] Found ${results.length} local results for "$query"');
    return results.take(20).toList();
  }

  /// Lightweight check: returns true if the video has Chinese captions.
  Future<bool> hasChineseCaptions(String videoId) async {
    try {
      final cached = _captionCheckCache[videoId];
      if (cached != null &&
          DateTime.now().difference(cached.timestamp) < _captionCheckCacheTtl) {
        return cached.value;
      }

      final yt = _createYoutubeExplode();
      try {
        final manifest = await yt.videos.closedCaptions.getManifest(videoId);
        final hasChinese =
            manifest.tracks.any((t) => _isChineseLanguage(t.language.code));

        _captionCheckCache[videoId] = _CachedBool(
          value: hasChinese,
          timestamp: DateTime.now(),
        );

        debugPrint('[YT hasCaptions] $videoId → $hasChinese');
        return hasChinese;
      } finally {
        yt.close();
      }
    } catch (e) {
      debugPrint('[YT hasChineseCaptions] Error for $videoId: $e');
      return false;
    }
  }

  /// Fetches the transcript (closed captions) for a YouTube video.
  Future<VideoTranscript?> getTranscript(String videoId) async {
    try {
      final cached = _transcriptCache[videoId];
      if (cached != null &&
          DateTime.now().difference(cached.timestamp) < _transcriptCacheTtl) {
        debugPrint(
            '[YT Transcript] Cache hit for $videoId ${cached.transcript.lines.length} lines');
        return cached.transcript;
      }

      final yt = _createYoutubeExplode();
      try {
        final manifest = await yt.videos.closedCaptions.getManifest(videoId);

        // Prefer manual track over auto-generated
        ClosedCaptionTrackInfo? bestTrack;
        for (final track in manifest.tracks) {
          if (_isChineseLanguage(track.language.code)) {
            if (!track.isAutoGenerated) {
              bestTrack = track;
              break;
            }
            bestTrack ??= track;
          }
        }

        if (bestTrack == null) {
          debugPrint('[YT Transcript] No Chinese caption track for $videoId');
          return null;
        }

        final captionTrack = await yt.videos.closedCaptions.get(bestTrack);
        final lines = <TranscriptLine>[];

        for (final caption in captionTrack.captions) {
          final text = caption.text.trim();
          if (text.isEmpty) continue;
          lines.add(TranscriptLine(
            text: text,
            start: caption.offset,
            duration: caption.duration,
          ));
        }

        if (lines.isEmpty) {
          debugPrint('[YT Transcript] Empty captions for $videoId');
          return null;
        }

        final transcript = VideoTranscript(videoId: videoId, lines: lines);
        _transcriptCache[videoId] = _CachedTranscript(
          transcript: transcript,
          timestamp: DateTime.now(),
        );

        debugPrint('[YT Transcript] Success: $videoId → ${lines.length} lines');
        return transcript;
      } finally {
        yt.close();
      }
    } catch (e) {
      debugPrint('[YT Transcript] Error for $videoId: $e');
      return null;
    }
  }

  // ── Channel cache ──
  static final Map<String, _CachedChannel> _channelCache = {};
  static const _channelCacheTtl = Duration(hours: 1);

  // ── Channel uploads cache ──
  static final Map<String, _CachedResult> _channelUploadsCache = {};

  /// Gets channel metadata by @handle.
  Future<Map<String, String>> getChannelByHandle(String handle) async {
    final cacheKey = 'handle:$handle';
    final cached = _channelCache[cacheKey];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _channelCacheTtl) {
      return cached.data;
    }

    final yt = _createYoutubeExplode();
    try {
      final channel = await yt.channels.getByHandle(handle);
      final data = {
        'id': channel.id.value,
        'title': channel.title,
        'logoUrl': channel.logoUrl,
      };
      _channelCache[cacheKey] = _CachedChannel(
        data: data,
        timestamp: DateTime.now(),
      );
      debugPrint('[YT Channel] Resolved handle "$handle" → ${channel.title}');
      return data;
    } catch (e) {
      debugPrint('[YT Channel] Error resolving handle "$handle": $e');
      rethrow;
    } finally {
      yt.close();
    }
  }

  /// Gets channel metadata by channel ID (UC...).
  Future<Map<String, String>> getChannelById(String channelId) async {
    final cacheKey = 'id:$channelId';
    final cached = _channelCache[cacheKey];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _channelCacheTtl) {
      return cached.data;
    }

    final yt = _createYoutubeExplode();
    try {
      final channel = await yt.channels.get(channelId);
      final data = {
        'id': channel.id.value,
        'title': channel.title,
        'logoUrl': channel.logoUrl,
      };
      _channelCache[cacheKey] = _CachedChannel(
        data: data,
        timestamp: DateTime.now(),
      );
      debugPrint('[YT Channel] Resolved id "$channelId" → ${channel.title}');
      return data;
    } catch (e) {
      debugPrint('[YT Channel] Error resolving id "$channelId": $e');
      rethrow;
    } finally {
      yt.close();
    }
  }

  /// Gets channel metadata by discovering which channel uploaded a video.
  Future<Map<String, String>> getChannelByVideo(String videoId) async {
    final cacheKey = 'video:$videoId';
    final cached = _channelCache[cacheKey];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _channelCacheTtl) {
      return cached.data;
    }

    final yt = _createYoutubeExplode();
    try {
      final channel = await yt.channels.getByVideo(videoId);
      final data = {
        'id': channel.id.value,
        'title': channel.title,
        'logoUrl': channel.logoUrl,
      };
      _channelCache[cacheKey] = _CachedChannel(
        data: data,
        timestamp: DateTime.now(),
      );
      debugPrint('[YT Channel] Resolved video "$videoId" → ${channel.title}');
      return data;
    } catch (e) {
      debugPrint('[YT Channel] Error resolving video "$videoId": $e');
      rethrow;
    } finally {
      yt.close();
    }
  }

  /// Fetches recent uploads from a channel.
  /// Returns up to [maxPages] × 30 videos (capped at [maxVideos]).
  Future<List<YoutubeVideo>> getChannelUploads(String channelId,
      {int maxPages = 3, int maxVideos = 120}) async {
    final cacheKey = 'uploads:$channelId:$maxPages';
    final cached = _channelUploadsCache[cacheKey];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheTtl) {
      debugPrint(
          '[YT ChUploads] Cache hit for "$channelId" → ${cached.videos.length} videos');
      return cached.videos;
    }

    final yt = _createYoutubeExplode();
    try {
      final uploads = await yt.channels.getUploadsFromPage(channelId);
      final videos = <YoutubeVideo>[];

      var page = 1;
      var current = uploads;
      while (true) {
        for (final video in current) {
          videos.add(YoutubeVideo(
            id: video.id.value,
            title: video.title,
            url: 'https://www.youtube.com/watch?v=${video.id.value}',
            duration: video.duration,
            mediumThumbnailUrl: video.thumbnails.mediumResUrl,
            highThumbnailUrl: video.thumbnails.maxResUrl.isNotEmpty
                ? video.thumbnails.maxResUrl
                : video.thumbnails.mediumResUrl,
            uploadDate: video.publishDate,
            channelTitle: video.author,
          ));
        }

        // Stop if we've hit the page cap or video cap.
        if (page >= maxPages || videos.length >= maxVideos) {
          break;
        }

        // Try to fetch the next page.
        final next = await current.nextPage();
        if (next == null) break; // no more results
        current = next;
        page++;
      }

      _channelUploadsCache[cacheKey] = _CachedResult(
        videos: videos,
        timestamp: DateTime.now(),
      );
      debugPrint(
          '[YT ChUploads] Loaded ${videos.length} videos in $page page(s) for "$channelId"');
      return videos;
    } catch (e) {
      debugPrint('[YT ChUploads] Error for "$channelId": $e');
      rethrow;
    } finally {
      yt.close();
    }
  }

  bool _isChineseLanguage(String langCode) {
    final lower = langCode.toLowerCase();
    return lower.startsWith('zh') || lower == 'cmn' || lower == 'yue';
  }
}

class _CachedResult {
  final List<YoutubeVideo> videos;
  final DateTime timestamp;
  _CachedResult({required this.videos, required this.timestamp});
}

class _CachedTranscript {
  final VideoTranscript transcript;
  final DateTime timestamp;
  _CachedTranscript({required this.transcript, required this.timestamp});
}

class _CachedBool {
  final bool value;
  final DateTime timestamp;
  _CachedBool({required this.value, required this.timestamp});
}

class _CachedChannel {
  final Map<String, String> data;
  final DateTime timestamp;
  _CachedChannel({required this.data, required this.timestamp});
}
