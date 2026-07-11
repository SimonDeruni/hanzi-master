import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Checks if a YouTube video has Chinese captions by scraping the video page.
/// Returns true if any Chinese language track is found in ytInitialPlayerResponse.
Future<bool> _hasChineseCaptions(http.Client client, String videoId) async {
  try {
    final pageUri = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    final pageResponse = await client.get(pageUri,
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
          'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
          'Referer': 'https://www.youtube.com/',
        });

    if (pageResponse.statusCode != 200) return false;

    final body = pageResponse.body;
    final playerResponseMatch = RegExp(
      r'ytInitialPlayerResponse\s*=\s*(\{.+?\});',
      dotAll: true,
    ).firstMatch(body);

    if (playerResponseMatch == null) return false;

    final playerResponse = jsonDecode(playerResponseMatch.group(1)!) as Map<String, dynamic>;
    final captions = playerResponse['captions'] as Map<String, dynamic>?;
    final playerCaptionsTracklist = captions?['playerCaptionsTracklistRenderer'] as Map<String, dynamic>?;
    final captionTracks = playerCaptionsTracklist?['captionTracks'] as List<dynamic>?;

    if (captionTracks == null || captionTracks.isEmpty) return false;

    for (final track in captionTracks) {
      final trackMap = track as Map<String, dynamic>;
      final langCode = (trackMap['languageCode'] as String?)?.toLowerCase() ?? '';

      if (langCode == 'zh' || langCode == 'zh-cn' || langCode == 'zh-tw' ||
          langCode == 'zh-hans' || langCode == 'zh-hant' || langCode == 'cmn') {
        return true;
      }
    }

    return false;
  } catch (e) {
    stderr.writeln('  [caption check error] $videoId: $e');
    return false;
  }
}

void main() async {
  const apiKey = 'AIzaSyCvmm4uljoCyIFkBIoBybiishaWyyu2ROU';
  final client = http.Client();

  final channels = {
    'UCYQPTeY3HOk0BprrGuCWCaA': '优酷 YOUKU',
    'UCUhpu5MJQ_bjPkXO00jyxsw': '爱奇艺 iQIYI',
    'UCdpiId0eJGnnIvfhpbJIM1w': '腾讯视频动漫',
    'UCQatgKoA7lylp_UzvsLCgcw': '腾讯视频',
    'UCD_83Jh-UFQXRDwC6S8caCQ': 'iQIYI 悬疑社',
    'UCFh5x5AZHQQ6FaGKnG-QXDA': '腾讯视频 青春剧场',
    'UCRABdhiBHX4Bie-jfPCd2pg': '腾讯视频 古装剧场',
    'UC3PKcYXUAhao3p4kuNS4_9w': '腾讯视频 华语经典剧场',
  };

  final buffer = StringBuffer();
  buffer.writeln('// GENERATED FILE — do not edit manually.');
  buffer.writeln('// Generated from YouTube playlists.list API on ${DateTime.now().toIso8601String()}');
  buffer.writeln('// Total: will be filled after generation');
  buffer.writeln();
  buffer.writeln('// ignore_for_file: lines_longer_than_80_chars');
  buffer.writeln();
  buffer.writeln("import '../../domain/models/youtube_video.dart';");
  buffer.writeln();
  buffer.writeln('/// Hardcoded show catalog — instant loading, no API calls needed.');
  buffer.writeln('/// Episodes are still fetched on-demand via playlistItems.list API.');
  buffer.writeln('class HardcodedShows {');
  buffer.writeln('  static const List<Map<String, dynamic>> data = [');

  int totalShows = 0;

  for (final entry in channels.entries) {
    final channelId = entry.key;
    final channelName = entry.value;

    // Get channel info
    final chResp = await client.get(
      Uri.parse('https://www.googleapis.com/youtube/v3/channels?part=snippet&id=$channelId&key=$apiKey'),
    );
    if (chResp.statusCode != 200) {
      stderr.writeln('[$channelId] Channel API returned ${chResp.statusCode}');
      continue;
    }
    final chData = jsonDecode(chResp.body);
    final chItems = chData['items'] as List? ?? [];
    if (chItems.isEmpty) continue;
    final channelTitle = chItems[0]['snippet']['title'] ?? channelName;
    final channelThumb = (chItems[0]['snippet']['thumbnails'] as Map?)?['default']?['url'] ?? '';

    // Fetch playlists (paginated, up to 100)
    final playlists = <String, String>{}; // id -> title
    String? nextPageToken;

    for (int page = 0; page < 2; page++) {
      final uri = Uri.parse('https://www.googleapis.com/youtube/v3/playlists?part=snippet'
          '&channelId=$channelId'
          '&maxResults=50'
          '&key=$apiKey'
          '${nextPageToken != null ? '&pageToken=$nextPageToken' : ''}');

      final plResp = await client.get(uri);
      if (plResp.statusCode != 200) {
        stderr.writeln('[$channelId] Playlist API page $page: ${plResp.statusCode}');
        break;
      }

      final plData = jsonDecode(plResp.body);
      final plItems = plData['items'] as List? ?? [];

      for (final item in plItems) {
        final id = item['id'] as String?;
        final title = item['snippet']['title'] as String?;
        if (id != null && title != null && title.isNotEmpty) {
          playlists[id] = title;
        }
      }

      nextPageToken = plData['nextPageToken'] as String?;
      if (nextPageToken == null) break;
    }

    // Fetch episode count for each playlist (just count, don't store episodes)
    for (final plEntry in playlists.entries) {
      final playlistId = plEntry.key;
      final playlistTitle = plEntry.value;

      // Get thumbnail from first video, and capture first video ID for caption check
      String thumbnailUrl = channelThumb;
      int episodeCount = 0;
      String? firstVideoId;

      String? videoPageToken;
      for (int vp = 0; vp < 4; vp++) {
        final vUri = Uri.parse('https://www.googleapis.com/youtube/v3/playlistItems?part=snippet'
            '&playlistId=$playlistId'
            '&maxResults=50'
            '&key=$apiKey'
            '${videoPageToken != null ? '&pageToken=$videoPageToken' : ''}');

        final vResp = await client.get(vUri);
        if (vResp.statusCode != 200) break;

        final vData = jsonDecode(vResp.body);
        final vItems = vData['items'] as List? ?? [];

        for (final vItem in vItems) {
          final snippet = vItem['snippet'] as Map? ?? {};
          final resourceId = snippet['resourceId'] as Map? ?? {};
          firstVideoId ??= resourceId['videoId'] as String?;
          final thumbnails = snippet['thumbnails'] as Map?;
          if (thumbnailUrl.isEmpty || thumbnailUrl == channelThumb) {
            thumbnailUrl = thumbnails?['default']?['url'] as String? ?? thumbnailUrl;
          }
          episodeCount++;
        }

        videoPageToken = vData['nextPageToken'] as String?;
        if (videoPageToken == null) break;
      }

      if (episodeCount > 0) {
        // Check if the first video in the playlist has Chinese captions
        // This is a quick heuristic — if the first episode has captions,
        // the show is likely to have captions throughout.
        bool hasCaptions = false;
        if (firstVideoId != null) {
          stderr.write('  Checking captions for "$playlistTitle"... ');
          hasCaptions = await _hasChineseCaptions(client, firstVideoId);
          stderr.writeln(hasCaptions ? 'YES' : 'NO');
        }

        if (hasCaptions) {
          totalShows++;
          final escapedTitle = playlistTitle
              .replaceAll("'", "\\'")
              .replaceAll('\$', '\\\$');
          final escapedChannel = (channelTitle as String)
              .replaceAll("'", "\\'")
              .replaceAll('\$', '\\\$');

          buffer.writeln("    {");
          buffer.writeln("      'id': '$playlistId',");
          buffer.writeln("      'title': '$escapedTitle',");
          buffer.writeln("      'channelTitle': '$escapedChannel',");
          buffer.writeln("      'thumbnailUrl': '$thumbnailUrl',");
          buffer.writeln("      'episodeCount': $episodeCount,");
          buffer.writeln("    },");
        } else {
          stderr.writeln('  SKIPPED "$playlistTitle" — no Chinese captions');
        }
      }
    }

    stderr.writeln('Processed $channelName: ${playlists.length} playlists');
  }

  buffer.writeln('  ];');
  buffer.writeln();
  buffer.writeln('  static const int totalShows = $totalShows;');
  buffer.writeln('}');

  client.close();

  // Write to file
  final file = File('lib/features/media/data/repositories/shows_data.dart');
  await file.writeAsString(buffer.toString());
  stderr.writeln('\nWritten ${buffer.length} chars to ${file.path}');
  stderr.writeln('Total shows: $totalShows');
}