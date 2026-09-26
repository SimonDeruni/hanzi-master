import 'dart:convert';

import 'package:flutter/services.dart';

/// Localized **deck descriptions**: the title and blurb of each thematic deck.
///
/// Deck descriptions are content rather than chrome, so they do not belong in
/// `lib/l10n/*.arb` - they follow the same path as book synopses and show
/// summaries (`assets/data/l10n/books_<locale>.json`, read by
/// [LocalizedCatalogService]): one JSON file per locale, keyed by the deck id,
/// with English as the fallback. The six HSK levels are not here: their
/// descriptions are app chrome and live in `lib/l10n/*.arb`.
///
/// **Word definitions are deliberately not handled here.** They come from
/// `dictionary.db` through `CharacterLookupService.lookupAll(...,
/// targetLanguage: ...)`, which already carries a `definition_<lang>` column
/// for every locale the app ships and falls back to English per row; a second
/// copy in per-locale JSON would only be a thinner duplicate of that store.
///
/// Unlike the catalog service this exposes **synchronous** lookups, because the
/// deck library renders a whole shelf of cards in one build pass and cannot
/// await per card. Call [ensureLoaded] once when the locale is known (the
/// library screen does this in `initState` and again if the locale changes),
/// then read through [deckTitle] and [deckDescription].
///
/// Anything missing falls back to the English the caller already holds, so a
/// partially translated locale degrades one string at a time instead of
/// showing blanks.
class LocalizedDeckService {
  LocalizedDeckService._();

  static const String _deckAssetPrefix = 'assets/data/l10n/deck_descriptions_';

  static String _loadedLocale = '';
  static Map<String, dynamic> _decks = <String, dynamic>{};

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

    if (localeCode.isEmpty) return;

    try {
      final String raw = await rootBundle
          .loadString('$_deckAssetPrefix$localeCode.json');
      _decks = json.decode(raw) as Map<String, dynamic>;
    } catch (_) {
      _decks = <String, dynamic>{};
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
}
