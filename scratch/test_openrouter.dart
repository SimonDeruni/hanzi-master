import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final apiKey = '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';

  final response = await http.post(
    Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'model': 'google/gemini-2.5-flash',
      'messages': [
        {'role': 'user', 'content': 'Hello, respond in one word.'}
      ],
      'max_tokens': 10,
    }),
  );

  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}
