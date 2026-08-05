import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Browser-mimicking headers to avoid being blocked by YouTube's bot detection.
const _browserHeaders = {
  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
  'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
  'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
  'Referer': 'https://www.youtube.com/',
};

/// Checks if a YouTube video has Chinese captions by scraping the video page.
Future<bool> hasChineseCaptions(http.Client client, String videoId, {bool debug = false}) async {
  try {
    final pageUri = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    final pageResponse = await client.get(pageUri, headers: _browserHeaders);
    if (debug) stderr.writeln('  [debug] Page status: ${pageResponse.statusCode}, body length: ${pageResponse.body.length}');
    if (pageResponse.statusCode != 200) return false;

    final body = pageResponse.body;
    final playerResponseMatch = RegExp(
      r'ytInitialPlayerResponse\s*=\s*(\{.+?\});',
      dotAll: true,
    ).firstMatch(body);

    if (debug) stderr.writeln('  [debug] playerResponseMatch found: ${playerResponseMatch != null}');
    if (playerResponseMatch == null) return false;

    final playerResponse = jsonDecode(playerResponseMatch.group(1)!) as Map<String, dynamic>;
    final captions = playerResponse['captions'] as Map<String, dynamic>?;
    if (debug) stderr.writeln('  [debug] captions present: ${captions != null}');
    final playerCaptionsTracklist = captions?['playerCaptionsTracklistRenderer'] as Map<String, dynamic>?;
    if (debug) stderr.writeln('  [debug] playerCaptionsTracklist present: ${playerCaptionsTracklist != null}');
    final captionTracks = playerCaptionsTracklist?['captionTracks'] as List<dynamic>?;

    if (captionTracks == null || captionTracks.isEmpty) {
      if (debug) stderr.writeln('  [debug] No caption tracks found');
      return false;
    }

    if (debug) {
      stderr.writeln('  [debug] Found ${captionTracks.length} caption tracks:');
      for (final t in captionTracks) {
        final tm = t as Map<String, dynamic>;
        stderr.writeln('    - lang: ${tm['languageCode']}, name: ${tm['name']?['simpleText'] ?? tm['name']}');
      }
    }

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

/// Fetches transcript from YouTube's timedtext API.
/// Tries multiple approaches: direct timedtext API, page scrape with SRT/XML parsing.
Future<String?> getTranscript(http.Client client, String videoId) async {
  // Approach 1: Direct timedtext API with known language codes
  final langCodes = ['zh-Hans', 'zh-Hant', 'zh-CN', 'zh-TW', 'zh', 'cmn'];
  for (final lang in langCodes) {
    final url = 'https://www.youtube.com/api/timedtext?v=$videoId&lang=$lang&fmt=srv3';
    try {
      final resp = await client.get(Uri.parse(url), headers: _browserHeaders);
      if (resp.statusCode == 200 && resp.body.isNotEmpty && resp.body.length > 50) {
        final text = _parseSrv3(resp.body);
        if (text.isNotEmpty) {
          stderr.writeln('  [timedtext] Got transcript via lang=$lang (${text.length} chars)');
          return text;
        }
      }
    } catch (_) {}
  }

  // Approach 2: Scrape page for caption tracks, then fetch
  try {
    final pageUri = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    final pageResponse = await client.get(pageUri, headers: _browserHeaders);
    if (pageResponse.statusCode != 200) return null;

    final body = pageResponse.body;
    final playerResponseMatch = RegExp(
      r'ytInitialPlayerResponse\s*=\s*(\{.+?\});',
      dotAll: true,
    ).firstMatch(body);

    if (playerResponseMatch == null) return null;

    final playerResponse = jsonDecode(playerResponseMatch.group(1)!) as Map<String, dynamic>;
    final captions = playerResponse['captions'] as Map<String, dynamic>?;
    final playerCaptionsTracklist = captions?['playerCaptionsTracklistRenderer'] as Map<String, dynamic>?;
    final captionTracks = playerCaptionsTracklist?['captionTracks'] as List<dynamic>?;

    if (captionTracks == null || captionTracks.isEmpty) return null;

    // Find Chinese track
    Map<String, dynamic>? chineseTrack;
    for (final track in captionTracks) {
      final trackMap = track as Map<String, dynamic>;
      final langCode = (trackMap['languageCode'] as String?)?.toLowerCase() ?? '';
      if (langCode == 'zh' || langCode == 'zh-cn' || langCode == 'zh-tw' ||
          langCode == 'zh-hans' || langCode == 'zh-hant' || langCode == 'cmn') {
        chineseTrack = trackMap;
        break;
      }
    }

    if (chineseTrack == null) return null;

    // Try baseUrl first (XML format)
    final baseUrl = chineseTrack['baseUrl'] as String?;
    if (baseUrl != null) {
      final decodedUrl = baseUrl.replaceAll('\\u0026', '&');
      try {
        final resp = await client.get(Uri.parse(decodedUrl), headers: _browserHeaders);
        if (resp.statusCode == 200 && resp.body.isNotEmpty) {
          final text = _parseXmlTranscript(resp.body);
          if (text.isNotEmpty) {
            stderr.writeln('  [page-scrape] Got transcript via baseUrl (${text.length} chars)');
            return text;
          }
        }
      } catch (_) {}
    }

    // Try with fmt=srv3 appended
    if (baseUrl != null) {
      final srv3Url = '${baseUrl.replaceAll('\\u0026', '&')}&fmt=srv3';
      try {
        final resp = await client.get(Uri.parse(srv3Url), headers: _browserHeaders);
        if (resp.statusCode == 200 && resp.body.isNotEmpty && resp.body.length > 50) {
          final text = _parseSrv3(resp.body);
          if (text.isNotEmpty) {
            stderr.writeln('  [page-scrape] Got transcript via baseUrl+srv3 (${text.length} chars)');
            return text;
          }
        }
      } catch (_) {}
    }
  } catch (e) {
    stderr.writeln('  [page-scrape error] $e');
  }

  return null;
}

/// Parse SRV3 format (JSON with events array)
String _parseSrv3(String body) {
  try {
    final json = jsonDecode(body) as Map<String, dynamic>;
    final events = json['events'] as List<dynamic>?;
    if (events == null || events.isEmpty) return '';

    final buffer = StringBuffer();
    for (final event in events) {
      final segs = event['segs'] as List<dynamic>?;
      if (segs != null) {
        for (final seg in segs) {
          final utf8 = seg['utf8'] as String?;
          if (utf8 != null && utf8.isNotEmpty) {
            buffer.writeln(utf8);
          }
        }
      }
    }
    return buffer.toString().trim();
  } catch (_) {
    return '';
  }
}

/// Parse XML transcript format
String _parseXmlTranscript(String xml) {
  try {
    // Remove XML tags
    var text = xml.replaceAll(RegExp(r'<[^>]+>'), '');
    // Decode HTML entities using character codes to avoid formatter issues
    final amp = '${String.fromCharCode(38)}amp;';
    final lt = '${String.fromCharCode(38)}lt;';
    final gt = '${String.fromCharCode(38)}gt;';
    final quot = '${String.fromCharCode(38)}quot;';
    final apos = '${String.fromCharCode(38)}apos;';
    text = text
        .replaceAll(amp, String.fromCharCode(38))
        .replaceAll(lt, String.fromCharCode(60))
        .replaceAll(gt, String.fromCharCode(62))
        .replaceAll(quot, String.fromCharCode(34))
        .replaceAll('&#39;', "'")
        .replaceAll(apos, "'")
        .trim();
    return text;
  } catch (_) {
    return '';
  }
}

void main() async {
  final client = http.Client();

  // Test videos - try multiple known Chinese-language videos
  final testVideos = [
    'gzhd353OTjE', // 悬案 Unsettled Case
    'jT0R2F8VqX0', // Another Chinese video
    'B4z5KkZ9bJg', // Another test
  ];

  for (final videoId in testVideos) {
    print('\n=== Testing video: $videoId ===');
    final hasCaptions = await hasChineseCaptions(client, videoId, debug: true);
    print('Has Chinese captions: $hasCaptions');

    if (hasCaptions) {
      print('=== Testing getTranscript ===');
      final transcript = await getTranscript(client, videoId);
      if (transcript != null && transcript.isNotEmpty) {
        final lines = transcript.split('\n');
        print('Success! Got ${lines.length} lines:');
        for (int i = 0; i < lines.length && i < 10; i++) {
          print('  ${lines[i]}');
        }
        if (lines.length > 10) {
          print('  ... and ${lines.length - 10} more lines');
        }
      } else {
        print('FAILED: getTranscript returned null or empty');
      }
    }
  }

  client.close();
}
