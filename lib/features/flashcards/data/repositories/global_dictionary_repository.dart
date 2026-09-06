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
  static const String requiredSchemaVersion = '2';

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
        final metadata = await tempDb.rawQuery(
          "SELECT value FROM dictionary_metadata WHERE key = 'dictionary_schema_version'",
        );
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
            !colNames.contains('definition_hi') ||
            metadata.isEmpty ||
            metadata.first['value'] != requiredSchemaVersion) {
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

    final q = _normalizeSearchText(query.trim());

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
      // It could be Pinyin or a translated definition. GLOB character classes
      // make localized matching case- and diacritic-insensitive without
      // applying many nested REPLACE calls to every row in the dictionary.
      final pinyinSearch = q.replaceAll(RegExp(r'[0-9]'), '');
      final cleanSearch = pinyinSearch.replaceAll(' ', '');
      final selectedDefinition = _definitionColumn(targetLanguage);
      final searchesFallback = selectedDefinition != 'definition';
      final fallbackWhere =
          searchesFallback ? " OR COALESCE(definition, '') GLOB ?" : '';
      final exactDefinitionPattern = _searchGlobPattern(q);
      final prefixDefinitionPattern = '$exactDefinitionPattern*';
      final containsDefinitionPattern = '*$exactDefinitionPattern*';

      sqlQuery = '''
        SELECT *,
          CASE 
            WHEN REPLACE(pinyin_no_tones, ' ', '') = ? THEN 1
            WHEN COALESCE($selectedDefinition, '') GLOB ? THEN 1
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 2
            WHEN COALESCE($selectedDefinition, '') GLOB ? THEN 2
            WHEN REPLACE(pinyin_no_tones, ' ', '') LIKE ? THEN 3
            WHEN COALESCE($selectedDefinition, '') GLOB ? THEN 3
            ELSE 4
          END as rank
        FROM words
        WHERE REPLACE(pinyin_no_tones, ' ', '') LIKE ?
          OR COALESCE($selectedDefinition, '') GLOB ?$fallbackWhere
        ORDER BY rank ASC, LENGTH(simplified) ASC
        LIMIT 200
      ''';
      args = [
        cleanSearch, // Pinyin exact
        exactDefinitionPattern, // Selected definition exact
        '$cleanSearch%', // Pinyin prefix
        prefixDefinitionPattern, // Selected definition prefix
        '$cleanSearch%', // Pinyin prefix
        containsDefinitionPattern, // Selected definition contains
        '%$cleanSearch%', // Match condition Pinyin
        containsDefinitionPattern, // Match condition selected definition
        if (searchesFallback)
          containsDefinitionPattern, // Match condition English fallback
      ];
    }

    try {
      final results = List<Map<String, dynamic>>.from(
        await _db!.rawQuery(sqlQuery, args),
      );
      await _attachQualityMetadata(results, targetLanguage);
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

  String _definitionColumn(String? targetLanguage) {
    final languageCode = _languageCode(targetLanguage);
    return languageCode == null ? 'definition' : 'definition_$languageCode';
  }

  static const Map<String, String> _searchCharacterReplacements = {
    'à': 'a',
    'á': 'a',
    'â': 'a',
    'ã': 'a',
    'ä': 'a',
    'å': 'a',
    'æ': 'ae',
    'ç': 'c',
    'è': 'e',
    'é': 'e',
    'ê': 'e',
    'ë': 'e',
    'ì': 'i',
    'í': 'i',
    'î': 'i',
    'ï': 'i',
    'ñ': 'n',
    'ò': 'o',
    'ó': 'o',
    'ô': 'o',
    'õ': 'o',
    'ö': 'o',
    'ø': 'o',
    'œ': 'oe',
    'ù': 'u',
    'ú': 'u',
    'û': 'u',
    'ü': 'u',
    'ý': 'y',
    'ÿ': 'y',
    'ß': 'ss',
  };

  String _normalizeSearchText(String text) {
    var normalized = text.toLowerCase();
    for (final replacement in _searchCharacterReplacements.entries) {
      normalized = normalized.replaceAll(replacement.key, replacement.value);
    }
    return normalized;
  }

  static const Map<String, String> _searchGlobCharacters = {
    'a': 'aAàÀáÁâÂãÃäÄåÅ',
    'c': 'cCçÇ',
    'e': 'eEèÈéÉêÊëË',
    'i': 'iIìÌíÍîÎïÏ',
    'n': 'nNñÑ',
    'o': 'oOòÒóÓôÔõÕöÖøØ',
    's': 'sSß',
    'u': 'uUùÙúÚûÛüÜ',
    'y': 'yYýÝÿŸ',
  };

  String _searchGlobPattern(String text) {
    final pattern = StringBuffer();
    for (final rune in text.runes) {
      final character = String.fromCharCode(rune);
      final variants = _searchGlobCharacters[character];
      if (variants != null) {
        pattern.write('[$variants]');
      } else if (RegExp(r'[a-z]').hasMatch(character)) {
        pattern.write('[$character${character.toUpperCase()}]');
      } else {
        switch (character) {
          case '*':
            pattern.write('[*]');
          case '?':
            pattern.write('[?]');
          case '[':
            pattern.write('[[]');
          default:
            pattern.write(character);
        }
      }
    }
    return pattern.toString();
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
      dictionaryWordId: (row['id'] as num).toInt(),
      englishDefinition: defEn,
      localizedDefinitionQuality:
          (row['localized_quality_score'] as num?)?.toInt(),
      isExpansionEligible: row['expansion_eligible'] == 1,
      sourceDefinitionHash: _decodeSourceHash(row['source_definition_hash']),
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
      final results = List<Map<String, dynamic>>.from(
        await _db!.rawQuery(sqlQuery, args),
      );
      await _attachQualityMetadata(results, targetLanguage);

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
      final results = List<Map<String, dynamic>>.from(await _db!.rawQuery(
        'SELECT * FROM words WHERE simplified = ? OR traditional = ?',
        [hanzi.trim(), hanzi.trim()],
      ));
      if (results.isEmpty) return null;
      if (results.length > 1) {
        final langCol = _definitionColumn(targetLanguage);
        results.sort((a, b) {
          int score(Map<String, dynamic> r) {
            int s = 0;
            final pinyin = r['pinyin'] as String? ?? '';
            final def = (r['definition'] as String? ?? '').toLowerCase();
            final loc = r[langCol] as String?;
            if (!def.startsWith('surname ')) s += 50;
            if (pinyin.isNotEmpty && pinyin[0] == pinyin[0].toLowerCase()) s += 30;
            if (loc != null && loc.trim().isNotEmpty) s += 20;
            s += (r['definition'] as String? ?? '').length.clamp(0, 10);
            return s;
          }
          return score(b).compareTo(score(a));
        });
      }
      await _attachQualityMetadata(results, targetLanguage);
      return _mapRowToCard(results.first, targetLanguage);
    } catch (e) {
      return null;
    }
  }

  /// Looks up the exact dictionary row selected by search.
  ///
  /// Unlike [getExact], this preserves the selected sense when multiple rows
  /// share the same simplified or traditional spelling.
  Future<Flashcard?> getByWordId(int wordId, {String? targetLanguage}) async {
    if (_db == null) return null;
    try {
      final results = List<Map<String, dynamic>>.from(await _db!.rawQuery(
        'SELECT * FROM words WHERE id = ? LIMIT 1',
        [wordId],
      ));
      if (results.isEmpty) return null;
      await _attachQualityMetadata(results, targetLanguage);
      return _mapRowToCard(results.first, targetLanguage);
    } catch (_) {
      return null;
    }
  }

  /// Returns the exact definition for [hanzi] in [targetLanguage], or null if not found.
  Future<String?> getExactDefinition(String hanzi,
      {String? targetLanguage}) async {
    final card = await getExact(hanzi, targetLanguage: targetLanguage);
    return card?.definition;
  }

  Future<void> _attachQualityMetadata(
    List<Map<String, dynamic>> rows,
    String? targetLanguage,
  ) async {
    final languageCode = _languageCode(targetLanguage);
    if (languageCode == null || rows.isEmpty) return;
    try {
      final ids = rows.map((row) => row['id']).toList();
      final placeholders = List.filled(ids.length, '?').join(',');
      final qualityRows = await _db!.rawQuery(
        'SELECT word_id, score, expansion_eligible, source_definition_hash '
        'FROM localized_definition_quality WHERE language_code = ? '
        'AND word_id IN ($placeholders)',
        [languageCode, ...ids],
      );
      final byId = {for (final row in qualityRows) row['word_id']: row};
      for (var index = 0; index < rows.length; index++) {
        final quality = byId[rows[index]['id']];
        if (quality != null) {
          rows[index] = {
            ...rows[index],
            'localized_quality_score': quality['score'],
            'expansion_eligible': quality['expansion_eligible'],
            'source_definition_hash': quality['source_definition_hash'],
          };
        }
      }
    } catch (_) {
      // Legacy/in-memory databases remain readable during phased rollout.
    }
  }

  String? _languageCode(String? language) {
    const codes = {
      'french': 'fr',
      'german': 'de',
      'spanish': 'es',
      'russian': 'ru',
      'italian': 'it',
      'portuguese': 'pt',
      'japanese': 'ja',
      'korean': 'ko',
      'vietnamese': 'vi',
      'indonesian': 'id',
      'arabic': 'ar',
      'hindi': 'hi',
      'thai': 'th',
    };
    if (language == null) return null;
    final normalized = language.toLowerCase().trim();
    return codes[normalized] ??
        (codes.containsValue(normalized) ? normalized : null);
  }

  String? _decodeSourceHash(Object? value) {
    if (value is String) return value;
    if (value is Uint8List) {
      return value.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
    }
    return null;
  }
}
