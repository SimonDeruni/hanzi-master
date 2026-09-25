import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Ordering contract for the web screen (MediaHubScreen).
///
/// Verified against the source because rendering the screen requires live
/// network feeds and an open Hive box (`saved_articles`), neither of which are
/// available in a unit test environment.
void main() {
  late String source;

  setUpAll(() {
    final file = File(
      'lib/features/media/presentation/screens/media_hub_screen.dart',
    );
    expect(file.existsSync(), isTrue,
        reason: 'media_hub_screen.dart must exist');
    source = file.readAsStringSync();
  });

  test('news of the day carousel is declared before the Web Explorer card', () {
    final carouselIndex = source.indexOf('child: _DailyDiscoveryCarousel()');
    final webExplorerIndex =
        source.indexOf('child: _buildWebExplorerHeroCard(context)');

    expect(carouselIndex, greaterThan(-1),
        reason: 'the daily discovery carousel must be rendered');
    expect(webExplorerIndex, greaterThan(-1),
        reason: 'the Web Explorer hero card must be rendered');

    expect(
      carouselIndex,
      lessThan(webExplorerIndex),
      reason: 'The news-of-the-day carousel must appear ABOVE the Web '
          'Explorer card in the CustomScrollView slivers.',
    );
  });

  test('no duplicate daily discovery carousel remains below the hero card', () {
    final occurrences =
        'child: _DailyDiscoveryCarousel()'.allMatches(source).length;
    expect(occurrences, 1,
        reason: 'The carousel must be declared exactly once after reordering');
  });

  test('quick bookmarks still follow the Web Explorer card', () {
    final webExplorerIndex =
        source.indexOf('child: _buildWebExplorerHeroCard(context)');
    final bookmarksIndex = source.indexOf('l10n.quickBookmarks');
    final bookmarksIndexAlt = source.indexOf('.quickBookmarks');

    final resolvedBookmarks =
        bookmarksIndex != -1 ? bookmarksIndex : bookmarksIndexAlt;
    expect(resolvedBookmarks, greaterThan(-1),
        reason: 'Quick Bookmarks section must still be rendered');

    expect(webExplorerIndex, lessThan(resolvedBookmarks),
        reason: 'Bookmarks must remain below the Web Explorer card');
  });
}
