import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the reader's bottom chapter bar.
///
/// **The bug it prevents from returning:** the bar held three differently
/// styled things in a `spaceBetween` row — a grey-filled "Précédent" (which read
/// as disabled next to its sibling), a solid-ink "Suivant" (which read as the
/// primary action) and a third, fainter pill for the chapter picker. Two
/// high-contrast pills inside another rounded surface gave a "capsule inside a
/// capsule" look, the outer controls hugged the bar's edges, and the bar had no
/// vertical breathing room from the home indicator or the text above it.
void main() {
  late String source;
  late String bar;

  setUpAll(() {
    // Normalized so the bounded-block anchors below work on both CRLF (Windows)
    // and LF (CI/Linux) checkouts.
    final String normalized = File(
      'lib/features/reading/presentation/screens/book_reader_screen.dart',
    ).readAsStringSync().replaceAll('\r\n', '\n');
    source = normalized;

    final int start = source.indexOf('// Bottom Chapter Navigation Bar.');
    expect(start, greaterThan(-1), reason: 'Bottom chapter bar not found');
    final int end = source.indexOf('],\n      ),\n    );\n  }\n}', start);
    expect(end, greaterThan(start), reason: 'Could not bound the bar block');
    bar = source.substring(start, end);
  });

  test('both chapter legs come from one shared builder', () {
    expect(RegExp(r'_buildChapterNavButton\(').allMatches(bar).length, 2,
        reason: 'A single builder is what keeps the pair visually identical');
    expect(bar, contains('iconLeading: true'));
    expect(bar, contains('iconLeading: false'));
    expect(source, contains('disabledForegroundColor'),
        reason: 'Only the disabled leg may look lighter than its sibling');
    expect(source, contains('minimumSize: const Size(0, 48)'),
        reason: 'Both legs keep a full-height touch target');
  });

  test('no filled pill survives inside the bar', () {
    // The old asymmetry: black12 "Précédent" beside a solid #1A1A1B "Suivant".
    expect(bar, isNot(contains('ElevatedButton')));
    expect(bar, isNot(contains('backgroundColor:')),
        reason: 'A filled pill inside the bar re-creates the nesting problem');
    expect(bar, isNot(contains('spaceBetween')),
        reason: 'Equal Expanded zones keep the outer controls off the edges');
    expect(bar, contains('Expanded('));
  });

  test('the bar reads as one segmented control', () {
    expect(RegExp(r'_buildChapterNavDivider\(').allMatches(bar).length, 2,
        reason: 'Hairlines separate the three zones');
    expect(RegExp(r'_buildChapterPicker\(').allMatches(bar).length, 1);
    expect(bar, contains('BorderRadius.circular(18)'),
        reason: 'One rounded surface, not three nested capsules');
  });

  test('the picker is the accent anchor', () {
    expect(source, contains("Colors.amber.shade300 : const Color(0xFF8B0000)"),
        reason: 'The middle zone wears the canonical accent');
    expect(source, contains('chapterXOfY('));
    expect(source, contains('maxLines: 1'),
        reason: 'The longest locale ellipsizes instead of overflowing');
  });

  test('the bar keeps breathing room from the edges and the text', () {
    expect(bar, contains('fromLTRB(16, 12, 16, 10)'),
        reason: 'Gutter above the bar and margin below it');
    expect(bar, contains('minimum: const EdgeInsets.only(bottom: 8)'),
        reason: 'Clearance from the home indicator on every device');
    expect(bar, contains('horizontal: 6, vertical: 6'),
        reason: 'Inner inset so the zones never touch the capsule edge');
    expect(source, contains('fromLTRB(20, 0, 20, 32)'),
        reason: 'The scroll content keeps a gap above the bar');
  });
}
