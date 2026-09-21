import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:http/http.dart' as http;
import 'api_key_pool.dart';
import '../providers/translation_language_provider.dart';
import '../../features/reading/domain/entities/poetry_story_id.dart';
import '../../features/flashcards/data/repositories/global_dictionary_repository.dart';
import '../providers.dart';

final localTranslationServiceProvider =
    Provider<LocalTranslationService>((ref) {
  final targetLanguage = ref.watch(translationLanguageProvider);
  final apiKeyPool = ref.watch(apiKeyPoolProvider);
  final dictionaryRepo = ref.watch(globalDictionaryRepositoryProvider);
  final service = LocalTranslationService(
    targetLanguage: targetLanguage,
    apiKeyPool: apiKeyPool,
    dictionaryRepository: dictionaryRepo,
  );
  ref.onDispose(() => service.dispose());
  return service;
});

class LocalTranslationService {
  final String targetLanguage;
  final ApiKeyPool? apiKeyPool;
  final GlobalDictionaryRepository? dictionaryRepository;
  // v6 invalidates definitions that may have been generated after an already
  // localized dictionary entry was incorrectly treated as English.
  static const String _boxName = 'local_translations_cache_v6';

  OnDeviceTranslator? _translator;
  OnDeviceTranslator? _englishDefinitionTranslator;
  bool _isModelDownloaded = false;

  LocalTranslationService({
    required this.targetLanguage,
    this.apiKeyPool,
    this.dictionaryRepository,
  });

  static Future<void> init() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        await Hive.box<String>(_boxName).close();
      }
      await Hive.openBox<String>(_boxName);
    } catch (e) {
      debugPrint('Error opening $_boxName: $e. Purging corrupted cache and re-opening.');
      try {
        if (Hive.isBoxOpen(_boxName)) {
          await Hive.box<String>(_boxName).close();
        }
        await Hive.deleteBoxFromDisk(_boxName);
      } catch (_) {}
      try {
        await Hive.openBox<String>(_boxName);
      } catch (e2) {
        debugPrint('Second attempt to open $_boxName failed: $e2');
      }
    }
    try {
      if (Hive.isBoxOpen(_boxName)) {
        await _seedEnglishCache();
      }
    } catch (e) {
      debugPrint('Seeding english cache encountered error: $e');
    }
  }

  static Future<void> _seedEnglishCache() async {
    final box = Hive.box<String>(_boxName);
    await _seedEnglishAsset(
      box,
      marker: '__english_seed_stories_v1__',
      asset: 'assets/data/1000_stories_en.json',
    );
    // Migrate from poetry v1 to v2: the dataset was rebuilt with
    // Traditional Chinese titles and new IDs in b8594f8.
    const poetryV2Marker = '__english_seed_poetry_v2__';
    const poetryV1Marker = '__english_seed_poetry_v1__';
    if (box.containsKey(poetryV1Marker) && !box.containsKey(poetryV2Marker)) {
      // Remove stale v1 entries (they were keyed by Simplified titles).
      final keysToRemove =
          box.keys.where((k) => k.toString().startsWith('English:')).toList();
      for (final k in keysToRemove) {
        await box.delete(k);
      }
    }
    await _seedEnglishAsset(
      box,
      marker: poetryV2Marker,
      asset: chinesePoetryAsset,
    );
    await _seedEnglishAsset(
      box,
      marker: '__english_seed_mandarin_bean_v1__',
      asset: 'assets/data/mandarin_bean_stories.json',
    );
  }

  static Future<void> _seedEnglishAsset(
    Box<String> box, {
    required String marker,
    required String asset,
  }) async {
    if (box.containsKey(marker)) return;
    try {
      final List<dynamic> list =
          json.decode(await rootBundle.loadString(asset));
      for (final data in list) {
        if (data['title'] != null && data['title_en'] != null) {
          box.put('English:${data['title']}', data['title_en']);
        }
        if (data['summary'] != null && data['summary_en'] != null) {
          box.put('English:${data['summary']}', data['summary_en']);
        }
      }
      await box.put(marker, '1');
    } catch (error) {
      debugPrint('Unable to seed translations from $asset: $error');
    }
  }

  Future<void> _ensureModelReady(TranslateLanguage targetLanguageEnum) async {
    if (_isModelDownloaded && _translator != null) return;

    final modelManager = OnDeviceTranslatorModelManager();
    // Chinese model check
    bool isChineseDownloaded =
        await modelManager.isModelDownloaded(TranslateLanguage.chinese.bcpCode);
    if (!isChineseDownloaded) {
      await modelManager.downloadModel(TranslateLanguage.chinese.bcpCode);
    }

    // Target model check
    bool isTargetDownloaded =
        await modelManager.isModelDownloaded(targetLanguageEnum.bcpCode);
    if (!isTargetDownloaded) {
      await modelManager.downloadModel(targetLanguageEnum.bcpCode);
    }

    _isModelDownloaded = true;
    _translator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.chinese,
      targetLanguage: targetLanguageEnum,
    );
  }

  void dispose() {
    _translator?.close();
    _englishDefinitionTranslator?.close();
  }

  /// Translates a complete canonical English dictionary definition verbatim.
  ///
  /// Unlike [translate], this method checks the offline SQLite dictionary first
  /// for the user's active [targetLanguage]. If not present offline, it translates
  /// on-the-fly and caches the result into Hive, with canonical English as fallback.
  Future<String> translateEnglishDefinition(String definition,
      {String? hanzi}) async {
    if (definition.isEmpty || targetLanguage.toLowerCase() == 'english') {
      return definition;
    }

    // 1. Check Offline SQLite Dictionary first if hanzi is known
    if (hanzi != null &&
        hanzi.trim().isNotEmpty &&
        dictionaryRepository != null) {
      try {
        final card = await dictionaryRepository!.getExact(
          hanzi.trim(),
          targetLanguage: targetLanguage,
        );
        if (card != null &&
            card.definition.trim().isNotEmpty &&
            card.definitionLanguage != null &&
            card.definitionLanguage!.toLowerCase() != 'english') {
          return card.definition.trim();
        }
      } catch (e) {
        debugPrint(
            '[LocalTranslationService] Offline dictionary check error: $e');
      }
    }

    final cacheKey = 'definition:en:$targetLanguage:$definition';
    Box<String>? box;
    if (Hive.isBoxOpen(_boxName)) {
      box = Hive.box<String>(_boxName);
    } else {
      try {
        box = await Hive.openBox<String>(_boxName);
      } catch (_) {}
    }

    final cached = box?.get(cacheKey);
    if (cached != null && cached.isNotEmpty) return cached;

    final openRouterKey = apiKeyPool?.nextKey ?? '';
    if (openRouterKey.isNotEmpty && openRouterKey != 'MISSING_KEY') {
      try {
        final client = http.Client();
        try {
          final response = await client
              .post(
                Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
                headers: {
                  'Authorization': 'Bearer $openRouterKey',
                  'Content-Type': 'application/json',
                  'HTTP-Referer': 'https://hanzimaster.app',
                  'X-Title': 'SinoSpark',
                },
                body: jsonEncode({
                  'model': 'google/gemini-2.5-flash',
                  'messages': [
                    {
                      'role': 'user',
                      'content':
                          'Translate the following complete English dictionary definition into $targetLanguage. Preserve every sense, explanation, usage note, parenthesis, example, and semicolon-separated section. Do not shorten, summarize, omit, reorder, or explain anything. Return only the translation, with no quotes or markdown.\n\n$definition',
                    }
                  ],
                  'max_tokens': 1000,
                  'provider': {'data_collection': 'deny'}
                }),
              )
              .timeout(const Duration(seconds: 8));

          if (response.statusCode == 200) {
            final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
            final translated =
                (json['choices']?[0]?['message']?['content'] as String? ?? '')
                    .trim();
            if (translated.isNotEmpty) {
              await box?.put(cacheKey, translated);
              return translated;
            }
          }
        } finally {
          client.close();
        }
      } catch (error) {
        debugPrint(
            '[LocalTranslationService] AI definition translation failed: $error');
      }
    }

    try {
      final target = _getTranslateLanguage(targetLanguage);
      final modelManager = OnDeviceTranslatorModelManager();
      final isEnglishDownloaded = await modelManager
          .isModelDownloaded(TranslateLanguage.english.bcpCode);
      if (!isEnglishDownloaded) {
        await modelManager.downloadModel(
          TranslateLanguage.english.bcpCode,
          isWifiRequired: false,
        );
      }
      final isDownloaded = await modelManager.isModelDownloaded(target.bcpCode);
      if (!isDownloaded) {
        await modelManager.downloadModel(target.bcpCode, isWifiRequired: false);
      }
      _englishDefinitionTranslator ??= OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: target,
      );
      final translated = await _englishDefinitionTranslator!
          .translateText(definition)
          .timeout(const Duration(seconds: 5));
      if (translated.isNotEmpty) {
        await box?.put(cacheKey, translated);
        return translated;
      }
    } catch (error) {
      debugPrint(
          '[LocalTranslationService] On-device definition translation failed: $error');
    }

    try {
      final targetCode = _getTargetLanguageCode(targetLanguage);
      final uri = Uri.parse(
          'https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=$targetCode&dt=t&q=${Uri.encodeComponent(definition)}');
      final client = http.Client();
      try {
        final response =
            await client.get(uri).timeout(const Duration(seconds: 4));
        if (response.statusCode == 200) {
          final dynamic data = jsonDecode(response.body);
          if (data is List && data.isNotEmpty && data[0] is List) {
            final translated = (data[0] as List<dynamic>)
                .whereType<List<dynamic>>()
                .where((part) => part.isNotEmpty && part[0] is String)
                .map((part) => part[0] as String)
                .join();
            if (translated.isNotEmpty) {
              await box?.put(cacheKey, translated);
              return translated;
            }
          }
        }
      } finally {
        client.close();
      }
    } catch (error) {
      debugPrint(
          '[LocalTranslationService] Definition translation request failed: $error');
    }

    return definition;
  }

  /// Translates [text] to the current [targetLanguage].
  Future<String> translate(String text) async {
    if (text.isEmpty) return text;
    // Don't translate if the target language is effectively English and the text is already mostly English
    if (targetLanguage.toLowerCase() == 'english' &&
        !RegExp(r'[\u4e00-\u9fa5]').hasMatch(text)) {
      return text[0].toUpperCase() + text.substring(1);
    }

    // Clean up Mandarin Bean pinyin artifacts from the string if present
    String cleanedText = text.replaceAll(
        RegExp(
            r'[āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜüa-zA-Z\s\u0300-\u036f]+(?=[\u4e00-\u9fa5]|$)'),
        ' ');
    if (cleanedText.trim().isEmpty ||
        !RegExp(r'[\u4e00-\u9fa5]').hasMatch(cleanedText)) {
      cleanedText = text;
    }

    final cacheKey = '$targetLanguage:$cleanedText';
    Box<String>? box;
    if (Hive.isBoxOpen(_boxName)) {
      box = Hive.box<String>(_boxName);
    } else {
      try {
        box = await Hive.openBox<String>(_boxName);
      } catch (_) {}
    }

    final cached = box?.get(cacheKey);
    if (cached != null) {
      return cached.isNotEmpty
          ? cached[0].toUpperCase() + cached.substring(1)
          : cached;
    }

    // 1. Try AI-powered translation via OpenRouter (Gemini 2.5 Flash) or Direct Gemini API for nuanced literary accuracy
    final openRouterKey = apiKeyPool?.nextKey ?? '';
    final googleKey = apiKeyPool?.googleKey ?? '';

    if (openRouterKey.isNotEmpty && openRouterKey != 'MISSING_KEY') {
      try {
        final client = http.Client();
        try {
          final prompt =
              'You are a master literary and classical Chinese translator. Translate the following Chinese sentence or title into natural, eloquent $targetLanguage. Capture any poetic imagery, idioms, or classical references accurately.\n\nChinese: "$cleanedText"\n\nReturn ONLY the direct translation. Do not add quotes, notes, or explanations.';

          final response = await client
              .post(
                Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
                headers: {
                  'Authorization': 'Bearer $openRouterKey',
                  'Content-Type': 'application/json',
                  'HTTP-Referer': 'https://hanzimaster.app',
                  'X-Title': 'SinoSpark',
                },
                body: jsonEncode({
                  'model': 'google/gemini-2.5-flash',
                  'messages': [
                    {'role': 'user', 'content': prompt}
                  ],
                  'max_tokens': 250,
                  'provider': {'data_collection': 'deny'}
                }),
              )
              .timeout(const Duration(seconds: 6));

          if (response.statusCode == 200) {
            final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
            String reply =
                json['choices']?[0]?['message']?['content'] as String? ?? '';
            reply = reply.trim();
            // Strip any wrapping quotes or markdown backticks if returned
            if ((reply.startsWith('"') && reply.endsWith('"')) ||
                (reply.startsWith('“') && reply.endsWith('”')) ||
                (reply.startsWith("'") && reply.endsWith("'"))) {
              reply = reply.substring(1, reply.length - 1).trim();
            }
            if (reply.isNotEmpty) {
              final formatted = reply[0].toUpperCase() + reply.substring(1);
              await box?.put(cacheKey, formatted);
              return formatted;
            }
          }
        } finally {
          client.close();
        }
      } catch (e) {
        debugPrint('[LocalTranslationService] OpenRouter AI translation: $e');
      }
    }

    if (googleKey.isNotEmpty && googleKey != 'MISSING_KEY') {
      try {
        final client = http.Client();
        try {
          final prompt =
              'Translate this Chinese text to $targetLanguage directly with literary accuracy. Chinese: "$cleanedText". Return ONLY the direct translation without explanations.';
          final response = await client
              .post(
                Uri.parse(
                    'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent?key=$googleKey'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({
                  'contents': [
                    {
                      'parts': [
                        {'text': prompt}
                      ]
                    }
                  ]
                }),
              )
              .timeout(const Duration(seconds: 6));

          if (response.statusCode == 200) {
            final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
            String reply = json['candidates']?[0]?['content']?['parts']?[0]
                    ?['text'] as String? ??
                '';
            reply = reply.trim();
            if ((reply.startsWith('"') && reply.endsWith('"')) ||
                (reply.startsWith('“') && reply.endsWith('”')) ||
                (reply.startsWith("'") && reply.endsWith("'"))) {
              reply = reply.substring(1, reply.length - 1).trim();
            }
            if (reply.isNotEmpty) {
              final formatted = reply[0].toUpperCase() + reply.substring(1);
              await box?.put(cacheKey, formatted);
              return formatted;
            }
          }
        } finally {
          client.close();
        }
      } catch (e) {
        debugPrint(
            '[LocalTranslationService] Google Gemini AI translation: $e');
      }
    }

    // 2. On-Device ML Kit Fallback
    try {
      final tl = _getTranslateLanguage(targetLanguage);
      await _ensureModelReady(tl).timeout(const Duration(milliseconds: 1500));

      if (_translator != null) {
        String translated = await _translator!
            .translateText(cleanedText)
            .timeout(const Duration(milliseconds: 1500));
        if (translated.isNotEmpty && RegExp(r'[a-zA-Z]').hasMatch(translated)) {
          translated = translated[0].toUpperCase() + translated.substring(1);
          await box?.put(cacheKey, translated);
          return translated;
        }
      }
    } catch (e) {
      debugPrint(
          '[LocalTranslationService] On-device translation fallback needed: $e');
    }

    // 3. High-speed mechanical endpoint fallback with automatic persistent Hive caching
    try {
      final targetCode = _getTargetLanguageCode(targetLanguage);
      final uri = Uri.parse(
          'https://translate.googleapis.com/translate_a/single?client=gtx&sl=zh-CN&tl=$targetCode&dt=t&q=${Uri.encodeComponent(cleanedText)}');
      final client = http.Client();
      try {
        final resp = await client.get(uri).timeout(const Duration(seconds: 4));
        if (resp.statusCode == 200) {
          final dynamic data = jsonDecode(resp.body);
          if (data is List && data.isNotEmpty && data[0] is List) {
            final sentences = data[0] as List<dynamic>;
            final sb = StringBuffer();
            for (final s in sentences) {
              if (s is List && s.isNotEmpty && s[0] is String) {
                sb.write(s[0]);
              }
            }
            final translated = sb.toString().trim();
            if (translated.isNotEmpty) {
              final formatted =
                  translated[0].toUpperCase() + translated.substring(1);
              await box?.put(cacheKey, formatted);
              return formatted;
            }
          }
        }
      } finally {
        client.close();
      }
    } catch (e) {
      debugPrint('[LocalTranslationService] Translation request failed: $e');
    }

    return cleanedText.isNotEmpty
        ? cleanedText[0].toUpperCase() + cleanedText.substring(1)
        : cleanedText;
  }

  String _getTargetLanguageCode(String language) {
    switch (language.toLowerCase()) {
      case 'french':
        return 'fr';
      case 'spanish':
        return 'es';
      case 'german':
        return 'de';
      case 'japanese':
        return 'ja';
      case 'korean':
        return 'ko';
      case 'italian':
        return 'it';
      case 'portuguese':
        return 'pt';
      case 'russian':
        return 'ru';
      case 'arabic':
        return 'ar';
      case 'indonesian':
        return 'id';
      case 'vietnamese':
        return 'vi';
      case 'hindi':
        return 'hi';
      default:
        return 'en';
    }
  }

  TranslateLanguage _getTranslateLanguage(String language) {
    switch (language.toLowerCase()) {
      case 'french':
        return TranslateLanguage.french;
      case 'spanish':
        return TranslateLanguage.spanish;
      case 'german':
        return TranslateLanguage.german;
      case 'japanese':
        return TranslateLanguage.japanese;
      case 'korean':
        return TranslateLanguage.korean;
      case 'italian':
        return TranslateLanguage.italian;
      case 'portuguese':
        return TranslateLanguage.portuguese;
      case 'russian':
        return TranslateLanguage.russian;
      case 'arabic':
        return TranslateLanguage.arabic;
      case 'indonesian':
        return TranslateLanguage.indonesian;
      case 'vietnamese':
        return TranslateLanguage.vietnamese;
      case 'hindi':
        return TranslateLanguage.hindi;
      default:
        return TranslateLanguage.english;
    }
  }
}
