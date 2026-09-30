/// Every study screen teaches the swipe gesture the same way.
///
/// **The bug this guards.** `SwipeToGradeHint` exists — and documents itself — as
/// the replacement for a single hardcoded string of emoji arrows: *"the emoji
/// rendered as empty tofu boxes wherever the emoji font was missing, the names
/// could not be translated independently, and one unbreakable `Text` could not
/// wrap on a 320px screen."* It was only ever adopted by `reading_mode`, so
/// recall, listening, speaking **and** the review screen each kept their own copy
/// of the emoji legend — which on an iPad rendered as four grey tofu boxes.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Removes `//` comments, so *documenting* the retired idiom is not mistaken for
/// using it. (The same helper `reading_mode_book_parity_test` uses.)
String _withoutLineComments(String source) =>
    source.split('\n').map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    }).join('\n');

/// Every host that shows a study card and grades it by swiping.
const List<String> _hosts = <String>[
  'lib/features/flashcards/presentation/widgets/modes/reading_mode.dart',
  'lib/features/flashcards/presentation/widgets/modes/recall_mode.dart',
  'lib/features/flashcards/presentation/widgets/modes/listening_mode.dart',
  'lib/features/flashcards/presentation/widgets/modes/speaking_mode.dart',
  'lib/features/flashcards/presentation/screens/review_screen.dart',
];

void main() {
  test('every study screen uses the shared swipe legend', () {
    for (final String path in _hosts) {
      expect(
        File(path).readAsStringSync(),
        contains('SwipeToGradeHint'),
        reason: '$path must use SwipeToGradeHint, not a legend of its own',
      );
    }
  });

  test('no study screen still renders the emoji-arrow legend', () {
    // U+2B05/27A1/2B06/2B07 are the four arrows. They are tofu wherever the
    // emoji font is missing, and the string they sat in cannot wrap.
    final RegExp emojiArrows = RegExp(r'[\u2B05\u27A1\u2B06\u2B07]');
    for (final String path in _hosts) {
      expect(
        emojiArrows.hasMatch(
            _withoutLineComments(File(path).readAsStringSync())),
        isFalse,
        reason: '$path still renders the emoji-arrow legend',
      );
    }
  });

  test('every study screen pads the legend with the one shared strip', () {
    // The strip is subtracted from the card above it, so a per-screen padding
    // made the same card two different sizes: the four modes padded 32 beneath
    // the legend, the review screen 16.
    for (final String path in _hosts) {
      final String code = _withoutLineComments(File(path).readAsStringSync());
      expect(
        code,
        contains('SwipeToGradeHint.stripPadding'),
        reason: '$path must use SwipeToGradeHint.stripPadding, not a strip '
            'value of its own',
      );
      expect(
        code,
        isNot(matches(RegExp(
            r'padding:\s*(?:const\s+)?EdgeInsets\.fromLTRB\(16,\s*0,\s*16,'))),
        reason: '$path still hardcodes the legend strip',
      );
    }
  });

  test('the retired single-string legend key is read nowhere', () {
    // `againGoodEasyHard` is the entire `'⬅️ Again    ➡️ Good …'` string in all
    // 13 locales. It stays in the generated localizations; nothing may read it.
    final List<String> offenders = <String>[];
    for (final FileSystemEntity entity
        in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final String path = entity.path.replaceAll(r'\', '/');
      if (path.contains('/l10n/')) continue;
      if (_withoutLineComments(entity.readAsStringSync())
          .contains('againGoodEasyHard')) {
        offenders.add(path);
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'These still read the retired emoji legend: $offenders',
    );
  });
}
