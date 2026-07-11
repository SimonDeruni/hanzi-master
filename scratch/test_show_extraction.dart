import 'dart:convert';
import 'package:http/http.dart' as http;

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

  int totalShows = 0;
  int totalEpisodes = 0;

  for (final entry in channels.entries) {
    final channelId = entry.key;
    final channelName = entry.value;

    // Get channel info
    final chResp = await client.get(
      Uri.parse('https://www.googleapis.com/youtube/v3/channels?part=snippet&id=$channelId&key=$apiKey'),
    );
    if (chResp.statusCode != 200) {
      print('\n===== $channelName: API ERROR ${chResp.statusCode} =====');
      continue;
    }
    final chData = jsonDecode(chResp.body);
    final chItems = chData['items'] as List? ?? [];
    if (chItems.isEmpty) {
      print('\n===== $channelName: CHANNEL NOT FOUND =====');
      continue;
    }
    final channelTitle = chItems[0]['snippet']['title'] ?? channelName;

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
      if (plResp.statusCode != 200) break;

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

    print('\n===== $channelName ($channelTitle) =====');
    print('Playlists found: ${playlists.length}');

    int channelShows = 0;

    for (final plEntry in playlists.entries) {
      final playlistId = plEntry.key;
      final playlistTitle = plEntry.value;

      // Fetch playlist videos (paginated, up to 200)
      final videos = <String>[];
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
          final title = vItem['snippet']['title'] as String?;
          if (title != null) videos.add(title);
        }

        videoPageToken = vData['nextPageToken'] as String?;
        if (videoPageToken == null) break;
      }

      if (videos.isNotEmpty) {
        channelShows++;
        totalEpisodes += videos.length;
        print('  SHOW: "$playlistTitle" (${videos.length} episodes)');
        for (final t in videos.take(2)) {
          print('    - $t');
        }
        if (videos.length > 2) print('    ... and ${videos.length - 2} more');
      }
    }

    totalShows += channelShows;
    print('  → $channelShows shows with episodes');
  }

  client.close();
  print('\n===== TOTAL: $totalShows shows, $totalEpisodes episodes =====');
}