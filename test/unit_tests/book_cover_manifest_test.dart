/// Every book in the library has a cover, and every recorded cover says where it came from.
///
/// The gap this closes was invisible by construction: `CalligraphicBookCover` falls
/// back to a code-drawn plate when its image is missing, and that plate looks
/// deliberate — so a book with no picture and a book whose picture failed were
/// indistinguishable on screen. Eleven books were in that state (every poetry
/// anthology in the catalog) until `scratch/book_covers.py --apply` fetched CC0
/// museum art for them on 2026-09-30; `scratch/cover_audit.py` is the inventory tool
/// that found them and the one to re-run when this test fails.
///
/// Scope comes from the app's own id rules, not from a hand-kept list: the catalog
/// for the books, `poetry_collections.json` for the poet collections, and the two
/// functions in `poetry_story_id.dart` that turn an id into a path. A rename or a
/// new digest would fail here rather than at runtime.
library;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';
import 'package:image/image.dart' as img;

/// The size every bundled cover is normalised to by the fetcher — the same 3:4
/// plate the reader and the grid are laid out for.
const int _coverWidth = 600;
const int _coverHeight = 800;

List<Map<String, dynamic>> _readList(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as List<dynamic>)
        .cast<Map<String, dynamic>>();

Map<String, dynamic> _readMap(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  final catalog = _readList('assets/data/grand_library_catalog.json');
  final authors =
      _readMap('assets/data/poetry_collections.json').keys.toList();

  group('the library has a cover for every book', () {
    test('every catalog book has a cover file', () {
      expect(catalog, isNotEmpty);
      final missing = <String>[];
      for (final book in catalog) {
        final id = book['id'] as String;
        // The app's own path rule, so `black_cat_poe`'s renamed asset is covered too.
        final path = bookCoverAssetPath(id, isPoetry: false);
        if (!File(path).existsSync()) missing.add('$id ($path)');
      }
      expect(missing, isEmpty,
          reason: 'a book with no cover silently shows the code-drawn plate '
              'instead: ${missing.join(', ')}');
    });

    test('every poet collection has a cover file', () {
      // A poet's collection is a book with a real cover; a single poem draws its
      // own, which is why only the collections are asserted here.
      expect(authors, hasLength(100));
      final missing = <String>[];
      for (final author in authors) {
        final path = poetryCoverAssetPath(
            'poetry_author_${poetryDigest(author as String)}');
        if (!File(path).existsSync()) missing.add(author as String);
      }
      expect(missing, isEmpty, reason: 'collections with no cover: $missing');
    });
  });

  group('the recorded covers say where they came from', () {
    test('every book-manifest entry is that book\'s file, with that hash', () {
      final manifest = _readMap('assets/data/book_cover_manifest.json');
      final covers = (manifest['covers'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
      expect(covers, isNotEmpty);

      final catalogIds = catalog.map((book) => book['id']).toSet();
      for (final cover in covers) {
        final id = cover['id'] as String;
        expect(catalogIds, contains(id),
            reason: '$id is recorded but is not in the catalog');

        final asset = cover['asset'] as String;
        final file = File(asset);
        expect(file.existsSync(), isTrue, reason: id);
        expect(asset, bookCoverAssetPath(id, isPoetry: false),
            reason: '$id is recorded against a path the app will not ask for');

        // The hash is the point of a provenance record: it ties the licence claim to
        // the bytes actually shipped, and it is what makes a swapped file visible.
        expect(sha256.convert(file.readAsBytesSync()).toString(), cover['sha256'],
            reason: id);

        // These are fetched, so the claim has to be the museum's CC0 release and the
        // object has to predate 1929 — the rule `book_covers.py` enforces.
        expect(cover['license'], 'CC0', reason: id);
        expect(cover['sourcePage'], startsWith('https://www.clevelandart.org/art/'),
            reason: id);
        final year = int.tryParse(
            RegExp(r'-?\d+').firstMatch(cover['objectDate'] as String)!.group(0)!);
        expect(year, isNotNull, reason: id);
        expect(year! <= 1928 || year < 0, isTrue,
            reason: '$id: objectDate ${cover['objectDate']} is after 1928');

        final decoded = img.decodeImage(Uint8List.fromList(file.readAsBytesSync()));
        expect(decoded, isNotNull, reason: '$id is not a decodable image');
        expect(decoded!.width, _coverWidth, reason: id);
        expect(decoded.height, _coverHeight, reason: id);
      }
    });

    test('no cover file is doing duty for two books', () {
      // The library has had duplicates before (`fix(library): resolve duplicate
      // covers for Golden Cangue and Liezi`), and a duplicate is invisible: both
      // cards simply look right.
      final byHash = <String, List<String>>{};
      for (final book in catalog) {
        final path = bookCoverAssetPath(book['id'] as String, isPoetry: false);
        final hash = sha256.convert(File(path).readAsBytesSync()).toString();
        byHash.putIfAbsent(hash, () => <String>[]).add(book['id'] as String);
      }
      final shared = byHash.values.where((ids) => ids.length > 1).toList();
      expect(shared, isEmpty, reason: 'the same image is bundled twice: $shared');
    });
  });
}
