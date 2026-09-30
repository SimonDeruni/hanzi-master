/// The reading surfaces that open a detail **beside** the list on an iPad.
///
/// **The bug:** the book catalogue had grown the pane (`_previewBook` beside the
/// shelf), but the two places that open *reading material that is not a novel* —
/// the Cultural Reading Room's cards (Mandarin Bean stories, poets' collections,
/// the daily story) and the catalogue's micro-read cards — still called
/// `Navigator.push` unconditionally. On an iPad the tap therefore covered the
/// whole window instead of filling the right pane, and the grid the learner was
/// browsing vanished behind it.
///
/// The rule is the catalogue's, applied to every card that opens a detail:
/// `if (context.zenWindow.isExpanded)` select into the pane, else push the same
/// route a phone gets. The pane hosts the very same screen in `embedded` mode,
/// and the host hands it `onClose` because a pane owns no route to pop.
///
/// A widget test cannot reach these screens (Hive, Riverpod providers, story
/// controllers), so the wiring is pinned against source, as with the reader,
/// scanner and desk guards.
@Tags(<String>['ipad-sweep'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String _library =
    'lib/features/media/presentation/screens/story_library_screen.dart';
const String _catalog =
    'lib/features/reading/presentation/screens/book_catalog_screen.dart';
const String _summary =
    'lib/features/media/presentation/screens/story_summary_screen.dart';

String _read(String path) =>
    File(path).readAsStringSync().replaceAll('\r\n', '\n');

void main() {
  late String library;
  late String catalog;
  late String summary;

  setUpAll(() {
    library = _read(_library);
    catalog = _read(_catalog);
    summary = _read(_summary);
  });

  group('The reading room opens its cards beside the grid', () {
    test('the tap branches on the window class, never a raw width', () {
      expect(library, contains('final bool beside = context.zenWindow.isExpanded;'),
          reason: 'One branch decides pane or route');
      expect(library, contains('if (!context.zenWindow.isExpanded) return screen;'));
      expect(
        RegExp(r'(width|shortestSide)\s*[><]=?\s*\d{3}').hasMatch(library),
        isFalse,
        reason: 'A Split View slice is narrower than any constant',
      );
    });

    test('a phone still gets the pushed routes it always had', () {
      // Both drill-downs survive unchanged below the branch.
      expect(library, contains('StorySummaryScreen(story: story),'));
      expect(library, contains('BookDetailScreen(book: poemBook),'));
    });

    test('the pane hosts the same two screens, embedded and closable', () {
      expect(library, contains('StorySummaryScreen(\n'
          '                story: _previewStory!,\n'
          '                embedded: true,\n'
          '                onClose: _closeDetailPane,'));
      expect(library, contains('BookDetailScreen(\n'
          '            book: _previewBook!,\n'
          '            embedded: true,\n'
          '            onClose: _closeDetailPane,'));
      expect(library, contains('const VerticalDivider(width: 1),'));
      expect(library, contains('SizedBox(width: 420, child: pane),'),
          reason: 'Same pane width as the catalogue, so the two feel alike');
    });

    test('a poem selects its poet\'s book, a story its summary', () {
      expect(library, contains('_previewBook = poemBook;'));
      expect(library, contains('_previewStory = story;'));
      // One slot per kind: the pane can never show a stale neighbour.
      expect(library, contains('_previewStory = null;'));
      expect(library, contains('_previewBook = null;'));
    });
  });

  group('The catalogue pane speaks both kinds', () {
    test('a micro-read selects into the pane instead of pushing', () {
      expect(catalog, contains('LibraryStory? _previewStory;'));
      expect(catalog, contains('_previewStory = story;'));
      expect(
        catalog,
        contains('if (context.zenWindow.isExpanded &&\n'
            '              (_previewBook != null || _previewStory != null))'),
      );
    });

    test('the pane renders whichever detail was selected', () {
      expect(catalog, contains('_previewStory != null\n'
          '                  ? StorySummaryScreen(\n'
          '                      story: _previewStory!,\n'
          '                      embedded: true,\n'
          '                      onClose: _closeDetailPane,'));
      expect(catalog, contains('void _closeDetailPane() {'));
    });
  });

  group('The summary screen can live in a pane', () {
    test('it carries the book screen\'s embedded contract', () {
      expect(summary, contains('final bool embedded;'));
      expect(summary, contains('final VoidCallback? onClose;'));
      expect(summary, contains('this.embedded = false,'));
      expect(summary, contains('this.onClose,'));
    });

    test('no back arrow to pop, but a corner that can dismiss', () {
      expect(summary, contains('automaticallyImplyLeading: false,'));
      expect(summary, contains('leading: widget.embedded'),
          reason: 'A pane has no route behind it');
      expect(summary, contains('tooltip: MaterialLocalizations.of(context)'
          '.closeButtonTooltip,'));
    });

    test('its cover\'s Hero is off while embedded', () {
      // The library card for the same story is on screen beside the pane with
      // the same tag, so two Heroes with one tag would share the reading-room
      // route.
      expect(summary, contains('enabled: !widget.embedded,'));
    });
  });
}
