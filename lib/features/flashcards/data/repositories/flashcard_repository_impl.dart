import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hanzi_master/core/character_loader.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../models/flashcard_model.dart';

// Top-level function for background parsing
Map<String, dynamic> _parseJsonMap(String data) => json.decode(data) as Map<String, dynamic>;
List<dynamic> _parseJsonList(String data) => json.decode(data) as List<dynamic>;

class FlashcardRepositoryImpl implements FlashcardRepository {
  final Box<FlashcardModel> flashcardBox;
  final Map<String, Map<String, dynamic>> _strokeCache = {};
  Map<String, dynamic>? _hsk1StrokesDb;
  Map<String, dynamic>? _hsk2BundleDb;
  Map<String, dynamic>? _animCjkDb;

  FlashcardRepositoryImpl(this.flashcardBox);

  @override
  Future<void> init() async {
    await preloadDatabases();
  }

  @override
  Future<void> preloadDatabases() async {
    try {
      if (_hsk1StrokesDb == null) {
        final jsonString = await rootBundle.loadString('assets/data/hsk1_strokes.json');
        if (jsonString.isNotEmpty) {
          _hsk1StrokesDb = await compute(_parseJsonMap, jsonString);
        }
      }
      if (_hsk2BundleDb == null) {
        try {
          final hsk2String = await rootBundle.loadString('assets/data/hsk2_bundle.json');
          if (hsk2String.isNotEmpty) {
            _hsk2BundleDb = await compute(_parseJsonMap, hsk2String);
          }
        } catch (e) { _hsk2BundleDb = {}; }
      }
      if (_animCjkDb == null) {
        try {
          final acjkString = await rootBundle.loadString('assets/data/hsk1_animcjk.json');
          if (acjkString.isNotEmpty) {
            _animCjkDb = await compute(_parseJsonMap, acjkString);
          }
        } catch (e) { _animCjkDb = {}; }
      }
    } catch (e) {
      debugPrint("Warning: Database pre-warming skipped: $e");
      _hsk1StrokesDb ??= {};
      _animCjkDb ??= {};
    }
  }

  @override
  Future<Either<String, List<Flashcard>>> getFlashcards() async {
    try {
      if (!flashcardBox.isOpen) return const Right([]);
      return Right(flashcardBox.values.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left("Failed to load cards: $e");
    }
  }

  @override
  Future<Either<String, void>> saveFlashcard(Flashcard card) async {
    try {
      if (!flashcardBox.isOpen) return const Left("Database box not open");
      await flashcardBox.put(card.id, FlashcardModel.fromEntity(card));
      return const Right(null);
    } catch (e) {
      return Left("Failed to save card: $e");
    }
  }

  @override
  Future<Either<String, void>> deleteFlashcard(String id) async {
    try {
      if (!flashcardBox.isOpen) return const Left("Database box not open");
      await flashcardBox.delete(id);
      return const Right(null);
    } catch (e) {
      return Left("Failed to delete card: $e");
    }
  }

  @override
  Future<Either<String, void>> deleteFlashcardsByLevel(int level) async {
    try {
      if (!flashcardBox.isOpen) return const Left("Database box not open");
      
      final keysToDelete = flashcardBox.values
          .where((m) => m.hskLevel == level)
          .map((m) => m.id)
          .toList();
          
      await flashcardBox.deleteAll(keysToDelete);
      return const Right(null);
    } catch (e) {
      return Left("Failed to delete level $level cards: $e");
    }
  }

  @override
  Future<Either<String, List<Flashcard>>> searchAll(String query) async {
    try {
      final List<Flashcard> results = [];
      final lowQuery = query.toLowerCase();

      // 1. Search HSK 1
      final hsk1String = await rootBundle.loadString('assets/data/hsk1.json');
      if (hsk1String.isNotEmpty) {
        final List<dynamic> hsk1List = json.decode(hsk1String);
        for (var item in hsk1List) {
          final hanzi = item['hanzi'] as String;
          final pinyin = (item['pinyin'] as String).toLowerCase();
          final def = (item['definition'] as String).toLowerCase();
          
          if (hanzi.contains(query) || pinyin.contains(lowQuery) || def.contains(lowQuery)) {
            results.add(FlashcardModel.fromJson({ ...item, 'hskLevel': 1 }).toEntity());
          }
        }
      }

      // 2. Search HSK 2
      final hsk2String = await rootBundle.loadString('assets/data/hsk2_bundle.json');
      if (hsk2String.isNotEmpty) {
        final Map<String, dynamic> hsk2Bundle = json.decode(hsk2String);
        final List<dynamic> vocabulary = hsk2Bundle['vocabulary'] as List<dynamic>;
        for (int i = 0; i < vocabulary.length; i++) {
          final item = vocabulary[i] as Map<String, dynamic>;
          final hanzi = item['hanzi'] as String;
          final pinyin = (item['pinyin'] as String).toLowerCase();
          final def = (item['definition'] as String).toLowerCase();

          if (hanzi.contains(query) || pinyin.contains(lowQuery) || def.contains(lowQuery)) {
            final String uuid = item['uuid'] ?? "hsk2_${(i + 1).toString().padLeft(3, '0')}";
            results.add(FlashcardModel.fromJson({
              ...item,
              'uuid': uuid,
              'hskLevel': 2,
            }).toEntity());
          }
        }
      }

      return Right(results);
    } catch (e) {
      return Left("Search failed: $e");
    }
  }

  @override
  Future<Either<String, void>> importHsk1() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/hsk1.json');
      if (jsonString.isEmpty) return const Left("HSK1 data file is empty");
      
      final List<dynamic> jsonList = await compute(_parseJsonList, jsonString);
      final Map<String, FlashcardModel> entries = {
        for (var item in jsonList) item['uuid']: FlashcardModel.fromJson(item)
      };
      
      if (!flashcardBox.isOpen) return const Left("Database box not open");
      await flashcardBox.putAll(entries);
      return const Right(null);
    } catch (e) {
      return Left("Import failed: $e");
    }
  }

  @override
  Future<Either<String, void>> importHsk2() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/hsk2_bundle.json');
      if (jsonString.isEmpty) return const Left("HSK2 bundle file is empty");
      
      final Map<String, dynamic> bundle = await compute(_parseJsonMap, jsonString);
      final List<dynamic> vocabulary = bundle['vocabulary'] as List<dynamic>;
      
      final Map<String, FlashcardModel> entries = {};
      for (int i = 0; i < vocabulary.length; i++) {
        final item = vocabulary[i] as Map<String, dynamic>;
        final String uuid = item['uuid'] ?? "hsk2_${(i + 1).toString().padLeft(3, '0')}";
        entries[uuid] = FlashcardModel.fromJson({
          ...item,
          'uuid': uuid,
          'hskLevel': 2,
        });
      }
      
      if (!flashcardBox.isOpen) return const Left("Database box not open");
      await flashcardBox.putAll(entries);
      return const Right(null);
    } catch (e) {
      return Left("Import failed: $e");
    }
  }

  @override
  Future<Either<String, Flashcard>> fetchAndSaveStrokes(Flashcard card) async {
    if (card.strokePaths.isNotEmpty) return Right(card);
    try {
      final characters = card.hanzi.split('');
      final allStrokes = <String>[];
      final allMedians = <List<Offset>>[];
      bool needsFlip = false;
      for (int i = 0; i < characters.length; i++) {
        final charData = await _fetchStrokesForCharacter(characters[i]);
        if (charData['source'] == 'hanzi-writer') needsFlip = true;
        
        final List<String> strokes = (charData['strokes'] as List? ?? []).cast<String>();
        final List<List<Offset>> medians = (charData['medians'] as List? ?? []).cast<List<Offset>>();

        if (i > 0 && strokes.isNotEmpty) {
          allStrokes.add('__CHAR_SEPARATOR__');
          // Add a placeholder to keep medianPaths index-synchronized with valid strokePaths
          allMedians.add([]); 
        }

        if (strokes.isNotEmpty) {
          allStrokes.addAll(strokes);
          // Normalize medians to 1000x1000 coordinate system
          allMedians.addAll(medians.map((stroke) => stroke.map(CharacterLoader.transformPoint).toList()));
        }
      }
      final updatedCard = card.copyWith(strokePaths: allStrokes, medianPaths: allMedians, isFlipped: needsFlip);
      await saveFlashcard(updatedCard);
      return Right(updatedCard);
    } catch (e) {
      return Right(card);
    }
  }

  Future<Map<String, dynamic>> _fetchStrokesForCharacter(String char) async {
    if (_strokeCache.containsKey(char)) return _strokeCache[char]!;
    
    // 1. Try Local Assets
    final offlineData = await _loadOfflineStrokes(char);
    if (offlineData.isNotEmpty) {
      _strokeCache[char] = offlineData; 
      return offlineData; 
    }
    
    // 2. Try Network Fallback (AnimCJK CDN)
    var onlineData = await _fetchOnlineStrokes(char);
    if (onlineData.isNotEmpty) {
      _strokeCache[char] = onlineData;
      return onlineData;
    }

    // 3. Proxy Rescue (Borrow strokes from a character that contains the radical)
    // This is the most robust way to handle isolated radicals in HSK1.
    final proxyStrokes = CharacterLoader.getProxyStrokes(char, _animCjkDb ?? {});
    if (proxyStrokes.isNotEmpty) {
      final List<List<Offset>> medians = await CharacterLoader.parseAndSampleAsync(proxyStrokes, interval: 2.0);

      final proxyData = {
        'strokes': proxyStrokes,
        'medians': medians,
        'source': 'animcjk'
      };
      _strokeCache[char] = proxyData;
      return proxyData;
    }

    // 4. Variant Hunt (Legacy fallback)
    // Map of common problematic radicals to their alternate Unicode forms
    const variants = {
      '阝': ['\u961D', '\u2ECF', '\u2ED6', '阜', '邑'], // Left/Right Ear variants + Full forms
      '亻': ['\u4EBB', '人'],
      '氵': ['\u6C35', '水'],
      '忄': ['\u5FC4', '心'],
      '扌': ['\u624C', '手'],
      '犭': ['\u72AD', '犬'],
      '礻': ['\u793B', '示'],
      '衤': ['\u8864', '衣'],
      '辶': ['\u8FB6', '辵'],
    };

    if (variants.containsKey(char)) {
      for (final variant in variants[char]!) {
        onlineData = await _fetchOnlineStrokes(variant);
        if (onlineData.isNotEmpty) {
          _strokeCache[char] = onlineData; // Cache under original char for seamless access
          return onlineData;
        }
      }
    }
    
    return {};
  }

  Future<Map<String, dynamic>> _fetchOnlineStrokes(String char) async {
    try {
      final url = Uri.parse('https://cdn.jsdelivr.net/npm/animcjk-data/data/zh-Hans/$char.json');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        
        List<String> strokes = (data['strokes'] as List).cast<String>();
        List<List<Offset>> medians = await CharacterLoader.parseAndSampleAsync(strokes, interval: 2.0);
        
        return {'strokes': strokes, 'medians': medians, 'source': 'animcjk'};
      }
    } catch (e) {
      debugPrint("Network fetch failed for $char: $e");
    }
    return {};
  }

  Future<Map<String, dynamic>> _loadOfflineStrokes(String char) async {
    try {
      await preloadDatabases();
      
      // Preferred Source: AnimCJK (High quality, no flip needed usually, but we check)
      final acjkData = _animCjkDb?[char];
      if (acjkData != null) {
        List<String> strokes = [];
        List<List<Offset>> medians = [];
        if (acjkData['outlines'] != null) strokes = (acjkData['outlines'] as List).cast<String>();
        if (acjkData['skeletons'] != null) {
          final List<String> skeletonStrings = (acjkData['skeletons'] as List).cast<String>();
          medians = await CharacterLoader.parseAndSampleAsync(skeletonStrings, interval: 2.0);
        }
        return {'strokes': strokes, 'medians': medians, 'source': 'animcjk'};
      }

      // 2. Try HSK 2 Bundle (New format, bundled strokes)
      final hsk2Data = _hsk2BundleDb?['strokes']?[char];
      if (hsk2Data != null) {
        final List<String> outlines = (hsk2Data['paths'] as List).cast<String>();
        final List<String> skeletonStrings = (hsk2Data['skeletons'] as List).cast<String>();
        
        final List<List<Offset>> medians = await CharacterLoader.parseAndSampleAsync(skeletonStrings, interval: 2.0);
        return {'strokes': outlines, 'medians': medians, 'source': 'animcjk'};
      }

      // 3. Fallback Source: Hanzi Writer (Legacy, Y-Up)
      final charData = _hsk1StrokesDb?[char];
      if (charData is Map) {
        List<String> strokes = (charData['strokes'] as List).cast<String>();
        List<List<Offset>> medians = (charData['medians'] as List).map((m) => CharacterLoader.flipPoints((m as List).map((p) => Offset((p as List)[0].toDouble(), (p[1]).toDouble())).toList())).toList();
        return {'strokes': strokes, 'medians': medians, 'source': 'hanzi-writer'};
      }
    } catch (e) {
      // Character data missing or corrupted.
    }
    return {};
  }
}