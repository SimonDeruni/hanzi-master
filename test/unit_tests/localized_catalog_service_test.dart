import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';

/// Which text a book's "Synopsis" card shows.
///
/// **The bug:** the lookup read `books_<locale>.json` (the prose catalogue) and
/// fell straight to `fallbackEn` when the id was absent. Poetry collections are
/// not in that file — their `description` is the poet's *translated* biography —
/// so a French reader got the English poem-title list under a "Synopsis"
/// heading: "pas de summary bien et traduit".
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const String localizedDescription =
      'Li Bai était un poète romantique de la dynastie Tang, surnommé le « Poète Immortel ».';
  const String englishTitles = 'Quiet Night Thoughts · Waterfall at Mount Lu';

  test('a book with no overlay of its own shows its localized description',
      () async {
    final text = await LocalizedCatalogService.getBookSynopsis(
      bookId: 'poetry_author_deadbeef',
      localeCode: 'fr',
      fallback: localizedDescription,
      fallbackEn: englishTitles,
    );

    expect(text, localizedDescription,
        reason: 'English is the last resort, not the first');
  });

  test('an empty localized description still falls through to English',
      () async {
    final text = await LocalizedCatalogService.getBookSynopsis(
      bookId: 'poetry_author_deadbeef',
      localeCode: 'fr',
      fallback: '   ',
      fallbackEn: englishTitles,
    );

    expect(text, englishTitles);
  });

  test('a caller that only has English keeps the old behaviour', () async {
    // `books_fr.json` is a real asset and the test runner loads it, so the id
    // has to be one the prose catalogue genuinely does not know — a poet's.
    final text = await LocalizedCatalogService.getBookSynopsis(
      bookId: 'poetry_author_cafebabe',
      localeCode: 'fr',
      fallbackEn: englishTitles,
    );

    expect(text, englishTitles);
  });

  test('a real poetry collection is absent from the prose catalogue', () async {
    // Guards the premise of the fix: if a poet's book ever joins
    // `books_<locale>.json`, this test tells us the fallback chain is no longer
    // the thing standing between a reader and the right text.
    final overlay = File('assets/data/l10n/books_fr.json').readAsStringSync();
    expect(overlay.contains('poetry_author_'), isFalse);
  });

  test('English is returned before any file is read', () async {
    final text = await LocalizedCatalogService.getBookSynopsis(
      bookId: 'journey_to_the_west',
      localeCode: 'en',
      fallback: localizedDescription,
      fallbackEn: englishTitles,
    );

    expect(text, englishTitles);
  });

  test('the book detail screen hands it the localized description', () {
    // The service is right; this pins the call site, which is where the English
    // text leaked in. A widget test cannot open the detail screen (Hive, the
    // story controller, the whole reading stack), so it is checked in source.
    final source = File(
            'lib/features/reading/presentation/screens/book_detail_screen.dart')
        .readAsStringSync()
        .replaceAll('\r\n', '\n');

    expect(source, contains('fallback: widget.book.description,'));
    expect(source, contains('fallbackEn: widget.book.descriptionEn,'));
  });
}
