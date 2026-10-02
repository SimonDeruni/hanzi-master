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

  /// The schema version this build expects in `assets/data/dictionary.db`.
  ///
  /// Bumping this is what makes an already-installed app replace its local copy of
  /// the dictionary. The bundled asset advertises the same value in
  /// `dictionary_metadata.dictionary_schema_version`; `init` re-copies the asset
  /// whenever the two disagree, so an install carrying an older dictionary picks up
  /// the new one on next launch without any migration step.
  ///
  /// Version 3 (2026-09-29) replaced the previous dictionary, whose localised values
  /// came partly from sources that were never licence-verified, with one built only
  /// from sources whose licences permit commercial redistribution, and added the
  /// `localized_definition_provenance` table which marks each machine-translated
  /// value so it can be labelled in the UI.
  static const String requiredSchemaVersion = '3';

  /// The content version this build expects, mirrored from
  /// `dictionary_metadata.dictionary_content_version`.
  ///
  /// The schema version alone is not enough to guarantee a device stops reading
  /// a stale copy: it is a string the *previous* asset also chose, and the
  /// licence audit replaced the dictionary's contents without changing the shape
  /// of its tables. A device still holding the pre-audit dictionary (its
  /// definitions came partly from sources that were never licence-verified, and
  /// its localised cells were thin) therefore kept it, and the reader saw the
  /// old English glosses — which is what the reported deck screens showed.
  /// Comparing the content version makes the copy self-invalidating: an asset
  /// that does not advertise this exact build is replaced on next launch.
  static const String requiredContentVersion = 'accepted-sources-v2+deepseek-mt';


  /// Headwords a usable copy must be able to answer for.
  ///
  /// Every everyday character here is present in any CC-CEDICT-derived entry
  /// list, so a copy that cannot answer one of them is not a smaller
  /// dictionary, it is a damaged one. `init` treats such a copy as stale and
  /// copies the bundled asset over it — see [copyAnswersQueries].
  static const List<String> _probeHeadwords = <String>['不', '好', '我', '你', '是'];

  String? _lastFailure;

  /// Whether the dictionary is open and answering.
  ///
  /// Callers need this to tell "the dictionary could not be read" apart from
  /// "this character is not in the dictionary": both used to surface as a `null`
  /// card, which the UI rendered as an empty Quick Look panel.
  bool get isReady => _db != null && _lastFailure == null;

  /// The last lookup or initialisation failure, if any.
  String? get lastFailure => _lastFailure;

  GlobalDictionaryRepository();

  @visibleForTesting
  GlobalDictionaryRepository.forTesting(
    Database database,
    Map<String, int> popularityRanks,
  )   : _db = database,
        _popularityRanks = popularityRanks;

  /// Opens the dictionary, repairing the local copy when it cannot be trusted.
  ///
  /// [forceRepair] discards the local copy and takes the bundled asset again.
  /// The file is ~250 MB, so that only happens on an explicit request (a user
  /// retrying a Quick Look card) or when [init] itself finds the copy unusable.
  Future<void> init({bool forceRepair = false}) async {
    if (forceRepair) {
      await _db?.close();
      _db = null;
    } else if (_db != null) {
      return;
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbDir = await getApplicationSupportDirectory();
    final dbPath = join(dbDir.path, "dictionary.db");
    final file = File(dbPath);

    if (forceRepair) {
      _lastFailure = null;
      try {
        if (await file.exists()) await file.delete();
      } catch (e) {
        debugPrint('Could not delete the local dictionary copy: $e');
      }
    }

    bool needsRefresh = false;
    if (!await file.exists()) {
      needsRefresh = true;
    } else {
      try {
        // Verify that the local database has the complete multilingual schema
        final tempDb = await databaseFactory.openDatabase(dbPath);
        try {
          final cols = await tempDb.rawQuery("PRAGMA table_info(words)");
          final colNames = cols.map((c) => c['name'] as String).toSet();
          final metadata = await tempDb.rawQuery(
            "SELECT key, value FROM dictionary_metadata WHERE key IN "
            "('dictionary_schema_version', 'dictionary_content_version')",
          );
          final Map<String, String> keys = <String, String>{
            for (final Map<String, Object?> row in metadata)
              row['key']! as String: row['value']! as String,
          };

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
              keys['dictionary_schema_version'] != requiredSchemaVersion ||
              keys['dictionary_content_version'] != requiredContentVersion) {
            needsRefresh = true;
          }

          // The version stamps above are necessary but not sufficient. A copy
          // interrupted half-way through still advertises them, and every
          // lookup against it afterwards returns nothing — which is exactly the
          // state the Quick Look card could not describe. Asking the copy for a
          // few everyday headwords makes that detectable, and therefore
          // repairable, before anything reads a definition from it.
          if (!needsRefresh && !await copyAnswersQueries(tempDb)) {
            debugPrint('The local dictionary copy cannot answer lookups; '
                're-copying assets/data/dictionary.db');
            needsRefresh = true;
          }
        } finally {
          await tempDb.close();
        }
      } catch (e) {
        debugPrint('The local dictionary copy is unreadable ($e); re-copying.');
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
        _lastFailure = 'Failed to load global dictionary: $e';
        throw Exception(_lastFailure);
      }
    }

    try {
      _db = await databaseFactory.openDatabase(dbPath);
    } catch (e) {
      _lastFailure = 'Failed to open global dictionary: $e';
      rethrow;
    }
    _popularityRanks = await _loadPopularityRanks();
  }

  /// Whether [db] can answer for the everyday headwords a dictionary must hold.
  ///
  /// A copy that fails this is treated as unusable and replaced by the bundled
  /// asset. Exposed for tests: the failure it guards against is otherwise
  /// invisible, because lookups against such a copy return an empty result
  /// instead of an error.
  @visibleForTesting
  static Future<bool> copyAnswersQueries(Database db) async {
    try {
      for (final headword in _probeHeadwords) {
        final rows = await db.rawQuery(
          'SELECT rowid FROM words WHERE simplified = ? OR traditional = ? '
          'LIMIT 1',
          [headword, headword],
        );
        if (rows.isEmpty) return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, int>> _loadPopularityRanks() async {
    final ranks = <String, int>{};

    // Seed high-priority everyday Chinese foundation phrases at rank 0
    // so essential words like 你好 (hello), 谢谢 (thank you), 再见 (goodbye)
    // always outrank obscure homophones or rare characters.
    const foundationPhrases = [
      '你好',
      '您好',
      '谢谢',
      '不客气',
      '再见',
      '对不起',
      '没关系',
      '早上好',
      '晚上好',
      '晚安',
      '请问',
      '欢迎',
    ];
    for (final phrase in foundationPhrases) {
      ranks[phrase] = 0;
    }

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
    final hanzi = row['simplified'] as String;
    final int rank = _popularityRanks[hanzi] ??
        _popularityRanks[row['traditional'] as String? ?? ''] ??
        0;
    final int hskLevel = (rank >= 1 && rank <= 6) ? rank : 0;

    return Flashcard(
      id: 'global_${row['id']}',
      hanzi: hanzi,
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
      hskLevel: hskLevel,
      strokePaths: const [],
      modeStats: const {},
    );
  }

  Future<Either<String, List<Flashcard>>> getWordsContaining(String character,
      {int limit = 6, String? targetLanguage}) async {
    if (_db == null) return const Left("Global Dictionary not initialized");
    if (character.trim().isEmpty) return const Right([]);

    // Pull a wider candidate pool than we return: the dictionary has no
    // frequency column, so meaningful ranking happens in Dart against the
    // in-memory HSK rank table. Length-ordered SQL alone surfaced obscure
    // two-character words instead of genuinely common ones.
    const sqlQuery = '''
      SELECT *
      FROM words 
      WHERE (simplified LIKE ? OR traditional LIKE ?)
        AND simplified != ?
        AND traditional != ?
      LIMIT ?
    ''';

    final args = [
      '%$character%',
      '%$character%',
      character,
      character,
      _wordCandidatePool,
    ];

    try {
      final results = List<Map<String, dynamic>>.from(
        await _db!.rawQuery(sqlQuery, args),
      );
      await _attachQualityMetadata(results, targetLanguage);

      results.sort(_compareWordRows);

      final List<Flashcard> cards = _dedupeBySimplified(results)
          .take(limit)
          .map<Flashcard>((row) => _mapRowToCard(row, targetLanguage))
          .toList();

      return Right(cards);
    } catch (e) {
      return Left("Failed to get common words: $e");
    }
  }

  /// Candidates fetched before ranking. Large enough to contain the HSK words
  /// for common characters, small enough to stay cheap on every card open.
  static const int _wordCandidatePool = 400;

  /// Orders related words by usefulness:
  ///   1. HSK level (1–6), so taught vocabulary wins over dictionary-only words
  ///   2. shorter words, since 2-character words are the common compounds
  ///   3. dictionary order, as a stable tie-breaker
  int _compareWordRows(
    Map<String, dynamic> left,
    Map<String, dynamic> right,
  ) {
    final leftHanzi = left['simplified'] as String? ?? '';
    final rightHanzi = right['simplified'] as String? ?? '';

    final popularityComparison =
        _popularityRank(leftHanzi).compareTo(_popularityRank(rightHanzi));
    if (popularityComparison != 0) return popularityComparison;

    final lengthComparison = leftHanzi.length.compareTo(rightHanzi.length);
    if (lengthComparison != 0) return lengthComparison;

    return (left['id'] as num).toInt().compareTo((right['id'] as num).toInt());
  }

  /// Drops duplicate `simplified` entries, keeping the best-ranked row.
  ///
  /// The dictionary stores simplified and traditional variants as separate rows,
  /// so a word like 好吃 can appear twice and would otherwise be listed twice.
  List<Map<String, dynamic>> _dedupeBySimplified(
      List<Map<String, dynamic>> rows) {
    final seen = <String>{};
    final out = <Map<String, dynamic>>[];
    for (final row in rows) {
      final hanzi = row['simplified'] as String? ?? '';
      if (hanzi.isEmpty || !seen.add(hanzi)) continue;
      out.add(row);
    }
    return out;
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
      // Returning an empty result for a failed read is what made a damaged
      // local copy indistinguishable from an unknown character. The card still
      // gets nothing, but now it can be told *why* — and retried.
      _lastFailure = 'getExact($hanzi): $e';
      debugPrint('GlobalDictionaryRepository.getExact failed: $e');
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

  /// The specific row a card is pinned to: [wordId], but only while that row
  /// still spells [hanzi].
  ///
  /// A card that came from the dictionary remembers the row it was built from,
  /// and this is how that identity is spent: 的 has four rows (de5, dí, dì, dī),
  /// so the row — not the spelling — is what keeps the reader on the sense and
  /// on the reading they were looking at. The spelling check is what makes the
  /// id safe to trust: row ids are minted by whichever build shipped
  /// `dictionary.db`, [init] replaces a stale copy wholesale, and an id saved
  /// against the previous copy can land on an unrelated row in the current one.
  /// A `null` here sends the caller back to [getExact], which answers from the
  /// spelling alone.
  Future<Flashcard?> getPinnedRow(
    int wordId,
    String hanzi, {
    String? targetLanguage,
  }) async {
    if (_db == null || hanzi.trim().isEmpty) return null;
    try {
      final results = List<Map<String, dynamic>>.from(await _db!.rawQuery(
        'SELECT * FROM words WHERE id = ? AND (simplified = ? OR traditional = ?) '
        'LIMIT 1',
        [wordId, hanzi.trim(), hanzi.trim()],
      ));
      if (results.isEmpty) return null;
      await _attachQualityMetadata(results, targetLanguage);
      return _mapRowToCard(results.first, targetLanguage);
    } catch (e) {
      _lastFailure = 'getPinnedRow($wordId, $hanzi): $e';
      debugPrint('GlobalDictionaryRepository.getPinnedRow failed: $e');
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
