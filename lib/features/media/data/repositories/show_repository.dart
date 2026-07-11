import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/api_key_pool.dart';
import '../../domain/models/youtube_video.dart';
import 'shows_data.dart';

/// A show (drama series) represented as a YouTube playlist with its episodes.
class Show {
  final String id; // YouTube playlist ID
  final String title;
  final String channelTitle;
  final String thumbnailUrl;
  final String genre;
  final int episodeCount;
  final List<YoutubeVideo> episodes;
  final List<String> tags;
  const Show({
    required this.id,
    required this.title,
    required this.channelTitle,
    required this.thumbnailUrl,
    required this.genre,
    required this.episodeCount,
    required this.episodes,
    this.tags = const [],
  });
}

/// Genre categories for Chinese dramas.
enum ShowGenre {
  romance('Romance', ['爱情', '恋爱', '甜宠', '总裁', '浪漫', 'love', 'romance']),
  historical('Historical', ['古装', '宫廷', '武侠', '仙侠', '江湖', '朝代', 'historical', 'dynasty']),
  modern('Modern Drama', ['现代', '都市', '职场', '青春', '校园', 'modern', 'city']),
  fantasy('Fantasy', ['玄幻', '奇幻', '修仙', '魔幻', '神话', 'fantasy', 'magic']),
  mystery('Mystery/Thriller', ['悬疑', '推理', '刑侦', '犯罪', '侦探', 'mystery', 'thriller']),
  family('Family', ['家庭', '亲情', '育儿', '婆媳', 'family']),
  comedy('Comedy', ['喜剧', '搞笑', '幽默', 'comedy', 'funny']),
  other('Other', []);

  final String label;
  final List<String> keywords;
  const ShowGenre(this.label, this.keywords);

  static ShowGenre detect(String text) {
    final lower = text.toLowerCase();
    for (final genre in ShowGenre.values) {
      if (genre == other) continue;
      for (final keyword in genre.keywords) {
        if (lower.contains(keyword)) return genre;
      }
    }
    return other;
  }
}

/// Channel IDs for Chinese drama content providers.
class ShowChannels {
  static const List<String> channelIds = [
    'UCYQPTeY3HOk0BprrGuCWCaA', // 优酷 YOUKU
    'UCUhpu5MJQ_bjPkXO00jyxsw', // 爱奇艺 iQIYI
    'UCdpiId0eJGnnIvfhpbJIM1w', // 腾讯视频动漫 TencentVideoAnimation
    'UCQatgKoA7lylp_UzvsLCgcw', // 腾讯视频 TencentVideo
    'UCD_83Jh-UFQXRDwC6S8caCQ', // iQIYI 悬疑社 (Suspense & Thriller)
    'UCFh5x5AZHQQ6FaGKnG-QXDA', // 腾讯视频 青春剧场 (Youth & Romance)
    'UCRABdhiBHX4Bie-jfPCd2pg', // 腾讯视频 古装剧场 (Costume & Period Drama)
    'UC3PKcYXUAhao3p4kuNS4_9w', // 腾讯视频 华语经典剧场 (Classic Chinese Drama)
  ];
}
final showRepositoryProvider = Provider<ShowRepository>((ref) {
  final apiKey = ref.watch(apiKeyPoolProvider).youtubeApiKey;
  return ShowRepository(apiKey: apiKey);
});

class ShowRepository {
  final String _apiKey;
  final http.Client _client;

  ShowRepository({required String apiKey, http.Client? client})
      : _apiKey = apiKey,
        _client = client ?? http.Client();

  static const String _baseUrl = 'https://www.googleapis.com/youtube/v3';
  static final Map<String, _CachedShows> _cache = {};
  static const _cacheTtl = Duration(hours: 2);

  /// Returns all shows from the hardcoded catalog (instant, no API calls).
  /// All shows have been pre-verified to have Chinese captions.
  /// Episodes are still fetched on-demand via [fetchEpisodes].
  Future<Map<ShowGenre, List<Show>>> fetchAllShows() async {
    const cacheKey = "all_shows_v2";
    final cached = _cache[cacheKey];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheTtl) {
      debugPrint("[ShowRepo] Cache hit: ${cached.showsByGenre.values.fold(0, (sum, list) => sum + list.length)} shows");
      return cached.showsByGenre;
    }

    final allShows = <Show>[];
    for (final entry in HardcodedShows.data) {
      allShows.add(Show(
        id: entry["id"] as String,
        title: entry["title"] as String,
        channelTitle: entry["channelTitle"] as String,
        thumbnailUrl: entry["thumbnailUrl"] as String,
        genre: ShowGenre.detect(entry["title"] as String).label,
        episodeCount: entry["episodeCount"] as int,
        episodes: [],
        tags: List<String>.from(entry["tags"] as List? ?? []),
      ));
    }

    debugPrint("[ShowRepo] Loaded ${allShows.length} shows from hardcoded catalog");

    final showsByGenre = <ShowGenre, List<Show>>{};
    for (final genre in ShowGenre.values) {
      showsByGenre[genre] = [];
    }
    for (final show in allShows) {
      final genre = ShowGenre.detect(show.title);
      showsByGenre[genre]!.add(show);
    }
    showsByGenre.removeWhere((_, list) => list.isEmpty);

    _cache[cacheKey] = _CachedShows(
      showsByGenre: showsByGenre,
      timestamp: DateTime.now(),
    );

    return showsByGenre;
  }

  /// Fetches all videos from a playlist (paginated, up to 200).
  /// Videos shorter than 90 seconds are skipped (trailers, teasers, clips).
  Future<List<YoutubeVideo>> _fetchPlaylistVideos(String playlistId) async {
    const minDuration = Duration(seconds: 90);
    final videos = <YoutubeVideo>[];
    String? nextPageToken;
    for (int page = 0; page < 4; page++) {
      final uri = Uri.parse('$_baseUrl/playlistItems?part=snippet,contentDetails'
          '&playlistId=$playlistId'
          '&maxResults=50'
          '&key=$_apiKey'
          '${nextPageToken != null ? '&pageToken=$nextPageToken' : ''}');
      final response = await _client.get(uri);
      if (response.statusCode != 200) break;
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>? ?? [];
      for (final item in items) {
        try {
          final video = YoutubeVideo.fromJson(item as Map<String, dynamic>);
          // Skip short videos (trailers, teasers, clips < 90s)
          if (video.duration != null && video.duration! < minDuration) {
            debugPrint('[ShowRepo] Skipping short video: ${video.title} (${video.duration})');
            continue;
          }
          videos.add(video);
        } catch (e) {
          debugPrint('[ShowRepo] Error parsing video: $e');
        }
      }
      nextPageToken = data['nextPageToken'] as String?;
      if (nextPageToken == null) break;
    }
    return videos;
  }

  /// Returns a date-seeded daily show recommendation.
  Future<Show?> getDailyShow() async {
    final showsByGenre = await fetchAllShows();
    final allShows = showsByGenre.values.expand((list) => list).toList();
    if (allShows.isEmpty) return null;

    final today = DateTime.now();
    final seed = '${today.year}-${today.month}-${today.day}';
    final index = seed.hashCode.abs() % allShows.length;
    return allShows[index];
  }

  /// Fetches episodes for a specific show via its playlist ID.
  /// All shows in the catalog are pre-verified for Chinese captions,
  /// so episodes are returned directly without per-video caption checks.
  Future<List<YoutubeVideo>> fetchEpisodes(String showId) async {
    if (showId.startsWith("fallback")) return [];

    // Try to load from hardcoded local database first
    try {
      final showEntry = HardcodedShows.data.firstWhere(
        (entry) => entry["id"] == showId,
      );
      final hardcodedEpisodesList = showEntry["episodes"] as List<dynamic>?;
      if (hardcodedEpisodesList != null && hardcodedEpisodesList.isNotEmpty) {
        final List<YoutubeVideo> episodes = [];
        for (final ep in hardcodedEpisodesList) {
          final epMap = ep as Map<String, dynamic>;
          episodes.add(YoutubeVideo(
            id: epMap["id"] as String,
            title: epMap["title"] as String,
            url: "https://www.youtube.com/watch?v=${epMap["id"]}",
            mediumThumbnailUrl: epMap["thumbnailUrl"] as String? ?? "",
            highThumbnailUrl: epMap["thumbnailUrl"] as String? ?? "",
            channelTitle: showEntry["channelTitle"] as String? ?? "",
            uploadDate: null,
            duration: null,
          ));
        }
        debugPrint("[ShowRepo] Loaded ${episodes.length} episodes from local hardcoded shows database");
        return episodes;
      }
    } catch (e) {
      debugPrint("[ShowRepo] Show not found in local hardcoded shows database or failed parsing: $e");
    }

    // Fallback to online YouTube API fetch
    final episodes = await _fetchPlaylistVideos(showId);

    // Sort by upload date (oldest first for chronological viewing)
    episodes.sort((a, b) => (a.uploadDate ?? DateTime(2000))
        .compareTo(b.uploadDate ?? DateTime(2000)));

    return episodes;
  }

  void dispose() {
    _client.close();
  }
}

class _CachedShows {
  final Map<ShowGenre, List<Show>> showsByGenre;
  final DateTime timestamp;

  _CachedShows({required this.showsByGenre, required this.timestamp});
}