import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

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
  test('all poetry covers are complete, decodable, and distinct', () {
    final poems = jsonDecode(
            File('assets/data/famous_chinese_poetry.json').readAsStringSync())
        as List<dynamic>;
    final manifest = jsonDecode(
            File('assets/data/poetry_cover_manifest.json').readAsStringSync())
        as Map<String, dynamic>;
    final covers = manifest['covers'] as List<dynamic>;
    expect(poems, hasLength(100));
    expect(covers, hasLength(poems.length));

    final poemIds = poems.map((p) => p['id'] as String).toSet();
    final manifestIds = <String>{};
    final hashes = <String>{};
    final sourcePages = <String>{};
    final perceptualHashes = <String, BigInt>{};

    for (final value in covers) {
      final cover = value as Map<String, dynamic>;
      final id = cover['id'] as String;
      manifestIds.add(id);
      expect(cover['license'], anyOf('Public domain', 'CC0'), reason: id);
      expect((cover['relevanceRationale'] as String).trim(), isNotEmpty,
          reason: id);
      expect(sourcePages.add(cover['sourcePage'] as String), isTrue,
          reason: 'Source artwork reused for $id');

      final file = File(cover['asset'] as String);
      expect(file.existsSync(), isTrue, reason: id);
      final bytes = file.readAsBytesSync();
      final hash = sha256.convert(bytes).toString();
      expect(hash, cover['sha256'], reason: id);
      expect(hashes.add(hash), isTrue, reason: 'Exact duplicate: $id');
      final decoded = img.decodeImage(Uint8List.fromList(bytes));
      expect(decoded, isNotNull, reason: id);
      expect(decoded!.width, 600, reason: id);
      expect(decoded.height, 800, reason: id);
      perceptualHashes[id] = _dHash(decoded);
    }
    expect(manifestIds, poemIds);

    final ids = perceptualHashes.keys.toList();
    for (var i = 0; i < ids.length; i++) {
      for (var j = i + 1; j < ids.length; j++) {
        final distance = _distance(
          perceptualHashes[ids[i]]!,
          perceptualHashes[ids[j]]!,
        );
        expect(distance, greaterThan(5),
            reason: 'Perceptual duplicate (${ids[i]}, ${ids[j]}): $distance');
      }
    }
  });
}
