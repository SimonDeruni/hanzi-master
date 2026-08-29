// =============================================================================
// Show Duration Analyzer — standalone CLI script
//
// Usage:
//   cd C:\Users\simon\Documents\hanzi_master
//   dart run lib/features/media/data/repositories/show_duration_analyzer.dart
//
// Fetches video durations for all shows from the YouTube Data API,
// then categorizes the "only-long" playlists (all episodes >= 13 min)
// into three buckets by average episode duration:
//   - Compact (13–35 min avg)
//   - Standard (35–55 min avg)
//   - Extended (> 55 min avg)
//
// Short-only and mixed playlists (containing any < 13 min episodes)
// are excluded from this analysis.
//
// Requires YOUTUBE_API_KEY in the .env file at project root.
// Caches results to show_durations_cache.json to avoid re-fetching.
// =============================================================================

import 'dart:convert';
import 'dart:io';

void main() async {
  final shows = _parseShowsData();
  if (shows.isEmpty) { print('No shows found'); return; }
  print('Found ${shows.length} shows/playlists');
  print('');

  final apiKey = _loadApiKey();
  if (apiKey == null) { print('No YOUTUBE_API_KEY found in .env'); return; }

  final cacheFile = File(
    'lib/features/media/data/repositories/show_durations_cache.json',
  );

  Map<String, List<_EpisodeInfo>>? cachedData;
  if (cacheFile.existsSync()) {
    try {
      final cached = jsonDecode(cacheFile.readAsStringSync()) as Map<String, dynamic>;
      cachedData = cached.map((k, v) => MapEntry(
            k, (v as List<dynamic>)
                .map((e) => _EpisodeInfo.fromJson(e as Map<String, dynamic>))
                .toList()));
      print('Loaded cached durations for ${cachedData.length} playlists');
    } catch (e) {
      print('Cache corrupt, re-fetching...');
    }
  }

  final Map<String, List<_EpisodeInfo>> allData;
  if (cachedData != null && cachedData.length == shows.length) {
    allData = cachedData;
    print('Using cache (${shows.length} playlists)');
  } else {
    allData = await _fetchAllDurations(shows, apiKey);
    final jsonMap = allData.map(
      (k, v) => MapEntry(k, v.map((e) => e.toJson()).toList()));
    cacheFile.writeAsStringSync(jsonEncode(jsonMap));
    print('Cache saved');
  }

  // ── Analysis: only long shows (all episodes >= 13 min) ──
  print('');
  print('=========================================================');
  print('           ONLY-LONG SHOWS — RECATEGORIZED');
  print('=========================================================');
  print('');

  const shortThreshold = Duration(minutes: 13);

  // Filter to only-long shows (exclude short-only and mixed)
  final onlyLong = <MapEntry<String, List<_EpisodeInfo>>>[];
  final excluded = <MapEntry<String, List<_EpisodeInfo>>>[];
  for (final e in allData.entries) {
    final allLonger = e.value.every((v) => v.duration >= shortThreshold);
    if (allLonger) {
      onlyLong.add(e);
    } else {
      excluded.add(e);
    }
  }

  print('Excluded ${excluded.length} playlists (short-only + mixed)');
  print('Analyzing ${onlyLong.length} remaining only-long playlists');
  print('');

  String showTitle(String id) {
    return shows.where((s) => s['id'] == id).firstOrNull?['title'] ?? id;
  }

  // Categorize by average duration
  // Standard shows: 35-55 min (typical TV drama length)
  // Extended shows: > 55 min (longer episodes)
  // Compact shows: 13-35 min

  const compactMax = Duration(minutes: 35);
  const standardMax = Duration(minutes: 55);

  final compact = <MapEntry<String, List<_EpisodeInfo>>>[];
  final standard = <MapEntry<String, List<_EpisodeInfo>>>[];
  final extended = <MapEntry<String, List<_EpisodeInfo>>>[];

  for (final e in onlyLong) {
    final avgSec = e.value.map((v) => v.durationSeconds).reduce((a, b) => a + b) / e.value.length;
    final avg = Duration(seconds: avgSec.round());
    if (avg < compactMax) {
      compact.add(e);
    } else if (avg <= standardMax) {
      standard.add(e);
    } else {
      extended.add(e);
    }
  }

  void printGroup(String label, List<MapEntry<String, List<_EpisodeInfo>>> group) {
    print('--- $label (${group.length} shows) ---');
    if (group.isEmpty) { print('  (none)'); return; }

    // Sort by episode count descending
    group.sort((a, b) => b.value.length.compareTo(a.value.length));

    for (final e in group) {
      final eps = e.value.length;
      final avgSec = e.value.map((v) => v.durationSeconds).reduce((a, b) => a + b) / e.value.length;
      final minDur = e.value.map((v) => v.durationSeconds).reduce((a, b) => a < b ? a : b);
      final maxDur = e.value.map((v) => v.durationSeconds).reduce((a, b) => a > b ? a : b);
      final mn = Duration(seconds: minDur);
      final mx = Duration(seconds: maxDur);
      print('  ${showTitle(e.key)}');
      print('    $eps eps | avg ${avgSec.toStringAsFixed(0)}s (${(avgSec / 60).toStringAsFixed(1)}m) | range ${mn.inMinutes}:${(mn.inSeconds % 60).toString().padLeft(2, '0')}–${mx.inMinutes}:${(mx.inSeconds % 60).toString().padLeft(2, '0')}');
    }
    print('');
  }

  printGroup('COMPACT (13–35 min avg)', compact);
  printGroup('STANDARD (35–55 min avg)', standard);
  printGroup('EXTENDED (> 55 min avg)', extended);

  // Summary
  print('=========================================================');
  print('                      SUMMARY');
  print('=========================================================');
  int totalEp = 0;
  for (final e in onlyLong) { totalEp += e.value.length; }
  print('  Only-long playlists: ${onlyLong.length}');
  print('  Total episodes: $totalEp');
  print('');
  print('  Compact (13-35m): ${compact.length} shows');
  print('  Standard (35-55m): ${standard.length} shows');
  print('  Extended (>55m): ${extended.length} shows');
  print('');
  print('Done');
}
// ---------------------------------------------------------------------------
// Parsing shows_data.dart
// ---------------------------------------------------------------------------

List<Map<String, String>> _parseShowsData() {
  final file = File('lib/features/media/data/repositories/shows_data.dart');
  if (!file.existsSync()) { print('shows_data.dart not found'); return []; }

  final content = file.readAsStringSync();
  final results = <Map<String, String>>[];

  final showPattern = RegExp(
    r"{\s*'id':\s*'(PL[^']+)'\s*,\s*\n\s*'title':\s*'([^']+)'[^{]*'episodes':\s*\[(.*?)\]\s*,\s*\n",
    dotAll: true,
  );

  for (final match in showPattern.allMatches(content)) {
    final playlistId = match.group(1)!;
    final title = match.group(2)!;
    final episodesBlock = match.group(3)!;

    final videoIds = <String>[];
    final videoPattern = RegExp(r"'id':\s*'([^']+)'");
    for (final vm in videoPattern.allMatches(episodesBlock)) {
      videoIds.add(vm.group(1)!);
    }

    if (videoIds.isNotEmpty) {
      results.add({
        'id': playlistId, 'title': title,
        'videoIds': videoIds.join(','), 'count': videoIds.length.toString(),
      });
    }
  }
  return results;
}

String? _loadApiKey() {
  final envFile = File('.env');
  if (!envFile.existsSync()) return null;
  for (final line in envFile.readAsLinesSync()) {
    if (line.trim().startsWith('YOUTUBE_API_KEY=')) {
      final key = line.trim().substring('YOUTUBE_API_KEY='.length);
      if (key.isNotEmpty) return key;
    }
  }
  return null;
}
// ---------------------------------------------------------------------------
// YouTube API fetch
// ---------------------------------------------------------------------------

Future<Map<String, List<_EpisodeInfo>>> _fetchAllDurations(
  List<Map<String, String>> shows, String apiKey,
) async {
  final client = HttpClient();
  final allData = <String, List<_EpisodeInfo>>{};
  int done = 0;

  for (final show in shows) {
    done++;
    final playlistId = show['id']!;
    final title = show['title']!;
    final videoIds = show['videoIds']!.split(',');

    final episodes = <_EpisodeInfo>[];
    print('  [$done/${shows.length}] "$title" (${videoIds.length} videos)...');

    // Fetch in batches of 50
    for (int i = 0; i < videoIds.length; i += 50) {
      final end = i + 50 > videoIds.length ? videoIds.length : i + 50;
      final batch = videoIds.sublist(i, end);
      final ids = batch.join(',');

      final uri = Uri.parse(
        'https://www.googleapis.com/youtube/v3/videos'
        '?part=contentDetails'
        '&id=$ids'
        '&key=$apiKey',
      );

      try {
        final request = await client.getUrl(uri);
        final response = await request.close();
        final body = await response.transform(utf8.decoder).join();

        if (response.statusCode != 200) {
          final error = jsonDecode(body);
          print('    API error: ${error['error']?['message'] ?? body}');
          continue;
        }

        final data = jsonDecode(body) as Map<String, dynamic>;
        final items = data['items'] as List<dynamic>? ?? [];

        for (final item in items) {
          final itemMap = item as Map<String, dynamic>;
          final vid = itemMap['id'] as String;
          final cd = itemMap['contentDetails'] as Map<String, dynamic>? ?? {};
          final durStr = cd['duration'] as String? ?? '';
          final d = _parseIso8601Duration(durStr);
          episodes.add(_EpisodeInfo(videoId: vid, durationSeconds: d));
        }
      } catch (e) {
        print('    Network error: $e');
      }

      await Future.delayed(const Duration(milliseconds: 300));
    }

    allData[playlistId] = episodes;
    if (episodes.isNotEmpty) {
      final avg = episodes.map((e) => e.durationSeconds).reduce((a, b) => a + b) / episodes.length;
      print('    ${episodes.length} episodes, avg ${avg.toStringAsFixed(0)}s');
    }
  }

  client.close();
  return allData;
}

int _parseIso8601Duration(String s) {
  if (s.isEmpty) return 0;
  int total = 0;
  final h = RegExp(r'(\d+)H').firstMatch(s);
  final m = RegExp(r'(\d+)M').firstMatch(s);
  final sec = RegExp(r'(\d+)S').firstMatch(s);
  if (h != null) total += int.parse(h.group(1)!) * 3600;
  if (m != null) total += int.parse(m.group(1)!) * 60;
  if (sec != null) total += int.parse(sec.group(1)!);
  return total;
}

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

class _EpisodeInfo {
  final String videoId;
  final int durationSeconds;
  const _EpisodeInfo({required this.videoId, required this.durationSeconds});
  Duration get duration => Duration(seconds: durationSeconds);

  factory _EpisodeInfo.fromJson(Map<String, dynamic> json) =>
      _EpisodeInfo(videoId: json['videoId'] as String, durationSeconds: json['durationSeconds'] as int);

  Map<String, dynamic> toJson() => {'videoId': videoId, 'durationSeconds': durationSeconds};
}