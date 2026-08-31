import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  final key = (await File('.env').readAsLines())
      .firstWhere((l) => l.startsWith('GEMINI_API_KEY='))
      .split('=')[1]
      .trim();
  final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$key');

  // Test exact prompt format from the script
  final batch = ['Chapter 1', 'Chapter 2', 'Chapter 3', 'The Monkey King', 'A Test Sentence'];
  final buf = StringBuffer();
  buf.writeln('Translate these ${batch.length} English texts to language code "id".');
  buf.writeln('Return ONLY numbered translations, one per line. ALWAYS translate.');
  buf.writeln('Example input: "Chapter 1" -> in French: "Chapitre 1"');
  for (int i = 0; i < batch.length; i++) {
    buf.writeln('${i + 1}. "${batch[i]}"');
  }
  print('=== PROMPT ===');
  print(buf.toString());
  print('=== END PROMPT ===');

  final r = await http.post(url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'contents': [{'parts': [{'text': buf.toString()}]}],
      'generationConfig': {'temperature': 0.05, 'maxOutputTokens': 8192},
    }),
  ).timeout(Duration(seconds: 30));

  print('Status: ${r.statusCode}');
  if (r.statusCode == 200) {
    final data = jsonDecode(r.body);
    final text = data['candidates'][0]['content']['parts'][0]['text'] as String;
    print('=== RESPONSE ===');
    print(text);
    print('=== END ===');

    // Try parsing
    final out = <String>[];
    for (final line in text.split('\n')) {
      final m = RegExp(r'^\d+\.\s*"?(.+?)"?\s*$').firstMatch(line.trim());
      if (m != null) {
        out.add(m.group(1)!.trim());
        print('  MATCH: "${m.group(1)}"');
      } else {
        print('  NO MATCH: "$line"');
      }
    }
    print('Parsed ${out.length}/${batch.length}');
  } else {
    print('Error: ${r.body}');
  }
}