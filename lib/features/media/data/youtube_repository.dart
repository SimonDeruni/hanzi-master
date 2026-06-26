import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../domain/models/video_transcript.dart';

final youtubeRepositoryProvider = Provider<YoutubeRepository>((ref) {
  return YoutubeRepository();
});

class YoutubeRepository {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<List<Video>> searchVideos(String query) async {
    final validVideos = <Video>[];
    try {
      final searchQuery = '$query 中文, cc';
      final results = await _yt.search.search(searchQuery);
      
      final iterator = results.iterator;
      int processedCount = 0;
      
      while (processedCount < 15) {
        Video video;
        try {
          if (!iterator.moveNext()) {
            break;
          }
          video = iterator.current;
        } catch (e) {
          // If a specific video has parsing errors (e.g. viewCount/duration parsing issues on streams), skip it
          debugPrint('Error parsing search result item: $e');
          continue;
        }
        
        processedCount++;
        
        try {
          final manifest = await _yt.videos.closedCaptions.getManifest(video.id);
          final hasChinese = manifest.tracks.any((t) => t.language.code.startsWith('zh'));
          if (hasChinese) {
            validVideos.add(video);
          }
        } catch (_) {
          // No closed captions or error fetching them, skip this video
        }
        
        // Stop early if we have enough results to show a good initial list
        if (validVideos.length >= 6) break;
      }
    } catch (e) {
      debugPrint('Error searching videos for query $query: $e');
    }
    
    return validVideos;
  }

  Future<VideoTranscript?> getTranscript(String videoId) async {
    try {
      final manifest = await _yt.videos.closedCaptions.getManifest(videoId);
      
      // Try to find Chinese or fallback to English, then default to first
      final tracks = manifest.tracks;
      if (tracks.isEmpty) return null;

      var trackInfo = tracks.where((t) => t.language.code.startsWith('zh')).firstOrNull;
      trackInfo ??= tracks.where((t) => t.language.code.startsWith('en')).firstOrNull;
      trackInfo ??= tracks.first;

      final track = await _yt.videos.closedCaptions.get(trackInfo);
      
      final lines = track.captions.map((c) => TranscriptLine(
        text: c.text,
        start: c.offset,
        duration: c.duration,
      )).toList();

      return VideoTranscript(videoId: videoId, lines: lines);
    } catch (e) {
      debugPrint('Error fetching transcript: $e');
      return null;
    }
  }

  void dispose() {
    _yt.close();
  }
}
