import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'dictionary_provider.g.dart';

final searchFocusRequestProvider = StateProvider<bool>((ref) => false);

class DictionaryEntry {
  final String hanzi;
  final String pinyin;
  final String definition;
  final int hskLevel;
  final bool inLibrary;

  DictionaryEntry({
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    required this.hskLevel,
    this.inLibrary = false,
  });
}

@Riverpod(keepAlive: true)
class MasterDictionary extends _$MasterDictionary {
  final Map<String, DictionaryEntry> _allEntries = {};
  final Set<String> _vocabulary = {};
  bool _isInitialized = false;

  @override
  Future<void> build() async {
    if (_isInitialized) return;
    await _loadData();
    _isInitialized = true;
  }

  Future<void> _loadData() async {
    try {
      for (int level = 1; level <= 6; level++) {
        final String fileName = level == 1 ? 'assets/data/hsk1.json' : 'assets/data/hsk${level}_bundle.json';
        final jsonString = await rootBundle.loadString(fileName);
        if (jsonString.isNotEmpty) {
          final dynamic decoded = json.decode(jsonString);
          final List<dynamic> vocabulary;
          
          if (level == 1) {
            vocabulary = decoded as List<dynamic>;
          } else {
            vocabulary = (decoded as Map<String, dynamic>)['vocabulary'] as List<dynamic>;
          }

          for (var item in vocabulary) {
            final entry = DictionaryEntry(
              hanzi: item['hanzi'],
              pinyin: PinyinUtils.convertNumericToMarks(item['pinyin'] ?? ''),
              definition: item['definition'],
              hskLevel: level,
            );
            if (!_allEntries.containsKey(entry.hanzi)) {
              _allEntries[entry.hanzi] = entry;
            }
            _vocabulary.add(entry.hanzi);
          }
        }
      }
    } catch (e) {
      debugPrint("Dictionary load error: $e");
    }
  }

  /// Lookup a word/character in the master dictionary
  DictionaryEntry? lookup(String hanzi) {
    // Check user library first via the flashcard controller
    final libraryCards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
    final libMatch = libraryCards.firstWhere((c) => c.hanzi == hanzi, orElse: () => Flashcard(id: '', hanzi: '', pinyin: '', definition: '', hskLevel: 0, strokePaths: const [], modeStats: const {}));
    
    if (libMatch.hanzi.isNotEmpty) {
      return DictionaryEntry(
        hanzi: libMatch.hanzi,
        pinyin: libMatch.pinyin,
        definition: libMatch.definition,
        hskLevel: libMatch.hskLevel,
        inLibrary: true,
      );
    }

    return _allEntries[hanzi];
  }

  /// Segment text using Maximum Forward Matching (MFM)
  List<String> segment(String text) {
    final List<String> result = [];
    int start = 0;
    while (start < text.length) {
      String match = "";
      // Max word length in HSK 1-2 is usually 4 (e.g. 公共汽车)
      for (int len = 4; len >= 1; len--) {
        if (start + len <= text.length) {
          String candidate = text.substring(start, start + len);
          if (_vocabulary.contains(candidate)) {
            match = candidate;
            break;
          }
        }
      }

      if (match.isNotEmpty) {
        result.add(match);
        start += match.length;
      } else {
        // No match, take one character (even if it's not Chinese)
        result.add(text[start]);
        start += 1;
      }
    }
    return result;
  }
}

final masterSearchProvider = FutureProvider.family<List<Flashcard>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final repository = ref.read(globalDictionaryRepositoryProvider);
  final result = await repository.search(query);
  return result.fold((l) => [], (r) => r);
});
