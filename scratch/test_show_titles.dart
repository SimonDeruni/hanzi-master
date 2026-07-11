import 'dart:convert';
import 'dart:io';

void main() async {
  // Read .env manually
  final envFile = File('.env');
  final lines = await envFile.readAsLines();
  String apiKey = 'MISSING_KEY';
  for (final line in lines) {
    if (line.startsWith('YOUTUBE_API_KEY=')) {
      apiKey = line.substring('YOUTUBE_API_KEY='.length).trim();
      break;
    }
  }
  print('API Key: ${apiKey.substring(0, 8)}...');

  const baseUrl = 'https://www.googleapis.com/youtube/v3';
  final client = HttpClient();

  // Test channels
  const channels = {
    'UCYQPTeY3HOk0BprrGuCWCaA': '优酷 YOUKU',
    'UCUhpu5MJQ_bjPkXO00jyxsw': '爱奇艺 iQIYI',
    'UCdpiId0eJGnnIvfhpbJIM1w': '腾讯视频动漫 TencentVideoAnimation',
    'UCQatgKoA7lylp_UzvsLCgcw': '腾讯视频 TencentVideo',
  };

  for (final entry in channels.entries) {
    final channelId = entry.key;
    final channelName = entry.value;
    print('\n===== $channelName ($channelId) =====');

    try {
      // Step 1: Get uploads playlist ID
      final channelUri = Uri.parse(
        '$baseUrl/channels?part=snippet,contentDetails&id=$channelId&key=$apiKey',
      );
      final channelReq = await client.getUrl(channelUri);
      final channelRes = await channelReq.close();
      final channelBody = await channelRes.transform(utf8.decoder).join();
      print('Channels API status: ${channelRes.statusCode}');

      if (channelRes.statusCode != 200) {
        print('Error body: $channelBody');
        continue;
      }

      final channelData = jsonDecode(channelBody) as Map<String, dynamic>;
      final items = channelData['items'] as List<dynamic>? ?? [];
      if (items.isEmpty) {
        print('No channel found (may be invalid ID)');
        continue;
      }

      final snippet = items[0]['snippet'] as Map<String, dynamic>? ?? {};
      print('Channel title: ${snippet['title']}');

      final cd = items[0]['contentDetails'] as Map<String, dynamic>? ?? {};
      final rp = cd['relatedPlaylists'] as Map<String, dynamic>? ?? {};
      final uploadsId = rp['uploads'] as String?;
      if (uploadsId == null) {
        print('No uploads playlist found');
        continue;
      }
      print('Uploads playlist: $uploadsId');

      // Step 2: Fetch playlist items (max 50)
      final playlistUri = Uri.parse(
        '$baseUrl/playlistItems?part=snippet,contentDetails'
        '&playlistId=$uploadsId'
        '&maxResults=50'
        '&key=$apiKey',
      );
      final playlistReq = await client.getUrl(playlistUri);
      final playlistRes = await playlistReq.close();
      final playlistBody = await playlistRes.transform(utf8.decoder).join();
      print('PlaylistItems API status: ${playlistRes.statusCode}');

      if (playlistRes.statusCode != 200) {
        print('Error body: $playlistBody');
        continue;
      }

      final playlistData = jsonDecode(playlistBody) as Map<String, dynamic>;
      final playlistItems = playlistData['items'] as List<dynamic>? ?? [];
      print('Total playlist items fetched: ${playlistItems.length}');

      // Print first 20 video titles
      print('\n--- First 20 video titles ---');
      for (int i = 0; i < playlistItems.length && i < 20; i++) {
        final item = playlistItems[i] as Map<String, dynamic>;
        final s = item['snippet'] as Map<String, dynamic>? ?? {};
        final title = s['title'] as String? ?? 'NO TITLE';
        final resourceId = s['resourceId'] as Map<String, dynamic>? ?? {};
        final videoId = resourceId['videoId'] as String? ?? 'NO_VIDEO_ID';
        print('  [$i] $title  (videoId: $videoId)');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  client.close();
  print('\n===== DONE =====');
}