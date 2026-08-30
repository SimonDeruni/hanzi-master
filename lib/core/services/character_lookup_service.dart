import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/flashcards/data/repositories/global_dictionary_repository.dart';
import '../utils/pinyin_utils.dart';

/// A lightweight character info object returned by the lookup service.
class CharacterInfo {
  final String hanzi;
  final String pinyin;
  final String definition;
  final int hskLevel; // 1–6, or 0 if not in HSK

  const CharacterInfo({
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    required this.hskLevel,
  });
}

/// Provides fast character lookups against:
///   1. The HSK 1–6 vocabulary bundles (for HSK level tagging).
///   2. The full dictionary.db (23MB, CEDICT-based, ~100k+ entries) for any
///      character not in HSK or for richer data.
///
/// Usage: `ref.read(characterLookupServiceProvider).lookup('好')`
class CharacterLookupService {
  final GlobalDictionaryRepository _db;

  /// Map from hanzi → hsk level, built from bundled JSON at init.
  final Map<String, int> _hskLevelMap = {};

  bool _initialized = false;

  CharacterLookupService(this._db);

  /// Call once (e.g. in app startup or first use). Idempotent.
  Future<void> init() async {
    if (_initialized) return;
    await _db.init();
    await _buildHskLevelMap();
    _initialized = true;
  }

  Future<void> _buildHskLevelMap() async {
    // HSK1 has a different structure (flat array), 2–6 use bundle format.
    try {
      final hsk1Raw = await rootBundle.loadString('assets/data/hsk1.json');
      final List<dynamic> hsk1List = json.decode(hsk1Raw);
      for (final item in hsk1List) {
        _hskLevelMap[item['hanzi'] as String] = 1;
      }
    } catch (_) {}

    for (int level = 2; level <= 6; level++) {
      try {
        final raw = await rootBundle.loadString('assets/data/hsk${level}_bundle.json');
        final Map<String, dynamic> bundle = json.decode(raw);
        final List<dynamic> vocab = bundle['vocabulary'] ?? [];
        for (final item in vocab) {
          final hanzi = item['hanzi'] as String? ?? '';
          if (hanzi.isNotEmpty) {
            _hskLevelMap[hanzi] = level;
          }
        }
      } catch (_) {}
    }
  }

  /// Looks up a single character or word.
  ///
  /// Returns null if truly unknown (not in dictionary.db either).
  Future<CharacterInfo?> lookup(String hanzi) async {
    if (!_initialized) await init();
    final card = await _db.getExact(hanzi);
    if (card == null) return null;
    return CharacterInfo(
      hanzi: card.hanzi,
      pinyin: PinyinUtils.convertNumericToMarks(card.pinyin),
      definition: card.definition,
      hskLevel: _hskLevelMap[hanzi] ?? 0,
    );
  }

  /// Bulk-lookup a list of characters. Returns only those that were found.
  /// De-duplicates results by hanzi.
  Future<List<CharacterInfo>> lookupAll(Iterable<String> chars) async {
    if (!_initialized) await init();
    final seen = <String>{};
    final results = <CharacterInfo>[];
    for (final c in chars) {
      if (seen.contains(c)) continue;
      seen.add(c);
      final info = await lookup(c);
      if (info != null) results.add(info);
    }
    return results;
  }

  /// Whether the service has been initialized.
  bool get isReady => _initialized;
}

// ─── Providers ──────────────────────────────────────────────────────────────

final globalDictionaryRepositoryProvider = Provider<GlobalDictionaryRepository>((ref) {
  return GlobalDictionaryRepository();
});

final characterLookupServiceProvider = Provider<CharacterLookupService>((ref) {
  final repo = ref.watch(globalDictionaryRepositoryProvider);
  return CharacterLookupService(repo);
});
