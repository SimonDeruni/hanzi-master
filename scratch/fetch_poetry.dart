import 'dart:convert';
import 'dart:io';

void main() async {
  final stories = [];

  // Correct URL — Chinese characters in path, not percent-encoded
  for (int i = 0; i <= 57; i++) {
    final urlStr = 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/全唐诗/poet.tang.$i.json';
    final url = Uri.parse(Uri.encodeFull(urlStr));
    try {
      print('Downloading batch $i...');
      final request = await HttpClient().getUrl(url);
      final response = await request.close();
      
      if (response.statusCode == 200) {
        final jsonString = await response.transform(utf8.decoder).join();
        final List<dynamic> data = json.decode(jsonString);
        
        for (var item in data) {
          final paragraphs = (item['paragraphs'] as List<dynamic>).cast<String>();
          if (paragraphs.isNotEmpty) {
            stories.add({
              'title': item['title'] ?? 'Untitled',
              'sourceName': item['author'] ?? 'Unknown Author',
              'summary': 'A classic Tang Dynasty poem by ${item['author'] ?? 'Unknown'}.',
              'rawText': paragraphs.join('\n'),
              'category': 'Classical Literature',
              'hskLevel': 0
            });
          }
          if (stories.length >= 1000) break;
        }
        print('  -> ${stories.length} poems so far');
        if (stories.length >= 1000) break;
      } else {
        // 404 means we've run out of files
        print('  -> Done at batch $i (${response.statusCode})');
        break;
      }
    } catch (e) {
      print('Error on batch $i: $e');
      break;
    }
  }

  final dir = Directory('assets/data');
  if (!await dir.exists()) await dir.create(recursive: true);
  
  final file = File('assets/data/tang_poetry.json');
  await file.writeAsString(json.encode(stories));
  print('Done! Saved ${stories.length} poems to assets/data/tang_poetry.json');
}
