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
  Map<String, dynamic>? _hanziVgDb;

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
      if (_hanziVgDb == null) {
        try {
          final hvgString = await rootBundle.loadString('assets/data/hsk1_hanzivg.json');
          if (hvgString.isNotEmpty) {
            _hanziVgDb = await compute(_parseJsonMap, hvgString);
          }
        } catch (e) { _hanziVgDb = {}; }
      }
    } catch (e) {
      debugPrint("Warning: Database pre-warming skipped: $e");
      _hsk1StrokesDb ??= {};
      _animCjkDb ??= {};
      _hanziVgDb ??= {};
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
  Future<Either<String, List<Flashcard>>> getFlashcardsByDeck(String deckId) async {
    try {
      if (!flashcardBox.isOpen) return const Right([]);
      return Right(flashcardBox.values
          .where((m) => m.deckId == deckId || (deckId == 'default' && m.deckId == null))
          .map((m) => m.toEntity())
          .toList());
    } catch (e) {
      return Left("Failed to load cards for deck: $e");
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

      for (int level = 1; level <= 6; level++) {
        final levelResults = await _searchHskLevel(level, query, lowQuery);
        results.addAll(levelResults);
      }

      return Right(results);
    } catch (e) {
      return Left("Search failed: $e");
    }
  }

  Future<List<Flashcard>> _searchHskLevel(int level, String query, String lowQuery) async {
    final List<Flashcard> results = [];
    final String fileName = level == 1 ? 'assets/data/hsk1.json' : 'assets/data/hsk${level}_bundle.json';
    
    try {
      final jsonString = await rootBundle.loadString(fileName);
      if (jsonString.isNotEmpty) {
        final dynamic decoded = json.decode(jsonString);
        final List<dynamic> vocabulary;
        
        if (level == 1) {
          vocabulary = decoded as List<dynamic>;
        } else {
          vocabulary = (decoded as Map<String, dynamic>)['vocabulary'] as List<dynamic>;
        }

        for (int i = 0; i < vocabulary.length; i++) {
          final item = vocabulary[i] as Map<String, dynamic>;
          final hanzi = item['hanzi'] as String;
          final pinyin = (item['pinyin'] as String).toLowerCase();
          final def = (item['definition'] as String).toLowerCase();
          
          if (hanzi.contains(query) || pinyin.contains(lowQuery) || def.contains(lowQuery)) {
            final String uuid = item['uuid'] ?? "hsk${level}_${(i + 1).toString().padLeft(3, '0')}";
            results.add(FlashcardModel.fromJson({
              ...item,
              'uuid': uuid,
              'hskLevel': level,
            }).toEntity());
          }
        }
      }
    } catch (e) {
      // Ignore if file doesn't exist or parsing fails
    }
    return results;
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
  Future<Either<String, void>> importLevel(int level) async {
    try {
      final String fileName = level == 1 ? 'assets/data/hsk1.json' : 'assets/data/hsk${level}_bundle.json';
      final jsonString = await rootBundle.loadString(fileName);
      if (jsonString.isEmpty) return Left("HSK$level bundle file is empty");
      
      final dynamic decoded = await compute(_parseJsonMap, jsonString);
      final List<dynamic> vocabulary;
      if (level == 1) {
        // HSK 1 is sometimes a direct list depending on the parser, wait, _parseJsonMap expects a Map.
        // Let's use json.decode directly or _parseJsonList if level is 1?
        // Actually, importHsk1() already handles level 1.
        // importLevel will only be called for level >= 2.
        final bundle = decoded as Map<String, dynamic>;
        vocabulary = bundle['vocabulary'] as List<dynamic>;
      } else {
        final bundle = decoded as Map<String, dynamic>;
        vocabulary = bundle['vocabulary'] as List<dynamic>;
      }
      
      final Map<String, FlashcardModel> entries = {};
      for (int i = 0; i < vocabulary.length; i++) {
        final item = vocabulary[i] as Map<String, dynamic>;
        final String uuid = item['uuid'] ?? "hsk${level}_${(i + 1).toString().padLeft(3, '0')}";
        entries[uuid] = FlashcardModel.fromJson({
          ...item,
          'uuid': uuid,
          'hskLevel': level,
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
    if (card.strokePaths.isNotEmpty) {
      // Self-healing migration: If the card has cached outline paths (contains 'z' or 'Z' for closed path),
      // we force a re-fetch to generate the new skeletal paths from HanziVG or our medians.
      final hasOutlines = card.strokePaths.any((p) => p.contains('Z') || p.contains('z'));
      if (!hasOutlines) {
        return Right(card);
      }
    }
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
          
          // Ensure medians length parity with strokes count
          final List<List<Offset>> normalizedMedians;
          if (medians.length == strokes.length) {
            normalizedMedians = medians;
          } else {
            // Provide empty skeletons if parity is broken to avoid desync
            normalizedMedians = List.generate(strokes.length, (_) => <Offset>[]);
          }
          allMedians.addAll(normalizedMedians);
        }
      }
      final updatedCard = card.copyWith(strokePaths: allStrokes, medianPaths: allMedians, isFlipped: needsFlip);
      if (!card.id.startsWith('global_')) {
        await saveFlashcard(updatedCard);
      }
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
      final url = Uri.parse('https://cdn.jsdelivr.net/npm/hanzi-writer-data@2.0.1/$char.json');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        
        List<String> strokes = [];
        List<List<Offset>> medians = [];
        if (data['medians'] != null) {
          // Parse medians as points
          medians = (data['medians'] as List).map((m) {
            final pts = (m as List).map((p) => Offset((p as List)[0].toDouble(), (p[1]).toDouble())).toList();
            return CharacterLoader.flipPoints(pts).map(CharacterLoader.transformPoint).toList();
          }).toList();
          
          // Construct skeletal SVG paths from the RAW medians so they look like HanziVG (single thick strokes)
          strokes = (data['medians'] as List).map((m) {
            final pts = m as List;
            if (pts.isEmpty) return "";
            String pathStr = "M ${pts[0][0]} ${pts[0][1]}";
            for (int i = 1; i < pts.length; i++) {
              pathStr += " L ${pts[i][0]} ${pts[i][1]}";
            }
            return pathStr;
          }).toList();
        } else {
          strokes = (data['strokes'] as List).cast<String>();
          medians = await CharacterLoader.parseAndSampleAsync(strokes, interval: 2.0);
        }
        
        return {'strokes': strokes, 'medians': medians, 'source': 'hanzi-writer'};
      }
    } catch (e) {
      debugPrint("Network fetch failed for $char: $e");
    }
    return {};
  }

  Future<Map<String, dynamic>> _loadOfflineStrokes(String char) async {
    try {
      await preloadDatabases();
      
      List<String> strokes = [];
      List<List<Offset>> medians = []; 
      
      // The True Original 'Gold' Aesthetics used skeleton paths rendering with PaintStyle.stroke.
      if (_hanziVgDb != null && _hanziVgDb!.containsKey(char)) {
        List<String> resolvePaths(String targetChar) {
          if (!_hanziVgDb!.containsKey(targetChar)) return [];
          List<String> rawPaths = List<String>.from(_hanziVgDb![targetChar]['paths'] ?? []);
          List<String> resolved = [];
          for (String path in rawPaths) {
            if (path.startsWith('hvg:')) {
              String hex = path.substring(4);
              if (hex.startsWith('0x')) hex = hex.substring(2);
              int? codePoint = int.tryParse(hex, radix: 16);
              if (codePoint != null) {
                resolved.addAll(resolvePaths(String.fromCharCode(codePoint)));
              }
            } else {
              resolved.add(path);
            }
          }
          return resolved;
        }

        final resolvedStrokes = resolvePaths(char);
        if (resolvedStrokes.isNotEmpty) {
          strokes = resolvedStrokes;
          medians = await CharacterLoader.parseAndSampleAsync(strokes, interval: 2.0);
          return {'strokes': strokes, 'medians': medians, 'source': 'hanzivg'};
        }
      } 
      // Fallback: Hanzi Writer
      if (_hsk1StrokesDb != null && _hsk1StrokesDb!.containsKey(char)) {
        if (_hsk1StrokesDb![char]['medians'] != null) {
          medians = (_hsk1StrokesDb![char]['medians'] as List).map((m) {
            final pts = (m as List).map((p) => Offset((p as List)[0].toDouble(), (p[1]).toDouble())).toList();
            return CharacterLoader.flipPoints(pts).map(CharacterLoader.transformPoint).toList();
          }).toList();
          
          // Construct skeletal SVG paths from the RAW medians so they look like HanziVG (single thick strokes)
          strokes = (_hsk1StrokesDb![char]['medians'] as List).map((m) {
            final pts = m as List;
            if (pts.isEmpty) return "";
            String pathStr = "M ${pts[0][0]} ${pts[0][1]}";
            for (int i = 1; i < pts.length; i++) {
              pathStr += " L ${pts[i][0]} ${pts[i][1]}";
            }
            return pathStr;
          }).toList();
        } else {
          strokes = List<String>.from(_hsk1StrokesDb![char]['strokes'] ?? []);
        }
        return {'strokes': strokes, 'medians': medians, 'source': 'hanzi-writer'};
      }
      
    } catch (e) {
      debugPrint("HM: Offline load failed for $char: $e");
    }
    return {};
  }
}