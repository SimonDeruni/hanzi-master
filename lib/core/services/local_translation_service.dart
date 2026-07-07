import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import '../providers/translation_language_provider.dart';

final localTranslationServiceProvider = Provider<LocalTranslationService>((ref) {
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
      await Hive.deleteBoxFromDisk(_boxName);
      await Hive.openBox<String>(_boxName);
    }
    await _seedEnglishCache();
  }

  static Future<void> _seedEnglishCache() async {
    final box = Hive.box<String>(_boxName);
    if (box.containsKey('English:阿鼻地狱')) return;

    try {
      final String jsonString = await rootBundle.loadString('assets/data/1000_stories_en.json');
      final List<dynamic> list = json.decode(jsonString);
      for (var data in list) {
        if (data['title'] != null && data['title_en'] != null) {
          box.put('English:${data['title']}', data['title_en']);
        }
        if (data['summary'] != null && data['summary_en'] != null) {
          box.put('English:${data['summary']}', data['summary_en']);
        }
      }
    } catch (_) {}
    
    try {
      final String jsonString2 = await rootBundle.loadString('assets/data/tang_poetry_en.json');
      final List<dynamic> list2 = json.decode(jsonString2);
      for (var data in list2) {
        if (data['title'] != null && data['title_en'] != null) {
          box.put('English:${data['title']}', data['title_en']);
        }
        if (data['summary'] != null && data['summary_en'] != null) {
          box.put('English:${data['summary']}', data['summary_en']);
        }
      }
    } catch (_) {}

    try {
      final String jsonString3 = await rootBundle.loadString('assets/data/mandarin_bean_stories.json');
      final List<dynamic> list3 = json.decode(jsonString3);
      for (var data in list3) {
        if (data['title'] != null && data['title_en'] != null) {
          box.put('English:${data['title']}', data['title_en']);
        }
        if (data['summary'] != null && data['summary_en'] != null) {
          box.put('English:${data['summary']}', data['summary_en']);
        }
      }
    } catch (_) {}
  }

  Future<void> _ensureModelReady(TranslateLanguage targetLanguageEnum) async {
    if (_isModelDownloaded && _translator != null) return;
    
    final modelManager = OnDeviceTranslatorModelManager();
    // Chinese model check
    bool isChineseDownloaded = await modelManager.isModelDownloaded(TranslateLanguage.chinese.bcpCode);
    if (!isChineseDownloaded) {
      await modelManager.downloadModel(TranslateLanguage.chinese.bcpCode);
    }
    
    // Target model check
    bool isTargetDownloaded = await modelManager.isModelDownloaded(targetLanguageEnum.bcpCode);
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
    if (targetLanguage.toLowerCase() == 'english' && !RegExp(r'[\u4e00-\u9fa5]').hasMatch(text)) {
      return text[0].toUpperCase() + text.substring(1);
    }

    // Clean up Mandarin Bean pinyin artifacts from the string if present
    String cleanedText = text.replaceAll(RegExp(r'[āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜüa-zA-Z\s\u0300-\u036f]+(?=[\u4e00-\u9fa5]|$)'), ' ');
    if (cleanedText.trim().isEmpty || !RegExp(r'[\u4e00-\u9fa5]').hasMatch(cleanedText)) {
      cleanedText = text;
    }

    final cacheKey = '$targetLanguage:$cleanedText';
    final box = Hive.box<String>(_boxName);
    
    final cached = box.get(cacheKey);
    if (cached != null) {
      return cached.isNotEmpty ? cached[0].toUpperCase() + cached.substring(1) : cached;
    }

    try {
      final tl = _getTranslateLanguage(targetLanguage);
      await _ensureModelReady(tl);
      
      if (_translator != null) {
        String translated = await _translator!.translateText(cleanedText);
        if (translated.isNotEmpty) {
          translated = translated[0].toUpperCase() + translated.substring(1);
          await box.put(cacheKey, translated);
          return translated;
        }
      }
    } catch (e) {
      // Fallback silently
    }
    
    return cleanedText.isNotEmpty ? cleanedText[0].toUpperCase() + cleanedText.substring(1) : cleanedText; 
  }

  TranslateLanguage _getTranslateLanguage(String language) {
    switch (language.toLowerCase()) {
      case 'french': return TranslateLanguage.french;
      case 'spanish': return TranslateLanguage.spanish;
      case 'german': return TranslateLanguage.german;
      case 'japanese': return TranslateLanguage.japanese;
      case 'korean': return TranslateLanguage.korean;
      case 'italian': return TranslateLanguage.italian;
      case 'portuguese': return TranslateLanguage.portuguese;
      case 'russian': return TranslateLanguage.russian;
      case 'arabic': return TranslateLanguage.arabic;
      case 'indonesian': return TranslateLanguage.indonesian;
      case 'vietnamese': return TranslateLanguage.vietnamese;
      case 'hindi': return TranslateLanguage.hindi;
      default: return TranslateLanguage.english;
    }
  }
}
