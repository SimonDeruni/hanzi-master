import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> translate(String text) async {
  if (text.isEmpty) return text;
  // Skip if already in English (no Chinese characters)
  if (!RegExp(r'[\u4e00-\u9fff]').hasMatch(text)) return text;

  final encoded = Uri.encodeComponent(text);
  final urlStr =
      'https://translate.googleapis.com/translate_a/single?client=gtx&sl=zh-CN&tl=en&dt=t&q=$encoded';

  for (int attempt = 1; attempt <= 3; attempt++) {
    try {
      final response = await http
          .get(Uri.parse(urlStr))
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String translated = '';
        for (var obj in data[0]) {
          translated += (obj[0] ?? '');
        }
        return translated.trim();
      }
    } catch (e) {
      if (attempt == 3) print('Failed to translate after 3 attempts: $e');
      await Future.delayed(Duration(seconds: attempt));
    }
  }
  return text;
}

void main() async {
  final file = File('assets/data/mandarin_bean_stories.json');
  final List<dynamic> stories = json.decode(await file.readAsString());

  print('Translating ${stories.length} Mandarin Bean stories...\n');

  const batchSize = 10;
  for (int i = 0; i < stories.length; i += batchSize) {
    final end = (i + batchSize < stories.length) ? i + batchSize : stories.length;
    stdout.write('\rTranslating ${i + 1}–$end / ${stories.length}...');

    await Future.wait(stories.sublist(i, end).map((story) async {
      final title = story['title'] as String? ?? '';
      final summary = story['summary'] as String? ?? '';

      story['title_en'] = await translate(title);
      story['summary_en'] = await translate(summary);
    }));

    // Brief pause to avoid rate-limiting
    await Future.delayed(const Duration(milliseconds: 200));
  }

  print('\nDone! Saving...');
  final encoder = JsonEncoder.withIndent('  ');
  await file.writeAsString(encoder.convert(stories));
  print('Saved to ${file.path}');
}
