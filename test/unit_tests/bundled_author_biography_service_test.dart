import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/bundled_author_biography_service.dart';

/// Serves the biography catalogues from memory; a key it does not know is the
/// missing-asset case a build without one of the sweeps looks like.
class _FakeBundle extends CachingAssetBundle {
  _FakeBundle(this.files);

  final Map<String, String> files;

  @override
  Future<ByteData> load(String key) async {
    final text = files[key];
    if (text == null) {
      throw Exception('Unable to load asset: $key');
    }
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(text)));
  }
}

/// The author card on a book's detail.
///
/// **The bug:** the card read one catalogue, `author_bios_<locale>.json`, which
/// holds the prose classics' authors. A poetry collection's author is a poet —
/// `李白`, `杜甫` — who is in *neither* that file nor the catalogue it is keyed
/// from, so the card silently rendered nothing: "no explanation of the author".
/// The poets' own biographies (all 100, in all 14 locales) were already bundled
/// in `poet_bios_<locale>.json`.
void main() {
  const String proseFr =
      '{"罗贯中": "Luo Guanzhong est traditionnellement considéré…"}';
  const String poetsFr = '{"李白": "Li Bai était un poète romantique…"}';
  const String poetsEn = '{"李白": "Li Bai was a romantic poet…"}';

  BundledAuthorBiographyService service(Map<String, String> files) =>
      BundledAuthorBiographyService(bundle: _FakeBundle(files));

  test('a poet resolves from the poetry catalogue', () async {
    final bio = await service(<String, String>{
      'assets/data/l10n/author_bios_fr.json': proseFr,
      'assets/data/l10n/poet_bios_fr.json': poetsFr,
    }).biographyFor(author: '李白', localeCode: 'fr');

    expect(bio, isNotNull);
    expect(bio!.text, contains('Li Bai'));
    expect(bio.resolvedLocale, 'fr');
    expect(bio.usedEnglishFallback, isFalse);
  });

  test('a prose author still resolves from the prose catalogue', () async {
    final bio = await service(<String, String>{
      'assets/data/l10n/author_bios_fr.json': proseFr,
      'assets/data/l10n/poet_bios_fr.json': poetsFr,
    }).biographyFor(author: '罗贯中', localeCode: 'fr');

    expect(bio?.text, contains('Luo Guanzhong'));
  });

  test('a poet goes to the English poetry catalogue when theirs is missing',
      () async {
    final bio = await service(<String, String>{
      'assets/data/l10n/author_bios_fr.json': proseFr,
      'assets/data/l10n/poet_bios_en.json': poetsEn,
    }).biographyFor(author: '李白', localeCode: 'fr');

    expect(bio?.text, contains('romantic poet'));
    expect(bio?.resolvedLocale, 'en');
    expect(bio?.usedEnglishFallback, isTrue);
  });

  test('one missing catalogue never costs the other', () async {
    final onlyProse = service(<String, String>{
      'assets/data/l10n/author_bios_fr.json': proseFr,
    });
    expect((await onlyProse.biographyFor(author: '罗贯中', localeCode: 'fr'))?.text,
        isNotNull);
    expect(await onlyProse.biographyFor(author: '李白', localeCode: 'fr'), isNull);
  });

  test('a collection-shaped value is accepted too', () async {
    // `assets/data/poet_bios.json` stores `{summary, origin, source}`; the
    // translations are plain strings, and both shapes must work.
    final bio = await service(<String, String>{
      'assets/data/l10n/poet_bios_fr.json':
          '{"王维": {"summary": "Wang Wei était peintre et poète…"}}',
    }).biographyFor(author: '王维', localeCode: 'fr');

    expect(bio?.text, contains('Wang Wei'));
  });

  test('an author in neither catalogue resolves to null, not to an empty card',
      () async {
    final bio = await service(<String, String>{})
        .biographyFor(author: 'Nobody', localeCode: 'fr');

    expect(bio, isNull);
  });
}
