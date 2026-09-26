@Tags(<String>['locale-sweep'])
library;

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
String _withoutLineComments(String source) =>
    source.split('\n').map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    }).join('\n');

/// Argument text of the call whose `(` sits at [openParen], plus the index of the
/// matching `)`. Nesting-aware, so a container's *own* `width:` is never confused
/// with a width belonging to something nested inside it.
(String, int)? _balancedArgs(String source, int openParen) {
  int depth = 0;
  for (int i = openParen; i < source.length; i++) {
    final String c = source[i];
    if (c == '(' || c == '[' || c == '{') {
      depth++;
    } else if (c == ')' || c == ']' || c == '}') {
      depth--;
      if (depth == 0) return (source.substring(openParen + 1, i), i);
    }
  }
  return null;
}

/// Splits a call's arguments on depth-0 commas, ignoring commas inside strings.
List<String> _splitTopLevel(String args) {
  final List<String> parts = <String>[];
  final StringBuffer current = StringBuffer();
  int depth = 0;
  String? quote;
  for (int i = 0; i < args.length; i++) {
    final String c = args[i];
    if (quote != null) {
      if (c == r'\') {
        current.write(args.substring(i, i + 2));
        i++;
        continue;
      }
      if (c == quote) quote = null;
    } else if (c == "'" || c == '"') {
      quote = c;
    } else if (c == '(' || c == '[' || c == '{') {
      depth++;
    } else if (c == ')' || c == ']' || c == '}') {
      depth--;
    } else if (c == ',' && depth == 0) {
      parts.add(current.toString());
      current.clear();
      continue;
    }
    current.write(c);
  }
  parts.add(current.toString());
  return parts
      .map((String part) => part.trim())
      .where((String part) => part.isNotEmpty)
      .toList();
}

/// Raw text of a top-level named argument of a call, or null.
String? _topLevelArg(List<String> args, String name) {
  for (final String arg in args) {
    if (arg.startsWith('$name:')) return arg.substring(name.length + 1).trim();
  }
  return null;
}

/// The numeric literal when [expression] is a bare finite number.
double? _bareNumber(String? expression) {
  if (expression == null) return null;
  final RegExpMatch? match = RegExp(r'^([\d.]+)$').firstMatch(expression);
  return match == null ? null : double.tryParse(match.group(1)!);
}

/// A bare numeric literal inside a `BoxConstraints(...)` expression.
double? _constraintNumber(String? expression, String key) {
  if (expression == null) return null;
  final RegExpMatch? match = RegExp('(?<![\\w.])$key\\s*:\\s*([\\d.]+)\\s*[,)]')
      .firstMatch(expression);
  return match == null ? null : double.tryParse(match.group(1)!);
}

/// True when [child] states how it degrades instead of relying on silent
/// clipping: a scale-down box, or a line cap with an overflow strategy.
bool _declaresDegradation(String child) =>
    child.contains('FittedBox(') ||
    (child.contains('maxLines:') && child.contains('overflow:'));

/// Containers whose *own* [dimension] (`width` / `height`) is capped around a
/// child subtree that holds text, where the child declares no degradation.
/// Pass [limit] to narrow the rule to especially small caps; a null [limit]
/// means "any finite cap", which is the design standard's actual wording —
/// never fix the size of a box that holds localized text.
/// Mirrors `scratch/fixed_width_text_audit.py`.
List<String> _cappedTextContainers({
  required String dimension,
  double? limit,
}) {
  final String constraintKey = dimension == 'width' ? 'maxWidth' : 'maxHeight';
  final List<String> offenders = <String>[];
  for (final File file in _libSources()) {
    final String source = file.readAsStringSync();
    for (final String name in <String>[
      'SizedBox',
      'Container',
      'ConstrainedBox',
    ]) {
      for (final RegExpMatch match
          in RegExp('(?<![\\w.])$name\\s*\\(').allMatches(source)) {
        final (String, int)? call = _balancedArgs(source, match.end - 1);
        if (call == null) continue;
        final List<String> top = _splitTopLevel(call.$1);
        final String? child = _topLevelArg(top, 'child');
        if (child == null) continue;
        if (!RegExp(r'(?<![\w.])Text\(').hasMatch(child)) continue;
        if (_declaresDegradation(child)) continue;
        final double? cap = _bareNumber(_topLevelArg(top, dimension)) ??
            _constraintNumber(_topLevelArg(top, 'constraints'), constraintKey);
        if (cap == null || (limit != null && cap > limit)) continue;
        offenders.add('${file.path}:${_lineOf(source, match.start)} '
            '$name($dimension: ${cap.toStringAsFixed(0)})');
      }
    }
  }
  return offenders;
}

/// True when [args] holds a localized label (`l10n.…`, `AppLocalizations.…`).
bool _hasLocalizedLabel(String args) =>
    args.contains('l10n.') ||
    args.contains('AppLocalizations') ||
    args.contains('localizations.');

/// True when the `Row(` at [rowStart] cannot overflow with a translation: it
/// declares `// locale-safe: <reason>`, gives at least one child
/// `Expanded`/`Flexible`/`Wrap`, or carries no localized label at all (icons and
/// fixed-size badges do not grow with a language).
///
/// The marker is looked for in a small window around the row, because
/// `dart format` moves a trailing comment onto the line just inside the call.
bool _rowIsSafe(String source, int rowStart, String args) {
  int windowStart = source.lastIndexOf('\n', rowStart) + 1;
  for (int i = 0; i < 2; i++) {
    final int previousNewline =
        windowStart >= 2 ? source.lastIndexOf('\n', windowStart - 2) : -1;
    if (previousNewline < 0) break;
    windowStart = previousNewline + 1;
  }
  int windowEnd = source.indexOf('\n', rowStart);
  if (windowEnd < 0) {
    windowEnd = source.length;
  } else {
    for (int i = 0; i < 2; i++) {
      final int nextNewline = source.indexOf('\n', windowEnd + 1);
      if (nextNewline < 0) {
        windowEnd = source.length;
        break;
      }
      windowEnd = nextNewline;
    }
  }
  if (source.substring(windowStart, windowEnd).contains('locale-safe')) {
    return true;
  }
  if (args.contains('Expanded(') ||
      args.contains('Flexible(') ||
      args.contains('Wrap(')) {
    return true;
  }
  return !_hasLocalizedLabel(args);
}

/// Every `Row` that holds a button *and a localized label* — the two-actions
/// side-by-side case, one entry per button, matching the audit's counting.
List<String> _inflexibleActionRows() {
  final RegExp button = RegExp(
      r'(?:Elevated|Outlined|Text|Filled|Cupertino)?Button(?:\.icon)?\s*\(');
  final List<String> offenders = <String>[];
  for (final File file in _libSources()) {
    final String source = file.readAsStringSync();
    for (final RegExpMatch match in button.allMatches(source)) {
      final int rowStart = source.lastIndexOf('Row(', match.start);
      if (rowStart == -1) continue;
      final (String, int)? row = _balancedArgs(source, rowStart + 3);
      if (row == null || match.start > row.$2) continue;
      if (_rowIsSafe(source, rowStart, row.$1)) continue;
      offenders.add('${file.path}:${_lineOf(source, rowStart)}');
    }
  }
  return offenders;
}

/// Every `Row` that holds localized text but no flexible child anywhere — the
/// general case, one entry per row.
List<String> _inflexibleRows() {
  final List<String> offenders = <String>[];
  for (final File file in _libSources()) {
    final String source = file.readAsStringSync();
    for (final RegExpMatch match
        in RegExp(r'(?<![\w.])Row\(').allMatches(source)) {
      final (String, int)? row = _balancedArgs(source, match.end - 1);
      if (row == null) continue;
      if (_rowIsSafe(source, match.start, row.$1)) continue;
      offenders.add('${file.path}:${_lineOf(source, match.start)}');
    }
  }
  return offenders;
}

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
          final int end =
              match.end + 400 < source.length ? match.end + 400 : source.length;
          final String tail = source.substring(match.end, end);
          if (!tail.contains('overflow:') && !tail.contains('maxLines:')) {
            offenders.add('${file.path}:${_lineOf(source, match.start)}');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'Prefer Flexible/Expanded/ConstrainedBox(minWidth:) over a fixed\n'
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

    test('an action Row keeps every localized child flexible', () {
      // Ratchet: this number can only go DOWN. A button inside a `Row` with no
      // `Expanded`/`Flexible`/`Wrap` cannot grow, so a longer translation pushes
      // it — or its neighbour — out of the row. That is the reported "in another
      // language the text goes outside the button" case: English "Report" is
      // Vietnamese "Báo cáo chi tiết" (2.7x).
      // Measured 23 on 2026-09-25 across 12 rows; this number can only go DOWN.
      const int baseline = 0;
      final List<String> offenders = _inflexibleActionRows();

      expect(
        offenders.length,
        lessThanOrEqualTo(baseline),
        reason:
            'A Row holding a button with no Expanded/Flexible/Wrap overflows '
            'as soon as a translation expands (${offenders.length} found, '
            'baseline $baseline). Make the text-bearing child flexible, or use '
            'Wrap:\n${offenders.join('\n')}',
      );
    });

    test('a Row that holds localized text keeps it flexible', () {
      // Ratchet: can only go DOWN. The rule above covers two actions side by side;
      // this is the general case — ANY row carrying a localized label with no
      // `Expanded`/`Flexible`/`Wrap` grows with its translation and drags its
      // neighbours off the screen. Measured 72 on 2026-09-25.
      const int baseline = 72;
      final List<String> offenders = _inflexibleRows();

      expect(
        offenders.length,
        lessThanOrEqualTo(baseline),
        reason: 'A Row holding localized text with no Expanded/Flexible/Wrap '
            'overflows as soon as a translation expands (${offenders.length} '
            'found, baseline $baseline). Make the text-bearing child flexible, '
            'or use Wrap:\n${offenders.join('\n')}',
      );
    });

    test('a width-capped container around text declares how the text degrades',
        () {
      // Ratchet: can only go DOWN. The design standard says never size a box that
      // holds localized text — so *any* finite width cap on a text-bearing child
      // is a candidate, unless the child already states how it degrades:
      // `FittedBox(fit: BoxFit.scaleDown)`, or `maxLines:` + `overflow:`.
      // Measured 11 on 2026-09-25 (the <=130px subset alone is 10).
      const int baseline = 11;
      final List<String> offenders = _cappedTextContainers(
        dimension: 'width',
      );

      expect(
        offenders.length,
        lessThanOrEqualTo(baseline),
        reason: 'Containers with a fixed width around text and no degradation '
            'strategy (${offenders.length} found, baseline $baseline). Prefer '
            'Flexible/Expanded, or declare FittedBox(scaleDown) / '
            'maxLines+overflow:\n${offenders.join('\n')}',
      );
    });

    test('a height-capped container around text declares how the text degrades',
        () {
      // Ratchet: can only go DOWN. A fixed height clips the taller line boxes of
      // Devanagari, Thai and Arabic, and a button pinned to a fixed height clips
      // a label that has to wrap in a longer language.
      // Measured 40 on 2026-09-25 (the <=48px subset alone is 6).
      const int baseline = 40;
      final List<String> offenders = _cappedTextContainers(
        dimension: 'height',
      );

      expect(
        offenders.length,
        lessThanOrEqualTo(baseline),
        reason: 'Containers with a fixed height around text and no degradation '
            'strategy (${offenders.length} found, baseline $baseline). Remove '
            'the height cap, use a minimum height, or declare the degradation:'
            '\n${offenders.join('\n')}',
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
          expect(minimum!.width, 0,
              reason: 'A width clamp breaks long locales');
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
