import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final apiKey = 'YOUR_OPENROUTER_KEY';
  final model = 'google/gemini-2.5-flash';
  final prompt = 'test';
  try {
    final response = await http.post(
      Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer ' + apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'messages': [{'role': 'user', 'content': prompt}],
        'response_format': {'type': 'json_object'},
      }),
    );
    print(response.statusCode);
    print(response.body);
  } catch (e) {
    print(e);
  }
}
