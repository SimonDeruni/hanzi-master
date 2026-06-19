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
    
    // Check if it's hanzi
    final isHanzi = RegExp(r'[\u4e00-\u9fa5]').hasMatch(q);

    String sqlQuery;
    List<dynamic> args;

    if (isHanzi) {
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
      // It's ascii, so it could be Pinyin or an English word (e.g. "switzerland").
      // We will search BOTH columns and rank them.
      final pinyinSearch = q.replaceAll(RegExp(r'[0-9]'), ''); 
      final cleanSearch = pinyinSearch.replaceAll(' ', ''); 

      sqlQuery = '''
        SELECT *,
          CASE 
            WHEN REPLACE(pinyin_no_tones, ' ', '') = ? THEN 1
            WHEN definition = ? THEN 1
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 2
            WHEN definition LIKE ? OR definition LIKE ? OR definition LIKE ? OR definition LIKE ? THEN 2
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 3
            WHEN definition LIKE ? THEN 3
            ELSE 4
          END as rank
        FROM words
        WHERE REPLACE(pinyin_no_tones, ' ', '') LIKE ? OR definition LIKE ?
        ORDER BY rank ASC, LENGTH(simplified) ASC
        LIMIT 50
      ''';
      args = [
        cleanSearch,           // Pinyin exact
        q,                     // Def exact
        '$cleanSearch %',      // Pinyin boundary
        '$q %', '% $q %', '% $q', '%($q)%', // Def boundaries
        '$cleanSearch%',       // Pinyin prefix
        '$q%',                 // Def prefix
        '%$cleanSearch%',      // Match condition Pinyin
        '%$q%'                 // Match condition Def
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
          modeStats: const {},
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

    const sqlQuery = '''
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
          modeStats: const {},
        );
      }).toList();

      return Right(cards);
    } catch (e) {
      return Left("Failed to get common words: $e");
    }
  }

  /// Looks up a single character/word exactly. Fast single-row query.
  Future<Flashcard?> getExact(String hanzi) async {
    if (_db == null || hanzi.trim().isEmpty) return null;
    try {
      final results = await _db!.rawQuery(
        'SELECT * FROM words WHERE simplified = ? LIMIT 1',
        [hanzi.trim()],
      );
      if (results.isEmpty) return null;
      final row = results.first;
      return Flashcard(
        id: 'global_${row['id']}',
        hanzi: row['simplified'] as String,
        pinyin: row['pinyin'] as String,
        definition: row['definition'] as String,
        hskLevel: 0,
        strokePaths: const [],
        modeStats: const {},
      );
    } catch (e) {
      return null;
    }
  }
}
