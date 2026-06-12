import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/flashcard.dart';

class GlobalDictionaryRepository {
  Database? _db;

  Future<void> init() async {
    if (_db != null) return;

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbDir = await getApplicationSupportDirectory();
    final dbPath = join(dbDir.path, "dictionary.db");

    // Copy from assets if it doesn't exist
    if (!await File(dbPath).exists()) {
      try {
        final data = await rootBundle.load("assets/data/dictionary.db");
        final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(dbPath).writeAsBytes(bytes, flush: true);
      } catch (e) {
        throw Exception("Failed to load global dictionary: $e");
      }
    }

    _db = await databaseFactory.openDatabase(dbPath);
  }

  Future<Either<String, List<Flashcard>>> search(String query) async {
    if (_db == null) return const Left("Global Dictionary not initialized");
    if (query.trim().isEmpty) return const Right([]);

    final q = query.trim().toLowerCase();
    
    // Check if it's pinyin (only ascii characters)
    final isPinyin = RegExp(r'^[a-z\s0-9]+$').hasMatch(q);
    
    // Check if it's hanzi
    final isHanzi = RegExp(r'[\u4e00-\u9fa5]').hasMatch(q);

    String sqlQuery;
    List<dynamic> args;

    if (isPinyin) {
      final pinyinSearch = q.replaceAll(RegExp(r'[0-9]'), ''); // Strip numbers for robust matching
      final cleanSearch = pinyinSearch.replaceAll(' ', ''); // Strip spaces to match both spaced and unspaced

      sqlQuery = '''
        SELECT *,
          CASE 
            WHEN REPLACE(pinyin_no_tones, ' ', '') = ? THEN 1
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 2
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 3
            ELSE 4
          END as rank
        FROM words
        WHERE REPLACE(pinyin_no_tones, ' ', '') LIKE ?
        ORDER BY rank ASC, LENGTH(simplified) ASC
        LIMIT 50
      ''';
      args = [
        cleanSearch,           // 1: Exact
        '$cleanSearch %',      // 2: Exact word boundary (e.g. searching 'de' finding 'de guo')
        '$cleanSearch%',       // 3: Prefix
        '%$cleanSearch%',      // Match condition
      ];
    } else if (isHanzi) {
      sqlQuery = '''
        SELECT *,
          CASE 
            WHEN simplified = ? OR traditional = ? THEN 1
            WHEN simplified LIKE ? OR traditional LIKE ? THEN 2
            ELSE 3
          END as rank
        FROM words 
        WHERE simplified LIKE ? OR traditional LIKE ? 
        ORDER BY rank ASC, LENGTH(simplified) ASC
        LIMIT 50
      ''';
      args = [
        q, q,                  // 1: Exact
        '$q%', '$q%',          // 2: Prefix
        '%$q%', '%$q%'         // Match condition
      ];
    } else {
      // English definition search
      sqlQuery = '''
        SELECT *,
          CASE 
            WHEN definition = ? THEN 1
            WHEN definition LIKE ? OR definition LIKE ? OR definition LIKE ? OR definition LIKE ? THEN 2
            WHEN definition LIKE ? THEN 3
            ELSE 4
          END as rank
        FROM words 
        WHERE definition LIKE ? 
        ORDER BY rank ASC, LENGTH(simplified) ASC
        LIMIT 50
      ''';
      args = [
        q,                     // 1: Exact definition match
        '$q %', '% $q %', '% $q', '%($q)%', // 2: Word boundary matches
        '$q%',                 // 3: Prefix match
        '%$q%'                 // Match condition
      ];
    }

    try {
      final results = await _db!.rawQuery(sqlQuery, args);
      
      final List<Flashcard> cards = results.map<Flashcard>((row) {
        return Flashcard(
          id: 'global_${row['id']}',
          hanzi: row['simplified'] as String,
          pinyin: row['pinyin'] as String,
          definition: row['definition'] as String,
          hskLevel: 0,
          strokePaths: const [],
          nextReviewDate: DateTime.now(),
          interval: 0,
          easeFactor: 2.5,
          streak: 0,
        );
      }).toList();

      return Right(cards);
    } catch (e) {
      return Left("Search failed: $e");
    }
  }

  Future<Either<String, List<Flashcard>>> getWordsContaining(String character, {int limit = 6}) async {
    if (_db == null) return const Left("Global Dictionary not initialized");
    if (character.trim().isEmpty) return const Right([]);

    final sqlQuery = '''
      SELECT *
      FROM words 
      WHERE (simplified LIKE ? OR traditional LIKE ?)
        AND simplified != ?
        AND traditional != ?
      ORDER BY LENGTH(simplified) ASC
      LIMIT ?
    ''';
    
    final args = ['%$character%', '%$character%', character, character, limit];

    try {
      final results = await _db!.rawQuery(sqlQuery, args);
      
      final List<Flashcard> cards = results.map<Flashcard>((row) {
        return Flashcard(
          id: 'global_${row['id']}',
          hanzi: row['simplified'] as String,
          pinyin: row['pinyin'] as String,
          definition: row['definition'] as String,
          hskLevel: 0,
          strokePaths: const [],
          nextReviewDate: DateTime.now(),
          interval: 0,
          easeFactor: 2.5,
          streak: 0,
        );
      }).toList();

      return Right(cards);
    } catch (e) {
      return Left("Failed to get common words: $e");
    }
  }
}
