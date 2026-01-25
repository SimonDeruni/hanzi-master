import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ... (your existing imports)

import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../models/flashcard_model.dart';
import 'package:http/http.dart' as http; // Add this at the top


class FlashcardRepositoryImpl implements FlashcardRepository {
  final Box<FlashcardModel> flashcardBox;

  FlashcardRepositoryImpl(this.flashcardBox);

  @override
  Future<Either<String, List<Flashcard>>> getFlashcards() async {
    try {
      // 1. Get all models from Hive
      final models = flashcardBox.values.toList();
      
      // 2. Convert them to "Pure" entities
      final entities = models.map((m) => m.toEntity()).toList();
      
      return Right(entities);
    } catch (e) {
      return Left("Failed to load cards: $e");
    }
  }

  @override
  Future<Either<String, void>> saveFlashcard(Flashcard card) async {
    try {
      // 1. Convert "Pure" entity to Hive Model
      final model = FlashcardModel.fromEntity(card);
      
      // 2. Save to Hive (using the ID as the key)
      await flashcardBox.put(card.id, model);
      
      return const Right(null);
    } catch (e) {
      return Left("Failed to save card: $e");
    }
  }

  @override
  Future<Either<String, void>> deleteFlashcard(String id) async {
    try {
      await flashcardBox.delete(id);
      return const Right(null);
    } catch (e) {
      return Left("Failed to delete card: $e");
    }
  }
  @override
  Future<Either<String, void>> importHsk1() async {
    try {
      // 1. Load the JSON file from assets
      final String jsonString = await rootBundle.loadString('assets/data/hsk1.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      // 2. Convert JSON objects to Hive Models
      // This uses the .fromJson factory we just added to your Model
      final List<FlashcardModel> newModels = jsonList
          .map((jsonItem) => FlashcardModel.fromJson(jsonItem))
          .toList();

      // 3. Prepare a Map for efficient bulk saving (Key: ID, Value: Model)
      final Map<String, FlashcardModel> entries = {
        for (var model in newModels) model.id: model
      };

      // 4. Save all to Hive in one operation
      await flashcardBox.putAll(entries);

      return const Right(null);
    } catch (e) {
      return Left("Import failed: $e");
    }
  }
  // 🖌️ STROKE ORDER LOGIC
  @override
  Future<Either<String, Flashcard>> fetchAndSaveStrokes(Flashcard card) async {
    // 1. If we already have strokes, don't waste data!
    if (card.strokePaths.isNotEmpty) {
      return Right(card);
    }

    try {
      // 2. Handle both single characters and phrases
      final characters = card.hanzi.split('');
      final allStrokes = <String>[];
      
      // For multi-character words, separate each character's strokes with a marker
      for (int i = 0; i < characters.length; i++) {
        final char = characters[i];
        final charStrokes = await _fetchStrokesForCharacter(char);
        
        if (i > 0 && charStrokes.isNotEmpty) {
          // Add separator to indicate new character
          allStrokes.add('__CHAR_SEPARATOR__');
        }
        allStrokes.addAll(charStrokes);
      }

      if (allStrokes.isNotEmpty) {
        final updatedCard = card.copyWith(strokePaths: allStrokes);
        await saveFlashcard(updatedCard);
        return Right(updatedCard);
      }

      return Right(card);
    } catch (e) {
      return Right(card);
    }
  }

  // Helper to fetch strokes for a single character
  Future<List<String>> _fetchStrokesForCharacter(String char) async {
    try {
      // 🚀 Try local bundled data FIRST (instant + offline support)
      final offlineStrokes = await _loadOfflineStrokes(char);
      if (offlineStrokes.isNotEmpty) {
        return offlineStrokes;
      }

      // Small delay to avoid rate limiting
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Try Hanzi Writer CDN as fallback
      final url1 = Uri.parse('https://cdn.jsdelivr.net/npm/hanzi-writer-data@2.0/$char.json');
      var response = await http.get(url1).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> strokesRaw = data['strokes'] ?? [];
        final List<String> strokes = strokesRaw.cast<String>().toList();

        if (strokes.isNotEmpty) {
          return strokes;
        }
      }

      // Try CJK Database
      final codePoint = char.codeUnitAt(0).toRadixString(16).toUpperCase().padLeft(4, '0');
      final url2 = Uri.parse('https://raw.githubusercontent.com/CJKvi/cjkvi-data/master/data/stroke/$codePoint.json');
      response = await http.get(url2).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final strokes = <String>[];
        if (data['strokes'] != null) {
          final strokeList = data['strokes'];
          if (strokeList is List) {
            strokes.addAll(strokeList.cast<String>());
          }
        }

        if (strokes.isNotEmpty) {
          return strokes;
        }
      }

      // Try KanjiVG
      final url3 = Uri.parse('https://raw.githubusercontent.com/KanjiVG/kanjivg/master/kanji/$codePoint.svg');
      response = await http.get(url3).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final svgContent = response.body;
        final strokes = _extractStrokesFromSVG(svgContent);

        if (strokes.isNotEmpty) {
          return strokes;
        }
      }

      // Try GlyphWiki
      final url4 = Uri.parse('https://glyphwiki.org/api.php?action=query&format=json&titles=u${codePoint.toLowerCase()}');
      response = await http.get(url4).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          final pages = data['query']?['pages'] as Map?;
          if (pages != null && pages.isNotEmpty) {
            final page = pages.values.first as Map?;
            final strokes = _extractStrokesFromGlyphWiki(page);
            
            if (strokes.isNotEmpty) {
              return strokes;
            }
          }
        } catch (e) {
          // Error parsing GlyphWiki
        }
      }

      // Try Animated Hanzi
      final url5 = Uri.parse('https://raw.githubusercontent.com/amumu/Hanzi/master/src/animate-data/${codePoint.toLowerCase()}.json');
      response = await http.get(url5).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final strokes = <String>[];
        
        if (data is List) {
          for (var stroke in data) {
            if (stroke is Map && stroke['path'] != null) {
              strokes.add(stroke['path'].toString());
            }
          }
        } else if (data is Map && data['strokes'] != null) {
          final strokeList = data['strokes'];
          if (strokeList is List) {
            strokes.addAll(strokeList.cast<String>());
          }
        }

        if (strokes.isNotEmpty) {
          return strokes;
        }
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  // Load strokes from bundled offline database
  Future<List<String>> _loadOfflineStrokes(String char) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/hsk1_strokes.json');
      final Map<String, dynamic> strokeMap = json.decode(jsonString);
      final strokes = strokeMap[char];
      
      if (strokes is List) {
        return strokes.cast<String>();
      }
    } catch (e) {
      // Offline data not available
    }
    return [];
  }

  // Helper method to extract stroke paths from KanjiVG SVG format
  List<String> _extractStrokesFromSVG(String svgContent) {
    final strokes = <String>[];
    try {
      // Extract all <path d="..."> elements that represent strokes
      final pathRegex = RegExp(r'<path[^>]*d="([^"]*)"[^>]*id="kvg:stroke[^"]*"');
      final matches = pathRegex.allMatches(svgContent);
      
      if (matches.isEmpty) {
        // Try alternative regex if kvg:stroke not found
        final altRegex = RegExp(r'd="([^"]*)"');
        for (final match in altRegex.allMatches(svgContent)) {
          final pathData = match.group(1);
          if (pathData != null && pathData.isNotEmpty && !pathData.contains('NaN')) {
            strokes.add(pathData);
          }
        }
      } else {
        for (final match in matches) {
          final pathData = match.group(1);
          if (pathData != null && pathData.isNotEmpty && !pathData.contains('NaN')) {
            strokes.add(pathData);
          }
        }
      }
    } catch (e) {
      // Error parsing SVG
    }
    return strokes;
  }

  // Helper method to extract strokes from GlyphWiki format
  List<String> _extractStrokesFromGlyphWiki(Map? page) {
    final strokes = <String>[];
    try {
      if (page == null) return strokes;
      
      final text = page['text'] as String?;
      if (text != null) {
        // GlyphWiki uses newline-separated paths
        final lines = text.split('\n');
        for (final line in lines) {
          if (line.startsWith('画:')) {
            final pathData = line.substring(2).trim();
            if (pathData.isNotEmpty) {
              strokes.add(pathData);
            }
          }
        }
      }
    } catch (e) {
      // Error parsing GlyphWiki page
    }
    return strokes;
  }
}