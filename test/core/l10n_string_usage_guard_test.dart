import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Guards the two ways an ARB string silently reaches the screen wrong.
///
/// Both were live: bookmarking a chapter showed
/// *"Closure: (Object) => String from Function 'bookmarkAdded': . - Chapitre 2
/// sur 20"* in the toast, and every locale's bookmark text began with the
/// Chinese template it was written from. Neither is a crash, so nothing caught
/// them.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Keys whose ARB value carries a `{placeholder}`. `flutter gen-l10n`
  /// generates those as *methods*; using the key as a String prints the method's
  /// closure instead of a message and drops the placeholder argument.
  Set<String> placeholderKeys() {
    final Set<String> keys = <String>{};
    final RegExp placeholder = RegExp(r'\{[A-Za-z0-9_]+\}');
    for (final FileSystemEntity entity
        in Directory('lib/l10n').listSync()) {
      if (entity is! File || !entity.path.endsWith('.arb')) continue;
      final String raw = entity.readAsStringSync();
      for (final RegExpMatch match
          in RegExp(r'^\s*"([A-Za-z0-9_]+)":\s*"(.*)",\s*$', multiLine: true)
              .allMatches(raw)) {
        if (placeholder.hasMatch(match.group(2)!)) {
          keys.add(match.group(1)!);
        }
      }
    }
    return keys;
  }

  test('no placeholder message is used as a String', () {
    final Set<String> keys = placeholderKeys();
    expect(keys, isNotEmpty,
        reason: 'the ARB scan found no placeholder keys at all');

    // One alternation rather than a pattern per key: there are ~140 of them and
    // this walks every line of every file under lib/.
    final String alternatives = keys.map(RegExp.escape).join('|');
    // The receivers this codebase actually uses. A looser pattern (`!.key`)
    // matched `card!.hskLevel`, a model field, and reported it as a bug.
    final RegExp usage = RegExp(
      r'\b(?:l10n|loc|localizations|strings)\s*\.\s*(?:' +
          alternatives +
          r')\b|AppLocalizations\.of\([^()]*\)\s*!\s*\.\s*(?:' +
          alternatives +
          r')\b',
    );
    final RegExp trailingKey = RegExp(r'([A-Za-z0-9_]+)$');

    final List<String> offenders = <String>[];
    for (final FileSystemEntity entity
        in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      // The generated localizations are the definitions, not usages.
      if (entity.path.contains('l10n${Platform.pathSeparator}')) continue;

      final List<String> lines = entity.readAsLinesSync();
      for (var index = 0; index < lines.length; index++) {
        final String line = lines[index];
        if (line.trimLeft().startsWith('//')) continue;
        for (final RegExpMatch match in usage.allMatches(line)) {
          final String after = line.substring(match.end).trimLeft();
          if (after.startsWith('(')) continue; // called, as it must be
          final String key = trailingKey.firstMatch(match.group(0)!)!.group(1)!;
          offenders.add('${entity.path}:${index + 1}  $key');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'These use a placeholder message without calling it, so the '
          'closure prints instead of the text and the placeholder is lost:\n'
          '${offenders.join('\n')}',
    );
  });

  group('bookmark messages', () {
    test('carry the chapter they were added to', () {
      for (final Locale locale in AppLocalizations.supportedLocales) {
        final AppLocalizations l10n = lookupAppLocalizations(locale);
        expect(
          l10n.bookmarkAdded(2),
          contains('2'),
          reason: '${locale.languageCode}: the chapter never reaches the '
              'message (a placeholder written as "(chapter)" renders as-is)',
        );
      }
    });

    test('are written in the reader\'s language', () {
      // Han characters are legitimate in Japanese (第2章) and nowhere else: the
      // other values used to start with the Chinese they were translated from.
      final RegExp han = RegExp(r'[\u3400-\u4dbf\u4e00-\u9fff]');
      for (final Locale locale in AppLocalizations.supportedLocales) {
        if (locale.languageCode == 'ja') continue;
        final AppLocalizations l10n = lookupAppLocalizations(locale);
        for (final String message in <String>[
          l10n.bookmarkAdded(2),
          l10n.bookmarkRemoved,
        ]) {
          expect(
            han.hasMatch(message),
            isFalse,
            reason: '${locale.languageCode}: "$message" carries Chinese text '
                'that is not part of this language',
          );
        }
      }
    });
  });
}
