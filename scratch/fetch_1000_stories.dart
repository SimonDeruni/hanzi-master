import 'dart:convert';
import 'dart:io';

void main() async {
  final url = Uri.parse('https://raw.githubusercontent.com/pwxcoo/chinese-xinhua/master/data/idiom.json');
  
  try {
    print('Downloading idiom dataset...');
    final request = await HttpClient().getUrl(url);
    final response = await request.close();
    
    if (response.statusCode == 200) {
      final jsonString = await response.transform(utf8.decoder).join();
      final List<dynamic> data = json.decode(jsonString);
      
      final stories = [];
      for (var item in data) {
        final derivation = item['derivation'] ?? '';
        if (derivation.length > 10) {
          stories.add({
            'title': item['word'],
            'sourceName': 'Idiom Dictionary',
            'summary': item['explanation'] ?? '',
            'rawText': derivation,
            'category': 'Idiom Stories'
          });
          
          if (stories.length >= 1000) break;
        }
      }
      
      final dir = Directory('assets/data');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      
      final file = File('assets/data/1000_stories.json');
      await file.writeAsString(json.encode(stories));
      print('Successfully saved ${stories.length} stories!');
    } else {
      print('Failed to download: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
