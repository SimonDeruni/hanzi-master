import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/ai_cache.dart';

/// Guards the contract that makes a cache safe: **two calls may share a key only
/// if they may share an answer.**
///
/// Every case below corresponds to a way that contract was broken in the
/// `ai_cache` box before keys were centralised - a title-only key for a
/// localized summary, a deck-id-only key for vocabulary-derived story, and no
/// version anywhere, so a prompt improvement never reached anyone.
void main() {
  group('aiCacheKey', () {
    test('is deterministic for identical inputs', () {
      expect(
        aiCacheKey('define_word', <Object?>['学']),
        aiCacheKey('define_word', <Object?>['学']),
      );
    });

    test('separates operations that share an input', () {
      expect(
        aiCacheKey('define_word', <Object?>['学']),
        isNot(aiCacheKey('context', <Object?>['学'])),
      );
    });

    test('separates the target language - the collision this replaces', () {
      // `generateDetailedSummary` cached on the title alone while taking a
      // `targetLanguage`, so a French reader could receive the English summary
      // that happened to be written first.
      expect(
        aiCacheKey('detailed_summary', <Object?>['Café', 'en']),
        isNot(aiCacheKey('detailed_summary', <Object?>['Café', 'fr'])),
        reason: 'a localized answer must never share a key across languages',
      );
    });

    test('separates the content and the level', () {
      expect(
        aiCacheKey('simplify', <Object?>['文章', 3]),
        isNot(aiCacheKey('simplify', <Object?>['文章', 4])),
      );
      expect(
        aiCacheKey('simplify', <Object?>['文章', 3]),
        isNot(aiCacheKey('simplify', <Object?>['课文', 3])),
      );
    });

    test('separates vocabulary lists that differ in composition', () {
      expect(
        aiCacheKey('deck_story', <Object?>['d1', 'Deck', 'en', '我', '你']),
        isNot(aiCacheKey('deck_story', <Object?>['d1', 'Deck', 'en', '我'])),
      );
    });

    test('is order-sensitive, so a caller cannot shuffle inputs', () {
      expect(
        aiCacheKey('x', <Object?>['a', 'b']),
        isNot(aiCacheKey('x', <Object?>['b', 'a'])),
      );
    });

    test('cannot be fooled by moving the boundary between inputs', () {
      // Without a separator, ['ab','c'] and ['a','bc'] would join to the same
      // string and collide.
      expect(
        aiCacheKey('x', <Object?>['ab', 'c']),
        isNot(aiCacheKey('x', <Object?>['a', 'bc'])),
      );
    });

    test('stays short however large the content is', () {
      final String key =
          aiCacheKey('simplify', <Object?>['测' * 3000, 'HSK3', 'en']);
      expect(key.length, lessThan(48));
    });

    test('carries the version, so a bump invalidates every entry', () {
      expect(aiCacheKey('x', <Object?>['y']), contains('v$aiCacheVersion'));
    });

    test('normalises a null input to the empty string', () {
      // Documented behaviour rather than an accident: a caller that might pass
      // null must not also pass '' for the same input.
      expect(
        aiCacheKey('x', <Object?>[null]),
        aiCacheKey('x', <Object?>['']),
      );
    });
  });
}
