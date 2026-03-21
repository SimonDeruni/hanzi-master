// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

void main() async {
  print("Downloading HSK JSON data...");
  final url = Uri.parse("https://raw.githubusercontent.com/LiudmilaLV/json_hsk/master/hsk.json");
  final request = await HttpClient().getUrl(url);
  final response = await request.close();

  if (response.statusCode != 200) {
    print("Failed to download data: \${response.statusCode}");
    return;
  }

  // Properly handle UTF-8 decoding
  final List<int> bytes = await response.expand((b) => b).toList();
  final responseBody = utf8.decode(bytes);
  
  final List<dynamic> allWords = jsonDecode(responseBody);
  print("Downloaded \${allWords.length} words.");

  for (int level = 3; level <= 6; level++) {
    final levelWords = allWords.where((word) => word['level'] == level).toList();
    print("Found \${levelWords.length} words for HSK \$level.");

    final List<Map<String, dynamic>> vocabularyList = [];
    int counter = 1;

    for (final rawWord in levelWords) {
      final hanzi = rawWord['hanzi'] ?? '';
      final pinyin = rawWord['pinyin'] ?? '';
      
      // Clean up translations
      String definition = '';
      if (rawWord['translations'] != null && rawWord['translations']['eng'] != null) {
         final List<dynamic> engList = rawWord['translations']['eng'];
         definition = engList.join('; ');
      }

      vocabularyList.add({
        "uuid": "hsk${level}_${counter.toString().padLeft(4, '0')}",
        "hanzi": hanzi,
        "pinyin": pinyin,
        "definition": definition,
      });
      counter++;
    }

    final bundle = {
      "version": "1.0",
      "hskLevel": level,
      "vocabulary": vocabularyList
    };

    final file = File('assets/data/hsk\${level}_bundle.json');
    // Ensure the output file is written as UTF-8
    await file.writeAsString(jsonEncode(bundle), encoding: utf8);
    print("Saved -> \${file.path}");
  }
}
