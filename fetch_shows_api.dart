import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = "AIzaSyCvmm4uljoCyIFkBIoBybiishaWyyu2ROU";

Future<List<dynamic>> searchPlaylists(String query, int maxResults) async {
  final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search?part=snippet&type=playlist&q=${Uri.encodeComponent(query)}&maxResults=$maxResults&key=$apiKey');
  final resp = await http.get(url);
  if (resp.statusCode != 200) {
    print("Error searching: ${resp.body}");
    return [];
  }
  return json.decode(resp.body)['items'] ?? [];
}

Future<List<dynamic>> getPlaylistItems(String playlistId) async {
  final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=$playlistId&maxResults=50&key=$apiKey');
  final resp = await http.get(url);
  if (resp.statusCode != 200) {
    return [];
  }
  return json.decode(resp.body)['items'] ?? [];
}

Future<bool> checkCc(String videoId) async {
  final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/captions?part=snippet&videoId=$videoId&key=$apiKey');
  final resp = await http.get(url);
  if (resp.statusCode == 200) {
    final items = json.decode(resp.body)['items'] ?? [];
    for (var item in items) {
      final lang = item['snippet']['language'].toString().toLowerCase();
      if (lang.startsWith('zh') || lang == 'cmn' || lang == 'yue') {
        return true;
      }
    }
  }
  return false;
}

void main() async {
  print("Searching for playlists...");
  final playlists = await searchPlaylists("chinese drama full episodes YOUKU Tencent iQIYI", 50);

  final file = File('lib/features/media/data/repositories/shows_data.dart');
  final content = await file.readAsString();

  final List<String> newEntries = [];
  int added = 0;

  for (var pl in playlists) {
    if (added >= 50) break;

    final pid = pl['id']['playlistId'];
    if (content.contains("'$pid'")) {
      print("Skipping existing: $pid");
      continue;
    }

    final title = pl['snippet']['title'].toString().replaceAll("'", r"\'");
    final channel = pl['snippet']['channelTitle'].toString().replaceAll("'", r"\'");

    final items = await getPlaylistItems(pid);
    if (items.length < 10) {
      print("Skipping $title (too short)");
      continue;
    }

    final firstVideo = items[0]['snippet']['resourceId']['videoId'];
    var thumbObj = items[0]['snippet']['thumbnails'];
    String thumb = '';
    if (thumbObj != null) {
      thumb = (thumbObj['maxres'] ?? thumbObj['high'] ?? thumbObj['default'] ?? {})['url'] ?? '';
    }

    bool hasCc = await checkCc(firstVideo);
    String subtitleType = hasCc ? 'soft' : 'hard';

    final sb = StringBuffer();
    sb.writeln("    {");
    sb.writeln("      'id': '$pid',");
    sb.writeln("      'title': '$title',");
    sb.writeln("      'channelTitle': '$channel',");
    sb.writeln("      'thumbnailUrl': '$thumb',");
    sb.writeln("      'episodeCount': ${items.length},");
    sb.writeln("      'tags': ['Drama'],");
    sb.writeln("      'subtitleType': '$subtitleType',");
    sb.writeln("      'episodes': [");

    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      var vid = item['snippet']['resourceId']['videoId'];
      var vthumbObj = item['snippet']['thumbnails'];
      String vthumb = thumb;
      if (vthumbObj != null) {
        vthumb = (vthumbObj['maxres'] ?? vthumbObj['high'] ?? vthumbObj['default'] ?? {})['url'] ?? thumb;
      }

      final vtitle = "EP${(i + 1).toString().padLeft(2, '0')}";
      sb.writeln("        {");
      sb.writeln("          'id': '$vid',");
      sb.writeln("          'title': '$vtitle',");
      sb.writeln("          'thumbnailUrl': '$vthumb',");
      sb.writeln("        },");
    }

    sb.writeln("      ],");
    sb.writeln("    },");

    newEntries.add(sb.toString());
    added++;
    print("Added $added: $title");
  }

  if (newEntries.isNotEmpty) {
    final closingIdx = content.lastIndexOf("];");
    if (closingIdx != -1) {
      final newContent = "${content.substring(0, closingIdx)}${newEntries.join("\n")}\n  ${content.substring(closingIdx)}";
      await file.writeAsString(newContent);
      print("Successfully added ${newEntries.length} shows.");
    }
  } else {
    print("No new shows added.");
  }
}
