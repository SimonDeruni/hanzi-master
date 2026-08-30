import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/api_key_pool.dart';
import '../../domain/models/youtube_video.dart';
import 'shows_data.dart';
import 'valid_show_ids.dart';

/// Whether a show has softcoded (interactive) or hardcoded (burned-in) subtitles.
enum SubtitleType { soft, hard }

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
  final SubtitleType subtitleType;
  const Show({
    required this.id,
    required this.title,
    required this.channelTitle,
    required this.thumbnailUrl,
    required this.genre,
    required this.episodeCount,
    required this.episodes,
    this.tags = const [],
    this.subtitleType = SubtitleType.hard,
  });
}

/// Genre categories for Chinese dramas.
enum ShowGenre {
  romance('Romance', [
    '爱情', '恋爱', '甜宠', '总裁', '浪漫', '情', '恋', '嫁', '夫', '妻', '妻主', '妃', '宠',
    '心动', '相爱', 'love', 'romance', 'sweet', 'lover', 'wedding', 'heart', 'kiss', 'girl',
    'girlfriend', 'boy', 'boyfriend', 'fall in love', 'my girl', 'first romance', 'fall for'
  ]),
  historical('Historical / Costume', [
    '古装', '宫廷', '武侠', '仙侠', '江湖', '朝代', '大唐', '大宋', '明朝', '清朝', '皇', '帝',
    '剑', '刀', '侠', '宗', '门', '国', '天下', '锦', '令', '传', '世家', 'historical',
    'dynasty', 'costume', 'wuxia', 'xianxia', 'palace', 'emperor', 'king', 'sword', 'blade'
  ]),
  modern('Modern & Youth', [
    '现代', '都市', '职场', '青春', '校园', '生活', '日常', '少年', '同学', '大学', '高中',
    '毕业', '奋斗', '逆袭', '成长', '青年', '时代', '年华', '岁', '守诚', 'police', 'guardian',
    '刑侦', '犯罪', '侦探', '破案', '真相', '探案', '重案', 'modern', 'city', 'youth',
    'campus', 'school', 'student', 'life', 'story', 'dream', 'young'
  ]),
  fantasy('Fantasy & Mythology', [
    '玄幻', '奇幻', '修仙', '魔幻', '神话', '妖', '魔', '神', '灵', '九', '龙', '凤',
    '异能', '转世', '重生', '异界', 'fantasy', 'magic', 'myth', 'demon', 'fairy', 'god',
    'immortal', 'spirit', 'dragon', 'reborn', 'rebirth'
  ]),
  family('Family & Drama', [
    '家庭', '亲情', '育儿', '婆媳', '父母', '父母爱情', '儿女', '姊妹', '兄弟', '家', '亲',
    '大院', '巷', '家常', '门第', 'family', 'parents', 'sister', 'brother', 'home',
    'mother', 'father', 'drama'
  ]),
  comedy('Comedy', [
    '喜剧', '搞笑', '幽默', '欢乐', '爆笑', '段子', '开心', '笑', '喜事', 'comedy', 'funny',
    'humor', 'laugh', 'hilarious'
  ]),
  other('Other', []);

  final String label;
  final List<String> keywords;
  const ShowGenre(this.label, this.keywords);

  static ShowGenre detect(String title, {List<String> tags = const [], String channel = ''}) {
    final combined = '$title ${tags.join(" ")} $channel'.toLowerCase();
    for (final genre in ShowGenre.values) {
      if (genre == other) continue;
      for (final keyword in genre.keywords) {
        if (combined.contains(keyword.toLowerCase())) return genre;
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
  final pool = ref.watch(apiKeyPoolProvider);
  return ShowRepository(apiKeyPool: pool);
});

class ShowRepository {
  final ApiKeyPool _apiKeyPool;
  final http.Client _client;

  ShowRepository({required ApiKeyPool apiKeyPool, http.Client? client})
      : _apiKeyPool = apiKeyPool,
        _client = client ?? http.Client();

  static const String _baseUrl = 'https://www.googleapis.com/youtube/v3';
  static final Map<String, _CachedShows> _cache = {};
  static const _cacheTtl = Duration(hours: 2);

  /// Returns all shows from the hardcoded catalog (instant, no API calls).
  /// All shows have been pre-verified to have Chinese captions.
  /// Episodes are still fetched on-demand via [fetchEpisodes].
  Future<Map<ShowGenre, List<Show>>> fetchAllShows() async {
    const cacheKey = "all_shows_v7";
    final cached = _cache[cacheKey];
    if (cached != null &&
        DateTime.now().difference(cached.timestamp) < _cacheTtl) {
      debugPrint("[ShowRepo] Cache hit: ${cached.showsByGenre.values.fold(0, (sum, list) => sum + list.length)} shows");
      return cached.showsByGenre;
    }

    final allShows = <Show>[];
    for (final entry in HardcodedShows.data) {
      final playlistId = entry["id"] as String? ?? '';
      // Exclude any playlist that contains trailers, short teasers, or clips under 13 minutes
      if (!kValidLongShowIds.contains(playlistId)) continue;

      String thumb = (entry["thumbnailUrl"] as String? ?? '').trim();
      final episodes = entry["episodes"] as List? ?? [];
      
      // If thumb is empty or missing, fall back to first episode's thumb
      if ((thumb.isEmpty || !thumb.startsWith('http')) && episodes.isNotEmpty) {
        final firstEp = episodes.first as Map<String, dynamic>?;
        thumb = (firstEp?['thumbnailUrl'] as String? ?? '').trim();
      }

      // Convert maxresdefault / default to hqdefault which is universally guaranteed to exist for all YouTube videos
      if (thumb.contains('maxresdefault.jpg') || thumb.contains('sddefault.jpg') || (thumb.contains('default.jpg') && !thumb.contains('hqdefault.jpg'))) {
        thumb = thumb.replaceAll('maxresdefault.jpg', 'hqdefault.jpg')
                     .replaceAll('sddefault.jpg', 'hqdefault.jpg')
                     .replaceAll('default.jpg', 'hqdefault.jpg');
      }

      // If still empty or no hqdefault, construct from first episode ID
      if ((thumb.isEmpty || !thumb.startsWith('http')) && episodes.isNotEmpty) {
        final firstEp = episodes.first as Map<String, dynamic>?;
        final epId = firstEp?['id'] as String? ?? '';
        if (epId.isNotEmpty) {
          thumb = 'https://i.ytimg.com/vi/$epId/hqdefault.jpg';
        }
      }

      final title = entry["title"] as String? ?? '';
      final channelTitle = entry["channelTitle"] as String? ?? '';
      final tags = List<String>.from(entry["tags"] as List? ?? []);

      final detectedGenre = ShowGenre.detect(title, tags: tags, channel: channelTitle);

      allShows.add(Show(
        id: playlistId,
        title: title,
        channelTitle: channelTitle,
        thumbnailUrl: thumb,
        genre: detectedGenre.label,
        episodeCount: entry["episodeCount"] as int? ?? episodes.length,
        episodes: [],
        tags: tags,
        subtitleType: entry["subtitleType"] == "soft"
            ? SubtitleType.soft
            : SubtitleType.hard,
      ));
    }

    debugPrint("[ShowRepo] Loaded ${allShows.length} qualified shows (filtered short playlists)");

    final showsByGenre = <ShowGenre, List<Show>>{};
    for (final genre in ShowGenre.values) {
      showsByGenre[genre] = [];
    }
    for (final show in allShows) {
      final genre = ShowGenre.detect(show.title, tags: show.tags, channel: show.channelTitle);
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
      http.Response? response;
      for (int i = 0; i < 3; i++) {
        final currentApiKey = _apiKeyPool.youtubeApiKey;
        if (currentApiKey == 'MISSING_KEY') break;
        
        final uri = Uri.parse('$_baseUrl/playlistItems?part=snippet,contentDetails'
            '&playlistId=$playlistId'
            '&maxResults=50'
            '&key=$currentApiKey'
            '${nextPageToken != null ? '&pageToken=$nextPageToken' : ''}');
        
        response = await _client.get(uri);
        if (response.statusCode == 200) {
          break;
        } else if (response.statusCode == 403) {
          debugPrint('[ShowRepo] Key quota exceeded, trying next key...');
          continue;
        } else {
          break;
        }
      }

      if (response == null || response.statusCode != 200) break;
      
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