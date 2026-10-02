import 'dart:convert';
import 'package:flutter/services.dart';

/// Provides instant, cached access to localized book synopses and show summaries.
class LocalizedCatalogService {
  static final Map<String, Map<String, String>> _bookCache = {};
  static final Map<String, Map<String, String>> _showCache = {};

  static String normalizeLocale(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return 'en';
    final token = trimmed.split(RegExp(r'[-_]')).first.toLowerCase();
    return token.isEmpty ? 'en' : token;
  }

  /// Loads and returns the localized book synopsis for [bookId] and [localeCode].
  ///
  /// Precedence: the bundled overlay for this locale → [fallback] (the book's own
  /// description *in the reader's language*, which is all a poetry collection
  /// has: its `description` is the poet's translated biography) → [fallbackEn].
  ///
  /// That middle step is why a French reader no longer reads the English poem
  /// titles under a "Synopsis" heading on a poet's book: the collection is not in
  /// `books_<locale>.json` (only the prose catalogue is), so the lookup used to
  /// land straight on [fallbackEn].
  static Future<String> getBookSynopsis({
    required String bookId,
    required String localeCode,
    required String fallbackEn,
    String? fallback,
  }) async {
    final languageCode = normalizeLocale(localeCode);
    if (languageCode == 'en' || languageCode.isEmpty) {
      return fallbackEn;
    }

    if (!_bookCache.containsKey(languageCode)) {
      try {
        final jsonStr = await rootBundle
            .loadString('assets/data/l10n/books_$languageCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        _bookCache[languageCode] = raw.map((k, v) => MapEntry(k, v.toString()));
      } catch (_) {
        _bookCache[languageCode] = {};
      }
    }

    final localized = _bookCache[languageCode]?[bookId];
    if (localized != null && localized.isNotEmpty) {
      return localized;
    }
    if (fallback != null && fallback.trim().isNotEmpty) {
      return fallback;
    }
    return fallbackEn;
  }

  static final Map<String, Map<String, List<String>>> _channelCache = {};

  /// Loads and returns the localized show summary for [showTitle] and [localeCode].
  /// Falls back to [fallbackEn] if not found or if English is selected.
  static Future<String> getShowSummary({
    required String showTitle,
    required String localeCode,
    required String fallbackEn,
  }) async {
    final languageCode = normalizeLocale(localeCode);
    if (languageCode == 'en' || languageCode.isEmpty) {
      return fallbackEn;
    }

    if (!_showCache.containsKey(languageCode)) {
      try {
        final jsonStr = await rootBundle
            .loadString('assets/data/l10n/shows_$languageCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        _showCache[languageCode] = raw.map((k, v) => MapEntry(k, v.toString()));
      } catch (_) {
        _showCache[localeCode] = {};
      }
    }

    final localized = _showCache[languageCode]?[showTitle];
    if (localized != null && localized.isNotEmpty) {
      return localized;
    }
    return fallbackEn;
  }

  /// Loads and returns the localized description points for [channelKey] and [localeCode].
  /// Falls back to [fallbackPoints] if not found or if English is selected.
  static Future<List<String>> getChannelDescriptionPoints({
    required String channelKey,
    required String localeCode,
    required List<String> fallbackPoints,
  }) async {
    final languageCode = normalizeLocale(localeCode);
    if (languageCode == 'en' || languageCode.isEmpty) {
      return fallbackPoints;
    }

    if (!_channelCache.containsKey(languageCode)) {
      try {
        final jsonStr = await rootBundle
            .loadString('assets/data/l10n/channels_$languageCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        _channelCache[languageCode] = raw.map((k, v) => MapEntry(
            k,
            (v as List<dynamic>)
                .map((e) => e.toString())
                .where((s) => s.isNotEmpty)
                .toList()));
      } catch (_) {
        _channelCache[languageCode] = {};
      }
    }

    final localized = _channelCache[languageCode]?[channelKey] ??
        _channelCache[languageCode]?['DEFAULT'];
    if (localized != null && localized.isNotEmpty) {
      return localized;
    }
    return fallbackPoints;
  }

  static final Map<String, Map<String, String>> _chapterTitleCache = {};
  static final Map<String, Map<String, String>> _chapterTitleByIdCache = {};

  /// Loads and returns the localized chapter title for [titleEn] and [localeCode].
  /// E.g. 'Chapter 1' -> 'Chapitre 1' in French.
  static Future<String> getChapterTitle({
    String? chapterId,
    required String titleEn,
    required String localeCode,
    Map<String, String> localizedTitles = const {},
  }) async {
    final languageCode = normalizeLocale(localeCode);
    final normalizedLocale = localeCode.replaceAll('-', '_').toLowerCase();
    final suppliedTitle =
        localizedTitles[normalizedLocale] ?? localizedTitles[languageCode];
    if (suppliedTitle != null && suppliedTitle.trim().isNotEmpty) {
      return suppliedTitle;
    }
    if (languageCode.isEmpty) {
      return titleEn;
    }

    if (chapterId != null && chapterId.isNotEmpty) {
      if (!_chapterTitleByIdCache.containsKey(languageCode)) {
        try {
          final jsonStr = await rootBundle.loadString(
            'assets/data/l10n/chapter_titles_by_id_$languageCode.json',
          );
          final Map<String, dynamic> raw = json.decode(jsonStr);
          _chapterTitleByIdCache[languageCode] =
              raw.map((key, value) => MapEntry(key, value.toString()));
        } catch (_) {
          _chapterTitleByIdCache[languageCode] = {};
        }
      }
      final generated = _chapterTitleByIdCache[languageCode]?[chapterId];
      if (generated != null && generated.trim().isNotEmpty) {
        return generated;
      }
    }
    if (languageCode == 'en') return titleEn;

    if (!_chapterTitleCache.containsKey(languageCode)) {
      try {
        final jsonStr = await rootBundle
            .loadString('assets/data/l10n/chapter_titles_$languageCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        _chapterTitleCache[languageCode] =
            raw.map((k, v) => MapEntry(k, v.toString()));
      } catch (_) {
        _chapterTitleCache[languageCode] = {};
      }
    }

    final localized = _chapterTitleCache[languageCode]?[titleEn];
    if (localized != null && localized.isNotEmpty) {
      return localized;
    }
    return _localizeChapterPrefix(titleEn, languageCode);
  }

  static String _localizeChapterPrefix(String title, String languageCode) {
    final match = RegExp(r'^Chapter\s+(\d+)(.*)$', caseSensitive: false)
        .firstMatch(title.trim());
    if (match == null) return title;

    const chapterPatterns = <String, String>{
      'ar': 'الفصل {number}',
      'de': 'Kapitel {number}',
      'es': 'Capítulo {number}',
      'fr': 'Chapitre {number}',
      'hi': 'अध्याय {number}',
      'id': 'Bab {number}',
      'it': 'Capitolo {number}',
      'ja': '第{number}章',
      'ko': '제{number}장',
      'pt': 'Capítulo {number}',
      'ru': 'Глава {number}',
      'th': 'บทที่ {number}',
      'vi': 'Chương {number}',
    };
    final pattern = chapterPatterns[languageCode];
    if (pattern == null) return title;
    return '${pattern.replaceFirst('{number}', match.group(1)!)}${match.group(2)!}';
  }

  static final Map<String, Map<String, dynamic>> _radicalCache = {};

  /// Loads and returns the complete dictionary of 71 radicals localized for [localeCode].
  /// Falls back to English (assets/data/radicals.json) if not found or if English is selected.
  static Future<Map<String, dynamic>> getRadicals(String localeCode) async {
    final languageCode = normalizeLocale(localeCode);

    if (languageCode.isEmpty) {
      return _loadFallbackRadicals();
    }

    if (_radicalCache.containsKey(languageCode)) {
      return _radicalCache[languageCode]!;
    }

    if (languageCode != 'en') {
      try {
        final jsonStr = await rootBundle
            .loadString('assets/data/l10n/radicals_$languageCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        final converted =
            raw.map((k, v) => MapEntry(k, Map<String, dynamic>.from(v as Map)));
        _radicalCache[languageCode] = converted;
        return converted;
      } catch (_) {}
    }

    final fallback = await _loadFallbackRadicals();
    _radicalCache[languageCode] = fallback;
    return fallback;
  }

  static Future<Map<String, dynamic>> _loadFallbackRadicals() async {
    if (_radicalCache.containsKey('en')) {
      return _radicalCache['en']!;
    }
    try {
      final jsonStr = await rootBundle.loadString('assets/data/radicals.json');
      final Map<String, dynamic> raw = json.decode(jsonStr)['radicals'];
      final converted =
          raw.map((k, v) => MapEntry(k, Map<String, dynamic>.from(v as Map)));
      _radicalCache['en'] = converted;
      return converted;
    } catch (_) {
      return {};
    }
  }

  /// Loads and returns the localized radical entry for [radicalChar] in [localeCode].
  static Future<Map<String, dynamic>?> getRadicalData(
      String radicalChar, String localeCode) async {
    final radicals = await getRadicals(localeCode);
    return radicals[radicalChar];
  }
}
