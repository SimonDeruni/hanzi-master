import "dart:convert";
import "dart:io";
void main() {
  var src = <String>{};
  for (var f in Directory("assets/data/books").listSync().whereType<File>().toList()..sort((a,b)=>a.path.compareTo(b.path))) {
    var bid = f.uri.pathSegments.last.replaceAll(".json","");
    var chs = json.decode(f.readAsStringSync()) as List;
    for (var ch in chs) {
      var t = ch["titleEn"] as String? ?? ch["title"] as String? ?? "";
      var cm = RegExp(r"[\u4e00-\u9fff]").firstMatch(t);
      if (cm != null) {
        t = t.substring(0, cm.start).trim();
        if (t.isEmpty || t.endsWith(":") || t.endsWith("：")) t = "Chapter ${ch["chapterIndex"]}";
        else t = t.replaceAll(RegExp(r"[：:\s]+$"), "");
      }
      src.add(t);
    }
  }
  var list = src.toList()..sort();
  File("tool/all_chapter_titles.txt").writeAsStringSync(list.join("\n"));
  print("Written ${list.length} unique titles");
}
