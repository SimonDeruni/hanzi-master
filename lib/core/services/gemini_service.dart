import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hanzi_master/features/media/domain/models/media_briefing.dart';
import 'package:hanzi_master/features/media/domain/models/video_transcript.dart';
import '../../features/flashcards/domain/entities/flashcard.dart';
import 'api_key_pool.dart';
import 'analytics_service.dart';
import '../providers/translation_language_provider.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  final analytics = ref.watch(analyticsServiceProvider);
  final targetLanguage = ref.watch(translationLanguageProvider);
  return GeminiService(pool: pool, analytics: analytics, targetLanguage: targetLanguage);
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

class AiWord {
  final String hanzi;
  final String pinyin;
  final String meaning;
  final String english; // StoryModeScreen uses 'english' in some places
  
  AiWord({required this.hanzi, required this.pinyin, required this.meaning, this.english = ''});
  
  factory AiWord.fromJson(Map<String, dynamic> json) {
    return AiWord(
      hanzi: json['hanzi'] as String? ?? '',
      pinyin: json['pinyin'] as String? ?? '',
      meaning: json['meaning'] as String? ?? '',
      english: json['english'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hanzi': hanzi,
      'pinyin': pinyin,
      'meaning': meaning,
      if (english.isNotEmpty) 'english': english,
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
      Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
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

  GeminiService({required this.pool, required this.analytics, this.targetLanguage = 'English'});

  Future<String> makeOpenRouterCall({
    required String model,
    required List<Map<String, dynamic>> messages,
    bool jsonMode = false,
  }) async {
    final body = {
      'model': model,
      'messages': messages,
    };
    
    if (jsonMode) {
      body['response_format'] = {'type': 'json_object'};
    }

    final response = await http.post(
      Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer ${pool.nextKey}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 90));

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
    final request = http.Request(
      'POST',
      Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
    );
    request.headers.addAll({
      'Authorization': 'Bearer ${pool.nextKey}',
      'Content-Type': 'application/json',
    });
    request.body = jsonEncode({
      'model': 'google/gemini-2.5-flash',
      'messages': [{'role': 'user', 'content': prompt}],
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

  Future<Map<String, String>> defineWord(String word) async {
    final cacheKey = 'def_$word';
    final box = Hive.box<String>('ai_cache');
    
    if (box.containsKey(cacheKey)) {
      final json = jsonDecode(box.get(cacheKey)!);
      return {'pinyin': json['pinyin'].toString(), 'meaning': json['meaning'].toString()};
    }

    final prompt = '''
You are an expert Chinese dictionary. Define the following word/character: "$word".
Provide the meaning in $targetLanguage.
Return ONLY valid JSON with this exact structure:
{
  "pinyin": "...",
  "meaning": "The $targetLanguage meaning here..."
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

  Future<Flashcard> translateObject(String label) async {
    final prompt = '''
Translate the English object label "$label" into Chinese.
Provide:
1. The Chinese character(s) (Hanzi).
2. The Pinyin with tone marks.
3. A concise $targetLanguage definition.

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
    "english": "$targetLanguage translation (e.g., company)"
  }
]
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
          }).toList();
        }
      }
      throw Exception("Empty response from OpenRouter");
    } catch (e) {
      analytics.logApiUsage(apiName: 'openrouter', feature: 'generate_deck', success: false);
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

  Future<AiStory> generateGradedStory(String topic, String category, int hskLevel) async {
    final prompt = '''
You are a professional Chinese language professor creating Graded Readers.
Write an engaging, culturally accurate story or article about "$topic" (Category: $category).
CRITICAL: You MUST restrict your vocabulary entirely to the HSK $hskLevel word list. Keep it under 400 words.

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

  Future<AiStory> parseRawStoryToAiStory(String rawChineseText, int hskLevel) async {
    final prompt = '''
I have the following Chinese story. Parse it into an array of sentences, each broken down into words, with pinyin and English definitions.
Ensure that the vocabulary targets HSK level $hskLevel as a guideline for meanings.
CRITICAL: Put the English translation in the "english" JSON key!

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
You are a Chinese learning assistant. Write a short Chinese story (around 3-5 paragraphs) about "$topic" in the "$category" category.
CRITICAL INSTRUCTION: The story MUST be written strictly using HSK level $hskLevel vocabulary and grammar. Do not use advanced vocabulary.
$focusInstructions
Keep it under 200 words.
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
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: pool.googleKey,
    );

    final String targetContext = expectedChinese.isNotEmpty 
      ? 'Listen to the user trying to say the following phrase:\nHanzi: "$expectedChinese"\nPinyin: "$expectedPinyin"'
      : 'Listen to the user speaking freely in Chinese. Transcribe exactly what they said.';

    final prompt = '''
You are an expert native Chinese teacher. $targetContext

Evaluate their pronunciation using THREE tiers for each character/word:
- isCorrect: true  → Pronunciation and tone are both correct. (GREEN)
- isCorrect: false, isPartial: true  → The base syllable is understandable but the TONE is imprecise or slightly off. (YELLOW)
- isCorrect: false, isPartial: false → The pronunciation or tone is clearly wrong. (RED)

For every word, provide a specific "feedback" string explaining:
- What tone they produced vs what was expected (e.g. "You said 4th tone mào but it should be 4th tone — actually correct!")
- If isCorrect is true, feedback can be empty string "".
- If isPartial or wrong, feedback MUST be specific (e.g. "You said 1st tone māo but it should be 2nd tone máo. Try going up like a question.")

Return ONLY valid JSON with exactly this structure:
{
  "score": 85,
  "accuracy": 82,
  "completeness": 100,
  "fluency": 75,
  "overallFeedback": "Good overall, but watch your third tones.",
  "words": [
    {
      "word": "苹",
      "pinyin": "píng",
      "expectedTone": 2,
      "actualTone": 2,
      "isCorrect": true,
      "isPartial": false,
      "feedback": ""
    },
    {
      "word": "果",
      "pinyin": "guǒ",
      "expectedTone": 3,
      "actualTone": 2,
      "isCorrect": false,
      "isPartial": true,
      "feedback": "Your tone dipped slightly but didn't fully fall-rise. Try exaggerating the dip more for a clear 3rd tone."
    },
    {
      "word": "汁",
      "pinyin": "zhī",
      "expectedTone": 1,
      "actualTone": 4,
      "isCorrect": false,
      "isPartial": false,
      "feedback": "You said a sharp falling 4th tone. This should be a flat high 1st tone — hold it steady and high."
    }
  ]
}
''';

    try {
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('audio/m4a', Uint8List.fromList(audioBytes)),
        ])
      ];
      final response = await model.generateContent(content);
      if (response.text != null && response.text!.isNotEmpty) {
        final cleanText = response.text!.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                                        .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        analytics.logApiUsage(apiName: 'gemini', feature: 'grade_audio', success: true);
        return jsonDecode(cleanText);
      }
      throw Exception("Empty response from Gemini Audio");
    } catch (e) {
      analytics.logApiUsage(apiName: 'gemini', feature: 'grade_audio', success: false);
      rethrow;
    }
  }

  Future<List<AiWord>> generatePreFlightVocab(String articleText, List<String> knownWords) async {
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
  {"hanzi": "word", "pinyin": "pinyin", "meaning": "English meaning in context of the article"}
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

  Future<Map<String, dynamic>> extractAllUnknownWords(String articleText, List<String> knownWords) async {
    final textContent = articleText.length > 4000 ? articleText.substring(0, 4000) : articleText;
    final knownWordsList = knownWords.join(', ');

    final prompt = '''
You are a Chinese learning assistant.
Analyze the following article text. Create a short, descriptive "deckName" based on the subject of the article. Then, extract ALL the important Chinese words (up to 25 words) that are NOT in the student's known words list.
CRITICAL: Do NOT include any of these words: [$knownWordsList]

Article Text:
"$textContent"

Return ONLY a valid JSON object matching this structure:
{
  "deckName": "e.g., Chinese Cooking Basics",
  "words": [
    {"hanzi": "word", "pinyin": "pinyin", "meaning": "English meaning in context"}
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
    
    return {
      "deckName": jsonObj['deckName'] ?? "Extracted Vocabulary",
      "words": wordsArr.map((i) => AiWord.fromJson(i as Map<String, dynamic>)).toList()
    };
  }

  Future<List<TranscriptLine>> translateTranscriptToHanzi(List<TranscriptLine> lines) async {
    final text = lines.map((l) => l.text).join('\n');
    final prompt = '''
You are a Chinese learning assistant. Translate the following video transcript lines into Chinese Hanzi characters. Maintain the exact same number of lines.
Transcript:
$text
    ''';
    final response = await makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: [{'role': 'user', 'content': prompt}],
    );
    final translatedText = response.split('\n');
    final result = <TranscriptLine>[];
    for (int i = 0; i < lines.length; i++) {
      result.add(TranscriptLine(
        text: i < translatedText.length ? translatedText[i] : lines[i].text,
        start: lines[i].start,
        duration: lines[i].duration,
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
}
