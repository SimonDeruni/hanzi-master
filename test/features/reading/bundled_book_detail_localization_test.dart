import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/bundled_author_biography_service.dart';

const _supportedLocales = <String>{
  'en',
  'ar',
  'de',
  'es',
  'fr',
  'hi',
  'id',
  'it',
  'ja',
  'ko',
  'pt',
  'ru',
  'th',
  'vi',
};

Map<String, dynamic> _objectFrom(String path) {
  final file = File(path);
  expect(file.existsSync(), isTrue, reason: 'Missing bundled asset: $path');
  final value = jsonDecode(file.readAsStringSync());
  expect(value, isA<Map<String, dynamic>>(), reason: '$path must be an object');
  return value as Map<String, dynamic>;
}

void main() {
  group('bundled book-detail localization assets', () {
    final catalog = jsonDecode(
      File('assets/data/grand_library_catalog.json').readAsStringSync(),
    ) as List<dynamic>;
    final authors = catalog
        .map((entry) => (entry as Map<String, dynamic>)['author'] as String)
        .toSet();
    final bookIds = catalog
        .map((entry) => (entry as Map<String, dynamic>)['id'] as String)
        .toSet();
    late final Map<String, dynamic> englishBiographies =
        _objectFrom('assets/data/l10n/author_bios_en.json');
    final englishSynopses = <String, String>{
      for (final entry in catalog.cast<Map<String, dynamic>>())
        entry['id'] as String: (entry['descriptionEn'] as String).trim(),
    };

    // Expanded to 101 canonical books and 83 authentic authors following the full
    // library author biography and synopsis restoration.
    test('catalog has the canonical 83 authors and 101 synopsis IDs', () {
      expect(authors, hasLength(83));
      expect(bookIds, hasLength(101));
    });

    for (final locale in _supportedLocales) {
      test('$locale biographies contain exactly every catalog author', () {
        final bios = _objectFrom(
          'assets/data/l10n/author_bios_$locale.json',
        );
        expect(bios.keys.toSet(), authors,
            reason: '$locale biography keys must match the catalog exactly');
        for (final author in authors) {
          expect(bios[author], isA<String>(), reason: '$locale: $author');
          expect((bios[author] as String).trim(), isNotEmpty,
              reason: '$locale has an empty biography for $author');
          final minLength =
              (locale == 'ja' || locale == 'ko' || locale == 'zh') ? 50 : 80;
          expect(
              (bios[author] as String).trim().length,
              greaterThanOrEqualTo(minLength),
              reason: '$locale has an implausibly short biography for $author');
          if (locale != 'en') {
            expect(
              (bios[author] as String).trim(),
              isNot((englishBiographies[author] as String).trim()),
              reason: '$locale biography for $author is still English',
            );
          }
        }
      });

      test('$locale synopses contain exactly every catalog book ID', () {
        final synopses = locale == 'en'
            ? <String, dynamic>{
                for (final entry in catalog.cast<Map<String, dynamic>>())
                  entry['id'] as String: entry['descriptionEn'],
              }
            : _objectFrom('assets/data/l10n/books_$locale.json');
        expect(synopses.keys.toSet(), bookIds,
            reason: '$locale synopsis keys must match the catalog exactly');
        for (final id in bookIds) {
          expect(synopses[id], isA<String>(), reason: '$locale: $id');
          expect((synopses[id] as String).trim(), isNotEmpty,
              reason: '$locale has an empty synopsis for $id');
          final minLength =
              (locale == 'ja' || locale == 'ko' || locale == 'zh') ? 50 : 80;
          expect(
              (synopses[id] as String).trim().length,
              greaterThanOrEqualTo(minLength),
              reason: '$locale has an implausibly short synopsis for $id');
          if (locale != 'en') {
            expect(
              (synopses[id] as String).trim(),
              isNot(englishSynopses[id]),
              reason: '$locale synopsis for $id is still English',
            );
          }
        }
      });
    }
  });

  group('BundledAuthorBiographyService', () {
    test('normalizes language tags', () {
      expect(BundledAuthorBiographyService.normalizeLocale('pt-BR'), 'pt');
      expect(BundledAuthorBiographyService.normalizeLocale('ZH_Hant'), 'zh');
      expect(BundledAuthorBiographyService.normalizeLocale(''), 'en');
    });

    test('resolves localized text and falls back to English', () async {
      final bundle = _MemoryAssetBundle({
        'assets/data/l10n/author_bios_fr.json': '{"甲":"Français"}',
        'assets/data/l10n/author_bios_en.json':
            '{"甲":"English A","乙":"English B"}',
      });
      final service = BundledAuthorBiographyService(bundle: bundle);

      final localized =
          await service.biographyFor(author: '甲', localeCode: 'fr-FR');
      expect(localized?.text, 'Français');
      expect(localized?.usedEnglishFallback, isFalse);

      final fallback =
          await service.biographyFor(author: '乙', localeCode: 'fr');
      expect(fallback?.text, 'English B');
      expect(fallback?.usedEnglishFallback, isTrue);
    });

    test('caches locale loads and safely handles missing authors', () async {
      final bundle = _MemoryAssetBundle({
        'assets/data/l10n/author_bios_en.json': '{"甲":"English"}',
      });
      final service = BundledAuthorBiographyService(bundle: bundle);
      expect(
          await service.biographyFor(author: '未知', localeCode: 'de'), isNull);
      expect(
          await service.biographyFor(author: '未知', localeCode: 'de'), isNull);
      expect(bundle.loadCounts['assets/data/l10n/author_bios_de.json'], 1);
      expect(bundle.loadCounts['assets/data/l10n/author_bios_en.json'], 1);
    });
  });
}

class _MemoryAssetBundle extends CachingAssetBundle {
  _MemoryAssetBundle(this.assets);

  final Map<String, String> assets;
  final Map<String, int> loadCounts = {};

  @override
  Future<ByteData> load(String key) async {
    loadCounts.update(key, (count) => count + 1, ifAbsent: () => 1);
    final value = assets[key];
    if (value == null) throw StateError('Missing test asset: $key');
    final bytes = utf8.encode(value);
    return ByteData.sublistView(Uint8List.fromList(bytes));
  }
}
