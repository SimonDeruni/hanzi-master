import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/data/story_fetcher_service.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';

/// The thirteen `mandarin_bean_stories_<locale>.json` overlays sat in the bundle
/// with all 150 titles translated, and **no code read them**: the reader fell
/// back to `summaryEn` on every locale (audit 37, P0). `StoryFetcherService`
/// now loads them through `_loadBeanOverlay`.
///
/// These tests keep that wiring honest. They exercise the real service against
/// the real assets - no fixture - because the whole failure mode was "the file
/// exists and nobody reads it", which a mocked loader would hide.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const String confuciusLink = 'https://mandarinbean.com/confucius/';

  late StoryFetcherService service;

  setUp(() {
    service = StoryFetcherService();
  });

  test('every story carries a localized title map, keyed by its link', () async {
    final List<LibraryStory> stories = await service.fetchLocalStories();
    expect(stories, isNotEmpty, reason: 'The bundled shelf itself must load.');

    final LibraryStory confucius = stories.firstWhere(
      (LibraryStory story) => story.link == confuciusLink,
      orElse: () => throw StateError('confucius is missing from the shelf'),
    );

    expect(
      confucius.localizedTitles,
      isNotEmpty,
      reason: 'An empty map is exactly the regression: the shelf then shows '
          '`titleEn` for every locale.',
    );
    expect(
      confucius.localizedTitles.length,
      greaterThanOrEqualTo(10),
      reason: 'All thirteen overlays ship translated titles for this story.',
    );
  });

  test('the localized text differs from the English the story carries', () async {
    final List<LibraryStory> stories = await service.fetchLocalStories();
    final LibraryStory confucius = stories
        .firstWhere((LibraryStory story) => story.link == confuciusLink);

    final String german = confucius.localizedTitle('de');
    expect(german, isNotEmpty);
    expect(
      german,
      isNot(confucius.titleEn),
      reason: 'The overlay must win over the English fallback for a locale it '
          'covers.',
    );

    // Arabic is a completed translation sweep, so its summary is a real
    // translation rather than the English the data carries.
    final String arabicSummary = confucius.localizedSummary('ar');
    expect(arabicSummary, isNotEmpty);
    expect(
      arabicSummary,
      isNot(confucius.summaryEn),
      reason: 'This is the P0: before the wiring, localizedSummary() always '
          'returned summaryEn.',
    );
  });

  test('a locale the overlay does not cover still degrades to English', () async {
    final List<LibraryStory> stories = await service.fetchLocalStories();
    final LibraryStory confucius = stories
        .firstWhere((LibraryStory story) => story.link == confuciusLink);

    // `zz` is not a shipped locale, so nothing may blow up or blank out.
    expect(confucius.localizedTitle('zz'), confucius.titleEn ?? confucius.title);
    expect(confucius.localizedSummary('zz'), confucius.summaryEn);
  });

  test('the overlay is keyed the same way the story data is', () async {
    // Guards the join itself: the loader keys by JSON key, and the story keys by
    // `link`. If those ever drift apart the maps silently come back empty.
    final Map<String, dynamic> overlay = jsonDecode(
      File('assets/data/l10n/mandarin_bean_stories_de.json')
          .readAsStringSync(),
    ) as Map<String, dynamic>;
    final List<dynamic> base = jsonDecode(
      File('assets/data/mandarin_bean_stories.json').readAsStringSync(),
    ) as List<dynamic>;

    final Set<String> links = base
        .map((dynamic entry) => (entry as Map)['link'].toString())
        .toSet();
    expect(links, hasLength(150));
    expect(
      links.difference(overlay.keys.toSet()),
      isEmpty,
      reason: 'Every story link must have an overlay entry, or that story '
          'silently shows English in German.',
    );
  });
}
