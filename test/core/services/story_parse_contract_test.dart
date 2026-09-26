import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/story_parse_contract.dart';

/// Guards the reading half of the precomputed story seed.
///
/// The contract that matters: a seed is used **only** when it was written by the
/// prompt version this build knows about, and anything unusable returns `null`
/// so the caller falls back to the model. A seed that was accepted wrongly would
/// show a stale or blank story, which is far worse than a wasted model call.
void main() {
  Map<String, dynamic> seed({
    int version = storyParsePromptVersion,
    Object? sentences,
  }) =>
      <String, dynamic>{
        'promptVersion': version,
        'sentences': sentences ??
            <Object?>[
              <String, dynamic>{
                'english': 'Once there was a cat.',
                'words': <Object?>[
                  <String, dynamic>{
                    'hanzi': '猫',
                    'pinyin': 'māo',
                    'english': 'cat',
                    'hskLevel': 1,
                  },
                ],
              },
            ],
      };

  test('reads a seed written by the current prompt version', () {
    final story = storyFromSeed(seed());
    expect(story, isNotNull);
    expect(story!.sentences, isNotEmpty);
  });

  test('refuses a seed from an older prompt, so the model is called instead', () {
    expect(storyFromSeed(seed(version: storyParsePromptVersion - 1)), isNull);
  });

  test('refuses a seed from a newer prompt', () {
    expect(storyFromSeed(seed(version: storyParsePromptVersion + 1)), isNull);
  });

  test('refuses a missing, empty or sentence-less seed', () {
    expect(storyFromSeed(null), isNull);
    expect(storyFromSeed(<String, dynamic>{}), isNull);
    expect(storyFromSeed(seed(sentences: <Object?>[])), isNull);
  });

  test('refuses a malformed seed rather than throwing', () {
    // A throw here would take down the screen that was merely unlucky enough to
    // meet a bad document.
    expect(storyFromSeed(seed(sentences: 'not a list')), isNull);
    expect(storyFromSeed(seed(sentences: <Object?>['not an object'])), isNull);
  });
}
