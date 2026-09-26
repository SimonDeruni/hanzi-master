import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the classical-reader toolbar's width budget.
///
/// **The bug:** the AppBar carried **eight** `IconButton`s (~384dp of actions)
/// beside a two-line title on a phone. Flutter's `NavigationToolbar` lays the
/// trailing row out at `width - trailingWidth`, so on a 390dp screen the real
/// content width for the actions could not fit and the row was placed at
/// `x ≈ 6` — the first action (the Cinnabar headphones icon) was painted **on
/// top of the leading back arrow** and swallowed its taps.
///
/// The screen needs Hive boxes and a book repository to render, so the
/// invariant is verified against source, like the other reader-sheet guards.
void main() {
  late String source;
  late String appBar;
  late String actions;

  setUpAll(() {
    source = File(
      'lib/features/reading/presentation/screens/book_reader_screen.dart',
    ).readAsStringSync();

    // The reader can be embedded as a pane (the iPad listen-and-read desk), so
    // the app bar became conditional — and `dart format` decides whether that
    // ternary stays on one line. Match the argument, not the layout of it.
    final RegExpMatch? appBarArg = RegExp(
      r'appBar: (?:widget\.embedded\s*\?\s*null\s*:\s*)?AppBar\(',
    ).firstMatch(source);
    final int appBarStart = appBarArg?.start ?? -1;
    expect(appBarStart, greaterThan(-1), reason: 'Reader AppBar not found');
    final int bodyStart = source.indexOf('body: Column(', appBarStart);
    expect(bodyStart, greaterThan(appBarStart));

    appBar = source.substring(appBarStart, bodyStart);
    actions = appBar.substring(appBar.indexOf('actions: ['));
  });

  test('the toolbar keeps at most three icons plus one overflow menu', () {
    final int iconButtons = RegExp(r'IconButton\(').allMatches(actions).length;
    final int overflowMenus = RegExp(r'PopupMenuButton<_ReaderMenuAction>\(')
        .allMatches(actions)
        .length;

    expect(overflowMenus, 1,
        reason: 'Secondary controls live behind a single overflow menu');
    expect(iconButtons, lessThanOrEqualTo(3),
        reason: 'Each extra icon widens the actions row towards the leading '
            'slot — three plus the menu is the budget');
    // 4 slots * the 48dp minimum touch target = 192dp, so even a 320dp-wide
    // device leaves the title its own space and keeps the back arrow clear.
    expect((iconButtons + overflowMenus) * 48, lessThanOrEqualTo(192));
  });

  test('the leading back control is untouched and reachable', () {
    expect(appBar, contains('Icons.arrow_back_ios_new'));
    expect(appBar, contains('leading: IconButton('));
  });

  test('the title is a single ellipsized line', () {
    expect(appBar, contains('maxLines: 1'),
        reason: 'A two-line title eats the width the actions need');
    expect(appBar, contains('overflow: TextOverflow.ellipsis'));
    // The hardcoded English counter that used to sit under the title is gone:
    // the localized body header owns it (`chapterXOfY` · `sentenceXOfY` · %).
    expect(appBar, isNot(contains('Classical Verse')));
    expect(appBar, isNot(contains('Sent.')));
  });

  test('every displaced control stays reachable from the overflow menu', () {
    for (final String key in <String>[
      'audiobookPlayer',
      'ambientSoundscape',
      'adjustFontSize',
      'viewBookmarks',
    ]) {
      expect(appBar, contains('l10n.$key'),
          reason: '$key must still be offered, just not in the toolbar');
    }
  });

  test('every toolbar control is labelled from the .arb files', () {
    // The translation toggle used to carry hardcoded English tooltips
    // ('Show/Hide English Translations'). `showTranslation` / `hideTranslation`
    // already existed in all 14 locales, and the reading language follows the
    // app locale, so the label is language-neutral.
    expect(appBar, contains('AppLocalizations.of(context)!.showTranslation'));
    expect(appBar, contains('AppLocalizations.of(context)!.hideTranslation'));
    expect(appBar, contains('AppLocalizations.of(context)!.togglePinyin'));
    expect(appBar, contains('AppLocalizations.of(context)!.bookmarkChapter'));
    expect(appBar, isNot(contains('Show English Translations')));
    expect(appBar, isNot(contains('Hide English Translations')));
  });

  test('the duplicated table-of-contents icon left the toolbar', () {
    // The bottom bar's "Chapitre X sur Y" button opens the same chapter drawer,
    // so the extra icon was pure width cost.
    expect(appBar, isNot(contains('tableOfContents')));
    expect(appBar, isNot(contains('format_list_bulleted')));
    expect(source, contains('_openChapterDrawer('),
        reason: 'The chapter drawer itself must still exist and be reachable');
  });
}
