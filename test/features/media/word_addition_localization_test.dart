import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  group('Word Addition Localization Tests (14 Languages)', () {
    test(
        'all 14 locales render addedWordsAndUpdatedWords without unreplaced placeholders',
        () async {
      for (final locale in AppLocalizations.supportedLocales) {
        final l10n = await AppLocalizations.delegate.load(locale);

        final result = l10n.addedWordsAndUpdatedWords(23, 2, 'Test Deck');
        expect(result, isNotEmpty);
        expect(result, contains('23'));
        expect(result, contains('2'));
        expect(result, contains('Test Deck'));
        expect(result, isNot(contains('{addedCount}')));
        expect(result, isNot(contains('{updatedCount}')));
        expect(result, isNot(contains('{deckName}')));
      }
    });

    test(
        'all 14 locales render addedWordsToDeck and updatedWordsInDeck cleanly',
        () async {
      for (final locale in AppLocalizations.supportedLocales) {
        final l10n = await AppLocalizations.delegate.load(locale);

        final addedMsg = l10n.addedWordsToDeck(5, 'Test Deck');
        expect(addedMsg, contains('5'));
        expect(addedMsg, contains('Test Deck'));
        expect(addedMsg, isNot(contains('{count}')));
        expect(addedMsg, isNot(contains('{deckName}')));

        final updatedMsg = l10n.updatedWordsInDeck(3, 'Test Deck');
        expect(updatedMsg, contains('3'));
        expect(updatedMsg, contains('Test Deck'));
        expect(updatedMsg, isNot(contains('{count}')));
        expect(updatedMsg, isNot(contains('{deckName}')));
      }
    });

    test('all 14 locales render addedCardToDeck cleanly', () async {
      for (final locale in AppLocalizations.supportedLocales) {
        final l10n = await AppLocalizations.delegate.load(locale);

        final msg = l10n.addedCardToDeck('学', 'Test Deck');
        expect(msg, contains('学'));
        expect(msg, contains('Test Deck'));
        expect(msg, isNot(contains('{hanzi}')));
        expect(msg, isNot(contains('{deckName}')));
      }
    });

    test('French localized strings match user scenario accurately', () async {
      final l10n = await AppLocalizations.delegate.load(
        AppLocalizations.supportedLocales
            .singleWhere((l) => l.languageCode == 'fr'),
      );

      final msg =
          l10n.addedWordsAndUpdatedWords(23, 2, 'La bibliothèque principale');
      expect(
        msg,
        'Ajout de 23 nouveaux mots, mise à jour de 2 mots existants dans La bibliothèque principale',
      );

      final addedMsg = l10n.addedWordsToDeck(23, 'La bibliothèque principale');
      expect(addedMsg, 'Ajout de 23 mots à La bibliothèque principale');

      final updatedMsg =
          l10n.updatedWordsInDeck(2, 'La bibliothèque principale');
      expect(updatedMsg,
          'Mise à jour de 2 mots existants dans La bibliothèque principale');

      final singleMsg = l10n.addedCardToDeck('学', 'La bibliothèque principale');
      expect(singleMsg, '学 ajouté à La bibliothèque principale');
    });

    test('English localized strings match expected baseline', () async {
      final l10n = await AppLocalizations.delegate.load(
        AppLocalizations.supportedLocales
            .singleWhere((l) => l.languageCode == 'en'),
      );

      final msg = l10n.addedWordsAndUpdatedWords(23, 2, 'Main Deck');
      expect(msg, 'Added 23 new words, updated 2 existing words to Main Deck');

      final addedMsg = l10n.addedWordsToDeck(23, 'Main Deck');
      expect(addedMsg, 'Added 23 words to Main Deck');

      final updatedMsg = l10n.updatedWordsInDeck(2, 'Main Deck');
      expect(updatedMsg, 'Updated 2 existing words in Main Deck');

      final singleMsg = l10n.addedCardToDeck('学', 'Main Deck');
      expect(singleMsg, 'Added 学 to Main Deck');
    });
  });
}
