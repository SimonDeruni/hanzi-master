import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() async {
  final yt = YoutubeExplode();
  final file = File('lib/features/media/data/repositories/shows_data.dart');
  var content = await file.readAsString();

  // Find all shows. Each show has an ID and a first episode ID.
  // We can find them using a regex that captures the show id and the first episode id.
  final showRegex = RegExp(r"'id':\s*'([^']+)',\s*'title':.*?episodes':\s*\[\s*{\s*'id':\s*'([^']+)'", dotAll: true);
  
  final matches = showRegex.allMatches(content).toList();
  print('Found ${matches.length} shows to check.');

  for (final match in matches) {
    final showId = match.group(1);
    final firstEpisodeId = match.group(2);
    
    if (showId == null || firstEpisodeId == null) continue;

    try {
      final manifest = await yt.videos.closedCaptions.getManifest(firstEpisodeId);
      final hasChineseCC = manifest.tracks.any((track) => track.language.code.toLowerCase().startsWith('zh'));
      
      if (hasChineseCC) {
        print('[$showId] Soft Sub (Chinese CC found)');
        
        // Find this specific show's subtitleType line in the content
        // We'll replace it inside this specific block to avoid replacing everything globally.
        final showBlockRegex = RegExp(r"'id':\s*'" + showId + r"'.*?'subtitleType':\s*'hard'", dotAll: true);
        content = content.replaceFirstMapped(showBlockRegex, (m) {
          return m.group(0)!.replaceFirst("'subtitleType': 'hard'", "'subtitleType': 'soft'");
        });
      } else {
        print('[$showId] Hard Sub (No Chinese CC)');
      }
    } catch (e) {
      print('[$showId] Error fetching CC for $firstEpisodeId: $e');
    }
    
    // Slight delay to avoid getting rate limited immediately
    await Future.delayed(Duration(milliseconds: 200));
  }

  await file.writeAsString(content);
  yt.close();
  print('Finished updating shows_data.dart');
}
