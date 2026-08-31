import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/utils/pinyin_utils.dart';
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

  Future<Either<String, List<Flashcard>>> search(String query, {String? targetLanguage}) async {
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
      // It's ascii or foreign text, so it could be Pinyin or a translated definition.
      final pinyinSearch = q.replaceAll(RegExp(r'[0-9]'), ''); 
      final cleanSearch = pinyinSearch.replaceAll(' ', ''); 

      sqlQuery = '''
        SELECT *,
          CASE 
            WHEN REPLACE(pinyin_no_tones, ' ', '') = ? THEN 1
            WHEN definition = ? OR definition_fr = ? OR definition_de = ? OR definition_es = ? OR definition_ru = ? OR definition_vi = ? OR definition_ja = ? OR definition_ko = ? OR definition_it = ? OR definition_pt = ? OR definition_id = ? OR definition_ar = ? OR definition_hi = ? THEN 1
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 2
            WHEN definition LIKE ? OR definition_fr LIKE ? OR definition_de LIKE ? OR definition_es LIKE ? THEN 2
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 3
            WHEN definition LIKE ? OR definition_fr LIKE ? OR definition_de LIKE ? THEN 3
            ELSE 4
          END as rank
        FROM words
        WHERE REPLACE(pinyin_no_tones, ' ', '') LIKE ? OR definition LIKE ? OR definition_fr LIKE ? OR definition_de LIKE ? OR definition_es LIKE ? OR definition_ru LIKE ? OR definition_vi LIKE ? OR definition_ja LIKE ? OR definition_ko LIKE ? OR definition_it LIKE ? OR definition_pt LIKE ? OR definition_id LIKE ? OR definition_ar LIKE ? OR definition_hi LIKE ?
        ORDER BY rank ASC, LENGTH(simplified) ASC
        LIMIT 50
      ''';
      args = [
        cleanSearch,           // Pinyin exact
        q, q, q, q, q, q, q, q, q, q, q, q, q, // Def exact (all langs)
        '$cleanSearch %',      // Pinyin boundary
        '% $q %', '% $q %', '% $q %', '% $q %', // Def boundaries
        '$cleanSearch%',       // Pinyin prefix
        '$q%', '$q%', '$q%',   // Def prefix
        '%$cleanSearch%',      // Match condition Pinyin
        '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%' // Match condition Def
      ];
    }

    try {
      final results = await _db!.rawQuery(sqlQuery, args);
      
      final List<Flashcard> cards = results.map<Flashcard>((row) {
        return _mapRowToCard(row, targetLanguage);
      }).toList();

      return Right(cards);
    } catch (e) {
      return Left("Search failed: $e");
    }
  }

  Flashcard _mapRowToCard(Map<String, dynamic> row, [String? targetLanguage]) {
    final rawPinyin = row['pinyin'] as String? ?? '';
    final defEn = row['definition'] as String? ?? '';
    
    String? localizedDef;
    if (targetLanguage != null && targetLanguage.isNotEmpty) {
      final lang = targetLanguage.toLowerCase().trim();
      switch (lang) {
        case 'fr':
        case 'french':
          localizedDef = row['definition_fr'] as String?;
          break;
        case 'de':
        case 'german':
          localizedDef = row['definition_de'] as String?;
          break;
        case 'es':
        case 'spanish':
          localizedDef = row['definition_es'] as String?;
          break;
        case 'ru':
        case 'russian':
          localizedDef = row['definition_ru'] as String?;
          break;
        case 'vi':
        case 'vietnamese':
          localizedDef = row['definition_vi'] as String?;
          break;
        case 'ja':
        case 'japanese':
          localizedDef = row['definition_ja'] as String?;
          break;
        case 'ko':
        case 'korean':
          localizedDef = row['definition_ko'] as String?;
          break;
        case 'it':
        case 'italian':
          localizedDef = row['definition_it'] as String?;
          break;
        case 'pt':
        case 'portuguese':
          localizedDef = row['definition_pt'] as String?;
          break;
        case 'id':
        case 'indonesian':
          localizedDef = row['definition_id'] as String?;
          break;
        case 'ar':
        case 'arabic':
          localizedDef = row['definition_ar'] as String?;
          break;
        case 'hi':
        case 'hindi':
          localizedDef = row['definition_hi'] as String?;
          break;
      }
    }

    final chosenDef = (localizedDef != null && localizedDef.trim().isNotEmpty)
        ? localizedDef.trim()
        : defEn;

    return Flashcard(
      id: 'global_${row['id']}',
      hanzi: row['simplified'] as String,
      pinyin: PinyinUtils.convertNumericToMarks(rawPinyin),
      definition: chosenDef,
      hskLevel: 0,
      strokePaths: const [],
      modeStats: const {},
    );
  }

  Future<Either<String, List<Flashcard>>> getWordsContaining(String character, {int limit = 6, String? targetLanguage}) async {
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
        return _mapRowToCard(row, targetLanguage);
      }).toList();

      return Right(cards);
    } catch (e) {
      return Left("Failed to get common words: $e");
    }
  }

  /// Looks up a single character/word exactly. Fast single-row query.
  Future<Flashcard?> getExact(String hanzi, {String? targetLanguage}) async {
    if (_db == null || hanzi.trim().isEmpty) return null;
    try {
      final results = await _db!.rawQuery(
        'SELECT * FROM words WHERE simplified = ? OR traditional = ? LIMIT 1',
        [hanzi.trim(), hanzi.trim()],
      );
      if (results.isEmpty) return null;
      return _mapRowToCard(results.first, targetLanguage);
    } catch (e) {
      return null;
    }
  }

  /// Returns the exact definition for [hanzi] in [targetLanguage], or null if not found.
  Future<String?> getExactDefinition(String hanzi, {String? targetLanguage}) async {
    final card = await getExact(hanzi, targetLanguage: targetLanguage);
    return card?.definition;
  }
}
