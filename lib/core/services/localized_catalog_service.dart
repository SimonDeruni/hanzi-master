import 'dart:convert';
import 'package:flutter/services.dart';

/// Provides instant, cached access to localized book synopses and show summaries.
class LocalizedCatalogService {
  static final Map<String, Map<String, String>> _bookCache = {};
  static final Map<String, Map<String, String>> _showCache = {};

  /// Loads and returns the localized book synopsis for [bookId] and [localeCode].
  /// Falls back to [fallbackEn] if not found or if English is selected.
  static Future<String> getBookSynopsis({
    required String bookId,
    required String localeCode,
    required String fallbackEn,
  }) async {
    if (localeCode == 'en' || localeCode.isEmpty) {
      return fallbackEn;
    }

    if (!_bookCache.containsKey(localeCode)) {
      try {
        final jsonStr = await rootBundle
            .loadString('assets/data/l10n/books_$localeCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        _bookCache[localeCode] = raw.map((k, v) => MapEntry(k, v.toString()));
      } catch (_) {
        _bookCache[localeCode] = {};
      }
    }

    final localized = _bookCache[localeCode]?[bookId];
    if (localized != null && localized.isNotEmpty) {
      return localized;
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
    if (localeCode == 'en' || localeCode.isEmpty) {
      return fallbackEn;
    }

    if (!_showCache.containsKey(localeCode)) {
      try {
        final jsonStr = await rootBundle
            .loadString('assets/data/l10n/shows_$localeCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        _showCache[localeCode] = raw.map((k, v) => MapEntry(k, v.toString()));
      } catch (_) {
        _showCache[localeCode] = {};
      }
    }

    final localized = _showCache[localeCode]?[showTitle];
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
    if (localeCode == 'en' || localeCode.isEmpty) {
      return fallbackPoints;
    }

    if (!_channelCache.containsKey(localeCode)) {
      try {
        final jsonStr = await rootBundle
            .loadString('assets/data/l10n/channels_$localeCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        _channelCache[localeCode] = raw.map((k, v) => MapEntry(
            k,
            (v as List<dynamic>)
                .map((e) => e.toString())
                .where((s) => s.isNotEmpty)
                .toList()));
      } catch (_) {
        _channelCache[localeCode] = {};
      }
    }

    final localized = _channelCache[localeCode]?[channelKey] ??
        _channelCache[localeCode]?['DEFAULT'];
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
    final normalizedLocale = localeCode.replaceAll('-', '_').toLowerCase();
    final languageCode = normalizedLocale.split('_').first;
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
    final normalizedLocale = localeCode.replaceAll('-', '_').toLowerCase();
    final languageCode = normalizedLocale.split('_').first;

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
