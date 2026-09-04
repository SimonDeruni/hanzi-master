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
      '42:fr:abc:gemini-2.5-flash:dictionary-expansion-v1',
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
}
