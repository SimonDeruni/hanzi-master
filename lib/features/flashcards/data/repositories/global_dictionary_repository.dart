import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/utils/pinyin_utils.dart';
import '../../domain/entities/flashcard.dart';

class GlobalDictionaryRepository {
  Database? _db;
  Map<String, int> _popularityRanks = const {};

  static const int _unrankedPopularity = 1000000;

  GlobalDictionaryRepository();

  @visibleForTesting
  GlobalDictionaryRepository.forTesting(
    Database database,
    Map<String, int> popularityRanks,
  )   : _db = database,
        _popularityRanks = popularityRanks;

  Future<void> init() async {
    if (_db != null) return;

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbDir = await getApplicationSupportDirectory();
    final dbPath = join(dbDir.path, "dictionary.db");
    final file = File(dbPath);

    bool needsRefresh = false;
    if (!await file.exists()) {
      needsRefresh = true;
    } else {
      try {
        // Verify that the local database has the complete multilingual schema
        final tempDb = await databaseFactory.openDatabase(dbPath);
        final cols = await tempDb.rawQuery("PRAGMA table_info(words)");
        final colNames = cols.map((c) => c['name'] as String).toSet();
        await tempDb.close();

        if (!colNames.contains('definition_fr') ||
            !colNames.contains('definition_ru') ||
            !colNames.contains('definition_vi') ||
            !colNames.contains('definition_ja') ||
            !colNames.contains('definition_es') ||
            !colNames.contains('definition_ko') ||
            !colNames.contains('definition_id') ||
            !colNames.contains('definition_th') ||
            !colNames.contains('definition_pt') ||
            !colNames.contains('definition_it') ||
            !colNames.contains('definition_de') ||
            !colNames.contains('definition_ar') ||
            !colNames.contains('definition_hi')) {
          needsRefresh = true;
        }

      } catch (_) {
        needsRefresh = true;
      }
    }

    if (needsRefresh) {
      try {
        final data = await rootBundle.load("assets/data/dictionary.db");
        final bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(dbPath).writeAsBytes(bytes, flush: true);
      } catch (e) {
        throw Exception("Failed to load global dictionary: $e");
      }
    }

    _db = await databaseFactory.openDatabase(dbPath);
    _popularityRanks = await _loadPopularityRanks();
  }

  Future<Map<String, int>> _loadPopularityRanks() async {
    final ranks = <String, int>{};

    try {
      final assets = await Future.wait([
        rootBundle.loadString('assets/data/hsk1.json'),
        for (var level = 2; level <= 6; level++)
          rootBundle.loadString('assets/data/hsk${level}_bundle.json'),
      ]);

      for (var index = 0; index < assets.length; index++) {
        final level = index + 1;
        final decoded = jsonDecode(assets[index]);
        final vocabulary = decoded is List
            ? decoded
            : (decoded as Map<String, dynamic>)['vocabulary'] as List<dynamic>;

        for (final entry in vocabulary.cast<Map<String, dynamic>>()) {
          final hanzi = (entry['hanzi'] as String? ?? '').trim();
          if (hanzi.isNotEmpty) ranks.putIfAbsent(hanzi, () => level);
        }
      }
    } catch (_) {
      // Search remains available if an optional popularity asset cannot load.
    }

    return ranks;
  }

  Future<Either<String, List<Flashcard>>> search(String query,
      {String? targetLanguage}) async {
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
        LIMIT 200
      ''';
      args = [
        q, q, // 1: Exact
        '$q%', '$q%', // 2: Prefix
        '%$q%', '%$q%' // Match condition
      ];
    } else {
      // It's ascii or foreign text, so it could be Pinyin or a translated definition.
      final pinyinSearch = q.replaceAll(RegExp(r'[0-9]'), '');
      final cleanSearch = pinyinSearch.replaceAll(' ', '');

      sqlQuery = '''
        SELECT *,
          CASE 
            WHEN REPLACE(pinyin_no_tones, ' ', '') = ? THEN 1
            WHEN LOWER(definition) = ? OR LOWER(definition_fr) = ? OR LOWER(definition_de) = ? OR LOWER(definition_es) = ? OR LOWER(definition_ru) = ? OR LOWER(definition_vi) = ? OR LOWER(definition_ja) = ? OR LOWER(definition_ko) = ? OR LOWER(definition_it) = ? OR LOWER(definition_pt) = ? OR LOWER(definition_id) = ? OR LOWER(definition_th) = ? OR LOWER(definition_ar) = ? OR LOWER(definition_hi) = ? THEN 1
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 2
            WHEN LOWER(definition) LIKE ? OR LOWER(definition_fr) LIKE ? OR LOWER(definition_de) LIKE ? OR LOWER(definition_es) LIKE ? THEN 2
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 3
            WHEN LOWER(definition) LIKE ? OR LOWER(definition_fr) LIKE ? OR LOWER(definition_de) LIKE ? THEN 3
            ELSE 4
          END as rank
        FROM words
        WHERE REPLACE(pinyin_no_tones, ' ', '') LIKE ? OR LOWER(definition) LIKE ? OR LOWER(definition_fr) LIKE ? OR LOWER(definition_de) LIKE ? OR LOWER(definition_es) LIKE ? OR LOWER(definition_ru) LIKE ? OR LOWER(definition_vi) LIKE ? OR LOWER(definition_ja) LIKE ? OR LOWER(definition_ko) LIKE ? OR LOWER(definition_it) LIKE ? OR LOWER(definition_pt) LIKE ? OR LOWER(definition_id) LIKE ? OR LOWER(definition_th) LIKE ? OR LOWER(definition_ar) LIKE ? OR LOWER(definition_hi) LIKE ?
        ORDER BY rank ASC, LENGTH(simplified) ASC
        LIMIT 200
      ''';
      args = [
        cleanSearch, // Pinyin exact
        q, q, q, q, q, q, q, q, q, q, q, q, q, q, // Def exact (all langs)
        '$cleanSearch %', // Pinyin boundary
        '% $q %', '% $q %', '% $q %', '% $q %', // Def boundaries
        '$cleanSearch%', // Pinyin prefix
        '$q%', '$q%', '$q%', // Def prefix
        '%$cleanSearch%', // Match condition Pinyin
        '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%', '%$q%',
        '%$q%', '%$q%', '%$q%', '%$q%', '%$q%' // Match condition Def
      ];
    }

    try {
      final results = List<Map<String, dynamic>>.from(
        await _db!.rawQuery(sqlQuery, args),
      );
      results.sort(_compareSearchRows);

      final List<Flashcard> cards = results.take(50).map<Flashcard>((row) {
        return _mapRowToCard(row, targetLanguage);
      }).toList();

      return Right(cards);
    } catch (e) {
      return Left("Search failed: $e");
    }
  }

  int _compareSearchRows(
    Map<String, dynamic> left,
    Map<String, dynamic> right,
  ) {
    final relevanceComparison =
        (left['rank'] as num).toInt().compareTo((right['rank'] as num).toInt());
    if (relevanceComparison != 0) return relevanceComparison;

    final leftHanzi = left['simplified'] as String? ?? '';
    final rightHanzi = right['simplified'] as String? ?? '';
    final popularityComparison =
        _popularityRank(leftHanzi).compareTo(_popularityRank(rightHanzi));
    if (popularityComparison != 0) return popularityComparison;

    final lengthComparison = leftHanzi.length.compareTo(rightHanzi.length);
    if (lengthComparison != 0) return lengthComparison;

    return (left['id'] as num).toInt().compareTo((right['id'] as num).toInt());
  }

  int _popularityRank(String hanzi) =>
      _popularityRanks[hanzi] ?? _unrankedPopularity;

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
        case 'th':
        case 'thai':
          localizedDef = row['definition_th'] as String?;
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

    final hasLocalizedDefinition =
        localizedDef != null && localizedDef.trim().isNotEmpty;
    final chosenDef = hasLocalizedDefinition ? localizedDef.trim() : defEn;

    return Flashcard(
      id: 'global_${row['id']}',
      hanzi: row['simplified'] as String,
      pinyin: PinyinUtils.convertNumericToMarks(rawPinyin),
      definition: chosenDef,
      definitionLanguage:
          hasLocalizedDefinition ? targetLanguage!.trim() : 'English',
      hskLevel: 0,
      strokePaths: const [],
      modeStats: const {},
    );
  }

  Future<Either<String, List<Flashcard>>> getWordsContaining(String character,
      {int limit = 6, String? targetLanguage}) async {
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
  Future<String?> getExactDefinition(String hanzi,
      {String? targetLanguage}) async {
    final card = await getExact(hanzi, targetLanguage: targetLanguage);
    return card?.definition;
  }
}
