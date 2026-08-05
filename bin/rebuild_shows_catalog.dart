import "dart:convert";
import "dart:io";
import "package:youtube_explode_dart/youtube_explode_dart.dart";

const apk = "AIzaSyBYEY2lbPnDPk179ztaw5MxLwu9keTqNlk";
const base = "https://www.googleapis.com/youtube/v3";
const ch = [
  "UCYQPTeY3HOk0BprrGuCWCaA", "UCUhpu5MJQ_bjPkXO00jyxsw", "UCdpiId0eJGnnIvfhpbJIM1w",
  "UCQatgKoA7lylp_UzvsLCgcw", "UCD_83Jh-UFQXRDwC6S8caCQ", "UCFh5x5AZHQQ6FaGKnG-QXDA",
  "UCRABdhiBHX4Bie-jfPCd2pg", "UC3PKcYXUAhao3p4kuNS4_9w"
];
final cl = HttpClient();

// The 4 curated shows the user already has (DO NOT REMOVE)
const curatedShows = [
  "PLDpUVcjhvJisQCVw4YJVNTxT-DrVQUgbr", // 似锦 Si Jin
  "PLDpUVcjhvJitpknWzhJb-wevf7VSVWXk2", // 六姊妹 SIX SISTERS
  "PLDpUVcjhvJiv7s5xxFY0kXLj4o3BIOmlk", // 骄阳似我 Shine On Me
  "PLMX26aiIvX5pOaq5gNEShd4L2Tzfh_8Da", // 四喜 Those Days
];

Future<void> main() async {
  print("=========================================");
  print("🎬 Fetching shows with SOFTCODED subtitles");
  print("=========================================");

  final kept = <Map<String, dynamic>>[];

  // 1. First, fetch and keep the 4 existing curated shows
  print("\n--- Fetching the 4 curated shows ---");
  for (var pid in curatedShows) {
    var plMeta = await _get("$base/playlists?part=snippet&id=$pid&key=$apk");
    if (plMeta == null) continue;
    var d = jsonDecode(plMeta) as Map<String, dynamic>;
    if ((d["items"] as List).isEmpty) continue;
    
    var s = d["items"][0]["snippet"] as Map<String, dynamic>;
    var title = s["title"] as String;
    var channel = s["channelTitle"] as String;
    var thumb = s["thumbnails"]["high"]?["url"] ?? s["thumbnails"]["default"]?["url"] ?? "";

    var vids = await _fetchVids(pid);
    vids.removeWhere((v) => v["priv"] == true);
    var kw = ["trailer","预告","特辑","花絮","幕后","预告片","片花"];
    vids.removeWhere((v) {
      var t = (v["title"] as String).toLowerCase();
      return kw.any((k) => t.contains(k.toLowerCase()));
    });
    
    if (vids.isNotEmpty) {
      kept.add({"id": pid, "title": title, "channelTitle": channel, "thumbnailUrl": thumb, "episodes": vids});
      print("  ✅ Kept curated show: $title");
    }
  }

  // 2. Search for 10 MORE shows across the channels with soft-captions
  print("\n--- Searching for 10 MORE shows with soft-captions ---");
  int newShowsFound = 0;
  
  outer:
  for (var cid in ch) {
    var pls = await _fetchPl(cid, 50); // Fetch up to 50 playlists per channel to find good ones
    print("\n[CH] $cid -> Checking ${pls.length} playlists...");
    
    for (var pl in pls) {
      
      var id = pl["id"] as String;
      if (curatedShows.contains(id)) continue; // skip if already curated
      
      var title = pl["title"] as String;
      print("  Checking: $title");
      
      var vids = await _fetchVids(id);
      if (vids.isEmpty) continue;
      if (vids.any((v) => v["priv"] == true)) continue; // skip private
      
      var kw = ["trailer","预告","特辑","花絮","幕后","预告片","片花"];
      vids.removeWhere((v) {
        var t = (v["title"] as String).toLowerCase();
        return kw.any((k) => t.contains(k.toLowerCase()));
      });
      if (vids.isEmpty) continue;

      // Check for softcoded captions! Only check first 2 episodes to save time/requests.
      // If the first 2 episodes have soft captions, we assume the whole show does.
      bool hasSoftCaps = true;
      int checkCount = vids.length > 2 ? 2 : vids.length;
      for (int i = 0; i < checkCount; i++) {
        if (!await _hasCaps(vids[i]["id"])) {
          hasSoftCaps = false;
          break;
        }
      }
      
      if (!hasSoftCaps) {
        print("    ❌ Skipped: No soft-captions found.");
        continue;
      }

      print("    ✅ FOUND SOFT-CAPTIONS! Added new show: $title");
      kept.add({
        "id": id,
        "title": title,
        "channelTitle": pl["ch"],
        "thumbnailUrl": pl["thumb"],
        "episodes": vids
      });
      newShowsFound++;
    }
  }

  print("\n=== Generating shows_data.dart with ${kept.length} total shows ===");
  _write(kept);
}

String _cleanTitle(String title, bool isEpisode) {
  var t = title;
  
  // 1. If episode, look for EPxx or 第x集
  if (isEpisode) {
    var epMatch = RegExp(r'(EP\s*\d+|第\s*\d+\s*集|Episode\s*\d+)', caseSensitive: false).firstMatch(t);
    if (epMatch != null) {
      return epMatch.group(1)!.toUpperCase().replaceAll(' ', ''); // Returns e.g. EP01 or 第1集
    }
  } else {
    // 2. If playlist, look for text inside 【...】 or 《...》
    var titleMatch = RegExp(r'[【《](.*?)[】》]').firstMatch(t);
    if (titleMatch != null) {
      t = titleMatch.group(1)!;
      // Also clean up inside the brackets just in case
      return t.replaceAll(RegExp(r'(正片|FULL|ENG SUB|ENGSUB)'), '').trim();
    }
  }

  // Fallback: Remove all hashtags and common fluff
  t = t.replaceAll(RegExp(r'#\S+'), '');
  final tags = ['正片FULL', '正片', '|', 'ENG SUB', 'ENGSUB', 'MULTI SUB', 'Multi Sub', '【】', '()', '（）'];
  for (var tag in tags) {
    t = t.replaceAll(tag, '');
  }
  
  return t.trim().replaceAll(RegExp(r'\s+'), ' ');
}

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
    tags.add('Drama');
  }
  return tags;
}

void _write(List<Map<String, dynamic>> kept) {
  var b = StringBuffer();
  b.writeln("// GENERATED");
  b.writeln("// ${DateTime.now().toIso8601String()}");
  b.writeln("// Note: Episodes are hardcoded to avoid live API calls.");
  b.writeln();
  b.writeln("// ignore_for_file: lines_longer_than_80_chars");
  b.writeln();
  b.writeln("class HardcodedShows {");
  b.writeln("  static const List<Map<String, dynamic>> data = [");
  
  for (var p in kept) {
    String rawTitle = p["title"] as String;
    String rawChannel = p["channelTitle"] as String;
    
    // Filter previews
    if (rawTitle.contains('预告') || rawTitle.contains('Trailer') || rawTitle.contains('Preview') || rawTitle.contains('花絮') || rawTitle.contains('特辑')) {
      continue;
    }
    
    List<String> tags = _generateTags(rawTitle, rawChannel);
    
    b.writeln("    {");
    b.writeln("      'id': '${p["id"]}',");
    b.writeln("      'title': '${_cleanTitle(rawTitle, false).replaceAll("\\","\\\\").replaceAll("'","\\'")}',");
    b.writeln("      'channelTitle': '${rawChannel.replaceAll("\\","\\\\").replaceAll("'","\\'")}',");
    b.writeln("      'thumbnailUrl': '${p["thumbnailUrl"]}',");
    b.writeln("      'episodeCount': ${(p["episodes"] as List).length},");
    b.writeln("      'tags': ['${tags.join("', '")}'],");
    b.writeln("      'episodes': [");
    for (var v in p["episodes"] as List) {
      b.writeln("        {");
      b.writeln("          'id': '${v["id"]}',");
      b.writeln("          'title': '${_cleanTitle(v["title"] as String, true).replaceAll("\\","\\\\").replaceAll("'","\\'")}',");
      b.writeln("          'thumbnailUrl': '${v["thumb"]}',");
      b.writeln("        },");
    }
    b.writeln("      ],");
    b.writeln("    },");
  }
  
  b.writeln("  ];");
  b.writeln("}");
  File("lib/features/media/data/repositories/shows_data.dart").writeAsStringSync(b.toString());
  print("🎉 Written successfully!");
}

Future<List<Map<String, dynamic>>> _fetchPl(String cid, int max) async {
  var out = <Map<String, dynamic>>[]; String? tok;
  while (out.length < max) {
    var n = (max-out.length).clamp(1,50);
    var u = "$base/playlists?part=snippet&channelId=$cid&maxResults=$n&key=$apk${tok!=null?"&pageToken=$tok":""}";
    var r = await _get(u); if (r==null) break;
    var d = jsonDecode(r) as Map<String, dynamic>;
    for (var it in (d["items"] as List<dynamic>? ?? [])) {
      var s = it["snippet"] as Map<String, dynamic>? ?? {};
      var th = s["thumbnails"] as Map<String, dynamic>? ?? {};
      var dt = th["default"] as Map<String, dynamic>?;
      var ht = th["high"] as Map<String, dynamic>?;
      out.add({"id":it["id"]??"","title":s["title"]??"","ch":s["channelTitle"]??"","thumb":dt?["url"]??ht?["url"]??""});
    }
    tok = d["nextPageToken"] as String?;
    if (tok==null||out.length>=max) break;
  }
  return out;
}

Future<List<Map<String, dynamic>>> _fetchVids(String pid) async {
  var out = <Map<String, dynamic>>[]; 
  String? tok;
  
  for (int pg = 0; pg < 4; pg++) {
    var url = "$base/playlistItems?part=snippet,status&playlistId=$pid&maxResults=50&key=$apk${tok != null ? "&pageToken=$tok" : ""}";
    var r = await _get(url); 
    if (r == null) break;
    
    var d = jsonDecode(r) as Map<String, dynamic>;
    for (var it in (d["items"] as List<dynamic>? ?? [])) {
      var s = it["snippet"] as Map<String, dynamic>? ?? {};
      var ri = s["resourceId"] as Map<String, dynamic>? ?? {};
      var vid = ri["videoId"] as String? ?? ""; 
      if (vid.isEmpty) continue;
      
      var st = it["status"] as Map<String, dynamic>? ?? {};
      var th = s["thumbnails"] as Map<String, dynamic>? ?? {};
      var thumb = th["high"]?["url"] ?? th["default"]?["url"] ?? "";
      
      out.add({
        "id": vid,
        "title": s["title"] ?? "",
        "thumb": thumb,
        "priv": (st["privacyStatus"] ?? "public") == "private"
      });
    }
    tok = d["nextPageToken"] as String?;
    if (tok == null) break;
  }
  return out;
}

Future<bool> _hasCaps(String vid) async {
  final yt = YoutubeExplode();
  try {
    final mf = await yt.videos.closedCaptions.getManifest(vid);
    return mf.tracks.any((t) {
      final c = t.language.code;
      return c=="zh"||c=="zh-cn"||c=="zh-tw"||c=="zh-hans"||c=="zh-hant"||c=="cmn"||c=="yue";
    });
  } catch (_) {
    return false;
  } finally {
    yt.close();
  }
}

Future<String?> _get(String url) async {
  for (int i=0; i<3; i++) {
    try {
      var rq = await cl.getUrl(Uri.parse(url));
      var rs = await rq.close();
      if (rs.statusCode == 200) {
        return await rs.transform(utf8.decoder).join();
      }
      if (rs.statusCode == 403) {
        var b = await rs.transform(utf8.decoder).join();
        if (b.contains("quotaExceeded")) {
          print("  QUOTA wait 60s...");
          await Future.delayed(const Duration(seconds: 60));
          continue;
        }
      }
    } catch (_) {}
  }
  return null;
}
