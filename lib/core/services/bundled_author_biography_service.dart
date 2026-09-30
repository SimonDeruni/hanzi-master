import 'dart:convert';

import 'package:flutter/services.dart';

/// A resolved biography together with the locale that supplied its text.
class AuthorBiography {
  const AuthorBiography({
    required this.author,
    required this.text,
    required this.requestedLocale,
    required this.resolvedLocale,
  });

  final String author;
  final String text;
  final String requestedLocale;
  final String resolvedLocale;

  bool get usedEnglishFallback =>
      requestedLocale != 'en' && resolvedLocale == 'en';
}

/// Loads bundled, author-specific biographies and caches each locale once.
///
/// Two catalogues feed it, same shape (a top-level JSON object of author →
/// biography), so a lookup is one pass over both:
///
///  * `assets/data/l10n/author_bios_<locale>.json` — keyed by the exact `author`
///    values from `grand_library_catalog.json` (the prose classics).
///  * `assets/data/l10n/poet_bios_<locale>.json` — keyed by the poet's Chinese
///    name, which is the `author` of every poetry collection. Without it the
///    author card on a poet's book had nothing to say: a poet is not in the
///    prose catalogue, so "no explanation of the author" was all it could show.
class BundledAuthorBiographyService {
  BundledAuthorBiographyService({AssetBundle? bundle})
      : _bundle = bundle ?? rootBundle;

  static final BundledAuthorBiographyService instance =
      BundledAuthorBiographyService();

  final AssetBundle _bundle;
  final Map<String, Future<Map<String, String>>> _localeLoads = {};

  /// The biography catalogues, in lookup order.
  static const List<String> _catalogueFiles = <String>[
    'assets/data/l10n/author_bios_%s.json',
    'assets/data/l10n/poet_bios_%s.json',
  ];

  /// Resolves [author] in [localeCode], falling back to the bundled English
  /// biography. Returns null only when the author is absent from both files.
  Future<AuthorBiography?> biographyFor({
    required String author,
    required String localeCode,
  }) async {
    final requestedLocale = normalizeLocale(localeCode);
    final localized = await _loadLocale(requestedLocale);
    final localizedText = localized[author];
    if (localizedText != null) {
      return AuthorBiography(
        author: author,
        text: localizedText,
        requestedLocale: requestedLocale,
        resolvedLocale: requestedLocale,
      );
    }

    if (requestedLocale == 'en') return null;
    final englishText = (await _loadLocale('en'))[author];
    if (englishText == null) return null;
    return AuthorBiography(
      author: author,
      text: englishText,
      requestedLocale: requestedLocale,
      resolvedLocale: 'en',
    );
  }

  Future<Map<String, String>> _loadLocale(String locale) =>
      _localeLoads.putIfAbsent(locale, () async {
        // Every catalogue is optional: a missing or corrupt regional file is a
        // recoverable fallback case, never a reason to lose the ones that load.
        final merged = <String, String>{};
        for (final template in _catalogueFiles) {
          try {
            final source =
                await _bundle.loadString(template.replaceFirst('%s', locale));
            final decoded = jsonDecode(source);
            if (decoded is! Map<String, dynamic>) continue;
            for (final entry in decoded.entries) {
              final value = entry.value;
              final text = value is Map
                  ? (value['summary'] ?? '').toString().trim()
                  : value.toString().trim();
              if (text.isNotEmpty) merged[entry.key] = text;
            }
          } on Object {
            continue;
          }
        }
        return Map.unmodifiable(merged);
      });

  static String normalizeLocale(String localeCode) {
    final normalized = localeCode.trim().replaceAll('-', '_').toLowerCase();
    if (normalized.isEmpty) return 'en';
    return normalized.split('_').first;
  }
}
