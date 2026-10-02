/// The Tutorials tab's data source: the **official** YouTube Data API, and
/// nothing else.
///
/// The rest of the media feature reaches YouTube through
/// `youtube_explode_dart` (see `youtube_repository.dart`) — a scraper that pulls
/// search results, caption manifests and transcripts. That is not permitted by
/// the YouTube API Services Terms, and it is exactly what a teaching shelf must
/// not depend on. This file is the compliant alternative, and every rule it
/// follows is a deliberate, testable decision:
///
///  * **Documented endpoints only** — `search.list` and `videos.list` under
///    `googleapis.com/youtube/v3`, authenticated with the project's key pool.
///  * **`videoEmbeddable=true`** on the search, then **`status.embeddable`** is
///    re-checked on every hydrated item, so a card can never promise a video the
///    in-app player is refused.
///  * **`safeSearch=strict`**, because a teaching shelf is also a content shelf.
///  * **`videoCaption=closedCaption`**, because a tutorial a learner cannot read
///    along with is not a tutorial.
///  * **Nothing is downloaded and no audio is separated** — the app stores ids,
///    titles, a *link* to a thumbnail and a duration. Playback happens in
///    YouTube's own player, with YouTube's own ads and analytics intact.
///  * **Playback only, never extraction** — there is no caption or transcript
///    call anywhere in this feature, so nothing a creator published is copied.
///  * **Quota discipline** — `search.list` costs 100 of the 10,000 daily units,
///    so each shelf is answered from disk for a day (Google's terms allow limited
///    caching and require it to be refreshed; a hard 24-hour expiry is inside
///    that), and a warm cache costs nothing.
library;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/features/media/domain/models/tutorial_video.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// What one shelf load produced.
@immutable
class TutorialResult {
  const TutorialResult.ready(this.videos)
      : unavailable = false,
        failed = false;

  /// No API key is configured in this build. Not an error to shout about, and
  /// not the same thing as "no videos matched".
  const TutorialResult.unavailable()
      : videos = const <TutorialVideo>[],
        unavailable = true,
        failed = false;

  /// The call was made and did not succeed.
  const TutorialResult.failed()
      : videos = const <TutorialVideo>[],
        unavailable = false,
        failed = true;

  final List<TutorialVideo> videos;
  final bool unavailable;
  final bool failed;

  bool get isEmpty => videos.isEmpty && !unavailable && !failed;
}

class TutorialsRepository {
  TutorialsRepository({required ApiKeyPool apiKeyPool, http.Client? client})
      : _apiKeyPool = apiKeyPool,
        _client = client ?? http.Client();

  final ApiKeyPool _apiKeyPool;
  final http.Client _client;

  static const String _baseUrl = 'https://www.googleapis.com/youtube/v3';

  /// How long a shelf is trusted before it is asked for again.
  static const Duration cacheTtl = Duration(hours: 24);

  /// Page size for the search: enough to fill a scrollable shelf without paying
  /// for videos nobody will reach.
  static const int pageSize = 20;

  static const String _cachePrefix = 'tutorials_cache_v1';

  /// Loads one shelf, cache first.
  Future<TutorialResult> shelf({
    required String query,
    required String languageCode,
  }) async {
    final String cacheKey = '${_cachePrefix}_${languageCode}_${query.hashCode}';
    final List<TutorialVideo>? cached = await _readCache(cacheKey);
    if (cached != null) return TutorialResult.ready(cached);

    final String apiKey = _apiKeyPool.youtubeApiKey;
    if (apiKey.isEmpty || apiKey == 'MISSING_KEY') {
      return const TutorialResult.unavailable();
    }

    try {
      final List<String> ids = await _searchIds(query, languageCode, apiKey);
      final List<TutorialVideo> videos =
          ids.isEmpty ? const <TutorialVideo>[] : await _hydrate(ids, apiKey);
      await _writeCache(cacheKey, videos);
      return TutorialResult.ready(videos);
    } catch (error) {
      debugPrint('Tutorials shelf "$query" failed: $error');
      return const TutorialResult.failed();
    }
  }

  /// `search.list` — 100 quota units, so it runs at most once per shelf per day.
  Future<List<String>> _searchIds(
    String query,
    String languageCode,
    String apiKey,
  ) async {
    final Uri uri = Uri.parse('$_baseUrl/search').replace(queryParameters: {
      'part': 'snippet',
      'type': 'video',
      'maxResults': '$pageSize',
      'q': query,
      'videoEmbeddable': 'true',
      'videoCaption': 'closedCaption',
      'safeSearch': 'strict',
      'relevanceLanguage': languageCode,
      'regionCode': regionFor(languageCode),
      'key': apiKey,
    });

    final Map<String, dynamic> body = await _get(uri);
    final List<dynamic> items = (body['items'] as List<dynamic>?) ?? const [];
    return items
        .whereType<Map<dynamic, dynamic>>()
        .map((Map<dynamic, dynamic> item) =>
            ((item['id'] as Map?) ?? const <String, dynamic>{})['videoId']
                ?.toString() ??
            '')
        .where((String id) => id.isNotEmpty)
        .toList();
  }

  /// `videos.list` — 1 unit for up to 50 ids, and the only place a duration or
  /// `status.embeddable` can be read. Anything dropped here would have been a
  /// card that failed on tap.
  Future<List<TutorialVideo>> _hydrate(List<String> ids, String apiKey) async {
    final Uri uri = Uri.parse('$_baseUrl/videos').replace(queryParameters: {
      'part': 'snippet,contentDetails,status',
      'id': ids.take(50).join(','),
      'key': apiKey,
    });

    final Map<String, dynamic> body = await _get(uri);
    final List<dynamic> items = (body['items'] as List<dynamic>?) ?? const [];
    return items
        .whereType<Map<dynamic, dynamic>>()
        .map((Map<dynamic, dynamic> item) =>
            TutorialVideo.fromApiItem(item.cast<String, dynamic>()))
        .whereType<TutorialVideo>()
        .toList();
  }

  Future<Map<String, dynamic>> _get(Uri uri) async {
    final http.Response response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('YouTube Data API returned ${response.statusCode}');
    }
    return (json.decode(response.body) as Map<dynamic, dynamic>)
        .cast<String, dynamic>();
  }

  /// The store front to ask in, derived from the interface language.
  ///
  /// Not localisation theatre: `regionCode` is what makes `search.list` return
  /// the shelf a learner in that country would see, and it is the sanctioned
  /// alternative to hand-writing one query per language.
  @visibleForTesting
  static String regionFor(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return 'SA';
      case 'de':
        return 'DE';
      case 'es':
        return 'ES';
      case 'fr':
        return 'FR';
      case 'hi':
        return 'IN';
      case 'id':
        return 'ID';
      case 'it':
        return 'IT';
      case 'ja':
        return 'JP';
      case 'ko':
        return 'KR';
      case 'pt':
        return 'BR';
      case 'ru':
        return 'RU';
      case 'th':
        return 'TH';
      case 'vi':
        return 'VN';
      default:
        return 'US';
    }
  }

  /// The disk cache: ids, titles, thumbnail *links* and durations only.
  ///
  /// No media, no captions, and no thumbnails — re-hosting a thumbnail is not
  /// permitted, so only its URL is stored. An expired or unreadable entry is
  /// deleted rather than served.
  Future<List<TutorialVideo>?> _readCache(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(key);
    if (raw == null) return null;

    try {
      final Map<String, dynamic> payload =
          (json.decode(raw) as Map<dynamic, dynamic>).cast<String, dynamic>();
      final DateTime? savedAt =
          DateTime.tryParse(payload['savedAt']?.toString() ?? '');
      if (savedAt == null || DateTime.now().difference(savedAt) > cacheTtl) {
        await prefs.remove(key);
        return null;
      }
      final List<dynamic> rows =
          (payload['videos'] as List<dynamic>?) ?? const [];
      return rows
          .whereType<Map<dynamic, dynamic>>()
          .map((Map<dynamic, dynamic> row) =>
              TutorialVideo.fromJson(row.cast<String, dynamic>()))
          .whereType<TutorialVideo>()
          .toList();
    } catch (_) {
      await prefs.remove(key);
      return null;
    }
  }

  Future<void> _writeCache(String key, List<TutorialVideo> videos) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      key,
      json.encode(<String, dynamic>{
        'savedAt': DateTime.now().toIso8601String(),
        'videos': videos.map((TutorialVideo v) => v.toJson()).toList(),
      }),
    );
  }

  /// Drops every cached shelf.
  ///
  /// Public, not test-only: switching the interface language makes the stored
  /// answers belong to a different audience, so the shelf clears itself rather
  /// than showing another language's search results.
  static Future<void> clearCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (final String key in prefs.getKeys().toList()) {
      if (key.startsWith(_cachePrefix)) await prefs.remove(key);
    }
  }
}
