import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // Use the valid Google Key we found in .env
  final apiKey = 'AQ.Ab8RN6IY_hG6QpIjnjAxCAo-dAbIMS-egNT9cH_vpJgpujXxKA';

  final systemInstruction = "You are a professional Mandarin tutor. Respond in valid JSON format with keys: 'chinese', 'english', 'pinyin'.";
  final messages = [
    {
      "role": "user",
      "parts": [{"text": "Hello, greet me."}]
    }
  ];

  final url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey';
  print('Calling Gemini native API at $url...');

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "contents": messages,
      "systemInstruction": {
        "parts": [{"text": systemInstruction}]
      },
      "generationConfig": {
        "responseMimeType": "application/json"
      }
    }),
  );

  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
}
