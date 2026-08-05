import 'dart:io';
import 'package:hanzi_master/features/media/data/repositories/shows_data.dart';

List<String> _generateTags(String title, String channel) {
  List<String> tags = [];
  final t = "${title.toLowerCase()} ${channel.toLowerCase()}";
  
  if (t.contains('古装') || t.contains('historical') || t.contains('wuxia') || t.contains('长安') || t.contains('大唐')) {
    tags.add('Historical');
  }
  if (t.contains('爱情') || t.contains('romance') || t.contains('love') || t.contains('恋')) {
    tags.add('Romance');
  }
  if (t.contains('喜剧') || t.contains('comedy') || t.contains('搞笑')) {
    tags.add('Comedy');
  }
  if (t.contains('悬疑') || t.contains('刑侦') || t.contains('探案') || t.contains('mystery') || t.contains('crime')) {
    tags.add('Mystery');
  }
  if (t.contains('生活') || t.contains('都市') || t.contains('家庭') || t.contains('life') || t.contains('family')) {
    tags.add('Slice of Life');
  }
  if (t.contains('小猪佩奇') || t.contains('peppa') || t.contains('kids') || t.contains('children')) {
    tags.add('Kids');
  }
  if (t.contains('纪录片') || t.contains('documentary') || t.contains('李子柒') || t.contains('liziqi')) {
    tags.add('Documentary');
  }
  if (t.contains('武侠') || t.contains('action') || t.contains('江湖')) {
    tags.add('Action');
  }
  
  if (tags.isEmpty) {
    tags.add('Drama'); // Default fallback
  }
  return tags;
}

void main() {
  var data = HardcodedShows.data;
  var b = StringBuffer();
  b.writeln("// GENERATED");
  b.writeln("// Note: Cleaned and tagged offline");
  b.writeln();
  b.writeln("// ignore_for_file: lines_longer_than_80_chars");
  b.writeln();
  b.writeln("class HardcodedShows {");
  b.writeln("  static const List<Map<String, dynamic>> data = [");
  
  int removedCount = 0;
  
  for (var p in data) {
    String title = p["title"] as String;
    String channel = p["channelTitle"] as String;
    
    // Filter out preview playlists
    if (title.contains('预告') || title.contains('Trailer') || title.contains('Preview') || title.contains('花絮') || title.contains('特辑')) {
      removedCount++;
      continue;
    }
    
    List<String> tags = _generateTags(title, channel);
    
    b.writeln("    {");
    b.writeln("      'id': '${p["id"]}',");
    b.writeln("      'title': '${title.replaceAll("\\","\\\\").replaceAll("'","\\'")}',");
    b.writeln("      'channelTitle': '${channel.replaceAll("\\","\\\\").replaceAll("'","\\'")}',");
    b.writeln("      'thumbnailUrl': '${p["thumbnailUrl"]}',");
    b.writeln("      'episodeCount': ${(p["episodes"] as List).length},");
    b.writeln("      'tags': ['${tags.join("', '")}'],");
    b.writeln("      'episodes': [");
    for (var v in p["episodes"] as List) {
      b.writeln("        {");
      b.writeln("          'id': '${v["id"]}',");
      b.writeln("          'title': '${(v["title"] as String).replaceAll("\\","\\\\").replaceAll("'","\\'")}',");
      b.writeln("          'thumbnailUrl': '${v["thumbnailUrl"]}',");
      b.writeln("        },");
    }
    b.writeln("      ],");
    b.writeln("    },");
  }
  b.writeln("  ];");
  b.writeln("}");
  
  File('lib/features/media/data/repositories/shows_data.dart').writeAsStringSync(b.toString());
  print("Successfully added tags and filtered out \$removedCount preview playlists!");
}
