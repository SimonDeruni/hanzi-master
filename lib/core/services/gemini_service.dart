import 'dart:convert';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/flashcards/domain/entities/flashcard.dart';
import 'api_key_pool.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  return GeminiService(pool: pool);
});

class GeminiContext {
// ... existing GeminiContext, ExampleSentence, LookAlike classes ...
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
  final ApiKeyPool _pool;

  GeminiService({required ApiKeyPool pool}) : _pool = pool;

  GenerativeModel _getModel({
    String? mimeType = 'application/json',
    Content? systemInstruction,
    int? maxOutputTokens,
  }) {
    return GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _pool.nextKey,
      generationConfig: GenerationConfig(
        responseMimeType: mimeType,
        maxOutputTokens: maxOutputTokens,
      ),
      systemInstruction: systemInstruction,
    );
  }

  Future<GeminiContext> generateContext(String hanzi, int hskLevel) async {
    final cacheKey = '${hanzi}_$hskLevel';
    final box = Hive.box<String>('ai_cache');
    
    // 1. Check Cache
    if (box.containsKey(cacheKey)) {
      final json = jsonDecode(box.get(cacheKey)!);
      return GeminiContext.fromJson(json);
    }

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
      final response = await _getModel().generateContent([Content.text(prompt)]);
      final text = response.text;
      if (text != null && text.isNotEmpty) {
        // Strip markdown code block if present
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        
        // 2. Save to Cache
        box.put(cacheKey, cleanText);
        
        return GeminiContext.fromJson(json);
      }
      throw Exception("Empty response from Gemini");
    } catch (e) {
      // ignore
      rethrow;
    }
  }

  /// Deep Scan: Identifies the main objects in an image and provides metadata.
  Future<GeminiContext> analyzeImage(List<int> bytes) async {
    const prompt = 'Identify the main objects in this image. For each, provide mnemonic, sentences, and lookalikes in the standard JSON format.';
    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', Uint8List.fromList(bytes)),
      ])
    ];

    try {
      final response = await _getModel().generateContent(content);
      final text = response.text;
      if (text != null && text.isNotEmpty) {
        final json = jsonDecode(text);
        // Handle both single object and list of objects (taking the first)
        if (json is List && json.isNotEmpty) {
          return GeminiContext.fromJson(json[0]);
        }
        return GeminiContext.fromJson(json);
      }
      throw Exception("Empty response from Gemini Vision");
    } catch (e) {
      rethrow;
    }
  }

  /// Translation Fallback: Translates a local ML label into a full Flashcard entity.
  Future<Flashcard> translateObject(String label) async {
    final prompt = '''
Translate the English object label "$label" into Chinese.
Provide:
1. The Chinese character(s) (Hanzi).
2. The Pinyin with tone marks.
3. A concise English definition.

Respond ONLY in valid JSON format with this exact structure:
{
  "hanzi": "...",
  "pinyin": "...",
  "definition": "..."
}
''';

    try {
      final response = await _getModel().generateContent([Content.text(prompt)]);
      final text = response.text;
      if (text != null && text.isNotEmpty) {
        final json = jsonDecode(text);
        return Flashcard(
          id: 'gen_${DateTime.now().millisecondsSinceEpoch}',
          hanzi: json['hanzi'] ?? '',
          pinyin: json['pinyin'] ?? '',
          definition: json['definition'] ?? '',
          hskLevel: 1,
          strokePaths: const [],
          nextReviewDate: DateTime.now(),
          interval: 0,
          easeFactor: 2.5,
          streak: 0,
        );
      }
      throw Exception("Failed to translate object: $label");
    } catch (e) {
      rethrow;
    }
  }

  ChatSession startCharacterChat(String hanzi) {
    final chatModel = _getModel(
      mimeType: null,
      maxOutputTokens: 220,
      systemInstruction: Content.system(
        'You are a concise Chinese Calligraphy and Etymology tutor inside a mobile flashcard app. '
        'The student is studying the character "$hanzi". '
        'RULES: Answer in 2–3 sentences max. Prefer bullet points for lists. '
        'Never write introductions, sign-offs, or filler phrases like "Great question!" or "Certainly!". '
        'Use **bold** for Chinese characters and key terms. '
        'Be direct and informative.',
      ),
    );
    return chatModel.startChat();
  }
}
