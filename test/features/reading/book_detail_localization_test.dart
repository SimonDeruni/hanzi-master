import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations_fr.dart';

void main() {
  group('Book detail localization', () {
    test('French strings cover the reported book-detail labels', () {
      final l10n = AppLocalizationsFr();

      expect(l10n.audiobookIncluded, 'Livre audio inclus');
      expect(l10n.chineseEpics, 'Épopées chinoises');
      expect(l10n.ancientPhilosophy, 'Philosophie antique');
      expect(l10n.mingDynasty, 'Dynastie Ming');
      expect(l10n.warringStates, 'Royaumes combattants');
      expect(l10n.chapters(100), '100 chapitres');
      expect(l10n.startReading, 'Commencer la lecture');
      expect(l10n.listenToAudiobook, 'Écouter le livre audio');
      expect(l10n.hanFeiLegalism, contains('principal penseur du légisme'));
    });

    test('reported English labels are not hard-coded in the detail screen', () {
      final source = File(
        'lib/features/reading/presentation/screens/book_detail_screen.dart',
      ).readAsStringSync();

      expect(source, isNot(contains("'Audiobook Included'")));
      expect(source, isNot(contains("'Listen to Audiobook'")));
      expect(source, isNot(contains("'Start Reading'")));
      expect(source, isNot(contains("'Synopsis'")));
      expect(source, contains('book.localizedTitle(localeCode)'));
      expect(source, contains('l10n.chapters(book.totalChapters)'));
      expect(source, contains("case 'Warring States':"));
      expect(source, contains('return l10n.warringStates;'));
      expect(source, contains('BundledAuthorBiographyService.instance'));
      expect(source, contains('biographyFor('));
      expect(source, isNot(contains('TranslatedDefinition(')));
      expect(source, isNot(contains('Icons.share_outlined')));
    });

    test('Han Feizi has a bundled French synopsis', () {
      final synopses = jsonDecode(
        File('assets/data/l10n/books_fr.json').readAsStringSync(),
      ) as Map<String, dynamic>;

      expect(
        synopses['han_feizi'],
        contains("à l'époque des Royaumes combattants"),
      );
    });
  });
}
