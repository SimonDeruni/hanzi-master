import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regression for the "Extract to Deck → Add to Deck → dismiss" loop.
///
/// Bug: `DeckSelectionSheet` returned `void`, so dismissing the deck picker was
/// indistinguishable from saving. `_runAddAllUnknowns` then ended the flow and
/// the user's extracted words were silently lost instead of returning them to
/// the review step.
///
/// Verified against source because exercising the real sheets needs typed Hive
/// boxes (`Box<FlashcardModel>` / `Box<DeckModel>`) plus registered adapters.
void main() {
  late String pickerSource;
  late String browserSource;

  setUpAll(() {
    pickerSource = File(
      'lib/features/flashcards/presentation/widgets/deck_selection_sheet.dart',
    ).readAsStringSync();
    browserSource = File(
      'lib/features/media/presentation/screens/web_browser_screen.dart',
    ).readAsStringSync();
  });

  group('DeckSelectionSheet reports whether words were saved', () {
    test('show() is typed to return a bool result', () {
      expect(
        pickerSource,
        contains('static Future<bool?> show(BuildContext context,'),
        reason: 'The picker must report success vs. dismissal',
      );
      expect(pickerSource, contains('GlobalBlurredBottomSheet.show<bool>'));
    });

    test('a successful add pops with true; dismissal leaves it null', () {
      expect(pickerSource, contains('navigator.pop(true)'),
          reason: 'Saving must return true');
      expect(pickerSource, isNot(contains('navigator.pop();')),
          reason: 'A bare pop() would be indistinguishable from dismissal');
    });
  });

  group('extract-to-deck flow re-opens the review step on dismissal', () {
    late String flowSource;

    setUpAll(() {
      final start = browserSource.indexOf('Future<void> _runAddAllUnknowns()');
      expect(start, greaterThan(-1));
      flowSource = browserSource.substring(
        start,
        browserSource.indexOf('Future<void> _runAutoSimplify'),
      );
    });

    test('the review sheet and picker run in a loop', () {
      expect(flowSource, contains('while (remaining.isNotEmpty)'),
          reason: 'The flow must be able to return to the review step');
      expect(flowSource, contains('ExtractedWordsReviewSheet('),
          reason: 'The review sheet must be re-openable');
    });

    test('the deck picker result is awaited and branched on', () {
      expect(
          flowSource, contains('final added = await DeckSelectionSheet.show'),
          reason: 'The picker result must be awaited');
      expect(flowSource, contains('if (added == true)'),
          reason: 'Saving must terminate the flow');
    });

    test('dismissing the picker restores the previous selection', () {
      // On dismissal the words the user had chosen are put back into the review
      // sheet, so nothing is silently dropped.
      expect(flowSource, contains('remaining = newWords'),
          reason: 'The selection must be restored on dismissal');
      expect(flowSource, contains('please_select_a_deck_to_add'),
          reason: 'The user must be told why they are back on the review step');
    });

    test('the loop exits cleanly when the user cancels out', () {
      expect(flowSource, contains('if (selectedWords == null'),
          reason: 'Dismissing the review sheet must end the loop');
      expect(flowSource, contains('if (!mounted) return;'),
          reason: 'Widget context must be guarded across async gaps');
    });
  });
}
