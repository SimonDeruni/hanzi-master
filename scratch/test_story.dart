import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final apiKey = 'YOUR_OPENROUTER_KEY';
  final model = 'google/gemini-2.5-flash';
  final prompt = '''
You are an expert Chinese teacher. Please write a short, engaging story (about 2-3 paragraphs) that uses the following vocabulary words:
你好, 谢谢, 再见

The theme or topic of the deck is: "Basics"

Keep the grammar at a level appropriate for someone learning these words. You may use basic connecting words, but try to use as many of the provided vocabulary words as possible.

Respond ONLY in valid JSON format with this exact structure:
{
  "chinese": "The full story in Chinese characters...",
  "pinyin": "The full story in pinyin...",
  "english": "The full story translated to English..."
}
''';

  print('Sending request to OpenRouter with model: \$model...');
  final sw = Stopwatch()..start();
  try {
    final response = await http.post(
      Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer \$apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'messages': [{'role': 'user', 'content': prompt}],
        'response_format': {'type': 'json_object'},
      }),
    );
    
    print('Completed in \${sw.elapsedMilliseconds}ms');
    print('Status: \${response.statusCode}');
    print('Body: \${response.body}');
  } catch (e) {
    print('Error: \$e');
  }
}
