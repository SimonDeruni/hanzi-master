/// The Project Gutenberg imports wear the cover PG auto-generates when a book has
/// no jacket — a flat colour field with a few random shapes and a "Project
/// Gutenberg" stamp — not a real cover. `CalligraphicBookCover` draws its own
/// calligraphic plate for those books instead of showing the photo, so the shelf
/// keeps the "Zen & Ink" look.
///
/// This pins that decision so it cannot drift silently:
///
/// * the id set stays inside the catalog, so a typo can't strip a real book's art,
/// * every placeholder book still ships a bundled file (the cover-manifest
///   contract is unchanged),
/// * the four hand-picked sub-20 KB jackets are not swept up by mistake, and
/// * the widget really draws the plate (no `Image`) while a real jacket stays a
///   picture.
///
/// The set is derived from the `gutenberg.org` sources in `docs/BOOK_SOURCES.md`
/// by `scratch/_cover_placeholder_probe.py`, which is the tool to re-run if this
/// fails.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';

List<Map<String, dynamic>> _catalog() =>
    (jsonDecode(File('assets/data/grand_library_catalog.json').readAsStringSync())
            as List<dynamic>)
        .cast<Map<String, dynamic>>();

BookModel _book(String id) => BookModel(
      id: id,
      title: '杜阳杂编',
      titleEn: 'Miscellaneous Records of Du Yang',
      author: '苏鹗',
      authorEn: 'Su E',
      category: 'Supernatural & Folklore',
      description: '…',
      descriptionEn: '…',
      dynastyOrEra: 'Tang Dynasty',
      hskLevel: 5,
      totalChapters: 3,
      coverEmoji: '📖',
      tags: const ['Folklore'],
    );

Widget _host(BookModel book) => MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 180,
            height: 240,
            child: CalligraphicBookCover(book: book, width: 180, height: 240),
          ),
        ),
      ),
    );

void main() {
  final catalogIds = _catalog().map((book) => book['id'] as String).toSet();

  test('no placeholder id is a stranger to the catalog', () {
    final orphaned = gutenbergPlaceholderCoverIds.difference(catalogIds);
    expect(orphaned, isEmpty,
        reason: 'these ids are not in the catalog: $orphaned');
  });

  test('every placeholder book still ships its cover file', () {
    final missing = <String>[];
    for (final id in gutenbergPlaceholderCoverIds) {
      final path = bookCoverAssetPath(id, isPoetry: false);
      if (!File(path).existsSync()) missing.add('$id ($path)');
    }
    expect(missing, isEmpty,
        reason: 'the manifest test requires a file per book: $missing');
  });

  test('a book with real art is never treated as a placeholder', () {
    // The four sub-20 KB covers outside Gutenberg are hand-picked jackets — the
    // exact false positives a file-size rule would have swallowed.
    for (final id in const [
      'dao_de_jing',
      'journey_to_the_west',
      'records_grand_historian',
      'the_art_of_war',
    ]) {
      expect(bookCoverIsPlaceholder(id), isFalse, reason: id);
    }
  });

  testWidgets('a placeholder book draws the plate, not the PG photo',
      (tester) async {
    await tester.pumpWidget(_host(_book('miscellaneous_records_of_duyang')));

    // The plate is code-drawn: no picture widget at all.
    expect(find.byType(Image), findsNothing);
    // …and the book's own title is on it, so a reader can still tell it apart.
    expect(find.text('杜阳杂编'), findsWidgets);
  });

  testWidgets('a real jacket is still shown as a picture', (tester) async {
    await tester.pumpWidget(_host(_book('journey_to_the_west')));

    final Image image = tester.widget<Image>(find.byType(Image).first);
    expect((image.image as AssetImage).assetName,
        'assets/images/books/journey_to_the_west.jpg');
  });
}
