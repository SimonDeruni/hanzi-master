import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  test('library navigation labels omit the Chinese branding prefix', () async {
    for (final locale in AppLocalizations.supportedLocales) {
      final localizations = await AppLocalizations.delegate.load(locale);

      expect(
        localizations.libraryLabel,
        isNot(contains('文化书房')),
        reason: 'Unexpected Chinese prefix for locale ${locale.languageCode}',
      );
    }
  });

  test('French library navigation label is concise', () async {
    final localizations = await AppLocalizations.delegate.load(
      AppLocalizations.supportedLocales.singleWhere(
        (locale) => locale.languageCode == 'fr',
      ),
    );

    expect(localizations.libraryLabel, 'Bibliothèque');
  });
}
