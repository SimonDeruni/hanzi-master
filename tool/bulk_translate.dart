import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const targetLanguages = [
  'es', 'fr', 'de', 'it', 'pt', 'ru', 'ja', 'ko', 'hi', 'ar', 'vi', 'th'
];

Future<String> _translateText(String text, String targetLang, String apiKey) async {
  if (text.isEmpty) return text;
  
  final prompt = 'Translate the following text into the language code "$targetLang". Provide ONLY the translation, nothing else. Text: "$text"';
  
  final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey');
  
  for (int attempt = 1; attempt <= 3; attempt++) {
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{'parts': [{'text': prompt}]}],
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['candidates'][0]['content']['parts'][0]['text'] as String;
        return result.trim();
      } else {
        throw Exception('Failed to translate: ${response.body}');
      }
    } catch (e) {
      if (attempt == 3) rethrow;
      print('Translation failed, retrying... ($e)');
      await Future.delayed(Duration(seconds: 2 * attempt));
    }
  }
  return text;
}

void main() async {
  final apiKey = Platform.environment['GEMINI_API_KEY'] ?? 'YOUR_GEMINI_KEY';
  if (apiKey.isEmpty || apiKey == 'YOUR_GEMINI_KEY') {
    print('Please provide a GEMINI_API_KEY environment variable.');
    exit(1);
  }

  final dataFiles = [
    'assets/data/1000_stories.json',
    'assets/data/tang_poetry.json',
    'assets/data/150_graded_readers.json',
    'assets/data/mandarin_bean_stories.json',
  ];

  for (final filePath in dataFiles) {
    final file = File(filePath);
    if (!file.existsSync()) {
      print('File not found: $filePath');
      continue;
    }

    print('Processing $filePath...');
    final rawData = file.readAsStringSync();
    
    // We expect a List or a Map.
    dynamic data = jsonDecode(rawData);
    List items = data is List ? data : (data as Map).values.toList();
    
    for (final lang in targetLanguages) {
      final translatedItems = [];
      final outName = filePath.replaceAll('.json', '_$lang.json');
      final outFile = File(outName);
      
      // If already generated, skip
      if (outFile.existsSync()) {
        print('Skipping $outName (already exists)');
        continue;
      }
      
      print('Translating ${items.length} items to $lang...');
      int count = 0;
      for (final item in items) {
        count++;
        // Print progress without newlines
        stdout.write('\rTranslating $count/${items.length} to $lang');
        
        final translatedItem = Map<String, dynamic>.from(item);
        
        // Only translate title and summary
        if (translatedItem.containsKey('title')) {
           translatedItem['title'] = await _translateText(translatedItem['title'], lang, apiKey);
        }
        if (translatedItem.containsKey('summary')) {
           translatedItem['summary'] = await _translateText(translatedItem['summary'], lang, apiKey);
        }
        
        // Wait briefly to avoid aggressive rate limiting
        await Future.delayed(const Duration(milliseconds: 300));
        translatedItems.add(translatedItem);
      }
      print(''); // new line
      
      final encoder = JsonEncoder.withIndent('  ');
      outFile.writeAsStringSync(encoder.convert(translatedItems));
      print('Saved translations to $outName');
    }
  }
  
  print('All bulk translations complete!');
}
