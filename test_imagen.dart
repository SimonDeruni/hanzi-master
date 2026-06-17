import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final googleKey = 'AQ.Ab8RN6Jw1wne4dkK1GceZmxu25nsh_a30BbXoWa6tDBo9Zt4Hw';
  
  print('Testing Imagen API with header...');
  final imageRes = await http.post(
    Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/imagen-4.0-generate-001:predict'),
    headers: {
      'Content-Type': 'application/json',
      'x-goog-api-key': googleKey,
    },
    body: jsonEncode({
      "instances": [
        {
          "prompt": "A 3D animated portrait of a young adult alien in Beijing. Warm color palette, Pixar/Disney aesthetic."
        }
      ],
      "parameters": {
        "sampleCount": 1
      }
    }),
  );
  
  print('Status: ${imageRes.statusCode}');
  print('Body: ${imageRes.body}');
}
