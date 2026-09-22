import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Guards the redesign of the ExtractedWordsReviewSheet — the screen that
/// appears after tapping "Extract to Deck".
///
/// Verified against source because the sheet requires Hive boxes, a Firebase
/// session and live AI extraction, none of which run headless.
void main() {
  late String source;
  late String sheetSource;
  late String cardSource;

  setUpAll(() {
    source = File(
      'lib/features/media/presentation/screens/web_browser_screen.dart',
    ).readAsStringSync();

    final sheetStart = source.indexOf('class ExtractedWordsReviewSheet');
    expect(sheetStart, greaterThan(-1));
    // Bound to the sheet (its state class + layout) so later widgets do not
    // leak into these assertions.
    sheetSource = source.substring(
      sheetStart,
      source.indexOf('class _ExtractedWordCard'),
    );

    final cardStart = source.indexOf('class _ExtractedWordCard');
    expect(cardStart, greaterThan(-1));
    cardSource = source.substring(
      cardStart,
      source.indexOf('class _CreateExtractedDeckDialog'),
    );
  });

  test('word cards use the book-screen card vocabulary', () {
    expect(cardSource, contains('BorderRadius.circular(18)'),
        reason: 'Cards must use the 18px book radius');
    expect(cardSource, contains('AppTheme.cardBgOf(context)'),
        reason: 'Card background must come from the shared token');
    expect(cardSource, contains('blurRadius: 10'));
    expect(cardSource, contains('const Offset(0, 4)'));
  });

  test('word cards select with the canonical accent, not indigo', () {
    expect(cardSource, contains('AppTheme.accentOf(context)'));
    expect(sheetSource, isNot(contains('Colors.indigo')),
        reason: 'The indigo accent must be fully removed from the sheet');
    expect(sheetSource, isNot(contains('Colors.orange')),
        reason: 'The ad-hoc orange button must be gone');
  });

  test('cards are real cards, not flat CheckboxListTile rows', () {
    expect(sheetSource, isNot(contains('CheckboxListTile')),
        reason: 'Flat checkbox rows were replaced by card widgets');
    expect(sheetSource, isNot(contains('Divider(height: 1)')),
        reason: 'Divider-separated rows were replaced by spaced cards');
    expect(sheetSource, contains('_ExtractedWordCard('),
        reason: 'The sheet must render the new card widget');
  });

  test('the sheet background matches the canonical surface', () {
    expect(sheetSource, contains('AppTheme.surfaceOf(context)'));
    expect(sheetSource, isNot(contains('const Color(0xFF1E1E1E)')),
        reason: 'The legacy sheet background must be gone');
  });

  test('action buttons follow the book-screen hierarchy', () {
    // Primary: filled ink/amber, 52 high, elevation 4, radius 16.
    expect(sheetSource, contains('Colors.amber.shade700'));
    expect(sheetSource, contains('height: 52'));
    expect(sheetSource, contains('elevation: 4'));
    // Secondary: outlined with an accent hairline border.
    expect(sheetSource, contains('OutlinedButton.icon'));
    expect(sheetSource, contains('width: 1.3'));
  });

  test('both action buttons are localized', () {
    expect(sheetSource, contains('l10n.newDeck'));
    expect(sheetSource, contains('l10n.addToDeck1'));
    expect(sheetSource, contains('l10n.cancelAction'));
    expect(sheetSource, contains('l10n.reviewExtractedDeck'));
  });

  test('the selection count is localized rather than hardcoded English', () {
    expect(sheetSource, contains('l10n.wordsSelectedCount('));
    expect(sheetSource, isNot(contains('words selected"')),
        reason: 'The hardcoded "N of M words selected" string must be gone');
  });

  test('select-all / deselect-all is offered and localized', () {
    expect(sheetSource, contains('l10n.selectAll'));
    expect(sheetSource, contains('l10n.deselectAll'));
  });

  test('wordsSelectedCount is translated in every supported locale', () async {
    // Rendered output for wordsSelectedCount(2, 8) — the numbers substituted in.
    const expected = {
      'en': '2 of 8 words selected',
      'fr': '2 sur 8 mots sélectionnés',
      'de': '2 von 8 Wörtern ausgewählt',
      'es': '2 de 8 palabras seleccionadas',
      'it': '2 di 8 parole selezionate',
      'pt': '2 de 8 palavras selecionadas',
      'ja': '8 語中 2 語を選択中',
      'ko': '8개 중 2개 단어 선택됨',
      'ru': 'Выбрано 2 из 8 слов',
      'ar': '2 من 8 كلمة محددة',
      'hi': '8 में से 2 शब्द चुने गए',
      'id': '2 dari 8 kata dipilih',
      'th': 'เลือกแล้ว 2 จาก 8 คำ',
      'vi': 'Đã chọn 2 trong 8 từ',
    };

    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = await AppLocalizations.delegate.load(locale);
      final rendered = l10n.wordsSelectedCount(2, 8);

      // No locale may leak the raw ICU placeholders.
      expect(rendered, isNot(contains('{selected}')));
      expect(rendered, isNot(contains('{total}')));
      expect(rendered, contains('2'));
      expect(rendered, contains('8'));

      final code = locale.languageCode;
      if (expected.containsKey(code)) {
        expect(rendered, expected[code],
            reason: 'Unexpected wording for $code');
      }
    }
  });
}
