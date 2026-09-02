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
        final jsonStr = await rootBundle.loadString('assets/data/l10n/books_$localeCode.json');
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
        final jsonStr = await rootBundle.loadString('assets/data/l10n/shows_$localeCode.json');
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
        final jsonStr = await rootBundle.loadString('assets/data/l10n/channels_$localeCode.json');
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

    final localized = _channelCache[localeCode]?[channelKey] ?? _channelCache[localeCode]?['DEFAULT'];
    if (localized != null && localized.isNotEmpty) {
      return localized;
    }
    return fallbackPoints;
  }

  static final Map<String, Map<String, String>> _chapterTitleCache = {};

  /// Loads and returns the localized chapter title for [titleEn] and [localeCode].
  /// E.g. 'Chapter 1' -> 'Chapitre 1' in French.
  static Future<String> getChapterTitle({
    required String titleEn,
    required String localeCode,
  }) async {
    if (localeCode == 'en' || localeCode.isEmpty) {
      return titleEn;
    }

    if (!_chapterTitleCache.containsKey(localeCode)) {
      try {
        final jsonStr = await rootBundle.loadString('assets/data/l10n/chapter_titles_$localeCode.json');
        final Map<String, dynamic> raw = json.decode(jsonStr);
        _chapterTitleCache[localeCode] = raw.map((k, v) => MapEntry(k, v.toString()));
      } catch (_) {
        _chapterTitleCache[localeCode] = {};
      }
    }

    final localized = _chapterTitleCache[localeCode]?[titleEn];
    if (localized != null && localized.isNotEmpty) {
      return localized;
    }
    return titleEn;
  }
}

