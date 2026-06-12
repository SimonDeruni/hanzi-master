import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  final apiKey = 'AIzaSyBh8Sfhu8g9aENfmf4BkR2iSf_TVzrchs0';
  final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
  try {
    final response = await model.generateContent([Content.text('Hello')]);
    print('Success: ${response.text}');
  } catch (e) {
    print('Error: $e');
  }
}
