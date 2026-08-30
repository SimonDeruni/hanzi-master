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
}
