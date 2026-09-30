/// The character reference's iPad treatment (#22 of docs/IPAD_ADAPTIVE_PLAN.md,
/// the last Phase 2 item) — the two rules its `PageView` forced:
///
///  1. **The wide layout fires on the window class, never a raw width.** It used
///     to be `constraints.maxWidth > 600`, so a 700dp Split View slice got the
///     "iPad" layout. Now: `window.isAtLeastMedium` plus the pane width against
///     the named `ZenBreakpoints.compactMax` — no magic numbers, which is what
///     also lets the adoption ledger scan this file.
///  2. **At expanded the sections stop being a stack behind pills.** They become
///     side-by-side columns and the pill bar is not built (its only job was
///     jumping between stacked sections).
///  3. **The anatomy layout measures its own slice, not the window.** Rule 1
///     fixed the *page* gate and left the anatomy one reading
///     `window.isExpanded`, which is a different question: at expanded the
///     sections are columns, so the anatomy widget is handed roughly half a
///     column — about 285dp on a 1366dp iPad. Four component cards in a `Row` of
///     `Expanded` then got ~70dp each, and since the card's own row is a 60dp
///     radical tile plus a 16dp gap (neither of which shrinks), the definition
///     text was left two pixels and wrapped one character per line while the
///     headers overlapped into `ANANATOMIEOMIE`. It now sits behind a
///     `LayoutBuilder` and shows a `Wrap` only when two minimum-width cards
///     genuinely fit, falling back to the carousel otherwise.
///
/// The sections need the dictionary repository and the AI-context provider to
/// render, so — like `book_reader_toolbar_density_test.dart` — these layout
/// decisions are pinned in source rather than faked into a widget tree.
@Tags(<String>['ipad-sweep'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String _screenPath =
    'lib/features/flashcards/presentation/screens/character_detail_screen.dart';

void main() {
  late String screen;

  setUpAll(() {
    screen = File(_screenPath).readAsStringSync().replaceAll('\r\n', '\n');
  });

  /// The body of a method, bounded by its closing brace at method indentation.
  String body(String signature) {
    final int start = screen.indexOf(signature);
    expect(start, greaterThan(-1), reason: '$signature not found');
    final int end = screen.indexOf('\n  }\n', start);
    expect(end, greaterThan(start), reason: 'could not bound $signature');
    return screen.substring(start, end);
  }

  group('the wide gate', () {
    test('decides on the window class plus a named threshold', () {
      final String build = body('Widget build(BuildContext context) {');
      expect(build, contains('context.zenWindow'));
      expect(build, contains('window.isAtLeastMedium'));
      expect(build, contains('ZenBreakpoints.compactMax'),
          reason: 'The pane width is compared to a named breakpoint, not 600');
      expect(
        RegExp(r'maxWidth\s*[><]=?\s*\d{3}').hasMatch(screen),
        isFalse,
        reason:
            'A raw pixel comparison is what let a Split View slice take the '
            'iPad layout',
      );
    });

    test('the class check guards the wide branch', () {
      final String build = body('Widget build(BuildContext context) {');
      final int gate = build.indexOf('window.isAtLeastMedium');
      final int wide = build.indexOf('_buildLandscapeLayout(');
      expect(gate, greaterThan(-1));
      expect(wide, greaterThan(gate));
    });
  });

  group('expanded sections', () {
    test('both arrangements come from one ordered section list', () {
      expect(screen, contains('List<Widget> _detailSectionWidgets('));
      expect(body('Widget _buildDetailSections('),
          contains('_detailSectionWidgets('));
      expect(body('Widget _buildDetailColumns('),
          contains('_detailSectionWidgets('));
    });

    test('the columns arrangement is two Expanded columns in a Row', () {
      final String columns = body('Widget _buildDetailColumns(');
      expect(RegExp(r'Expanded\(').allMatches(columns).length, 2);
      expect(columns, contains('Row('));
    });

    test('expanded drops the pill bar, the narrow path keeps it', () {
      final String landscape = body('Widget _buildLandscapeLayout(');
      final int gate = landscape.indexOf('if (context.zenWindow.isExpanded)');
      expect(gate, greaterThan(-1));
      final int elseAt = landscape.indexOf('] else ...[', gate);
      expect(elseAt, greaterThan(gate));
      final String expandedBranch = landscape.substring(gate, elseAt);
      expect(expandedBranch, contains('_buildDetailColumns('));
      expect(expandedBranch, isNot(contains('_buildPillTabBar(')),
          reason: 'No dead pill bar above content already on screen');
      expect(landscape.substring(elseAt),
          contains('_buildPillTabBar(isDark, floating: false)'));
    });

    test('the phone arrangement is untouched', () {
      expect(body('Widget _buildLandscapeLayout('),
          contains('_buildDetailSections(context, isDark)'));
      expect(body('Widget _buildPortraitLayout('),
          contains('_buildDetailSections(context, isDark)'));
    });
  });

  group('the anatomy pager', () {
    test('the layout is decided by the section width, not the window', () {
      final String anatomy = body('Widget _buildAnatomySection(');
      expect(anatomy, contains('LayoutBuilder('),
          reason: 'A widget handed a narrow slice of a wide window has to '
              'measure the slice it was given');
      expect(anatomy, contains('constraints.maxWidth'));
      expect(anatomy, isNot(contains('zenWindow')),
          reason:
              'Gating on the window class is what put four cards into a 285dp '
              'column on an iPad: ~70dp each, so the 60dp tile plus its 16dp gap '
              'left the text two pixels and it wrapped one character per line');
    });

    test('cards are never seated below their minimum width', () {
      final String anatomy = body('Widget _buildAnatomySection(');
      expect(anatomy, contains('_anatomyCardMinWidth'));
      expect(anatomy, contains('_anatomyCardGap'));
      expect(anatomy, contains('columns < 2'),
          reason: 'Side by side only when two cards actually fit');
      expect(anatomy, contains('_buildAnatomyPager('));
    });

    test('every component is shown at once when there is room', () {
      final String anatomy = body('Widget _buildAnatomySection(');
      expect(anatomy, contains('Wrap('),
          reason: 'Wrapping shows them all rather than paging');
      expect(anatomy, isNot(contains('_pageController')),
          reason: 'With every card visible there is nothing to page to');
    });

    test('the carousel survives as the narrow fallback', () {
      final String pager = body('Widget _buildAnatomyPager(');
      expect(pager, contains('PageView.builder('));
      expect(pager, contains('controller: _pageController'));
    });

    test('the component header cannot overflow its card', () {
      final String card = body('Widget _buildAnatomyCard(');
      expect(card, contains('Flexible('),
          reason: 'The label is wider than a narrow card and must be allowed to '
              'shrink, or the headers run together into ANANATOMIEOMIE');
      expect(card, contains('TextOverflow.ellipsis'));
    });
  });
}
