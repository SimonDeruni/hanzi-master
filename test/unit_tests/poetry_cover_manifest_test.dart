import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:hanzi_master/features/reading/domain/entities/poetry_collection.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';

BigInt _dHash(img.Image image) {
  final small = img.copyResize(img.grayscale(image), width: 9, height: 8);
  var hash = BigInt.zero;
  var bit = 0;
  for (var y = 0; y < 8; y++) {
    for (var x = 0; x < 8; x++) {
      if (small.getPixel(x, y).luminance < small.getPixel(x + 1, y).luminance) {
        hash |= BigInt.one << bit;
      }
      bit++;
    }
  }
  return hash;
}

int _distance(BigInt a, BigInt b) {
  var value = a ^ b;
  var count = 0;
  while (value != BigInt.zero) {
    value &= value - BigInt.one;
    count++;
  }
  return count;
}

void main() {
  test('poetry covers are complete, sourced, and distinct', () {
    final poems = jsonDecode(
            File('assets/data/famous_chinese_poetry.json').readAsStringSync())
        as List<dynamic>;
    // The real manifest the app ships, not a fixture: the covers below are the
    // bytes on disk.
    final manifest = jsonDecode(
            File('assets/data/poetry_cover_manifest.json').readAsStringSync())
        as Map<String, dynamic>;
    final covers = manifest['covers'] as List<dynamic>;

    // Schema 3 is the hybrid policy: a public-domain portrait where one exists,
    // a project-owned seal card otherwise. Schema 2 was the all-project-owned
    // illustration set, and schema 1 the CC0 museum pass before it.
    expect(manifest['schemaVersion'], 3);
    expect((manifest['policy'] as String).trim(), isNotEmpty);

    // The store is now one collection per poet (`poetry_author_<digest>`), keyed
    // on the raw Chinese author name. Every poet must end up with a cover.
    final expectedIds = <String>{};
    for (final value in poems) {
      final poem = value as Map<String, dynamic>;
      final raw = (poem['sourceName'] as String?)?.trim() ?? '';
      expectedIds.add(poetryAuthorBookId(raw.isEmpty ? poetryUnknownAuthor : raw));
    }

    final manifestIds = <String>{};
    final exactHashes = <String>{};
    final perceptualHashes = <String, BigInt>{};
    final kinds = <String, String>{};

    for (final value in covers) {
      final cover = value as Map<String, dynamic>;
      final id = cover['id'] as String;
      manifestIds.add(id);

      // A cover id must be the digest of the author it names, so it can never
      // drift onto a different poet.
      expect(id.startsWith(poetryAuthorBookPrefix), isTrue, reason: id);
      expect(id, poetryAuthorBookId(cover['author'] as String), reason: id);
      expect(expectedIds.contains(id), isTrue,
          reason: 'cover for an unknown poet: $id');

      final kind = cover['kind'] as String;
      kinds[id] = kind;
      if (kind == 'portrait') {
        // A portrait is only accepted when its source reports a public-domain
        // licence; the manifest must say so and point back at the source file.
        expect((cover['license'] as String).toLowerCase(),
            contains('public domain'),
            reason: id);
        expect(cover['copyright'], 'Public domain', reason: id);
        expect((cover['creator'] as String).trim(), isNotEmpty, reason: id);
        expect((cover['sourcePage'] as String).trim(), isNotEmpty, reason: id);
      } else {
        // The only other kind is the in-house seal, which carries no third-party
        // rights because none is embedded.
        expect(kind, 'seal', reason: id);
        expect(cover['license'], 'Not third-party licensed', reason: id);
        expect(cover['copyright'], 'Project-owned', reason: id);
        expect((cover['provenance'] as String).trim(), isNotEmpty, reason: id);
      }

      final file = File(cover['asset'] as String);
      expect(file.existsSync(), isTrue, reason: id);
      final bytes = file.readAsBytesSync();
      expect(sha256.convert(bytes).toString(), cover['sha256'], reason: id);
      expect(exactHashes.add(sha256.convert(bytes).toString()), isTrue,
          reason: 'Exact duplicate: $id');
      final decoded = img.decodeImage(Uint8List.fromList(bytes));
      expect(decoded, isNotNull, reason: id);
      expect(decoded!.width, 600, reason: id);
      expect(decoded.height, 800, reason: id);
      perceptualHashes[id] = _dHash(decoded);
    }

    expect(manifestIds, hasLength(covers.length));
    // Every poet has a cover, and no cover is orphaned.
    expect(manifestIds, equals(expectedIds));

    // Perceptual distinctness guards against two poets sharing the same picture.
    // It is asserted wherever a portrait is involved - the seals are a design
    // system that shares a layout on purpose, so they are only held to the
    // exact-hash rule above.
    final ids = perceptualHashes.keys.toList();
    for (var i = 0; i < ids.length; i++) {
      for (var j = i + 1; j < ids.length; j++) {
        if (kinds[ids[i]] != 'portrait' && kinds[ids[j]] != 'portrait') continue;
        final distance =
            _distance(perceptualHashes[ids[i]]!, perceptualHashes[ids[j]]!);
        expect(distance, greaterThan(5),
            reason: 'Perceptual duplicate (${ids[i]}, ${ids[j]}): $distance');
      }
    }
  });
}

