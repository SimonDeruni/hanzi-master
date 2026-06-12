import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  // In a real app, you would load this from an env file or secure storage.
  // Using the test API key provided earlier.
  return GeminiService(apiKey: 'AIzaSyBh8Sfhu8g9aENfmf4BkR2iSf_TVzrchs0');
});

class GeminiContext {
  final String mnemonic;
  final List<ExampleSentence> sentences;
  final List<LookAlike> lookAlikes;

  GeminiContext({required this.mnemonic, required this.sentences, required this.lookAlikes});

  factory GeminiContext.fromJson(Map<String, dynamic> json) {
    return GeminiContext(
      mnemonic: json['mnemonic'] as String? ?? '',
      sentences: (json['sentences'] as List<dynamic>?)
              ?.map((e) => ExampleSentence.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      lookAlikes: (json['lookAlikes'] as List<dynamic>?)
              ?.map((e) => LookAlike.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class ExampleSentence {
  final String chinese;
  final String pinyin;
  final String english;

  ExampleSentence({
    required this.chinese,
    required this.pinyin,
    required this.english,
  });

  factory ExampleSentence.fromJson(Map<String, dynamic> json) {
    return ExampleSentence(
      chinese: json['chinese'] as String? ?? '',
      pinyin: json['pinyin'] as String? ?? '',
      english: json['english'] as String? ?? '',
    );
  }
}

class LookAlike {
  final String character;
  final String pinyin;
  final String english;
  final String difference;

  LookAlike({
    required this.character,
    required this.pinyin,
    required this.english,
    required this.difference,
  });

  factory LookAlike.fromJson(Map<String, dynamic> json) {
    return LookAlike(
      character: json['character'] as String? ?? '',
      pinyin: json['pinyin'] as String? ?? '',
      english: json['english'] as String? ?? '',
      difference: json['difference'] as String? ?? '',
    );
  }
}

class GeminiService {
  final GenerativeModel _model;

  GeminiService({required String apiKey})
      : _model = GenerativeModel(
          model: 'gemini-2.5-flash',
          apiKey: apiKey,
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
          ),
        );

  Future<GeminiContext> generateContext(String hanzi, int hskLevel) async {
    final prompt = '''
You are an expert Chinese teacher. The student is viewing the Chinese character/word: "$hanzi".
They are roughly at HSK level $hskLevel (if 0, assume beginner/HSK 1).

Please provide:
1. A very short, highly memorable mnemonic or etymology story to help remember this character/word. (1-2 sentences).
2. Two highly natural example sentences using "$hanzi". The vocabulary used in the sentences should match their HSK level (keep it simple for beginners).
3. Identify 1 or 2 characters that look very visually similar to "$hanzi" (ghost characters) that students often confuse it with. Explain the visual difference briefly. If there are none, return an empty array.

Respond ONLY in valid JSON format with this exact structure:
{
  "mnemonic": "The story goes here...",
  "sentences": [
    {
      "chinese": "...",
      "pinyin": "...",
      "english": "..."
    },
    {
      "chinese": "...",
      "pinyin": "...",
      "english": "..."
    }
  ],
  "lookAlikes": [
    {
      "character": "...",
      "pinyin": "...",
      "english": "...",
      "difference": "..."
    }
  ]
}
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text;
      if (text != null && text.isNotEmpty) {
        final json = jsonDecode(text);
        return GeminiContext.fromJson(json);
      }
      throw Exception("Empty response from Gemini");
    } catch (e) {
      // ignore
      rethrow;
    }
  }

  ChatSession startCharacterChat(String hanzi) {
    final chatModel = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: 'AIzaSyBh8Sfhu8g9aENfmf4BkR2iSf_TVzrchs0',
      systemInstruction: Content.system('''
You are a helpful, expert Chinese Calligraphy and Etymology tutor.
The student is currently viewing the detail card for the Chinese character/word: "$hanzi".
Keep your answers concise, friendly, and focused.
If they ask about history, explain the oracle bone script origins or radicals.
If they ask about grammar or usage, provide clear, simple examples with pinyin and English.
'''),
    );
    return chatModel.startChat();
  }
}
