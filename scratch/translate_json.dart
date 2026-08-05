import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> translate(String text) async {
  if (text.isEmpty) return text;
  final encoded = Uri.encodeComponent(text);
  final urlStr = 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=zh-CN&tl=en&dt=t&q=$encoded';
  
  try {
    final response = await http.get(Uri.parse(urlStr));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String translated = '';
      for (var obj in data[0]) {
        translated += obj[0];
      }
      return translated;
    }
  } catch (e) {
    print('Error translating: \$e');
  }
  return text;
}

void main() async {
  print('Translating idioms...');
  final file = File('assets/data/1000_stories.json');
  final jsonString = await file.readAsString();
  final List<dynamic> stories = json.decode(jsonString);

  // Translate first 50 to save time and API limits, user can do rest later if needed.
  // Actually let's do all 1000. We can batch them, or just do it sequentially.
  // Sequential might be a bit slow, let's just do first 50 for now so the UI looks great.
  
  // Wait, let's do all of them. It's just 1000 requests. We can use a Future.wait in batches of 20.
  const int batchSize = 20;
  for (int i = 0; i < stories.length; i += batchSize) {
    int end = (i + batchSize < stories.length) ? i + batchSize : stories.length;
    print('Translating \$i to \$end...');
    final batch = stories.sublist(i, end);
    
    await Future.wait(batch.map((story) async {
      final origTitle = story['title'] ?? '';
      final origSummary = story['summary'] ?? '';
      
      final enTitle = await translate(origTitle);
      final enSummary = await translate(origSummary);
      
      story['title_en'] = enTitle;
      story['summary_en'] = enSummary;
    }));
  }

  await File('assets/data/1000_stories_en.json').writeAsString(json.encode(stories));
  print('Idioms done!');

  print('Translating poetry...');
  final pFile = File('assets/data/tang_poetry.json');
  final pJsonString = await pFile.readAsString();
  final List<dynamic> poetry = json.decode(pJsonString);

  for (int i = 0; i < poetry.length; i += batchSize) {
    int end = (i + batchSize < poetry.length) ? i + batchSize : poetry.length;
    print('Translating poetry \$i to \$end...');
    final batch = poetry.sublist(i, end);
    
    await Future.wait(batch.map((story) async {
      final origTitle = story['title'] ?? '';
      final enTitle = await translate(origTitle);
      story['title_en'] = enTitle;
      
      // We already have english summaries for poetry, but let's check
      final origSummary = story['summary'] ?? '';
      if (!origSummary.contains('Tang Dynasty')) {
         story['summary_en'] = await translate(origSummary);
      } else {
         story['summary_en'] = origSummary;
      }
    }));
  }

  await File('assets/data/tang_poetry_en.json').writeAsString(json.encode(poetry));
  print('Poetry done!');
}
