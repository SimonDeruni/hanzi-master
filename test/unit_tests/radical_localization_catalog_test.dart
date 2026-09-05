import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  const requiredFields = <String>{'name', 'meaning', 'mnemonic'};

  test('every supported non-English locale has every radical translated', () {
    final localizedLanguages = AppLocalizations.supportedLocales
        .map((locale) => locale.languageCode)
        .where((language) => language != 'en')
        .toSet();
    final sourceFile = File('assets/data/radicals.json');
    expect(sourceFile.existsSync(), isTrue);

    final source =
        jsonDecode(sourceFile.readAsStringSync()) as Map<String, dynamic>;
    final sourceRadicals =
        (source['radicals'] as Map<String, dynamic>).cast<String, dynamic>();
    expect(sourceRadicals, hasLength(71));

    for (final language in localizedLanguages) {
      final catalogFile = File('assets/data/l10n/radicals_$language.json');
      expect(catalogFile.existsSync(), isTrue,
          reason: 'Missing radical catalog for $language');

      final catalog =
          (jsonDecode(catalogFile.readAsStringSync()) as Map<String, dynamic>)
              .cast<String, dynamic>();
      expect(catalog.keys.toSet(), sourceRadicals.keys.toSet(),
          reason: '$language must contain exactly the canonical radical set');

      for (final radical in sourceRadicals.keys) {
        final entry = (catalog[radical] as Map<String, dynamic>);
        expect(entry.keys.toSet(), requiredFields,
            reason: '$language/$radical has an invalid schema');
        for (final field in requiredFields) {
          expect(entry[field], isA<String>(),
              reason: '$language/$radical/$field must be text');
          expect((entry[field] as String).trim(), isNotEmpty,
              reason: '$language/$radical/$field must be translated');
        }
      }
    }
  });
}
