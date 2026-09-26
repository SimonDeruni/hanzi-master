import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guard rails for **typography**: the app's identity is only real if the fonts
/// it asks for actually ship.
///
/// The bug this exists to prevent: `lib/` asked for `'NotoSerifSC'` in **60**
/// places while `pubspec.yaml`'s `fonts:` block was commented out and
/// `assets/fonts/` did not exist. Flutter therefore fell back silently at every
/// one of those sites, for the life of the project, on every platform - the
/// calligraphic identity never shipped and hanzi rendered in whatever
/// sans-serif CJK face the device happened to have. Nothing noticed, because
/// nothing checked.
///
/// **What this cannot see**, stated so the gap is not mistaken for coverage: a
/// family supplied through a *variable* (`AppLocalizations…!.notoserifsc`) rather
/// than a literal, and whether the subset actually carries a given glyph. The
/// second one is answered by `scratch/verify_font_coverage.py`, which reports
/// coverage against the app's own taught inventory - the last run said
/// **0 taught characters missing**.
List<File> _libSources() => Directory('lib')
    .listSync(recursive: true)
    .whereType<File>()
    .where((File file) => file.path.endsWith('.dart'))
    .toList();

/// Removes `//` comments so a commented-out family is not counted as a use.
String _withoutLineComments(String source) => source
    .split('\n')
    .map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    })
    .join('\n');

void main() {
  late String pubspec;
  late Set<String> declaredFamilies;
  late List<String> declaredFontAssets;

  setUpAll(() {
    pubspec = File('pubspec.yaml').readAsStringSync();
    declaredFamilies = RegExp(r'^\s*-\s*family:\s*(\S+)\s*$', multiLine: true)
        .allMatches(pubspec)
        .map((RegExpMatch m) => m.group(1)!)
        .toSet();
    declaredFontAssets = RegExp(r'^\s*-\s*asset:\s*(\S+)\s*$', multiLine: true)
        .allMatches(pubspec)
        .map((RegExpMatch m) => m.group(1)!)
        .toList();
  });

  group('Typography guard rails', () {
    test('the app asks only for fonts it actually bundles', () {
      final Set<String> families = <String>{};
      for (final File file in _libSources()) {
        final String source = _withoutLineComments(file.readAsStringSync());
        for (final RegExpMatch match
            in RegExp(r"fontFamily:\s*'([^']+)'").allMatches(source)) {
          families.add(match.group(1)!);
        }
      }

      expect(
        families.difference(declaredFamilies),
        isEmpty,
        reason: 'These families are requested in lib/ but never declared under '
            '`fonts:` in pubspec.yaml, so Flutter falls back to the platform '
            'font without saying so.',
      );
    });

    test('every declared font asset exists on disk, and is not empty', () {
      expect(declaredFontAssets, isNotEmpty, reason: 'no font is declared');

      for (final String asset in declaredFontAssets) {
        final File file = File(asset);
        expect(file.existsSync(), isTrue, reason: 'declared but absent: $asset');
        expect(
          file.lengthSync(),
          greaterThan(100 * 1024),
          reason: '$asset is suspiciously small - a placeholder would fall back '
              'exactly like a missing font',
        );
      }
    });

    test('the Zen serif ships in two weights with its licence', () {
      expect(declaredFamilies, contains('NotoSerifSC'));
      expect(pubspec, contains('assets/fonts/NotoSerifSC-Regular.ttf'));
      expect(pubspec, contains('assets/fonts/NotoSerifSC-Bold.ttf'));
      expect(
        File('assets/fonts/OFL.txt').existsSync(),
        isTrue,
        reason: 'the SIL OFL requires the licence to travel with the font',
      );
    });
  });
}
