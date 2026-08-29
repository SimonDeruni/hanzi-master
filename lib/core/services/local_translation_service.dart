import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:http/http.dart' as http;
import '../providers/translation_language_provider.dart';
import '../../features/reading/domain/entities/poetry_story_id.dart';

final localTranslationServiceProvider =
    Provider<LocalTranslationService>((ref) {
  final targetLanguage = ref.watch(translationLanguageProvider);
  final service = LocalTranslationService(targetLanguage: targetLanguage);
  ref.onDispose(() => service.dispose());
  return service;
});

class LocalTranslationService {
  final String targetLanguage;
  static const String _boxName = 'local_translations_cache_v5';

  OnDeviceTranslator? _translator;
  bool _isModelDownloaded = false;

  LocalTranslationService({required this.targetLanguage});

  static Future<void> init() async {
    try {
      await Hive.openBox<String>(_boxName);
    } catch (e) {
      debugPrint('Error opening $_boxName: $e. Deleting and retrying.');
      try {
        await Hive.deleteBoxFromDisk(_boxName);
      } catch (_) {
        // Box or lock file may already be partially deleted; continue
      }
      await Hive.openBox<String>(_boxName);
    }
    await _seedEnglishCache();
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

    try {
      final tl = _getTranslateLanguage(targetLanguage);
      await _ensureModelReady(tl);

      if (_translator != null) {
        String translated = await _translator!.translateText(cleanedText);
        if (translated.isNotEmpty && RegExp(r'[a-zA-Z]').hasMatch(translated)) {
          translated = translated[0].toUpperCase() + translated.substring(1);
          await box?.put(cacheKey, translated);
          return translated;
        }
      }
    } catch (e) {
      debugPrint('[LocalTranslationService] On-device translation fallback needed: $e');
    }

    // High-speed endpoint fallback with automatic persistent Hive caching
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
              final formatted = translated[0].toUpperCase() + translated.substring(1);
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
