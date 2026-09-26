/// Content-addressed keys for cached AI responses.
///
/// Extracted from `GeminiService` so the key rule can be **unit-tested as a pure
/// function** - the same reason `functions/dictionary-expansion.js` factors
/// `cacheIdentity` out of its handler. A key that cannot be tested is a key that
/// quietly serves the wrong answer, and this file exists because that already
/// happened:
///
///   * `generateDetailedSummary(title, fullText, targetLanguage)` cached under
///     `'detailed_summary_$title'` - so a **French and an English summary
///     collided**, and whichever was written first won for every later reader.
///   * `generateStory` cached under `'story_$deckId'` while the story is built
///     from that deck's *vocabulary*, so editing a deck kept serving the old
///     story for ever.
///   * None of the keys carried a version, so improving a prompt never reached
///     anyone who already had an answer cached.
///
/// The rule that prevents all three: **a key is built from every input that
/// changes the answer.** If two calls can share a key, they must be able to
/// share an answer.
library;

import 'dart:convert';

import 'package:crypto/crypto.dart';

/// The box the responses live in. It is opened with a cipher in `main.dart`, so
/// values are encrypted at rest - never write these keys anywhere else.
const String aiCacheBoxName = 'ai_cache';

/// Bump this to invalidate **every** cached AI response at once.
///
/// Cache keys are content-addressed, so they survive prompt edits by design -
/// which is exactly why a deliberate invalidation switch has to exist. Raise it
/// when a prompt changes so much that old answers would be wrong rather than
/// merely stale.
const int aiCacheVersion = 1;

/// Build the cache key for [operation] from every input that changes the answer.
///
/// [inputs] must include the target language whenever the answer is localized,
/// plus every piece of content and every level the prompt depends on. Pass
/// `null` for an input that is genuinely absent; ordering matters, so pass them
/// in a fixed order.
///
/// The digest keeps keys bounded (a 3 KB article is a 16-character key) and
/// makes them safe for any input; the readable prefix keeps them debuggable in a
/// box dump.
String aiCacheKey(String operation, List<Object?> inputs) {
  final String joined =
      inputs.map((Object? input) => input?.toString() ?? '').join('\u0001');
  final String digest =
      sha256.convert(utf8.encode(joined)).toString().substring(0, 16);
  return '$operation|v$aiCacheVersion|$digest';
}
