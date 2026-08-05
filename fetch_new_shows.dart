import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() async {
  final yt = YoutubeExplode();
  final file = File('lib/features/media/data/repositories/shows_data.dart');
  var content = await file.readAsString();

  print('Searching for playlists...');
  // Use a query likely to yield full Chinese dramas.
  const query = "chinese drama full episodes";
  
  // Note: search.getPlaylists doesn't exist directly on yt.search, we have to search normally 
  // and filter by PlaylistSearchQuery or similar, or just search normally and filter by Playlist.
  final searchResults = await yt.search.search(query, filter: TypeFilters.playlist);

  final List<String> newShowEntries = [];
  int addedCount = 0;
  
  for (final result in searchResults) {
    if (addedCount >= 50) break;
    
    // Check if it's a playlist. 
    // In YoutubeExplodeDart 3.x, search results with TypeFilters.playlist return SearchPlaylist
    final playlistId = result.id.value;
    
    // Check if we already have this playlist
    if (content.contains("'$playlistId'")) {
      print('Skipping already existing playlist: $playlistId');
      continue;
    }

    try {
      final playlist = await yt.playlists.get(playlistId);
      final videos = await yt.playlists.getVideos(playlistId).take(50).toList();
      
      // Filter out teasers by requiring at least 10 videos (typical dramas are 20-40 eps)
      if (videos.length < 10) {
        print('Skipping ${playlist.title} (only ${videos.length} videos, likely not a full drama)');
        continue;
      }

      print('Fetching CC info for first episode of: ${playlist.title}');
      final firstVideoId = videos.first.id.value;
      bool hasCC = false;
      try {
        final manifest = await yt.videos.closedCaptions.getManifest(firstVideoId);
        hasCC = manifest.tracks.any((track) => track.language.code.toLowerCase().startsWith('zh'));
      } catch (_) {
        // Ignore CC fetch errors
      }

      final subtitleType = hasCC ? 'soft' : 'hard';
      final title = playlist.title.replaceAll("'", r"\'");
      final channel = playlist.author.replaceAll("'", r"\'");
      final thumb = videos.first.thumbnails.highResUrl;

      final sb = StringBuffer();
      sb.writeln('    {');
      sb.writeln("      'id': '$playlistId',");
      sb.writeln("      'title': '$title',");
      sb.writeln("      'channelTitle': '$channel',");
      sb.writeln("      'thumbnailUrl': '$thumb',");
      sb.writeln("      'episodeCount': ${videos.length},");
      sb.writeln("      'tags': ['Drama'],");
      sb.writeln("      'subtitleType': '$subtitleType',");
      sb.writeln("      'episodes': [");
      
      for (int i = 0; i < videos.length; i++) {
        final v = videos[i];
        final vId = v.id.value;
        final vTitle = 'EP${(i+1).toString().padLeft(2, '0')}'; // Standardize titles since yt titles are messy
        final vThumb = v.thumbnails.highResUrl;
        
        sb.writeln('        {');
        sb.writeln("          'id': '$vId',");
        sb.writeln("          'title': '$vTitle',");
        sb.writeln("          'thumbnailUrl': '$vThumb',");
        sb.writeln('        },');
      }
      sb.writeln("      ],");
      sb.writeln("    },");
      
      newShowEntries.add(sb.toString());
      addedCount++;
      print('Prepared show $addedCount: $title');
      
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      print('Error fetching playlist $playlistId: $e');
    }
  }

  if (newShowEntries.isNotEmpty) {
    // Insert before the last closing bracket of the list
    final closingBracketIndex = content.lastIndexOf('];');
    if (closingBracketIndex != -1) {
      final newContent = content.substring(0, closingBracketIndex) +
          newShowEntries.join('\n') +
          content.substring(closingBracketIndex);
          
      await file.writeAsString(newContent);
      print('Successfully appended ${newShowEntries.length} new shows to shows_data.dart');
    } else {
      print('Could not find closing bracket in shows_data.dart');
    }
  } else {
    print('No new shows added.');
  }
  
  yt.close();
}
