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
///     jumping between stacked sections); the anatomy `PageView` becomes a row
///     of component cards, since a swipe carousel on a wide screen hides content
///     and fights two-finger trackpad scrolling.
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
    test('expanded shows every component at once', () {
      final String anatomy = body('Widget _buildAnatomySection(');
      final int gate = anatomy.indexOf('if (context.zenWindow.isExpanded)');
      // The narrow path is the `return Column(` below the expanded early return,
      // so this slice cannot reach the carousel or its controller.
      final int narrow = anatomy.indexOf('return Column(', gate);
      expect(gate, greaterThan(-1));
      expect(narrow, greaterThan(gate));
      final String expandedBranch = anatomy.substring(gate, narrow);
      expect(expandedBranch, contains('_buildAnatomyCard('));
      expect(expandedBranch, contains('Expanded('));
      expect(expandedBranch, isNot(contains('_pageController')),
          reason: 'With every card visible there is nothing to page to');
    });

    test('the carousel survives on the narrow path', () {
      final String anatomy = body('Widget _buildAnatomySection(');
      final int expanded = anatomy.indexOf('if (context.zenWindow.isExpanded)');
      final int pageView = anatomy.indexOf('PageView.builder(');
      expect(pageView, greaterThan(expanded),
          reason:
              'The carousel must only exist below the expanded early return');
      expect(anatomy, contains('controller: _pageController'));
    });
  });
}
