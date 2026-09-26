import 'dart:convert';

import 'package:flutter/services.dart';

/// Localized **deck content**: the titles and descriptions of the thematic
/// decks, and the definitions of the words their previews show.
///
/// Deck content is data rather than chrome, so it does not belong in
/// `lib/l10n/*.arb` - it follows the same path as book synopses and show
/// summaries (`assets/data/l10n/books_<locale>.json`, read by
/// [LocalizedCatalogService]): one JSON file per locale, keyed by a stable id
/// (the deck id, or the hanzi for a word), with English as the fallback.
///
/// Unlike the catalog service this exposes **synchronous** lookups, because the
/// deck library renders a whole shelf of cards in one build pass and cannot
/// await per card. Call [ensureLoaded] once when the locale is known (the
/// library screen does this in `initState` and again if the locale changes),
/// then read through [deckTitle], [deckDescription] and [wordDefinition].
///
/// Anything missing falls back to the English the caller already holds, so a
/// partially translated locale degrades one string at a time instead of
/// showing blanks.
class LocalizedDeckService {
  LocalizedDeckService._();

  static const String _deckAssetPrefix = 'assets/data/l10n/deck_descriptions_';
  static const String _wordAssetPrefix = 'assets/data/l10n/deck_words_';

  static String _loadedLocale = '';
  static Map<String, dynamic> _decks = <String, dynamic>{};
  static Map<String, String> _words = <String, String>{};

  /// True once a locale has been read (even if the files were absent).
  static bool get isLoaded => _loadedLocale.isNotEmpty;

  /// Loads the deck and word files for [localeCode] into memory.
  ///
  /// Safe to call repeatedly: it returns immediately when the locale is already
  /// loaded, and never throws - a missing or malformed file simply leaves the
  /// caches empty so every lookup uses its English fallback.
  static Future<void> ensureLoaded(String localeCode) async {
    if (localeCode == _loadedLocale) return;

    _loadedLocale = localeCode;
    _decks = <String, dynamic>{};
    _words = <String, String>{};

    if (localeCode.isEmpty) return;

    try {
      final String raw = await rootBundle
          .loadString('$_deckAssetPrefix$localeCode.json');
      _decks = json.decode(raw) as Map<String, dynamic>;
    } catch (_) {
      _decks = <String, dynamic>{};
    }

    try {
      final String raw =
          await rootBundle.loadString('$_wordAssetPrefix$localeCode.json');
      final Map<String, dynamic> decoded =
          json.decode(raw) as Map<String, dynamic>;
      _words = decoded.map((k, v) => MapEntry(k, v.toString()));
    } catch (_) {
      _words = <String, String>{};
    }
  }

  /// Localized title for [deckId], or [fallbackEn] when there is none.
  static String deckTitle({
    required String deckId,
    required String fallbackEn,
  }) {
    final dynamic entry = _decks[deckId];
    if (entry is Map) {
      final dynamic title = entry['title'];
      if (title is String && title.isNotEmpty) return title;
    }
    return fallbackEn;
  }

  /// Localized description for [deckId], or [fallbackEn] when there is none.
  static String deckDescription({
    required String deckId,
    required String fallbackEn,
  }) {
    final dynamic entry = _decks[deckId];
    if (entry is Map) {
      final dynamic description = entry['description'];
      if (description is String && description.isNotEmpty) return description;
    }
    return fallbackEn;
  }

  /// Localized definition for the word written [hanzi], else [fallbackEn].
  static String wordDefinition({
    required String hanzi,
    required String fallbackEn,
  }) {
    final String? localized = _words[hanzi];
    if (localized != null && localized.isNotEmpty) return localized;
    return fallbackEn;
  }
}
