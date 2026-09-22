import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The simplified-article reader must read as continuous prose matching the
/// in-app browser's Zen reading mode, not as a grid of word chips.
///
/// Verified against source because the screen needs a populated AiStory plus
/// live Quick Look plumbing; the styling contract is what regresses.
void main() {
  late String source;
  late String paragraphSource;

  setUpAll(() {
    source = File(
      'lib/features/media/presentation/screens/simplified_article_reader_screen.dart',
    ).readAsStringSync();
    paragraphSource = source.substring(
      source.indexOf('Widget _buildParagraph('),
      source.indexOf('class _TappableWord'),
    );
  });

  group('Zen reading-mode parity', () {
    test('uses the same reading column as the browser', () {
      expect(source, contains('BoxConstraints(maxWidth: 800)'),
          reason: "Zen mode uses max-width: 800px");
      expect(source, contains('fontFamily: l10n.serif'),
          reason: 'The reading mode is serif');
      expect(paragraphSource, contains('fontSize: 22'),
          reason: 'Zen mode body text is 22px');
      expect(paragraphSource, contains('height: 1.8'),
          reason: 'Zen mode line-height is 1.8');
    });

    test('uses the same paper/ink palette as Zen mode', () {
      expect(source, contains('0xFFDADADA'),
          reason: 'Dark-mode reading text is #DADADA, as in Zen mode');
      expect(source, contains('0xFF1A1A1B'),
          reason: 'Light-mode reading text is #1A1A1B, as in Zen mode');
      expect(source, contains('AppTheme.surfaceOf(context)'));
    });
  });

  group('prose, not chips', () {
    test('sentences render as one flowing rich-text paragraph', () {
      expect(paragraphSource, contains('Text.rich('),
          reason: 'A sentence must be a single inline paragraph');
      expect(paragraphSource, contains('WidgetSpan('),
          reason: 'Words stay tappable while flowing inline');
      expect(paragraphSource, contains('PlaceholderAlignment.baseline'),
          reason: 'Inline words must sit on the text baseline');
    });

    test('the old sentence-per-Wrap chip layout is gone', () {
      // The previous implementation wrapped each sentence in a Wrap of padded
      // containers, which read as a chip grid rather than prose.
      expect(paragraphSource, isNot(contains('child: Wrap(')),
          reason: 'Sentences must not be laid out as a Wrap of chips');
    });

    test('selection reads as an accent underline, not a filled block', () {
      expect(source, contains('TextDecoration.underline'),
          reason: 'A filled background would break the prose flow');
      expect(source, contains('decorationColor: accent'));
    });
  });

  group('accents follow the shared tokens', () {
    test('no ad-hoc blue/purple/indigo remains', () {
      for (final banned in [
        'Colors.blue,',
        'Colors.purple,',
        '0xFF4F46E5',
      ]) {
        expect(source, isNot(contains(banned)),
            reason: '$banned was an ad-hoc accent; use AppTheme.accentOf');
      }
    });

    test('the toggles and selection use the canonical accent', () {
      expect(source, contains('AppTheme.accentOf(context)'));
    });
  });

  test('pinyin and translation remain user-togglable', () {
    expect(source, contains('_showPinyin'));
    expect(source, contains('_showTranslation'));
    expect(source, contains('l10n.togglePinyin'));
    expect(source, contains('l10n.toggleTranslation'));
  });
}
