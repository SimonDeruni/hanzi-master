import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:http/testing.dart';

/// Guards the length-preservation contract of article simplification.
///
/// Bug: the prompt only said "do not omit major information" and the retry
/// threshold was 35%, so a 186-character article came back as ~155 characters
/// (83%) — the model silently dropped clauses and examples while keeping the
/// sentence count. Anything under 90% now retries, then fails loudly.
void main() {
  /// A service whose HTTP calls return canned responses in order.
  /// [onCall] receives the 1-based call index.
  GeminiService serviceReturning(String Function(int call) bodyForCall) {
    var call = 0;
    final client = MockClient((request) async {
      call++;
      // Encode explicitly as UTF-8: http.Response defaults to Latin-1, which
      // cannot represent the Chinese characters in the mock story.
      return http.Response.bytes(
        utf8.encode(bodyForCall(call)),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    return GeminiService(
      // No real network happens because httpClient is injected, so the pool's
      // key value is irrelevant here.
      pool: ApiKeyPool(),
      analytics: AnalyticsService(),
      httpClient: client,
    );
  }

  /// An OpenRouter-shaped response wrapping a story with [sentenceCount]
  /// sentences of [charsPerSentence] Chinese characters each.
  String storyBody(int sentenceCount, int charsPerSentence) {
    final sentences = List.generate(sentenceCount, (i) {
      final chinese = '测' * charsPerSentence;
      return {
        'chinese': chinese,
        'english': 'Sentence $i',
        'words': [
          {'hanzi': chinese, 'pinyin': 'ce4', 'meaning': 'test'}
        ],
      };
    });
    final payload = jsonEncode({'sentences': sentences});
    return jsonEncode({
      'choices': [
        {
          'message': {'content': payload}
        }
      ]
    });
  }

  // 160 Chinese characters, comfortably above the 100-char guard.
  final source = '这是一个测试文章。' * 20;

  test('a full-length result is accepted on the first call', () async {
    var calls = 0;
    final service = serviceReturning((call) {
      calls = call;
      return storyBody(5, 32); // 160 chars = 100% of source
    });

    final story = await service.simplifyTextToHsk(source, 3);

    expect(calls, 1, reason: 'A faithful rewrite must not trigger a retry');
    expect(story.sentences, isNotEmpty);
  });

  test('a truncated result triggers exactly one corrective retry', () async {
    var calls = 0;
    final service = serviceReturning((call) {
      calls = call;
      // First: badly truncated. Second: full length.
      return call == 1 ? storyBody(2, 5) : storyBody(5, 32);
    });

    final story = await service.simplifyTextToHsk(source, 3);

    expect(calls, 2, reason: 'A short result must be retried once');
    expect(story.sentences, isNotEmpty);
  });

  test('a still-truncated result after retry fails rather than truncating',
      () async {
    var calls = 0;
    // Always badly truncated — the old code accepted this silently.
    final service = serviceReturning((call) {
      calls = call;
      return storyBody(2, 5);
    });

    await expectLater(
      service.simplifyTextToHsk(source, 3),
      throwsA(isA<FormatException>()),
    );
    expect(calls, 2, reason: 'It retries once, then gives up loudly');
  });
}
