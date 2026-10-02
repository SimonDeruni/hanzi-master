import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/data/services/dictionary_expansion_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/dictionary_expansion.dart';

void main() {
  test('request cache identity includes source and language', () {
    const first = DictionaryExpansionRequest(
      wordId: 42,
      languageCode: 'fr',
      sourceDefinitionHash: 'abc',
    );
    const same = DictionaryExpansionRequest(
      wordId: 42,
      languageCode: 'fr',
      sourceDefinitionHash: 'abc',
    );
    const changedSource = DictionaryExpansionRequest(
      wordId: 42,
      languageCode: 'fr',
      sourceDefinitionHash: 'def',
    );
    expect(first, same);
    expect(
      first.cacheKey,
      '42:fr:abc:gemini-2.5-flash:dictionary-expansion-v2-concise',
    );
    expect(first, isNot(changedSource));
  });

  test('expansion rejects empty callable output', () {
    expect(
      () => DictionaryExpansion.fromJson(const {'text': ''}),
      throwsFormatException,
    );
  });

  test('expansion preserves provenance', () {
    final expansion = DictionaryExpansion.fromJson(const {
      'text': 'Une explication.',
      'languageCode': 'fr',
      'modelVersion': 'model-v1',
      'promptVersion': 'prompt-v1',
      'sourceDefinitionHash': 'abc',
      'cached': true,
    });
    expect(expansion.text, 'Une explication.');
    expect(expansion.fromSharedCache, isTrue);
    expect(expansion.sourceDefinitionHash, 'abc');
  });

  test('maps callable failures to actionable expansion failures', () {
    expect(
      DictionaryExpansionException.fromFirebaseCode('unauthenticated').failure,
      DictionaryExpansionFailure.signIn,
    );
    expect(
      DictionaryExpansionException.fromFirebaseCode('resource-exhausted')
          .failure,
      DictionaryExpansionFailure.quota,
    );
    expect(
      DictionaryExpansionException.fromFirebaseCode('not-found').failure,
      DictionaryExpansionFailure.staleSource,
    );
    expect(
      DictionaryExpansionException.fromFirebaseCode('unavailable').failure,
      DictionaryExpansionFailure.unavailable,
    );
  });

  test('the dictionary card offers expansion; the Quick Look only shows it',
      () {
    final dictionarySource = File(
      'lib/features/flashcards/presentation/screens/dictionary_screen.dart',
    ).readAsStringSync();
    final quickLookSource =
        File('lib/shared/widgets/quick_look_sheet.dart').readAsStringSync();
    final expansionPanelSource = File(
      'lib/features/flashcards/presentation/widgets/dictionary_expansion_panel.dart',
    ).readAsStringSync();

    // The library's "detail available" chip still requests the expansion as it
    // opens the Quick Look...
    expect(dictionarySource, contains('autoExpand: true'));
    expect(quickLookSource, contains('bool autoExpand = false'));
    expect(
      expansionPanelSource,
      contains('_requested = cached != null || widget.autoExpand'),
    );
    // ...but the Quick Look card itself offers no AI "expand" prompt: the
    // compact presentation shows a brief entry as-is.
    expect(
      expansionPanelSource,
      contains('widget.presentation == DictionaryExpansionPresentation.compact'),
      reason: 'The floating/bottom Quick Look card must not show an expand '
          'button',
    );
  });
}
