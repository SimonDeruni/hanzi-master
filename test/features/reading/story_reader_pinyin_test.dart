/// The story reader's pinyin contract.
///
/// **The bug this guards.** `GeminiService._deriveWords` builds story words with
/// `pinyin: ''` and documents that *"the reader derives pinyin from the hanzi
/// itself (`PinyinHelper`)"*. `BookReaderScreen` does exactly that in
/// `_getRubyTokens`; `StoryReaderScreen` printed `word.pinyin` straight out, so
/// every derived story — which is every story that comes from a deck — rendered
/// a blank pinyin line in **every** pinyin mode.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/presentation/screens/story_reader_screen.dart';

void main() {
  test('a word with no pinyin derives tone-marked pinyin from its hanzi', () {
    // This is the deck-story case: character-level words, pinyin never supplied.
    expect(storyWordPinyin('文', ''), 'wén');
    expect(storyWordPinyin('好', null), 'hǎo');
  });

  test('a word that already carries pinyin keeps it', () {
    // The model's answer beats a per-character guess on a multi-character word.
    expect(storyWordPinyin('妈妈', 'māma'), 'māma');
    expect(storyWordPinyin('文化', 'wén huà'), 'wén huà');
  });

  test('a "pinyin" that merely echoes the gloss is rejected and re-derived', () {
    // A known model failure mode: the gloss comes back in the pinyin field.
    expect(
      storyWordPinyin('文', 'civilisation', echo: 'civilisation'),
      'wén',
    );
    // ...and an echo of a *different* word is left alone.
    expect(storyWordPinyin('文', 'wén', echo: 'civilisation'), 'wén');
  });

  test('punctuation, Latin text and empty input derive nothing', () {
    expect(storyWordPinyin('，', ''), '');
    expect(storyWordPinyin('。', ''), '');
    expect(storyWordPinyin('abc', ''), '');
    expect(storyWordPinyin('', ''), '');
  });
}
