import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guard rails for **typography**.
///
/// The bug this exists to prevent: `lib/` asked for `'NotoSerifSC'` in **60**
/// places while `pubspec.yaml`'s `fonts:` block was commented out and
/// `assets/fonts/` did not exist. Flutter therefore fell back silently at every
/// one of those sites, for the life of the project, on every platform - so the
/// app's identity never actually shipped and hanzi rendered in whatever
/// sans-serif CJK face the device happened to have. Nothing noticed, because
/// nothing checked.
///
/// Policy now (2026-09-26, at the owner's request): the app ships **no** custom
/// font and asks for **none** - every text style uses the platform face (San
/// Francisco on iOS, Roboto on Android). So the guard flipped from "the serif
/// must be bundled" to "nothing may request a family at all", which is the
/// stricter and simpler rule. If a font is ever added back, it must be declared
/// under `fonts:` in `pubspec.yaml` *and* its asset committed, or these tests
/// fail the build.
///
/// **What this cannot see**, stated so the gap is not mistaken for coverage: a
/// family supplied through a *variable* (e.g. `someL10nString`) rather than a
/// literal, and whether a bundled font actually carries a given glyph (that is
/// answered by `scratch/verify_font_coverage.py`, which reports coverage
/// against the app's own taught inventory).
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

    test('the app ships no custom font - everything is platform-native', () {
      // The owner's decision (2026-09-26): no bundled face, no requested face.
      // A `fontFamily:` literal anywhere in lib/ would be a silent opt-out of
      // that, so this is asserted on raw source rather than on the parsed set.
      expect(
        declaredFamilies,
        isEmpty,
        reason: 'pubspec.yaml declares a font family again',
      );

      final List<String> offenders = <String>[];
      for (final File file in _libSources()) {
        final String source = _withoutLineComments(file.readAsStringSync());
        for (final RegExpMatch match
            in RegExp(r'fontFamily\s*:\s*([^,\r\n]+)').allMatches(source)) {
          final String value = match.group(1)!.trim();
          // `_fontFamily` is the theme's documented `null` (platform-native);
          // anything else is a real family name and therefore a fallback risk.
          if (value != '_fontFamily') {
            offenders.add('${file.path}: $value');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'These sites request a font family; the app ships none, so each '
            'of these is a silent fallback waiting to happen: $offenders',
      );

      // The one permitted spelling must genuinely mean "platform font".
      expect(
        RegExp(r'static const String\? _fontFamily = null;')
            .hasMatch(File('lib/core/theme/app_theme.dart').readAsStringSync()),
        isTrue,
        reason: 'the component themes must resolve to the platform font',
      );

      expect(
        Directory('assets/fonts').existsSync(),
        isFalse,
        reason: 'assets/fonts/ is back - if fonts ship again they need the OFL '
            'licence alongside them and a declaration in pubspec.yaml',
      );
    });
  });
}
