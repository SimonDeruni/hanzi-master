import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../support/locale_layout_harness.dart';

/// Every Dart source shipped in the application.
List<File> _libSources() => Directory('lib')
    .listSync(recursive: true)
    .whereType<File>()
    .where((File file) => file.path.endsWith('.dart'))
    .toList();

/// One-based line number of [index] inside [source].
int _lineOf(String source, int index) =>
    RegExp(r'\n').allMatches(source.substring(0, index)).length + 1;

/// Removes `//` comments so documenting an idiom is not mistaken for using it.
String _withoutLineComments(String source) => source
    .split('\n')
    .map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    })
    .join('\n');

/// Guard rails that keep longer translations from overflowing the UI again.
void main() {
  group('Localized layout guard rails', () {
    test('no widget clamps a button to a fixed size', () {
      // `fixedSize` (and a finite `maximumSize`) pins a button to the English
      // label width, so a longer translation is clipped. `minimumSize` is the
      // only size constraint the design system allows.
      final List<String> offenders = <String>[];
      final RegExp pattern = RegExp(r'(?<![\w.])fixedSize\s*:');
      for (final File file in _libSources()) {
        final String source = _withoutLineComments(file.readAsStringSync());
        for (final RegExpMatch match in pattern.allMatches(source)) {
          offenders.add('${file.path}:${_lineOf(source, match.start)}');
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Use minimumSize, never fixedSize, so long locales still fit:\n'
            '${offenders.join('\n')}',
      );
    });

    test('a fixed-width box around Text declares how the text degrades', () {
      // `SizedBox(width: 60, child: Text(label))` silently wrapped or clipped
      // every translated label. Prefer Flexible/Expanded/ConstrainedBox, and if
      // a fixed width is genuinely required (a glyph tile, a numeric badge) the
      // Text must state what happens when it does not fit.
      final RegExp fixedWidthText =
          RegExp(r'SizedBox\(\s*width:\s*[\d.]+\s*,\s*child:\s*Text\(');
      final List<String> offenders = <String>[];
      for (final File file in _libSources()) {
        final String source = _withoutLineComments(file.readAsStringSync());
        for (final RegExpMatch match in fixedWidthText.allMatches(source)) {
          final int end = match.end + 400 < source.length
              ? match.end + 400
              : source.length;
          final String tail = source.substring(match.end, end);
          if (!tail.contains('overflow:') && !tail.contains('maxLines:')) {
            offenders.add('${file.path}:${_lineOf(source, match.start)}');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Prefer Flexible/Expanded/ConstrainedBox(minWidth:) over a fixed\n'
            'width; when the width is required, add maxLines + overflow:\n'
            '${offenders.join('\n')}',
      );
    });

    test('the number of untranslated UI literals never grows', () {
      // Ratchet: this number can only go DOWN. An untranslated literal is a
      // label that cannot expand for the other 13 languages, and it is also
      // invisible to the locale sweep. Move strings into `lib/l10n/*.arb`.
      const int baseline = 81;
      final RegExp literalText =
          RegExp(r'''Text\(\s*(['"])([A-Za-z][^'"\\\n]{3,})\1''');
      final RegExp localizedLine =
          RegExp(r'l10n\.|AppLocalizations|localizations\.');
      final List<String> offenders = <String>[];

      for (final File file in _libSources()) {
        final String source = file.readAsStringSync();
        for (final RegExpMatch match in literalText.allMatches(source)) {
          final int lineStart = source.lastIndexOf('\n', match.start) + 1;
          final int lineEnd = source.indexOf('\n', match.start);
          final String line = source.substring(
            lineStart,
            lineEnd == -1 ? source.length : lineEnd,
          );
          // Skip labels that are already localized.
          if (localizedLine.hasMatch(line)) {
            continue;
          }
          offenders.add(
            '${file.path}:${_lineOf(source, match.start)}: ${match.group(2)}',
          );
        }
      }

      expect(
        offenders.length,
        lessThanOrEqualTo(baseline),
        reason: 'Untranslated UI literals grew from $baseline to '
            '${offenders.length}. Localize the new strings in lib/l10n/*.arb '
            'instead of adding English text:\n${offenders.join('\n')}',
      );
    });
  });

  group('Button geometry contract', () {
    test('both themes keep every button type width-free', () {
      // The app-wide fix relies on these styles: a non-zero minimum width would
      // clamp a label, and a fixed/maximum size would clip it outright.
      for (final ThemeData theme in <ThemeData>[
        AppTheme.lightTheme,
        AppTheme.darkTheme,
      ]) {
        final List<ButtonStyle?> styles = <ButtonStyle?>[
          theme.filledButtonTheme.style,
          theme.elevatedButtonTheme.style,
          theme.outlinedButtonTheme.style,
          theme.textButtonTheme.style,
        ];
        for (final ButtonStyle? style in styles) {
          expect(style, isNotNull, reason: 'Missing localized button geometry');
          expect(style!.fixedSize, isNull);
          expect(style.maximumSize, isNull);
          final Size? minimum = style.minimumSize?.resolve(<WidgetState>{});
          expect(minimum, isNotNull);
          expect(minimum!.width, 0, reason: 'A width clamp breaks long locales');
          expect(minimum.height, greaterThanOrEqualTo(40));
          // Tracking must stay minimal; 1.0 used to inflate every label.
          final double? tracking =
              style.textStyle?.resolve(<WidgetState>{})?.letterSpacing;
          expect(tracking ?? 0, lessThanOrEqualTo(0.5));
        }
      }
    });
  });

  group('Button label overflow', () {
    testWidgets('a long translated label never overflows across locales',
        (WidgetTester tester) async {
      // Roughly the p95 expansion of a two-word English label in Russian,
      // Vietnamese or Thai - the case that used to push text out of the button.
      const String longLabel = 'Untertitel ausblenden und zuruecksetzen';

      await expectNoOverflowAcrossLocales(
        tester,
        (BuildContext context) => Scaffold(
          backgroundColor: AppTheme.surfaceLight,
          body: SafeArea(
            // Scrollable so the fixture measures label WIDTH, not vertical space.
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Two actions side by side is the classic overflow row.
                  // BOTH children must be flexible: English "Report" becomes
                  // "Báo cáo chi tiết" in Vietnamese (2.7x), so an inflexible
                  // button in a Row overflows the moment the locale expands.
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(longLabel),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(AppLocalizations.of(context)!.report),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // A single full-width button must grow, not clip.
                  FilledButton(
                    onPressed: () {},
                    child: const Text(longLabel),
                  ),
                  const SizedBox(height: 12),
                  // Icon + label, the most common button shape in the app.
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh),
                    label: const Text(longLabel),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  });
}
