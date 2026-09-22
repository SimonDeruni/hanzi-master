import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  group('Deck Library localization', () {
    test('every supported locale defines all three deck-library strings', () async {
      expect(AppLocalizations.supportedLocales, isNotEmpty);

      for (final locale in AppLocalizations.supportedLocales) {
        final l10n = await AppLocalizations.delegate.load(locale);

        expect(l10n.deckLibraryTitle, isNotEmpty,
            reason: 'deckLibraryTitle missing for ${locale.languageCode}');
        expect(l10n.deckLibrarySubtitle, isNotEmpty,
            reason: 'deckLibrarySubtitle missing for ${locale.languageCode}');
        expect(l10n.downloadOfficialDecks, isNotEmpty,
            reason: 'downloadOfficialDecks missing for ${locale.languageCode}');
      }
    });

    test('the old "Master Deck Library" name is gone from every locale', () async {
      for (final locale in AppLocalizations.supportedLocales) {
        final l10n = await AppLocalizations.delegate.load(locale);

        expect(l10n.deckLibraryTitle.toLowerCase(), isNot(contains('master')),
            reason: 'The title was renamed to "Deck Library" for '
                '${locale.languageCode}');
      }
    });

    test('English uses the shortened "Deck Library" title', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      expect(l10n.deckLibraryTitle, 'Deck Library');
      expect(l10n.deckLibrarySubtitle,
          'Curated collections across HSK, culture, sports, & academics');
      expect(l10n.downloadOfficialDecks,
          'Download official HSK & thematic decks');
    });

    test('French translation is provided and localized', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('fr'));

      expect(l10n.deckLibraryTitle, 'Bibliothèque de decks');
      // French must not fall back to English on the description line.
      expect(l10n.downloadOfficialDecks, contains('Télécharger'));
    });

    test('non-Latin locales are translated rather than left in English',
        () async {
      for (final code in ['ja', 'ko', 'ru', 'th', 'hi', 'ar']) {
        final l10n =
            await AppLocalizations.delegate.load(Locale(code));

        expect(l10n.deckLibraryTitle, isNot('Deck Library'),
            reason: 'locale $code still shows the English title');
      }
    });
  });
}
