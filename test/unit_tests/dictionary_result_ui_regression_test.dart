import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dictionary result rows keep visible content and tap target in sync',
      () {
    final source = File(
      'lib/features/flashcards/presentation/screens/dictionary_screen.dart',
    ).readAsStringSync();

    expect(source, contains('key: ValueKey(card.id)'));
    expect(source, contains('void didUpdateWidget'));
    expect(source, contains('widget.card.hanzi == requestedHanzi'));
  });

  test('Quick Look bottom sheet is compact and remains scrollable', () {
    final source = File(
      'lib/shared/widgets/quick_look_sheet.dart',
    ).readAsStringSync();

    expect(source, contains('MediaQuery.sizeOf(sheetContext).height * 0.72'));
    expect(source, contains('child: SingleChildScrollView('));
  });

  test('Quick Look refreshes a selected sense by dictionary word ID', () {
    final source = File(
      'lib/shared/widgets/quick_look_sheet.dart',
    ).readAsStringSync();

    expect(source, contains('initialCard?.dictionaryWordId'));
    expect(source, contains('dictionaryWordProvider(wordId)'));
  });

  test('character detail preserves routed localized dictionary fields', () {
    final source = File(
      'lib/features/flashcards/presentation/screens/character_detail_screen.dart',
    ).readAsStringSync();

    expect(source, contains('var current = widget.card.copyWith('));
    expect(source, isNot(contains('return globalCard;')));
  });

  test('library merging prefers dictionary identity over shared Hanzi', () {
    final source = File(
      'lib/features/flashcards/presentation/screens/dictionary_screen.dart',
    ).readAsStringSync();

    expect(source, contains('libraryByWordId'));
    expect(source, contains('legacyLibraryByHanzi'));
  });
}
