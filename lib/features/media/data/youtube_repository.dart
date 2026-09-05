import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lpinyin/lpinyin.dart';
import 'package:xml/xml.dart' as xml;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../domain/models/youtube_video.dart';
import '../domain/models/video_transcript.dart';

final youtubeRepositoryProvider = Provider<YoutubeRepository>((ref) {
  return YoutubeRepository();
});

class YoutubeRepository {
  YoutubeRepository();

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

  /// Searches YouTube for videos matching [query] that have softcoded Chinese subtitles.
  Future<List<YoutubeVideo>> searchVideos(String query) async {
    // Check cache first
    final cached = _cache[query];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheTtl) {
      debugPrint(
          '[YT Cache] Hit for "$query" → ${cached.videos.length} videos');
      return cached.videos;
    }

    List<YoutubeVideo> videos = <YoutubeVideo>[];

    try {
      final yt = _createYoutubeExplode();
      try {
        final searchList = await yt.search.search(query);
        final rawVideos = <Video>[];
        for (final video in searchList) {
          rawVideos.add(video);
          if (rawVideos.length >= 25) break;
        }

        final candidates = rawVideos.map(_videoToModel).toList();
        videos = await filterWithSubtitlesOnly(candidates, max: 15);
      } finally {
        yt.close();
      }

      debugPrint('[YT Explode Search] Found ${videos.length} videos with subtitles for "$query"');
    } catch (e) {
      debugPrint('[YT Explode Search] Error: $e');
    }

    if (videos.isNotEmpty) {
      _cache[query] = _CachedResult(
        videos: videos,
        timestamp: DateTime.now(),
      );
    }

    return videos;
  }

  /// Converts a youtube_explode_dart [Video] to our [YoutubeVideo] domain model.
  YoutubeVideo _videoToModel(Video video) {
    String thumb = video.thumbnails.highResUrl;
    if (thumb.isEmpty) {
      thumb = video.thumbnails.mediumResUrl;
    }
    if (thumb.isEmpty) {
      thumb = 'https://img.youtube.com/vi/${video.id.value}/hqdefault.jpg';
    }

    return YoutubeVideo(
      id: video.id.value,
      title: video.title,
      url: 'https://www.youtube.com/watch?v=${video.id.value}',
      duration: video.duration,
      mediumThumbnailUrl: thumb,
      highThumbnailUrl: thumb,
      uploadDate: video.publishDate,
      channelTitle: video.author,
    );
  }



  /// Lightweight check: returns true if the video has any closed captions available (manual or auto-generated).
  Future<bool> hasCaptions(String videoId) async {
    try {
      final cached = _captionCheckCache[videoId];
      if (cached != null &&
          DateTime.now().difference(cached.timestamp) < _captionCheckCacheTtl) {
        return cached.value;
      }

      final yt = _createYoutubeExplode();
      try {
        final manifest = await yt.videos.closedCaptions.getManifest(videoId);
        final hasCc = manifest.tracks.isNotEmpty;

        _captionCheckCache[videoId] = _CachedBool(
          value: hasCc,
          timestamp: DateTime.now(),
        );

        debugPrint('[YT hasCaptions] $videoId → $hasCc (tracks: ${manifest.tracks.length})');
        return hasCc;
      } finally {
        yt.close();
      }
    } catch (e) {
      debugPrint('[YT hasCaptions] Error for $videoId: $e');
      return false;
    }
  }

  /// Filters candidates in parallel chunks, returning only videos that have closed caption subtitles.
  Future<List<YoutubeVideo>> filterWithSubtitlesOnly(
      List<YoutubeVideo> candidates,
      {int max = 30}) async {
    final verified = <YoutubeVideo>[];
    const chunkSize = 6;
    for (var i = 0; i < candidates.length; i += chunkSize) {
      final chunk = candidates.skip(i).take(chunkSize).toList();
      final checks = await Future.wait(chunk.map((v) async {
        final hasCc = await hasCaptions(v.id);
        return hasCc ? v : null;
      }));
      for (final v in checks) {
        if (v != null) verified.add(v);
      }
      if (verified.length >= max) break;
    }
    return verified;
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

        debugPrint('[YT hasChineseCaptions] $videoId → $hasChinese');
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
  /// Tries manual Chinese tracks first, then auto-generated Chinese tracks,
  /// then any available track. If youtube_explode_dart can't reach the
  /// caption manifest, returns null — the caller should fall back to
  /// YouTube's native (iframe) CC button which the user can toggle.
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
        // getManifest() may throw TransientFailureException when YouTube
        // rate-limits or blocks the request. Catch gracefully so the UI
        // can fall back to the iframe CC button.
        ClosedCaptionManifest manifest;
        try {
          manifest = await yt.videos.closedCaptions.getManifest(videoId);
        } catch (manifestError) {
          debugPrint('[YT Transcript] getManifest failed for $videoId: $manifestError');
          return null; // Let the UI fall back to native CC button
        }

        if (manifest.tracks.isEmpty) {
          debugPrint('[YT Transcript] No caption tracks in manifest for $videoId, trying timedtext ASR fallback...');
          final timedTextFallback = await _fetchTimedTextDirect(videoId);
          if (timedTextFallback != null && timedTextFallback.lines.isNotEmpty) {
            _transcriptCache[videoId] = _CachedTranscript(
              transcript: timedTextFallback,
              timestamp: DateTime.now(),
            );
            return timedTextFallback;
          }
          return null;
        }

        // 1. Score tracks to pick the highest quality Chinese track
        final sortedTracks = List<ClosedCaptionTrackInfo>.from(manifest.tracks)
          ..sort((a, b) => _scoreTrack(b).compareTo(_scoreTrack(a)));
        final bestTrack = sortedTracks.first;

        debugPrint('[YT Transcript] Using track: lang=${bestTrack.language.code} autoGen=${bestTrack.isAutoGenerated} score=${_scoreTrack(bestTrack)}');

        final captionTrack = await yt.videos.closedCaptions.get(bestTrack);
        final lines = <TranscriptLine>[];

        for (final caption in captionTrack.captions) {
          final text = caption.text.trim();
          if (text.isEmpty) continue;
          final pinyin = RegExp(r'[\u4e00-\u9fff]').hasMatch(text)
              ? PinyinHelper.getPinyinE(text,
                  separator: ' ', format: PinyinFormat.WITH_TONE_MARK)
              : null;
          lines.add(TranscriptLine(
            text: text,
            pinyin: pinyin,
            start: caption.offset,
            duration: caption.duration,
          ));
        }

        if (lines.isEmpty) {
          debugPrint('[YT Transcript] Empty captions in track for $videoId, trying timedtext fallback...');
          final timedTextFallback = await _fetchTimedTextDirect(videoId);
          if (timedTextFallback != null && timedTextFallback.lines.isNotEmpty) {
            _transcriptCache[videoId] = _CachedTranscript(
              transcript: timedTextFallback,
              timestamp: DateTime.now(),
            );
            return timedTextFallback;
          }
          return null;
        }

        final mergedLines = deduplicateAndMergeLines(lines);
        final transcript = VideoTranscript(videoId: videoId, lines: mergedLines);
        _transcriptCache[videoId] = _CachedTranscript(
          transcript: transcript,
          timestamp: DateTime.now(),
        );

        debugPrint('[YT Transcript] Success: $videoId → raw ${lines.length} lines, merged ${mergedLines.length} lines (${bestTrack.isAutoGenerated ? "auto-generated" : "manual"})');
        return transcript;
      } finally {
        yt.close();
      }
    } catch (e) {
      debugPrint('[YT Transcript] Error for $videoId: $e, trying timedtext fallback...');
      final timedTextFallback = await _fetchTimedTextDirect(videoId);
      if (timedTextFallback != null && timedTextFallback.lines.isNotEmpty) {
        _transcriptCache[videoId] = _CachedTranscript(
          transcript: timedTextFallback,
          timestamp: DateTime.now(),
        );
        return timedTextFallback;
      }
      return null;
    }
  }

  /// Direct YouTube TimedText ASR scraper fallback for videos where ClosedCaptionManifest is throttled or missing.
  Future<VideoTranscript?> _fetchTimedTextDirect(String videoId) async {
    final languagesToTry = ['zh-Hans', 'zh-Hant', 'zh', 'zh-CN', 'zh-TW', 'en'];
    for (final lang in languagesToTry) {
      try {
        final url = Uri.parse(
            'https://www.youtube.com/api/timedtext?v=$videoId&lang=$lang&fmt=srv3');
        final response = await http.get(url, headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        }).timeout(const Duration(seconds: 4));

        if (response.statusCode == 200 && response.body.contains('<p')) {
          final document = xml.XmlDocument.parse(response.body);
          final pElements = document.findAllElements('p');
          final lines = <TranscriptLine>[];

          for (final p in pElements) {
            final tAttr = p.getAttribute('t');
            final dAttr = p.getAttribute('d');
            final text = p.innerText.replaceAll('&#39;', "'").replaceAll('&quot;', '"').trim();
            if (text.isEmpty || tAttr == null) continue;

            final startMs = int.tryParse(tAttr) ?? 0;
            final durMs = int.tryParse(dAttr ?? '2000') ?? 2000;

            final pinyin = RegExp(r'[\u4e00-\u9fff]').hasMatch(text)
                ? PinyinHelper.getPinyinE(text,
                    separator: ' ', format: PinyinFormat.WITH_TONE_MARK)
                : null;

            lines.add(TranscriptLine(
              text: text,
              pinyin: pinyin,
              start: Duration(milliseconds: startMs),
              duration: Duration(milliseconds: durMs),
            ));
          }

          if (lines.isNotEmpty) {
            final mergedLines = deduplicateAndMergeLines(lines);
            debugPrint('[YT TimedText] Successfully fetched ${lines.length} raw lines, merged ${mergedLines.length} lines via timedtext for lang=$lang');
            return VideoTranscript(videoId: videoId, lines: mergedLines);
          }
        }
      } catch (e) {
        debugPrint('[YT TimedText] Error fetching timedtext for lang=$lang: $e');
      }
    }
    return null;
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
      {int maxPages = 3, int maxVideos = 120, String? channelName}) async {
    final cacheKey = 'uploads:$channelId:$maxPages';
    final cached = _channelUploadsCache[cacheKey];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheTtl) {
      debugPrint(
          '[YT ChUploads] Cache hit for "$channelId" → ${cached.videos.length} videos');
      return cached.videos;
    }

    final videos = <YoutubeVideo>[];
    final yt = _createYoutubeExplode();

    try {
      // 1. First, resolve handle or channel name to obtain the definitive search query
      final query = (channelName != null && channelName.isNotEmpty)
          ? channelName
          : channelId;

      try {
        // Search directly for the creator's videos to guarantee authentic video titles & durations
        final searchResults = await yt.search.search(query);
        for (final video in searchResults) {
          final model = _videoToModel(video);
          if (model.title.isNotEmpty) {
            videos.add(model);
          }
          if (videos.length >= maxVideos) break;
        }
      } catch (searchError) {
        debugPrint('[YT ChUploads] Search fallback failed: $searchError');
      }

      // 2. If search returned empty, attempt getUploadsFromPage
      if (videos.isEmpty) {
        try {
          final uploads = await yt.channels.getUploadsFromPage(channelId);
          for (final video in uploads) {
            final title = video.title.isNotEmpty ? video.title : '';
            videos.add(YoutubeVideo(
              id: video.id.value,
              title: title,
              url: 'https://www.youtube.com/watch?v=${video.id.value}',
              duration: video.duration,
              mediumThumbnailUrl: video.thumbnails.mediumResUrl,
              highThumbnailUrl: video.thumbnails.maxResUrl.isNotEmpty
                  ? video.thumbnails.maxResUrl
                  : video.thumbnails.mediumResUrl,
              uploadDate: video.publishDate,
              channelTitle: video.author.isNotEmpty ? video.author : (channelName ?? ''),
            ));
            if (videos.length >= maxVideos) break;
          }
        } catch (pageError) {
          debugPrint('[YT ChUploads] getUploadsFromPage also failed: $pageError');
        }
      }

      // Filter candidates so only videos with working closed captions (auto-generated or manual) are returned
      final verifiedVideos = await filterWithSubtitlesOnly(videos, max: maxVideos);

      _channelUploadsCache[cacheKey] = _CachedResult(
        videos: verifiedVideos,
        timestamp: DateTime.now(),
      );
      debugPrint(
          '[YT ChUploads] Loaded ${verifiedVideos.length} videos with subtitles for "$channelId"');
      return verifiedVideos;
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

  /// Score tracks so manual standard Chinese character tracks are prioritized
  /// over generic tracks or auto-generated tracks.
  static int _scoreTrack(ClosedCaptionTrackInfo track) {
    final code = track.language.code.toLowerCase();
    int score = 0;
    // Prefer human-uploaded captions over ASR
    if (!track.isAutoGenerated) score += 100;

    // Specific Chinese locales (Standard Simplified / Traditional) first
    if (code == 'zh-hans' || code == 'zh-cn') {
      score += 50;
    } else if (code == 'zh-hant' || code == 'zh-tw' || code == 'zh-hk') {
      score += 45;
    } else if (code.startsWith('zh') || code == 'cmn' || code == 'yue') {
      score += 35;
    } else if (code.startsWith('en')) {
      score += 10;
    }
    return score;
  }

  /// Deduplicates consecutive identical or near-identical transcript cues (e.g. roll-up
  /// captions or split subtitle segments) and smoothly merges their durations.
  static List<TranscriptLine> deduplicateAndMergeLines(List<TranscriptLine> rawLines) {
    if (rawLines.length <= 1) return rawLines;

    final merged = <TranscriptLine>[];

    String normalize(String text) {
      return text
          .trim()
          .replaceAll(RegExp(r'[\s，。！？、,.!?；;：“”"’‘—…\-]'), '')
          .replaceAll("'", '')
          .toLowerCase();
    }

    for (final current in rawLines) {
      if (current.text.trim().isEmpty) continue;

      if (merged.isEmpty) {
        merged.add(current);
        continue;
      }

      final prev = merged.last;
      final normCurrent = normalize(current.text);
      final normPrev = normalize(prev.text);

      // Check if current line is identical or normalized equivalent to previous line
      if (normCurrent.isNotEmpty && normCurrent == normPrev) {
        final prevEnd = prev.start + prev.duration;
        final currentEnd = current.start + current.duration;
        final gap = current.start - prevEnd;

        // If contiguous or overlapping within 2.5 seconds, merge them
        if (gap <= const Duration(milliseconds: 2500)) {
          final extendedEnd = currentEnd > prevEnd ? currentEnd : prevEnd;
          final extendedDuration = extendedEnd - prev.start;

          // Pick the richest text/pinyin/translation representation
          final bestText = current.text.length > prev.text.length ? current.text : prev.text;
          final bestPinyin = (current.pinyin != null && current.pinyin!.isNotEmpty)
              ? current.pinyin
              : prev.pinyin;
          final bestTranslation = (current.translation != null && current.translation!.isNotEmpty)
              ? current.translation
              : prev.translation;

          merged[merged.length - 1] = prev.copyWith(
            text: bestText,
            pinyin: bestPinyin,
            duration: extendedDuration,
            translation: bestTranslation,
          );
          continue;
        }
      }

      merged.add(current);
    }

    return merged;
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
