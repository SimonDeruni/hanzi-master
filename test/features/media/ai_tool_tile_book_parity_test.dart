import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the book-screen card vocabulary of the two AI reading tools
/// ("Extract to Deck" / "Auto-Simplify") rendered by `_AiToolTile`.
///
/// Verified against source because `WebBrowserScreen` requires a live
/// `WebViewController` and Hive boxes, which cannot run headless.
void main() {
  late String source;
  late String tileSource;

  setUpAll(() {
    final file = File(
      'lib/features/media/presentation/screens/web_browser_screen.dart',
    );
    expect(file.existsSync(), isTrue);
    source = file.readAsStringSync();

    final tileStart =
        source.indexOf('class _AiToolTile extends StatelessWidget');
    expect(tileStart, greaterThan(-1), reason: '_AiToolTile must still exist');
    // Bound the slice to the widget itself: slicing to EOF would swallow the
    // following widgets and make these assertions meaningless.
    final tileEnd = source.indexOf('class _DockIcon', tileStart);
    expect(tileEnd, greaterThan(tileStart));
    tileSource = source.substring(tileStart, tileEnd);
  });

  test('the AI tool tile uses the book-screen card vocabulary', () {
    expect(tileSource, contains('AppTheme.cardBgOf(context)'),
        reason: 'Card background must come from the shared theme token');
    expect(tileSource, contains('BorderRadius.circular(18)'),
        reason: 'Book-screen cards use an 18px radius');
    expect(tileSource, contains('blurRadius: 10'),
        reason: 'Book-screen cards use a blur-10 shadow');
    expect(tileSource, contains('const Offset(0, 4)'),
        reason: 'Book-screen cards offset their shadow by (0, 4)');
    expect(tileSource, contains('shape: BoxShape.circle'),
        reason: 'The icon chip must be circular, matching other hubs');
  });

  test('the tile icon uses the canonical accent, not ad-hoc colours', () {
    expect(tileSource, contains('AppTheme.accentOf(context)'));
    expect(tileSource, isNot(contains('0xFF4A90D9')),
        reason: 'The old blue accent must be gone');
    expect(tileSource, isNot(contains('0xFFFFB300')),
        reason: 'The ad-hoc amber accent must be gone');
  });

  test('the tile no longer takes redundant colour parameters', () {
    // cardBg / borderColor / textColor / isDark / iconColor / iconBgColor were
    // all derivable from context and have been removed.
    for (final param in [
      'required this.cardBg',
      'required this.borderColor',
      'required this.textColor',
      'required this.isDark',
      'required this.iconColor',
      'required this.iconBgColor',
    ]) {
      expect(tileSource, isNot(contains(param)),
          reason: '$param should no longer be a constructor argument');
    }
  });

  test('both AI tools render through the shared tile', () {
    final callSites = RegExp(r'_AiToolTile\(').allMatches(source).length;
    // Two call sites + the constructor declaration.
    expect(callSites, 3,
        reason: 'Extract-to-Deck and Auto-Simplify must both use _AiToolTile');
  });

  test('both AI tool subtitles are localized', () {
    expect(source, contains('?.extractAllUnknownWords'),
        reason: 'Extract-to-Deck subtitle must be localized');
    expect(source, contains('?.rewriteThisArticleToMatch'),
        reason: 'Auto-Simplify subtitle must be localized');

    // The hardcoded English literals must only survive as ?? fallbacks on the
    // same expression, never as a bare subtitle value.
    expect(
      source,
      isNot(contains(
          "subtitle:\n                        'Extract all unknown words")),
    );
  });

  test('the HSK level picker descriptions are localized', () {
    final pickerStart = source.indexOf('void _showAutoSimplifyLevelPicker');
    expect(pickerStart, greaterThan(-1));
    final pickerSource = source.substring(
      pickerStart,
      source.indexOf('Future<void> _runAutoSimplify'),
    );

    // The six difficulty labels must come from AppLocalizations, not a
    // hardcoded English list.
    for (final key in [
      'l10n.beginner',
      'l10n.elementary',
      'l10n.intermediate',
      'l10n.upperIntermediate',
      'l10n.advanced',
      'l10n.master',
    ]) {
      expect(pickerSource, contains(key),
          reason: '$key must be used for the level descriptions');
    }

    for (final literal in [
      "'Beginner'",
      "'Elementary'",
      "'Intermediate'",
      "'Upper-Intermediate'",
      "'Advanced'",
      "'Master'",
    ]) {
      expect(pickerSource, isNot(contains(literal)),
          reason: 'Hardcoded English level label $literal must be gone');
    }
  });

  test('the AI tools sheet background uses the canonical surface', () {
    final menuStart = source.indexOf('void _showAiToolsMenu');
    expect(menuStart, greaterThan(-1));
    final menuSource = source.substring(
      menuStart,
      source.indexOf('void _showAutoSimplifyLevelPicker'),
    );

    expect(menuSource, contains('AppTheme.surfaceOf(context)'));
    expect(menuSource, isNot(contains('const Color(0xFF1A1A1B)')),
        reason: 'The sheet must not use the legacy dark background');
  });
}
