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
/// Assets use a top-level JSON object whose keys are the exact `author` values
/// from `grand_library_catalog.json` and whose values are biography strings.
class BundledAuthorBiographyService {
  BundledAuthorBiographyService({AssetBundle? bundle})
      : _bundle = bundle ?? rootBundle;

  static final BundledAuthorBiographyService instance =
      BundledAuthorBiographyService();

  final AssetBundle _bundle;
  final Map<String, Future<Map<String, String>>> _localeLoads = {};

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
        try {
          final source = await _bundle.loadString(
            'assets/data/l10n/author_bios_$locale.json',
          );
          final decoded = jsonDecode(source);
          if (decoded is! Map<String, dynamic>) return const {};
          return Map.unmodifiable({
            for (final entry in decoded.entries)
              if (entry.value is String &&
                  (entry.value as String).trim().isNotEmpty)
                entry.key: (entry.value as String).trim(),
          });
        } on Object {
          // A missing/corrupt regional file is a recoverable fallback case.
          return const {};
        }
      });

  static String normalizeLocale(String localeCode) {
    final normalized = localeCode.trim().replaceAll('-', '_').toLowerCase();
    if (normalized.isEmpty) return 'en';
    return normalized.split('_').first;
  }
}
