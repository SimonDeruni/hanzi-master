import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/media/domain/models/media_briefing.dart';
import 'package:hanzi_master/features/media/domain/models/video_transcript.dart';
import '../../features/flashcards/domain/entities/flashcard.dart';
import 'api_key_pool.dart';
import 'analytics_service.dart';
import '../providers/translation_language_provider.dart';
import 'gemini_proxy_client.dart';
import 'revenuecat_service.dart';

class PremiumRequiredException implements Exception {
  final String message;
  PremiumRequiredException(this.message);
  @override
  String toString() => message;
}

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  final analytics = ref.watch(analyticsServiceProvider);
  final targetLanguage = ref.watch(translationLanguageProvider);
  return GeminiService(pool: pool, analytics: analytics, targetLanguage: targetLanguage, ref: ref);
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

class CulturalInsight {
  final String historicalContext;
  final String culturalSignificance;
  final String authorBackground;
  
  CulturalInsight({
    required this.historicalContext,
    required this.culturalSignificance,
    required this.authorBackground,
  });

  factory CulturalInsight.fromJson(Map<String, dynamic> json) {
    return CulturalInsight(
      historicalContext: json['historicalContext'] as String? ?? '',
      culturalSignificance: json['culturalSignificance'] as String? ?? '',
      authorBackground: json['authorBackground'] as String? ?? '',
    );
  }
}

class AiWord {
  final String hanzi;
  final String pinyin;
  final String meaning;
  final String english; // StoryModeScreen uses 'english' in some places
  final int hskLevel;
  
  AiWord({required this.hanzi, required this.pinyin, required this.meaning, this.english = '', this.hskLevel = 0});
  
  factory AiWord.fromJson(Map<String, dynamic> json) {
    return AiWord(
      hanzi: json['hanzi'] as String? ?? '',
      pinyin: json['pinyin'] as String? ?? '',
      meaning: json['meaning'] as String? ?? '',
      english: json['english'] as String? ?? '',
      hskLevel: (json['hskLevel'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hanzi': hanzi,
      'pinyin': pinyin,
      'meaning': meaning,
      if (english.isNotEmpty) 'english': english,
      'hskLevel': hskLevel,
    };
  }
}

class AiSentence {
  final String chinese;
  final String english;
  final List<AiWord> words;

  AiSentence({required this.chinese, required this.english, required this.words});

  factory AiSentence.fromJson(Map<String, dynamic> json) {
    var list = json['words'] as List? ?? [];
    List<AiWord> wordsList = list.map((i) => AiWord.fromJson(i as Map<String, dynamic>)).toList();
    
    return AiSentence(
      chinese: json['chinese'] as String? ?? '',
      english: json['english'] as String? ?? '',
      words: wordsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chinese': chinese,
      'english': english,
      'words': words.map((w) => w.toJson()).toList(),
    };
  }
}

class AiStory {
  final List<AiSentence> sentences;

  AiStory({required this.sentences});

  factory AiStory.fromJson(Map<String, dynamic> json) {
    var list = json['sentences'] as List? ?? [];
    List<AiSentence> sentencesList = list.map((i) => AiSentence.fromJson(i as Map<String, dynamic>)).toList();
    
    return AiStory(sentences: sentencesList);
  }

  Map<String, dynamic> toJson() {
    return {
      'sentences': sentences.map((s) => s.toJson()).toList(),
    };
  }
}

class AiChatSession {
  final String apiKey;
  final String systemInstruction;
  final String model;
  final List<Map<String, dynamic>> _history = [];

  AiChatSession({
    required this.apiKey,
    required this.systemInstruction,
    this.model = 'deepseek/deepseek-chat',
  }) {
    if (systemInstruction.isNotEmpty) {
      _history.add({'role': 'system', 'content': systemInstruction});
    }
  }

  Future<String> sendMessage(String text) async {
    _history.add({'role': 'user', 'content': text});

    final response = await http.post(
      Uri.parse('https://us-central1-hanzi-master-bcef9.cloudfunctions.net/openRouterProxy'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'messages': _history,
        'max_tokens': 220,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      final reply = json['choices']?[0]?['message']?['content'] ?? '';
      _history.add({'role': 'assistant', 'content': reply});
      return reply;
    } else {
      _history.removeLast(); // Rollback on failure
      _history.removeLast();
      throw Exception('OpenRouter Error ${response.statusCode}: ${response.body}');
    }
  }
}

class GeminiService {
  final ApiKeyPool pool;
  final AnalyticsService analytics;
  final String targetLanguage;
  final Ref ref;

  static const int _freeTierDailyLimit = 5; // Reduced based on user request
  static const _conversationTimeout = Duration(seconds: 15);

  GeminiService({required this.pool, required this.analytics, this.targetLanguage = 'English', required this.ref});

  Future<void> _checkUsageLimit() async {
    // Limits removed because the app is now completely hard-paywalled.
    return;
  }

  Future<String> makeOpenRouterCall({
    required String model,
    required List<Map<String, dynamic>> messages,
    bool jsonMode = false,
    Duration? timeout,
  }) async {
    await _checkUsageLimit();
    final body = {
      'model': model,
      'messages': messages,
      'max_tokens': 2048,
    };
    
    if (jsonMode) {
      body['response_format'] = {'type': 'json_object'};
    }

    final response = await http.post(
      Uri.parse('https://us-central1-hanzi-master-bcef9.cloudfunctions.net/openRouterProxy'),
      headers: {
        'Authorization': 'Bearer ${pool.nextKey}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    ).timeout(timeout ?? const Duration(seconds: 90));

    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return json['choices']?[0]?['message']?['content'] ?? '';
    } else {
      throw Exception('OpenRouter Error ${response.statusCode}: ${response.body}');
    }
  }

  Future<String> generateText(String prompt) async {
    return await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [
        {'role': 'user', 'content': prompt}
      ],
    );
  }

  Stream<String> streamOpenRouterText(String prompt) async* {
    await _checkUsageLimit();
    final request = http.Request(
      'POST',
      Uri.parse('https://us-central1-hanzi-master-bcef9.cloudfunctions.net/openRouterProxy'),
    );
    request.headers.addAll({
      'Authorization': 'Bearer ${pool.nextKey}',
      'Content-Type': 'application/json',
    });
    request.body = jsonEncode({
      'model': 'google/gemini-2.5-flash',
      'messages': [{'role': 'user', 'content': prompt}],
      'max_tokens': 2048,
      'stream': true,
    });

    final response = await http.Client().send(request);
    if (response.statusCode != 200) {
      final body = await response.stream.bytesToString();
      throw Exception('OpenRouter Error ${response.statusCode}: $body');
    }

    await for (final chunk in response.stream.transform(utf8.decoder).transform(const LineSplitter())) {
      if (chunk.startsWith('data: ') && !chunk.startsWith('data: [DONE]')) {
        final data = chunk.substring(6);
        try {
          final json = jsonDecode(data);
          final delta = json['choices']?[0]?['delta']?['content'];
          if (delta != null && delta is String) {
            yield delta;
          }
        } catch (_) {}
      }
    }
  }

  Future<Map<String, String>> generateShadowingPhrase(String mode, String contextInput) async {
    final prompt = '''
You are an expert native Chinese pronunciation coach. 
The user is practicing their pronunciation. Generate ONE natural, conversational Chinese sentence for them to practice.
Context:
Mode: $mode
Topic/Content: $contextInput

Rules:
- Keep the sentence between 4 and 10 words.
- Use highly natural, colloquial phrasing.

Return ONLY a valid JSON object with EXACTLY this structure:
{
  "hanzi": "我喜欢喝苹果汁。",
  "pinyin": "Wǒ xǐhuān hē píngguǒzhī.",
  "english": "I like drinking apple juice."
}
''';

    final response = await generateText(prompt);
    final cleanText = response.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                            .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
    try {
      final json = jsonDecode(cleanText) as Map<String, dynamic>;
      return {
        "hanzi": json["hanzi"].toString(),
        "pinyin": json["pinyin"].toString(),
        "english": json["english"].toString(),
      };
    } catch (e) {
      throw Exception("Failed to parse phrase JSON: $e");
    }
  }

  Future<Map<String, String>> defineWord(String word) async {
    final cacheKey = 'def_$word';
    final box = Hive.box<String>('ai_cache');
    
    if (box.containsKey(cacheKey)) {
      final json = jsonDecode(box.get(cacheKey)!);
      return {'pinyin': json['pinyin'].toString(), 'meaning': json['meaning'].toString()};
    }

    final prompt = '''
You are an expert Chinese dictionary. Define the following word/character: "$word".
Provide the meaning in English.
Return ONLY valid JSON with this exact structure:
{
  "pinyin": "...",
  "meaning": "The English meaning here..."
}
''';

    final response = await makeOpenRouterCall(
      model: 'deepseek/deepseek-chat',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: true,
    );

    try {
      final json = jsonDecode(response);
      box.put(cacheKey, response);
      analytics.logApiUsage(apiName: 'openrouter', feature: 'define_word', success: true);
      return {'pinyin': json['pinyin'].toString(), 'meaning': json['meaning'].toString()};
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'define_word', success: false);
      return {'pinyin': '?', 'meaning': 'Failed to fetch definition.'};
    }
  }

  Future<String> explainGrammar(String word, String sentence) async {
    final prompt = '''
Explain the grammatical role and usage of the word "$word" in the following sentence:
"$sentence"

Keep your explanation short, engaging, and easy to understand for a language learner. Max 3 sentences.
CRITICAL: You MUST write your entire explanation in $targetLanguage.
''';

    try {
      final response = await makeOpenRouterCall(
        model: 'deepseek/deepseek-chat',
        messages: [{'role': 'user', 'content': prompt}],
      );
      analytics.logApiUsage(apiName: 'openrouter', feature: 'grammar_explainer', success: true);
      return response;
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'grammar_explainer', success: false);
      return "Failed to load explanation.";
    }
  }

  /// Returns a cache key for nuance comparisons, deterministic based on sorted words.
  String _nuanceCacheKey(List<Map<String, String>> words) {
    final sorted = words.map((w) => w['hanzi'] ?? '').toList()..sort();
    return 'nuance_${sorted.join('_')}';
  }

  /// Streaming version of compareNuances — yields tokens as they arrive.
  Stream<String> streamCompareNuances(List<Map<String, String>> words) async* {
    final wordList = words.map((w) => '${w['hanzi']} (${w['pinyin']}): ${w['definition']}').join('\n');
    final prompt = '''
You are a Chinese language tutor. A student is looking at these Chinese words that share similar meanings:

$wordList

Keep the explanation very short and concise. Explain:
- The slight differences in meaning.
- The differences in formality and context.
- How to use each one practically.

Avoid long paragraphs. Be practical and direct for a language learner.
CRITICAL: You MUST write your entire explanation in $targetLanguage.
CRITICAL: Output ONLY the explanation. Do not introduce yourself, do not greet the user, and do not break character. Do not use LaTeX formatting or math symbols like \$ or \\textbf. Use standard Markdown ONLY.
''';

    yield* streamOpenRouterText(prompt);
  }

  Future<String> compareNuances(List<Map<String, String>> words) async {
    final cacheKey = _nuanceCacheKey(words);
    final box = Hive.box<String>('ai_cache');

    // Return cached result instantly if available
    if (box.containsKey(cacheKey)) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'compare_nuances', success: true);
      return box.get(cacheKey)!;
    }

    final wordList = words.map((w) => '${w['hanzi']} (${w['pinyin']}): ${w['definition']}').join('\n');
    final prompt = '''
You are a Chinese language tutor. A student is looking at these Chinese words that share similar meanings:

$wordList

Explain the nuanced differences between these words. Cover:
1. When to use each one (context, formality, register)
2. Key differences in meaning or usage
3. Common collocations or fixed expressions

Keep your explanation clear and practical for a language learner. Use examples where helpful.
CRITICAL: You MUST write your entire explanation in $targetLanguage.
''';

    try {
      final response = await makeOpenRouterCall(
        model: 'deepseek/deepseek-chat',
        messages: [{'role': 'user', 'content': prompt}],
      );
      box.put(cacheKey, response);
      analytics.logApiUsage(apiName: 'openrouter', feature: 'compare_nuances', success: true);
      return response;
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'compare_nuances', success: false);
      return "Failed to load comparison.";
    }
  }

  Future<GeminiContext> generateContext(String hanzi, int hskLevel) async {
    final cacheKey = '${hanzi}_$hskLevel';
    final box = Hive.box<String>('ai_cache');
    
    if (box.containsKey(cacheKey)) {
      final json = jsonDecode(box.get(cacheKey)!);
      return GeminiContext.fromJson(json);
    }

    final prompt = '''
You are an expert Chinese teacher. The student is viewing the Chinese character/word: "$hanzi".
They are roughly at HSK level $hskLevel (if 0, assume beginner/HSK 1).

Please provide:
1. A very brief mnemonic story (max 1 sentence, under 15 words) to help remember this character.
2. Two highly natural but VERY SHORT example sentences using "$hanzi" (keep under 8 words each).
3. Identify 1 or 2 visually similar characters (ghost characters). Explain the difference in 5 words or less. If none, return empty array.

Respond ONLY in valid JSON format with this exact structure.
CRITICAL: Place the $targetLanguage translation in the "english" JSON keys!
{
  "mnemonic": "The story goes here in $targetLanguage...",
  "sentences": [
    {
      "chinese": "...",
      "pinyin": "...",
      "english": "The $targetLanguage translation..."
    },
    {
      "chinese": "...",
      "pinyin": "...",
      "english": "The $targetLanguage translation..."
    }
  ],
  "lookAlikes": [
    {
      "character": "...",
      "pinyin": "...",
      "english": "The $targetLanguage meaning...",
      "difference": "Difference explained in $targetLanguage..."
    }
  ]
}
''';

    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        box.put(cacheKey, cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'context_generation', success: true);
        return GeminiContext.fromJson(json);
      }
      throw Exception("Empty response from OpenRouter");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'context_generation', success: false);
      rethrow;
    }
  }

  Future<GeminiContext> analyzeImage(List<int> bytes) async {
    const prompt = 'Identify the main objects in this image. For each, provide mnemonic, sentences, and lookalikes in the standard JSON format described previously.';
    final base64Image = base64Encode(bytes);
    
    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {
            'role': 'user',
            'content': [
              {'type': 'text', 'text': prompt},
              {
                'type': 'image_url',
                'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
              }
            ]
          }
        ],
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'image_analysis', success: true);
        if (json is List && json.isNotEmpty) {
          return GeminiContext.fromJson(json[0]);
        }
        return GeminiContext.fromJson(json);
      }
      throw Exception("Empty response from Vision model");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'image_analysis', success: false);
      rethrow;
    }
  }

  Future<String> extractTextFromImage(List<int> imageBytes) async {
    const prompt = 'Extract all Chinese characters from this image. Return ONLY the extracted text — no commentary, no formatting, no translations. Preserve line breaks. If there are no Chinese characters, return an empty string.';
    final base64Image = base64Encode(imageBytes);
    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {
            'role': 'user',
            'content': [
              {'type': 'text', 'text': prompt},
              {
                'type': 'image_url',
                'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
              }
            ]
          }
        ],
      );
      return text.trim();
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'text_extraction', success: false);
      debugPrint("extractTextFromImage error: $e");
      return '';
    }
  }

  Future<({String fullText, List<Map<String, dynamic>> blocks})> extractTextFromImageDetailed(List<int> imageBytes) async {
    final prompt = '''
Extract all Chinese characters from this image. The image is a photograph taken with a camera.

Return a JSON object with the full text and the pixel position of each distinct text region.

First, determine the image dimensions. Then for each text region, measure the exact pixel coordinates.

Output JSON matching this exact structure:
{
  "fullText": "全部提取的文字",
  "blocks": [
    {"text": "文字块1", "x": 100, "y": 200, "width": 80, "height": 30},
    {"text": "文字块2", "x": 300, "y": 200, "width": 120, "height": 30}
  ]
}

Rules:
- "fullText" is the complete extracted text preserving line breaks.
- "blocks" is a list of text regions found in the image, one per visual text cluster.
- For each block, "x" and "y" are the top-left corner coordinates in pixels, "width" and "height" are the dimensions.
- Coordinates must be absolute pixel values relative to the original image (0,0 = top-left corner).
- Each block's width/height must match the actual visual extent of the text. Do not return zero-width or zero-height blocks.
- If there are no Chinese characters, return an empty string for "fullText" and an empty array for "blocks".
- Return ONLY valid JSON, no commentary.
''';
    final base64Image = base64Encode(imageBytes);
    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {
            'role': 'user',
            'content': [
              {'type': 'text', 'text': prompt},
              {
                'type': 'image_url',
                'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
              }
            ]
          }
        ],
        jsonMode: true,
      );
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        final blocks = ((json['blocks'] as List<dynamic>?) ?? <dynamic>[])
            .map<Map<String, dynamic>>((b) => b as Map<String, dynamic>)
            .toList();
        analytics.logApiUsage(apiName: 'openrouter', feature: 'text_extraction_detailed', success: true);
        return (fullText: (json['fullText'] as String? ?? '').trim(), blocks: blocks);
      }
      return (fullText: '', blocks: <Map<String, dynamic>>[]);
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'text_extraction_detailed', success: false);
      debugPrint("extractTextFromImageDetailed error: $e");
      return (fullText: '', blocks: <Map<String, dynamic>>[]);
    }
  }

  Future<AiWord> identifySpecificObject(List<int> bytes, String genericLabel, String languageCode) async {
    final prompt = '''
The user has pointed their camera at an object. An on-device model generally categorized it as "$genericLabel".
Look at the center of the image. Identify exactly what specific object the user is looking at. Be as precise as possible (e.g., if it's a mug, say "mug" not "household object").
Return the exact Chinese vocabulary word for this specific object.

Output JSON matching this exact structure:
{
  "hanzi": "杯子",
  "pinyin": "bēizi",
  "meaning": "Meaning in the language corresponding to ISO 639-1 code $languageCode",
  "hskLevel": 1
}
''';
    final base64Image = base64Encode(bytes);
    
    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {
            'role': 'user',
            'content': [
              {'type': 'text', 'text': prompt},
              {
                'type': 'image_url',
                'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
              }
            ]
          }
        ],
        jsonMode: true,
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'ar_snap', success: true);
        return AiWord.fromJson(json);
      }
      throw Exception("Empty response from Vision model");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'ar_snap', success: false);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> analyzeSceneObjects(List<int> bytes, List<String> currentLabels, String languageCode) async {
    final labelsStr = currentLabels.map((l) => '"$l"').join(', ');
    final prompt = '''
The user has pointed their camera at a scene. An on-device object detection model found these generic labels: [$labelsStr].
Look at the image carefully and identify exactly what specific objects correspond to those generic labels in this scene. 
Additionally, list any other prominent objects you see in the scene.
Return the exact Chinese vocabulary word for all these specific objects.

Output JSON matching this exact structure:
{
  "updatedLabels": {
    "generic label from the list": {
      "hanzi": "汉字",
      "pinyin": "pinyin",
      "meaning": "Meaning in ISO 639-1 code $languageCode",
      "hskLevel": 1
    }
  },
  "allObjects": [
    {
      "hanzi": "汉字",
      "pinyin": "pinyin",
      "meaning": "Meaning in ISO 639-1 code $languageCode",
      "hskLevel": 1
    }
  ]
}

Make sure "updatedLabels" maps the exact string from the provided generic labels to the specific object you found in the scene. If a generic label is completely wrong or not in the scene, you can omit it.
''';
    final base64Image = base64Encode(bytes);
    
    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {
            'role': 'user',
            'content': [
              {'type': 'text', 'text': prompt},
              {
                'type': 'image_url',
                'image_url': {'url': 'data:image/jpeg;base64,$base64Image'}
              }
            ]
          }
        ],
        jsonMode: true,
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        
        final Map<String, AiWord> updatedLabels = {};
        if (json['updatedLabels'] != null) {
          (json['updatedLabels'] as Map<String, dynamic>).forEach((key, value) {
            updatedLabels[key] = AiWord.fromJson(value);
          });
        }
        
        final List<AiWord> allObjects = [];
        if (json['allObjects'] != null) {
          for (var item in json['allObjects']) {
            allObjects.add(AiWord.fromJson(item));
          }
        }
        
        analytics.logApiUsage(apiName: 'openrouter', feature: 'ar_scene_analyze', success: true);
        return {
          'updatedLabels': updatedLabels,
          'allObjects': allObjects,
        };
      }
      throw Exception("Empty response from Vision model");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'ar_scene_analyze', success: false);
      rethrow;
    }
  }

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
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'translate_object', success: true);
        return Flashcard(
          id: 'gen_${DateTime.now().millisecondsSinceEpoch}',
          hanzi: json['hanzi'] ?? '',
          pinyin: json['pinyin'] ?? '',
          definition: json['definition'] ?? '',
          hskLevel: 1,
          strokePaths: const [],
          modeStats: const {},
        );
      }
      throw Exception("Failed to translate object: $label");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'translate_object', success: false);
      rethrow;
    }
  }

  Future<List<Map<String, String>>> generateDeckCards({
    required String topic,
    required String difficulty,
    required String contextTone,
    required int count,
  }) async {
    final prompt = '''
You are an expert Chinese teacher. The student wants to generate a custom vocabulary deck of exactly $count Chinese words/phrases.
Topic: "$topic"
Difficulty Level: $difficulty
Context/Tone: ${contextTone.isEmpty ? "Standard" : contextTone}

Please provide exactly $count words or short phrases that fit this criteria.
Ensure that the vocabulary is natural and useful.

Respond ONLY in valid JSON format as a list of objects with this exact structure.
CRITICAL: Put the $targetLanguage translation in the "english" JSON key!
[
  {
    "hanzi": "公司",
    "pinyin": "gōng sī",
    "english": "$targetLanguage translation (e.g., company)",
    "hskLevel": 3,
    "partOfSpeech": "noun"
  }
]

IMPORTANT RULES for hskLevel and partOfSpeech:
- hskLevel: Estimate the HSK level (1-6) based on the word's complexity. Use 1 for very basic words, 3-4 for intermediate, 5-6 for advanced. If unsure, use 3.
- partOfSpeech: Use one of: "noun", "verb", "adjective", "adverb", "pronoun", "preposition", "conjunction", "particle", "measure word", "idiom", "phrase". For multi-word phrases use "phrase". For chengyu (idioms) use "idiom".
''';

    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'generate_deck', success: true);
        if (json is List) {
          return json.map((item) => {
            'hanzi': item['hanzi'].toString(),
            'pinyin': item['pinyin'].toString(),
            'english': item['english'].toString(),
            'hskLevel': (item['hskLevel'] as num?)?.toInt().toString() ?? '3',
            'partOfSpeech': item['partOfSpeech']?.toString() ?? '',
          }).toList();
        }
      }
      throw Exception("Empty response from OpenRouter");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'generate_deck', success: false);
      rethrow;
    }
  }

  Future<List<Map<String, String>>> generateContextualCards({
    required String deckTopic,
    required String contextTone,
    required int count,
    required List<String> existingHanzi,
    required List<String> existingPinyin,
  }) async {
    final existingPairs = List.generate(existingHanzi.length, (i) {
      final pinyin = i < existingPinyin.length ? existingPinyin[i] : '';
      return '${existingHanzi[i]} ($pinyin)';
    }).join(', ');

    final prompt = '''
You are an expert Chinese teacher. The student wants to add NEW vocabulary to their existing flashcard deck.

EXISTING DECK TOPIC: "$deckTopic"
CONTEXT/TONE: ${contextTone.isEmpty ? "Standard" : contextTone}
EXISTING WORDS (${existingHanzi.length} total): [$existingPairs]

The student already has the above words. Please generate exactly $count NEW Chinese words or short phrases that:
1. Are RELATED to the same theme or context as the existing deck
2. Are at a SIMILAR difficulty level as the existing words
3. Do NOT overlap with or duplicate any of the existing words
4. Are natural, useful, and commonly used

Respond ONLY in valid JSON format as a list of objects with this exact structure.
CRITICAL: Put the $targetLanguage translation in the "english" JSON key!
[
  {
    "hanzi": "公司",
    "pinyin": "gōng sī",
    "english": "$targetLanguage translation (e.g., company)",
    "hskLevel": 3,
    "partOfSpeech": "noun"
  }
]

IMPORTANT RULES for hskLevel and partOfSpeech:
- hskLevel: Estimate the HSK level (1-6) based on the word's complexity. Use 1 for very basic words, 3-4 for intermediate, 5-6 for advanced. If unsure, use 3.
- partOfSpeech: Use one of: "noun", "verb", "adjective", "adverb", "pronoun", "preposition", "conjunction", "particle", "measure word", "idiom", "phrase". For multi-word phrases use "phrase". For chengyu (idioms) use "idiom".
''';

    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );

      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'add_to_deck', success: true);
        if (json is List) {
          return json.map((item) => {
            'hanzi': item['hanzi'].toString(),
            'pinyin': item['pinyin'].toString(),
            'english': item['english'].toString(),
            'hskLevel': (item['hskLevel'] as num?)?.toInt().toString() ?? '3',
            'partOfSpeech': item['partOfSpeech']?.toString() ?? '',
          }).toList();
        }
      }
      throw Exception("Empty response from OpenRouter");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'add_to_deck', success: false);
      rethrow;
    }
  }

  Future<AiStory> generateStory(String deckId, String deckName, List<String> vocabulary, {bool forceRegenerate = false}) async {
    final cacheKey = 'story_$deckId';
    final box = Hive.box<String>('ai_cache');
    
    if (!forceRegenerate && box.containsKey(cacheKey)) {
      final json = jsonDecode(box.get(cacheKey)!);
      if (json is Map<String, dynamic> && json.containsKey('sentences')) {
        return AiStory.fromJson(json);
      }
    }

    final wordsList = vocabulary.join(", ");
    final prompt = '''
You are a professional Chinese language teacher creating Graded Readers.
Write a substantial, engaging story (8-12 sentences) using primarily the following vocabulary words:
$wordsList

The story should feel like a complete narrative with a beginning, middle, and end. 
Maintain a "Zen & Ink" tone: professional, calm, and culturally rich.

Respond ONLY in valid JSON format with this exact structure:
CRITICAL: Put the $targetLanguage translation in the "english" JSON key!
{
  "sentences": [
    {
      "chinese": "The full sentence in Chinese...",
      "english": "The $targetLanguage translation of the sentence...",
      "words": [
        {
           "hanzi": "The word or character in Chinese",
           "pinyin": "The pinyin for this specific word",
           "meaning": "The contextual $targetLanguage meaning of this word"
        }
      ]
    }
  ]
}

Make sure every single character in the 'chinese' sentence is represented in the 'words' array in order! If a word is multiple characters, group them into one object.
''';

    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        box.put(cacheKey, cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'generate_story', success: true);
        return AiStory.fromJson(json);
      }
      throw Exception("Empty response from OpenRouter");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'generate_story', success: false);
      rethrow;
    }
  }

  Future<String> translateTextToEnglish(String sourceText) async {
    final prompt = '''
You are a professional translator.
Translate the following Chinese text into a natural, accurate $targetLanguage translation.
Keep the original paragraph structure and tone intact.

Source Text:
"""
$sourceText
"""

Respond ONLY with the translated text. Do not add any conversational filler, markdown formatting blocks, or explanations.
''';

    try {
      final text = await generateText(prompt);
      analytics.logApiUsage(apiName: 'openrouter', feature: 'translate_article', success: true);
      return text;
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'translate_article', success: false);
      rethrow;
    }
  }

  Future<AiStory> generateGradedStory(String topic, String category, int hskLevel) async {
    final prompt = '''
You are a professional Chinese language professor creating Graded Readers.
Write an engaging, culturally accurate story or article about "$topic" (Category: $category).
CRITICAL: You MUST restrict your vocabulary entirely to the HSK $hskLevel word list. Keep it under 1000 words.

Respond ONLY in valid JSON format with this exact structure. DO NOT CUT OFF mid-generation. Ensure the JSON is complete and valid:
CRITICAL: Put the $targetLanguage translation in the "english" JSON key!
{
  "sentences": [
    {
      "chinese": "The full sentence in Chinese...",
      "english": "The $targetLanguage translation of the sentence...",
      "words": [
        {
           "hanzi": "The word or character in Chinese",
           "pinyin": "The pinyin for this specific word",
           "meaning": "The contextual $targetLanguage meaning of this word"
        }
      ]
    }
  ]
}

Make sure every single character in the 'chinese' sentence is represented in the 'words' array in order! If a word is multiple characters, group them into one object.
''';

    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'generate_graded_story', success: true);
        return AiStory.fromJson(json);
      }
      throw Exception("Empty response from DeepSeek API");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'generate_graded_story', success: false);
      rethrow;
    }
  }

  Future<AiStory> parseRawStoryToAiStory(String rawChineseText, int hskLevel, {String? englishTranslation}) async {
    String englishInstruction = englishTranslation != null && englishTranslation.isNotEmpty
        ? 'Here is the English translation for the story:\n"$englishTranslation"\n\nCRITICAL: You MUST use this provided translation to guide your sentence-by-sentence translation. Match your sentence translations to this provided meaning.'
        : 'CRITICAL: Put the English translation in the "english" JSON key!';

    final prompt = '''
I have the following Chinese story. Parse it into an array of sentences, each broken down into words, with pinyin and English definitions.
Ensure that the vocabulary targets HSK level $hskLevel as a guideline for meanings.
$englishInstruction

Story:
$rawChineseText

Respond ONLY with a valid JSON document matching this exact structure:
{
  "sentences": [
    {
      "english": "English translation of the entire sentence",
      "words": [
        {
          "hanzi": "Hanzi word",
          "pinyin": "pinyin with tone marks",
          "english": "definition in English",
          "hskLevel": 1
        }
      ]
    }
  ]
}
''';

    try {
      final text = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      
      final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                            .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
      final json = jsonDecode(cleanText);
      return AiStory.fromJson(json);
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'parse_raw_story', success: false);
      rethrow;
    }
  }

  Stream<String> streamGradedStoryRawText(String topic, String category, int hskLevel, {List<String>? dueWords, List<String>? masteredWords, List<String>? strugglingWords}) async* {
    String focusInstructions = "";
    if (dueWords != null && dueWords.isNotEmpty) {
      focusInstructions += "\nCRITICAL: Try to include these specific words naturally: ${dueWords.join(', ')}";
    }
    if (strugglingWords != null && strugglingWords.isNotEmpty) {
      focusInstructions += "\nCRITICAL: The user struggles with these words, include them for practice: ${strugglingWords.join(', ')}";
    }
    if (masteredWords != null && masteredWords.isNotEmpty) {
      focusInstructions += "\nNote: The user already knows these words well, avoid overusing them: ${masteredWords.join(', ')}";
    }

    final prompt = '''
You are a Chinese learning assistant. Write a Chinese story (5-8 paragraphs) about "$topic" in the "$category" category.
CRITICAL INSTRUCTION: The story MUST be written strictly using HSK level $hskLevel vocabulary and grammar. Do not use advanced vocabulary.
$focusInstructions
Keep it under 800 words.
Respond ONLY with the Chinese text. Do not include pinyin or translations. Do not include any formatting or introductions. Just the raw Chinese characters.
''';
    yield* streamOpenRouterText(prompt);
  }

  Future<AiStory> simplifyTextToHsk(String sourceText, int hskLevel) async {
    final prompt = '''
You are an expert Chinese teacher and translator.
The user has provided a complex text. Rewrite and simplify the entire meaning of the text so that it strictly only uses HSK $hskLevel vocabulary. 
Keep the core narrative and main ideas intact, but adjust the grammar and vocabulary to fit the target level.

Source Text:
"""
$sourceText
"""

Respond ONLY in valid JSON format with this exact structure:
CRITICAL: Put the $targetLanguage translation in the "english" JSON key!
{
  "sentences": [
    {
      "chinese": "The full simplified sentence in Chinese...",
      "english": "The $targetLanguage translation of the sentence...",
      "words": [
        {
           "hanzi": "The word or character in Chinese",
           "pinyin": "The pinyin for this specific word",
           "meaning": "The contextual $targetLanguage meaning of this word"
        }
      ]
    }
  ]
}

Make sure every single character in the 'chinese' sentence is represented in the 'words' array in order! If a word is multiple characters, group them into one object.
''';

    try {
      final text = await makeOpenRouterCall(
        model: 'deepseek/deepseek-chat',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final json = jsonDecode(cleanText);
        analytics.logApiUsage(apiName: 'openrouter', feature: 'simplify_text', success: true);
        return AiStory.fromJson(json);
      }
      throw Exception("Empty response from DeepSeek API");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'simplify_text', success: false);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> generateCulturalMemes(List<String> transcriptLines) async {
    final transcriptText = transcriptLines.asMap().entries.map((e) => "[Line ${e.key}] ${e.value}").join("\n");
    final prompt = '''
You are a Chinese cultural expert. Analyze the following transcript from a video.
Identify any culturally significant idioms (成语), modern internet slang, or deep cultural references.
For each one you find, provide the line number where it appeared, the keyword itself, and a short explanation in $targetLanguage.
Do NOT include basic vocabulary. Only include things that need cultural context or slang knowledge to understand.

Transcript:
"""
$transcriptText
"""

Respond ONLY in valid JSON format with this exact structure:
[
  {
    "line_index": 12,
    "keyword": "躺平",
    "explanation": "Lying flat: A cultural movement..."
  }
]
''';
    try {
      final text = await makeOpenRouterCall(
        model: 'deepseek/deepseek-chat',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final List<dynamic> json = jsonDecode(cleanText);
        return json.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Map<int, String>> simplifyTranscriptToHsk(List<String> transcriptLines, int hskLevel) async {
    final transcriptText = transcriptLines.asMap().entries.map((e) => "[${e.key}] ${e.value}").join("\n");
    final prompt = '''
You are a Chinese teacher. Simplify the following transcript lines to strict HSK $hskLevel vocabulary.
Keep the exact same number of lines. Output a JSON map where the key is the line index and the value is the simplified Chinese string.

Transcript:
"""
$transcriptText
"""

Respond ONLY in valid JSON format like:
{
  "0": "simplified line 0",
  "1": "simplified line 1"
}
''';
    try {
      final text = await makeOpenRouterCall(
        model: 'deepseek/deepseek-chat',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: true,
      );
      if (text.isNotEmpty) {
        final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                              .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        final Map<String, dynamic> json = jsonDecode(cleanText);
        return json.map((key, value) => MapEntry(int.parse(key), value.toString()));
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  AiChatSession startCharacterChat(String hanzi, String languageCode) {
    final systemInstruction = 'You are a concise Chinese Calligraphy and Etymology tutor inside a mobile flashcard app. '
        'The student is studying the character "$hanzi". '
        'RULES: Answer in 2–3 sentences max. Prefer bullet points for lists. '
        'Never write introductions, sign-offs, or filler phrases like "Great question!" or "Certainly!". '
        'Use **bold** for Chinese characters and key terms. '
        'Be direct and informative. '
        'CRITICAL RULE: You must respond ENTIRELY in the language corresponding to ISO 639-1 code "$languageCode" (except for the Chinese terms).';
        
    return AiChatSession(
      apiKey: pool.nextKey,
      systemInstruction: systemInstruction,
      model: 'deepseek/deepseek-chat',
    );
  }

  AiChatSession startGrammarChat(String word, String sentence, String languageCode) {
    final systemInstruction = 'You are a concise Chinese Grammar tutor inside a mobile app. '
        'The student is confused about the word "$word" in the sentence: "$sentence". '
        'RULES: Answer in 2–3 sentences max. '
        'Never write introductions, sign-offs, or filler phrases. '
        'Use **bold** for Chinese characters and key terms. '
        'Be direct and informative. '
        'CRITICAL RULE: You must respond ENTIRELY in the language corresponding to ISO 639-1 code "$languageCode" (except for the Chinese terms).';
        
    return AiChatSession(
      apiKey: pool.nextKey,
      systemInstruction: systemInstruction,
      model: 'deepseek/deepseek-chat',
    );
  }

  Future<Map<String, dynamic>> gradeAudio(List<int> audioBytes, String expectedChinese, String expectedPinyin) async {
    final key = pool.azureSpeechKey;
    final region = pool.azureSpeechRegion;

    if (key == 'MISSING_KEY' || region == 'MISSING_REGION') {
      throw Exception("Azure Speech API keys are missing.");
    }

    // Azure Pronunciation Assessment parameters
    // Strip punctuation to prevent Azure Speech API matching failures (especially for Chinese punctuation)
    final cleanReference = expectedChinese.replaceAll(RegExp(r'[^\p{Script=Hani}a-zA-Z0-9 ]', unicode: true), '');
    
    final Map<String, dynamic> params = {
      "ReferenceText": (cleanReference.isEmpty ? expectedChinese : cleanReference).trim(),
      "GradingSystem": "HundredMark",
      "Granularity": "Phoneme",
      "Dimension": "Comprehensive"
    };

    final String jsonParams = jsonEncode(params);
    final String base64Params = base64Encode(utf8.encode(jsonParams));

    final String endpoint = 'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=zh-CN';

    final request = http.Request('POST', Uri.parse(endpoint));
    request.headers.addAll({
      'Ocp-Apim-Subscription-Key': key,
      'Content-Type': 'audio/wav; codecs=audio/pcm; samplerate=16000',
      'Accept': 'application/json',
      'Pronunciation-Assessment': base64Params,
    });
    List<int> finalAudioBytes = audioBytes;
    if (audioBytes.length > 4 && !(audioBytes[0] == 82 && audioBytes[1] == 73 && audioBytes[2] == 70 && audioBytes[3] == 70)) {
      final byteCount = audioBytes.length;
      final wavHeader = <int>[
        82, 73, 70, 70, 
        (36 + byteCount) & 0xff, ((36 + byteCount) >> 8) & 0xff, ((36 + byteCount) >> 16) & 0xff, ((36 + byteCount) >> 24) & 0xff,
        87, 65, 86, 69, 
        102, 109, 116, 32, 
        16, 0, 0, 0, 
        1, 0, 
        1, 0, 
        128, 62, 0, 0, 
        0, 125, 0, 0, 
        2, 0, 
        16, 0, 
        100, 97, 116, 97, 
        byteCount & 0xff, (byteCount >> 8) & 0xff, (byteCount >> 16) & 0xff, (byteCount >> 24) & 0xff,
      ];
      finalAudioBytes = List<int>.from(wavHeader)..addAll(audioBytes);
    }
    
    request.bodyBytes = finalAudioBytes;

    try {
      final response = await http.Client().send(request).timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);

        final status = data['RecognitionStatus'];
        if (status != 'Success') {
          if (status == 'NoMatch' || status == 'InitialSilenceTimeout') {
            throw Exception("We couldn't hear you clearly. Please try again.");
          } else {
            throw Exception("Recognition failed: $status");
          }
        }

        // Map Azure response to our UI's expected format
        if (data['NBest'] == null || data['NBest'].isEmpty) {
          throw Exception("No NBest result found.");
        }
        
        final bestResult = data['NBest'][0];
        final assessment = bestResult['PronunciationAssessment'];
        
        final pronScore = (assessment?['PronScore'] as num?)?.toInt() ?? (bestResult['PronunciationScore'] as num?)?.toInt() ?? 0;
        final accuracyScore = (assessment?['AccuracyScore'] as num?)?.toInt() ?? (bestResult['AccuracyScore'] as num?)?.toInt() ?? 0;
        final completenessScore = (assessment?['CompletenessScore'] as num?)?.toInt() ?? (bestResult['CompletenessScore'] as num?)?.toInt() ?? 0;
        final fluencyScore = (assessment?['FluencyScore'] as num?)?.toInt() ?? (bestResult['FluencyScore'] as num?)?.toInt() ?? 0;

        List<Map<String, dynamic>> mappedWords = [];

        if (bestResult['Words'] != null) {
          for (var w in bestResult['Words']) {
            final wordText = w['Word'];
            final wAccuracy = w['PronunciationAssessment']?['AccuracyScore'] ?? w['AccuracyScore'] ?? 0;
            final wErrorType = w['PronunciationAssessment']?['ErrorType'] ?? w['ErrorType'] ?? 'None';
            
            bool isCorrect = wAccuracy >= 80 && wErrorType == 'None';
            bool isPartial = wAccuracy >= 60 && wAccuracy < 80;
            if (wErrorType != 'None') {
                isCorrect = false;
                isPartial = false;
            }

            String feedback = "";
            if (wErrorType == 'Omission') feedback = "You missed this word.";
            else if (wErrorType == 'Insertion') feedback = "Extra word added here.";
            else if (wErrorType == 'Mispronunciation') feedback = "Pronunciation was inaccurate. Score: ${wAccuracy.toStringAsFixed(0)}";

            mappedWords.add({
              "word": wordText,
              "pinyin": "", // UI gracefully handles empty pinyin
              "isCorrect": isCorrect,
              "isPartial": isPartial,
              "feedback": feedback
            });
          }
        }

        String overallFeedback = "Good effort! Keep practicing.";
        if (pronScore >= 90) overallFeedback = "Perfect pronunciation! Sounds like a native speaker.";
        else if (pronScore >= 80) overallFeedback = "Great job! A few minor tone inaccuracies.";
        else if (pronScore >= 60) overallFeedback = "Not bad, but your tones need some work.";
        else overallFeedback = "Keep practicing! Listen to the native audio and try again.";

        analytics.logApiUsage(apiName: 'azure_speech', feature: 'grade_audio', success: true);
        return {
          "score": pronScore,
          "accuracy": accuracyScore,
          "completeness": completenessScore,
          "fluency": fluencyScore,
          "overallFeedback": overallFeedback,
          "words": mappedWords
        };
      } else {
        throw Exception("Azure Error ${response.statusCode}: $responseBody");
      }
    } catch (e) {
      throw Exception("Grading failed: $e");
    }
  }

  Future<Map<String, dynamic>> gradeAudioUnscripted(List<int> audioBytes) async {
    final key = pool.azureSpeechKey;
    final region = pool.azureSpeechRegion;

    if (key == 'MISSING_KEY' || region == 'MISSING_REGION') {
      throw Exception("Azure Speech API keys are missing.");
    }

    // Azure Pronunciation Assessment parameters for UNSCRIPTED
    final Map<String, dynamic> params = {
      "ReferenceText": "", // Empty reference text triggers unscripted assessment
      "GradingSystem": "HundredMark",
      "Granularity": "Phoneme",
      "Dimension": "Comprehensive"
    };

    final String jsonParams = jsonEncode(params);
    final String base64Params = base64Encode(utf8.encode(jsonParams));

    final String endpoint = 'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=zh-CN';

    final request = http.Request('POST', Uri.parse(endpoint));
    request.headers.addAll({
      'Ocp-Apim-Subscription-Key': key,
      'Content-Type': 'audio/wav; codecs=audio/pcm; samplerate=16000',
      'Accept': 'application/json',
      'Pronunciation-Assessment': base64Params,
    });
    
    List<int> finalBytes = audioBytes;
    if (audioBytes.length > 4 && !(audioBytes[0] == 82 && audioBytes[1] == 73 && audioBytes[2] == 70 && audioBytes[3] == 70)) {
      final byteCount = audioBytes.length;
      final wavHeader = <int>[
        82, 73, 70, 70,
        (36 + byteCount) & 0xff, ((36 + byteCount) >> 8) & 0xff, ((36 + byteCount) >> 16) & 0xff, ((36 + byteCount) >> 24) & 0xff,
        87, 65, 86, 69,
        102, 109, 116, 32,
        16, 0, 0, 0,
        1, 0,
        1, 0,
        128, 62, 0, 0,
        0, 125, 0, 0,
        2, 0,
        16, 0,
        100, 97, 116, 97,
        byteCount & 0xff, (byteCount >> 8) & 0xff, (byteCount >> 16) & 0xff, (byteCount >> 24) & 0xff,
      ];
      finalBytes = List<int>.from(wavHeader)..addAll(audioBytes);
    }
    
    request.bodyBytes = finalBytes;

    try {
      final response = await http.Client().send(request)
          .timeout(const Duration(seconds: 15));
      final responseBody = await response.stream.bytesToString()
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);

        final status = data['RecognitionStatus'];
        if (status != 'Success') {
          if (status == 'NoMatch' || status == 'InitialSilenceTimeout') {
            throw Exception("We couldn't hear you clearly. Please try again.");
          } else {
            throw Exception("Recognition failed: $status");
          }
        }

        if (data['NBest'] == null || data['NBest'].isEmpty) {
          throw Exception("No NBest result found.");
        }
        
        final bestResult = data['NBest'][0];
        final transcribedText = bestResult['Lexical'] ?? '';
        final pronScore = (bestResult['PronunciationScore'] as num?)?.toInt() ?? 0;
        final accuracyScore = (bestResult['AccuracyScore'] as num?)?.toInt() ?? 0;
        final completenessScore = (bestResult['CompletenessScore'] as num?)?.toInt() ?? 0;
        final fluencyScore = (bestResult['FluencyScore'] as num?)?.toInt() ?? 0;

        List<Map<String, dynamic>> mappedWords = [];

        if (bestResult['Words'] != null) {
          for (var w in bestResult['Words']) {
            final wordText = w['Word'];
            final wAccuracy = w['PronunciationAssessment']?['AccuracyScore'] ?? 0;
            final wErrorType = w['PronunciationAssessment']?['ErrorType'] ?? 'None';
            
            bool isCorrect = wAccuracy >= 80 && wErrorType == 'None';
            bool isPartial = wAccuracy >= 60 && wAccuracy < 80;
            if (wErrorType != 'None') {
                isCorrect = false;
                isPartial = false;
            }

            String feedback = "";
            if (wErrorType == 'Omission') feedback = "You missed this word.";
            else if (wErrorType == 'Insertion') feedback = "Extra word added here.";
            else if (wErrorType == 'Mispronunciation') feedback = "Pronunciation was inaccurate. Score: ${wAccuracy.toStringAsFixed(0)}";

            mappedWords.add({
              "word": wordText,
              "pinyin": "", 
              "isCorrect": isCorrect,
              "isPartial": isPartial,
              "feedback": feedback
            });
          }
        }

        analytics.logApiUsage(apiName: 'azure_speech', feature: 'grade_audio_unscripted', success: true);
        return {
          "text": transcribedText,
          "score": pronScore,
          "accuracy": accuracyScore,
          "completeness": completenessScore,
          "fluency": fluencyScore,
          "words": mappedWords
        };
      } else {
        throw Exception("Azure Error ${response.statusCode}: $responseBody");
      }
    } catch (e) {
      analytics.logApiUsage(apiName: 'azure_speech', feature: 'grade_audio_unscripted', success: false);
      rethrow;
    }
  }

  Future<List<AiWord>> generatePreFlightVocab(String articleText, List<String> knownWords, String languageCode) async {
    final textContent = articleText.length > 4000 ? articleText.substring(0, 4000) : articleText;
    final knownWordsList = knownWords.join(', ');

    final prompt = '''
You are a Chinese learning assistant helping a student prepare to read an article.
Analyze the following article text and identify 15 to 20 important, thematic Chinese words that the student NEEDS to know to fully understand the subject of this article.
CRITICAL: Do NOT include any of these words, as the student already knows them: [$knownWordsList]

Article Text:
"$textContent"

Return ONLY a valid JSON array of word objects:
[
  {"hanzi": "word", "pinyin": "pinyin", "meaning": "Meaning in the language corresponding to ISO 639-1 code $languageCode"}
]
''';

    final text = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: true,
    );

    final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '').replaceAll(RegExp(r'^```\n?', multiLine: true), '');
    final List<dynamic> jsonArr = jsonDecode(cleanText);
    return jsonArr.map((i) => AiWord.fromJson(i as Map<String, dynamic>)).toList();
  }

  Future<List<AiWord>> extractAllUnknownWords(String articleText, List<String> knownWords, String languageCode) async {
    final textContent = articleText.length > 4000 ? articleText.substring(0, 4000) : articleText;
    final knownWordsList = knownWords.join(', ');

    final prompt = '''
You are a Chinese learning assistant.
Analyze the following article text. Extract ALL the important Chinese words (up to 25 words) that are NOT in the student's known words list.
CRITICAL: Do NOT include any of these words: [$knownWordsList]

Article Text:
"$textContent"

Return ONLY a valid JSON object matching this structure:
{
  "words": [
    {"hanzi": "word", "pinyin": "pinyin", "meaning": "Meaning in the language corresponding to ISO 639-1 code $languageCode"}
  ]
}
''';

    final text = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: true,
    );

    final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '').replaceAll(RegExp(r'^```\n?', multiLine: true), '');
    final Map<String, dynamic> jsonObj = jsonDecode(cleanText);
    final List<dynamic> wordsArr = jsonObj['words'] ?? [];
    
    return wordsArr.map((i) => AiWord.fromJson(i as Map<String, dynamic>)).toList();
  }

  Future<List<TranscriptLine>> translateTranscriptLines(List<TranscriptLine> lines) async {
    if (lines.isEmpty) return lines;

    // Detect if the text is Pinyin-based (Latin chars with diacritics) so we can store it.
    final isPinyinBased = !lines.any((l) => RegExp(r'[\u4e00-\u9fff]').hasMatch(l.text));

    // Process in chunks of 20 to avoid LLM token limits and parse failures.
    const chunkSize = 20;
    final result = <TranscriptLine>[];

    for (int start = 0; start < lines.length; start += chunkSize) {
      final end = (start + chunkSize).clamp(0, lines.length);
      final chunk = lines.sublist(start, end);

      try {
        final chunkText = chunk.asMap().entries.map((e) => '${e.key + 1}. ${e.value.text}').join('\n');
        final prompt = '''
You are a Chinese learning assistant.
I will give you ${chunk.length} video transcript lines.
If these lines are in Pinyin (Latin alphabet), convert them to standard Chinese Hanzi characters for the "hanzi" field.
If they are already in Hanzi, keep them as-is.
Translate each line to "$targetLanguage" for the "translation" field.

CRITICAL: Return EXACTLY ${chunk.length} objects in the array — one per input line. No skipping.

Input:
$chunkText

Return ONLY a valid JSON array:
[
  { "hanzi": "Chinese Hanzi here", "translation": "Translation in $targetLanguage" }
]''';

        final response = await makeOpenRouterCall(
          model: 'google/gemini-2.5-flash',
          messages: [{'role': 'user', 'content': prompt}],
          jsonMode: true,
        );

        final cleanText = response
            .replaceAll(RegExp(r'^```json\n', multiLine: true), '')
            .replaceAll(RegExp(r'^```\n?', multiLine: true), '')
            .trim();

        final List<dynamic> jsonArr = jsonDecode(cleanText);

        for (int i = 0; i < chunk.length; i++) {
          String hanzi = chunk[i].text;
          String? translation;

          if (i < jsonArr.length) {
            final item = jsonArr[i];
            if (item is Map) {
              hanzi = item['hanzi']?.toString() ?? chunk[i].text;
              translation = item['translation']?.toString();
            }
          }

          // Store original Pinyin in the pinyin field if we detected pinyin-based input
          final pinyinValue = isPinyinBased ? chunk[i].text : chunk[i].pinyin;

          result.add(TranscriptLine(
            text: hanzi,
            pinyin: pinyinValue,
            start: chunk[i].start,
            duration: chunk[i].duration,
            translation: translation,
          ));
        }
      } catch (e) {
        debugPrint('Error translating chunk $start-${start + chunkSize}: $e');
        // Fallback: keep originals for this chunk
        for (final line in chunk) {
          result.add(TranscriptLine(
            text: line.text,
            pinyin: isPinyinBased ? line.text : line.pinyin,
            start: line.start,
            duration: line.duration,
            translation: null,
          ));
        }
      }
    }

    return result;
  }

  /// Translates a single chunk of transcript lines (Pinyin → Hanzi + localized translation).
  /// Called incrementally by the screen to progressively update the UI.
  Future<List<TranscriptLine>> translateChunk(List<TranscriptLine> chunk, {String? language}) async {
    if (chunk.isEmpty) return chunk;

    final isPinyinBased = !chunk.any((l) => RegExp(r'[\u4e00-\u9fff]').hasMatch(l.text));

    final chunkText = chunk.asMap().entries
        .map((e) => '${e.key + 1}. ${e.value.text}')
        .join('\n');

    final prompt = '''
You are a Chinese learning assistant.
I will give you ${chunk.length} video transcript lines.
If these lines are in Pinyin (Latin alphabet with tone marks), convert them to standard Chinese Hanzi characters for the "hanzi" field.
If they are already in Hanzi, keep them as-is.
Translate each line to "${language ?? targetLanguage}" for the "translation" field.

CRITICAL: Return EXACTLY ${chunk.length} objects in the array — one per input line. No skipping.

Input:
$chunkText

Return ONLY a valid JSON array:
[
  { "hanzi": "Chinese Hanzi here", "translation": "Translation in ${language ?? targetLanguage}" }
]''';

    final response = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: true,
    );

    final cleanText = response
        .replaceAll(RegExp(r'^```json\n', multiLine: true), '')
        .replaceAll(RegExp(r'^```\n?', multiLine: true), '')
        .trim();

    final List<dynamic> jsonArr = jsonDecode(cleanText);
    final result = <TranscriptLine>[];

    for (int i = 0; i < chunk.length; i++) {
      String hanzi = chunk[i].text;
      String? translation;

      if (i < jsonArr.length) {
        final item = jsonArr[i];
        if (item is Map) {
          hanzi = item['hanzi']?.toString() ?? chunk[i].text;
          translation = item['translation']?.toString();
        }
      }

      result.add(TranscriptLine(
        text: hanzi,
        pinyin: isPinyinBased ? chunk[i].text : chunk[i].pinyin,
        start: chunk[i].start,
        duration: chunk[i].duration,
        translation: translation,
      ));
    }

    return result;
  }

 Future<MediaBriefing> generateVideoBriefing(String title, List<TranscriptLine> lines) async {
    final text = lines.map((l) => l.text).join('\n');
    final prompt = '''
You are a Chinese learning assistant. Create a briefing for a video titled "$title".
Transcript:
$text

Output JSON matching MediaBriefing format:
{
  "summary": "A short summary in English",
  "hardWords": ["HardWord1", "HardWord2"]
}
    ''';
    final response = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: true,
    );
    final cleanText = response.replaceAll(RegExp(r'^```json\n', multiLine: true), '').replaceAll(RegExp(r'^```\n?', multiLine: true), '');
    return MediaBriefing.fromJson(jsonDecode(cleanText));
  }

  Future<AiSentence> generateSentenceLesson(String sentence) async {
    final prompt = '''
You are a Chinese learning assistant. Analyze this sentence: "$sentence".
Output JSON matching this exact structure:
{
  "chinese": "$sentence",
  "english": "english translation",
  "words": [
    { "hanzi": "word1", "pinyin": "pinyin1", "meaning": "meaning1" },
    { "hanzi": "word2", "pinyin": "pinyin2", "meaning": "meaning2" }
  ]
}
    ''';
    final response = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: true,
    );
    final cleanText = response.replaceAll(RegExp(r'^```json\n', multiLine: true), '').replaceAll(RegExp(r'^```\n?', multiLine: true), '');
    return AiSentence.fromJson(jsonDecode(cleanText));
  }
  Future<String> explainInContext(String hanzi, String contextText) async {
    final prompt = '''
You are a Chinese learning assistant. A student encountered the word "$hanzi" in the following context:
"$contextText"

Explain the meaning of "$hanzi" specifically in this context. Keep the explanation concise (2-3 sentences max) and helpful for a learner.
''';

    final text = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: false,
    );

    return text.trim();
  }

  Future<ArticleInsight> generateArticleInsight(String text, List<String> knownWords, String languageCode) async {
    final prompt = '''
You are a Chinese learning assistant. Analyze the following Chinese article for a language learner.
The learner knows these words (or a subset of them): ${knownWords.take(500).join(", ")}.

Provide an insight containing:
1. "summary": A quick 2-3 sentence summary of the article in the language corresponding to ISO 639-1 code $languageCode.
2. "score": A rating out of 100 on how readable this is for the learner based on their known words. (0 = impossible, 100 = they know every word).
3. "hskLevel": The estimated HSK level (1-9) required to comfortably read this text.

Article text:
"""
${text.substring(0, math.min(text.length, 3000))}
"""

Output JSON matching this exact structure:
{
  "summary": "Summary in language $languageCode...",
  "score": 85,
  "hskLevel": 4
}
''';

    final response = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: true,
    );

    final cleanText = response.replaceAll(RegExp(r'^```json\n', multiLine: true), '').replaceAll(RegExp(r'^```\n?', multiLine: true), '');
    return ArticleInsight.fromJson(jsonDecode(cleanText));
  }

  Future<Map<String, dynamic>> extractVocabularyFromScan(String text) async {
    final prompt = '''
You are a Chinese learning assistant. A user has scanned some text from the real world (like a menu, a sign, or a book page) using OCR.

Extracted OCR Text:
"""
${text.substring(0, math.min(text.length, 3000))}
"""

Your task is to:
1. Check if the text is complete garbage (e.g. random English letters, OCR errors, no coherent Chinese meaning). If it is garbage, output "No coherent Chinese text found in the scan." as the fullTranslation and leave the words array empty.
2. If it is valid Chinese, provide a smooth, full English translation of the entire scanned text so the user understands the full context.
3. Extract the most important Chinese vocabulary (words, phrases, idioms) from the text. 
   - Group them into logical words (e.g. don't split idioms into 4 separate characters).
   - Provide the pinyin, english definition, and estimated HSK level (1-9).
   - Only include up to 20 of the most relevant/useful words.

Output JSON matching this exact structure:
{
  "fullTranslation": "The full English translation of the scanned text... OR 'No coherent Chinese text found.'",
  "deckName": "A short 2-4 word title for this scan (e.g. 'Restaurant Menu', 'Street Sign')",
  "words": [
    {
      "hanzi": "中国",
      "pinyin": "Zhōngguó",
      "meaning": "China",
      "hskLevel": 1
    }
  ]
}
''';

    final response = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
      jsonMode: true,
    );

    final cleanText = response.replaceAll(RegExp(r'^```json\n', multiLine: true), '').replaceAll(RegExp(r'^```\n?', multiLine: true), '');
    final json = jsonDecode(cleanText);
    
    final words = (json['words'] as List<dynamic>).map((w) => AiWord.fromJson(w as Map<String, dynamic>)).toList();
    
    return {
      'fullTranslation': json['fullTranslation'] as String? ?? 'No translation available.',
      'deckName': json['deckName'] as String? ?? 'Scan Results',
      'words': words,
    };
  }

  Future<String> generateDetailedSummary(String title, String fullText, String targetLanguage) async {
    final cacheKey = 'detailed_summary_$title';
    final box = Hive.box<String>('ai_cache');
    if (box.containsKey(cacheKey)) {
      try {
        final cached = box.get(cacheKey)!;
        if (cached.length > 100) return cached;
      } catch (_) {}
    }

    final prompt = '''
You are a Chinese classical literature expert. The user is about to read this classical Chinese poem:

Title: "$title"

Full text:
$fullText

Write a detailed, engaging 3-4 paragraph summary in $targetLanguage about this poem. Cover:
- Historical context: when and why it was written
- Literary analysis: themes, imagery, and artistic techniques
- Cultural significance: why this poem matters in Chinese literary tradition
- Key references or allusions in the text explained briefly

Make it informative yet accessible to a Chinese language learner.
Return ONLY the summary text, no markdown formatting, no JSON, no backticks.
''';

    try {
      final responseText = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {'role': 'system', 'content': 'You are a Chinese classical literature expert providing detailed accessible summaries of classical Chinese poetry.'},
          {'role': 'user', 'content': prompt}
        ],
      );
      if (responseText.length > 100) {
        box.put(cacheKey, responseText);
      }
      return responseText;
    } catch (e, st) {
      debugPrint('Error generating detailed summary: $e\n$st');
      return '';
    }
  }

  Future<CulturalInsight> generateCulturalInsight(String storyTitle, String storyContent) async {
    final cacheKey = 'cultural_insight_$storyTitle';
    final box = Hive.box<String>('ai_cache');
    if (box.containsKey(cacheKey)) {
      try {
        final cachedData = jsonDecode(box.get(cacheKey)!);
        if (cachedData is Map<String, dynamic> && cachedData.containsKey('historicalContext')) {
          return CulturalInsight.fromJson(cachedData);
        }
      } catch (e) {
        debugPrint('Cache decode error: $e');
      }
    }

    final prompt = '''
You are a Chinese culture and literature expert. 
The user is about to read the following text/poem: "$storyTitle"
Here is the text content:
$storyContent

Please provide a highly engaging, beautifully written cultural insight. 
Target Language: $targetLanguage

Return ONLY a valid JSON object with EXACTLY these keys:
{
  "historicalContext": "When was it written and what was happening in China at the time?",
  "culturalSignificance": "Why is this piece famous? What philosophical or cultural themes does it explore?",
  "authorBackground": "A brief bio of the author."
}
No markdown formatting, no backticks, just raw JSON.
''';

    try {
      final responseText = await makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {'role': 'system', 'content': 'You are a Chinese culture and literature expert. Provide highly engaging, beautifully written cultural insights.'},
          {'role': 'user', 'content': prompt}
        ],
        jsonMode: true,
      );

      var text = responseText.replaceAll('```json', '').replaceAll('```', '').trim();
      final decoded = jsonDecode(text);
      box.put(cacheKey, jsonEncode(decoded));
      
      return CulturalInsight.fromJson(decoded);
    } catch (e, st) {
      debugPrint('Error generating cultural insight: $e\\n$st');
      return CulturalInsight(
        historicalContext: "Information unavailable.",
        culturalSignificance: "Information unavailable.",
        authorBackground: "Information unavailable.",
      );
    }
  }
}

class ArticleInsight {
  final String summary;
  final int score;
  final int hskLevel;

  ArticleInsight({
    required this.summary,
    required this.score,
    required this.hskLevel,
  });

  factory ArticleInsight.fromJson(Map<String, dynamic> json) {
    return ArticleInsight(
      summary: json['summary'] as String? ?? 'No summary available.',
      score: (json['score'] as num?)?.toInt() ?? 0,
      hskLevel: (json['hskLevel'] as num?)?.toInt() ?? 1,
    );
  }
}