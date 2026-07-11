import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../domain/models/youtube_video.dart';
import '../domain/models/video_transcript.dart';
import '../../../core/services/api_key_pool.dart';

final youtubeRepositoryProvider = Provider<YoutubeRepository>((ref) {
  final apiKey = ref.watch(apiKeyPoolProvider).youtubeApiKey;
  return YoutubeRepository(apiKey: apiKey);
});

class YoutubeRepository {
  final String _apiKey;
  final http.Client _client;

  YoutubeRepository({required String apiKey, http.Client? client})
      : _apiKey = apiKey,
        _client = client ?? http.Client();

  static const _baseUrl = 'https://www.googleapis.com/youtube/v3';

  // In-memory cache: query → results with timestamp
  static final Map<String, _CachedResult> _cache = {};
  static const _cacheTtl = Duration(minutes: 5);

  // Cache for hasChineseCaptions results to avoid repeated API calls
  static final Map<String, _CachedBool> _captionCheckCache = {};
  static const _captionCheckCacheTtl = Duration(hours: 1);
/// Creates a fresh YoutubeExplode instance.
  YoutubeExplode _createYoutubeExplode() => YoutubeExplode();

  /// Searches YouTube for Chinese-language videos matching [query].
  /// Returns up to 20 videos that have captions available.
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
      final uri = Uri.parse('$_baseUrl/search?part=snippet'
          '&q=${Uri.encodeQueryComponent(searchQuery)}'
          '&type=video'
          '&videoCaption=closedCaption'
          '&relevanceLanguage=zh'
          '&maxResults=20'
          '&key=$_apiKey');

      final response = await _client.get(uri);

      if (response.statusCode != 200) {
        final errorBody = response.body;
        debugPrint('[YT Search] API error ${response.statusCode}: $errorBody');
        // Parse the error message for better debugging
        try {
          final errorData = jsonDecode(errorBody) as Map<String, dynamic>;
          final error = errorData['error'] as Map<String, dynamic>? ?? {};
          final message = error['message'] as String? ?? 'Unknown error';
          debugPrint('[YT Search] Error reason: $message');
        } catch (_) {}
        return validVideos;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>? ?? [];

      if (items.isEmpty) return validVideos;

      // Collect video IDs for batch duration lookup
      final videoIds = items
          .map((item) {
            final id = item['id'] as Map<String, dynamic>? ?? {};
            return id['videoId'] as String? ?? '';
          })
          .where((id) => id.isNotEmpty)
          .toList();

      if (videoIds.isEmpty) return validVideos;

      // Batch fetch video durations via videos.list
      final durationMap = await _fetchDurations(videoIds);

      for (final item in items) {
        final video = YoutubeVideo.fromJson(item as Map<String, dynamic>);

        // Enrich with duration if available
        final duration = durationMap[video.id];
        if (duration != null) {
          validVideos.add(YoutubeVideo(
            id: video.id,
            title: video.title,
            url: video.url,
            duration: duration,
            mediumThumbnailUrl: video.mediumThumbnailUrl,
            highThumbnailUrl: video.highThumbnailUrl,
            uploadDate: video.uploadDate,
            channelTitle: video.channelTitle,
          ));
        } else {
          validVideos.add(video);
        }
      }

      // Cache results
      _cache[query] = _CachedResult(
        videos: validVideos,
        timestamp: DateTime.now(),
      );

      debugPrint('[YT Search] Found ${validVideos.length} videos for "$query"');
    } catch (e) {
      debugPrint('[YT Search] Error: $e');
    }

    return validVideos;
  }

  /// Batch-fetches video durations using videos.list endpoint.
  Future<Map<String, Duration>> _fetchDurations(List<String> videoIds) async {
    final result = <String, Duration>{};
    if (videoIds.isEmpty) return result;

    try {
      final uri = Uri.parse('$_baseUrl/videos?part=contentDetails'
          '&id=${videoIds.join(',')}'
          '&key=$_apiKey');

      final response = await _client.get(uri);
      if (response.statusCode != 200) return result;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>? ?? [];

      for (final item in items) {
        final id = item['id'] as String? ?? '';
        final contentDetails =
            item['contentDetails'] as Map<String, dynamic>? ?? {};
        final durationStr = contentDetails['duration'] as String?;
        if (durationStr != null && durationStr.isNotEmpty) {
          result[id] = _parseDuration(durationStr);
        }
      }
    } catch (e) {
      debugPrint('[YT Durations] Error: $e');
    }

    return result;
  }

  /// Parses ISO 8601 duration string (e.g., "PT1H23M45S").
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

  /// Lightweight check: returns true if the video has Chinese captions available.
  /// Uses youtube_explode_dart to inspect the closed captions manifest.
  Future<bool> hasChineseCaptions(String videoId) async {
    try {
      // Check cache first
      final cached = _captionCheckCache[videoId];
      if (cached != null &&
          DateTime.now().difference(cached.timestamp) < _captionCheckCacheTtl) {
        return cached.value;
      }

      final yt = _createYoutubeExplode();
      try {
        final manifest = await yt.videos.closedCaptions.getManifest(videoId);
        final hasChinese = manifest.tracks.any(
          (t) => _isChineseLanguage(t.language.code),
        );

        _captionCheckCache[videoId] = _CachedBool(
          value: hasChinese,
          timestamp: DateTime.now(),
        );

        debugPrint(
            '[YT hasCaptions] $videoId → $hasChinese (via youtube_explode_dart)');
        return hasChinese;
      } finally {
        yt.close();
      }
    } catch (e) {
      debugPrint('[YT hasChineseCaptions] Error for $videoId: $e');
      return false;
    }
  }
// Transcript cache: videoId → cached transcript
  static final Map<String, _CachedTranscript> _transcriptCache = {};
  static const _transcriptCacheTtl = Duration(hours: 1);

  /// Fetches the transcript (closed captions) for a YouTube video.
  /// Uses youtube_explode_dart's closed captions API.
  Future<VideoTranscript?> getTranscript(String videoId) async {
    try {
      // Check transcript cache first
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

        // Find a Chinese track (prefer manual, fall back to auto-generated)
        ClosedCaptionTrackInfo? bestTrack;
        for (final track in manifest.tracks) {
          if (_isChineseLanguage(track.language.code)) {
            // Prefer manual ("standard") over auto-generated
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

        debugPrint(
            '[YT Transcript] Success: $videoId → ${lines.length} lines (via youtube_explode_dart)');
        return transcript;
      } finally {
        yt.close();
      }
    } catch (e) {
      debugPrint('[YT Transcript] Error for $videoId: $e');
      return null;
    }
  }

  /// Checks if a language code represents Chinese.
  bool _isChineseLanguage(String langCode) {
    return langCode == 'zh' ||
        langCode == 'zh-cn' ||
        langCode == 'zh-tw' ||
        langCode == 'zh-hans' ||
        langCode == 'zh-hant' ||
        langCode == 'cmn' ||
        langCode == 'yue';
  }

  void dispose() {
    _client.close();
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
