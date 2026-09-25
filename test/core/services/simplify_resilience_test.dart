import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Guards the failure modes that made "Simplify article" in the in-app browser
/// answer with *"Simplify failed: Simplification returned an empty article."*
///
/// Three defects combined:
/// 1. The browser hands `simplifyTextToHsk` whatever `innerText` it found, so an
///    English page was sent to a "rewrite this Chinese article" prompt - and the
///    prompt then asked for "0 to 0 Chinese characters".
/// 2. Any provider answer without a `sentences` array of `chinese`-keyed objects
///    was discarded whole, even when it held complete sentences that the token
///    budget had merely cut off.
/// 3. One unlucky chunk failed the entire article, and the fatal length ratio
///    (90%) rejected faithful-but-shorter rewrites after a single retry.
class _FakeApiKeyPool extends Fake implements ApiKeyPool {
  @override
  String get nextKey => 'test-openrouter-key';

  @override
  String get googleKey => 'MISSING_KEY';
}

void main() {
  GeminiService serviceReturning(String Function(http.Request request) content) {
    final client = MockClient((request) async {
      // Encode as UTF-8: http.Response defaults to Latin-1 and cannot represent
      // the Chinese characters in these payloads.
      return http.Response.bytes(
        utf8.encode(jsonEncode({
          'choices': [
            {
              'message': {'content': content(request)}
            }
          ]
        })),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    return GeminiService(
      pool: _FakeApiKeyPool(),
      analytics: AnalyticsService(),
      httpClient: client,
    );
  }

  /// An OpenRouter-shaped story with [sentenceCount] sentences of [chars] each.
  String story(int sentenceCount, int chars) {
    return jsonEncode({
      'sentences': [
        for (var i = 0; i < sentenceCount; i++)
          {
            'chinese': '测' * chars,
            'english': 'Sentence $i',
            'words': [
              {'hanzi': '测', 'pinyin': 'ce4', 'meaning': 'measure'}
            ],
          }
      ]
    });
  }

  // 78 Chinese characters: below the length-ratio guard, above the "no Chinese"
  // floor, so these cases exercise parsing rather than arithmetic.
  final chineseSource = '这是一篇关于中文学习的短文。' * 6;

  test('a page with no Chinese is refused before any request is made', () async {
    var calls = 0;
    final service = serviceReturning((request) {
      calls++;
      return story(1, 20);
    });

    await expectLater(
      service.simplifyTextToHsk(
        'The negotiations between Beijing and Washington have entered a new '
        'phase this autumn, according to officials briefed on the talks.',
        3,
      ),
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          contains('No Chinese article text'),
        ),
      ),
    );
    expect(calls, 0,
        reason: 'An English page has nothing to simplify: asking the model '
            'anyway is what produced an empty article');
  });

  test('an empty answer is retried, then reported instead of passed on',
      () async {
    var calls = 0;
    final service = serviceReturning((request) {
      calls++;
      return '{}';
    });

    await expectLater(
      service.simplifyTextToHsk(chineseSource, 2),
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          contains('empty article'),
        ),
      ),
    );
    expect(calls, 2, reason: 'One attempt plus one retry, then give up loudly');
  });

  test('a response cut off mid-JSON still yields its complete sentences',
      () async {
    const truncated = '{"sentences":['
        '{"chinese":"北京和美国政府在谈话。","english":"A",'
        '"words":[{"hanzi":"北京"}]},'
        '{"chinese":"台湾对中国很重要。","english":"B","words":[{"hanzi":"台';

    final service = serviceReturning((request) => truncated);
    final result = await service.simplifyTextToHsk(chineseSource, 2);

    expect(result.sentences.length, 2);
    expect(result.sentences.first.chinese, '北京和美国政府在谈话。');
    expect(result.sentences.last.chinese, '台湾对中国很重要。');
    expect(
      result.sentences.first.words.map((word) => word.hanzi).join(),
      '北京和美国政府在谈话。',
      reason: 'The reader renders the prose from the word array, so a repaired '
          'sentence must still carry its text as words',
    );
  });

  test('a renamed Chinese field still reads as the sentence text', () async {
    final payload = jsonEncode({
      'sentences': [
        {
          'text': '学生每天学习汉字。',
          'translation': 'Students study characters every day.',
        }
      ]
    });

    final service = serviceReturning((request) => payload);
    final result = await service.simplifyTextToHsk(chineseSource, 2);

    expect(result.sentences.single.chinese, '学生每天学习汉字。');
  });

  test('a nested article object is unwrapped', () async {
    final payload = jsonEncode({
      'article': {
        'sentences': [
          {
            'chinese': '学生每天学习汉字。',
            'english': 'Students study characters every day.',
            'words': <Map<String, dynamic>>[],
          }
        ]
      }
    });

    final service = serviceReturning((request) => payload);
    final result = await service.simplifyTextToHsk(chineseSource, 2);

    expect(result.sentences.single.chinese, '学生每天学习汉字。');
  });

  test('one lost chunk does not cost the reader the whole article', () async {
    // Four ~1000-character paragraphs with a marker each, so the section
    // splitter cuts several chunks and the markers land in known ones.
    final paragraphs = [
      for (var index = 1; index <= 4; index++) '${'汉字学习' * 250}[[X$index]]',
    ];

    var delivered = 0;
    var dropped = 0;
    final service = serviceReturning((request) {
      // Paragraphs 2 and 3 always come back empty, on both attempts.
      if (request.body.contains('[[X2]]') ||
          request.body.contains('[[X3]]')) {
        dropped++;
        return '{}';
      }
      delivered++;
      return story(6, 200);
    });

    final result = await service.simplifyTextToHsk(paragraphs.join('\n\n'), 3);

    expect(dropped, greaterThan(0),
        reason: 'The lost-section path must actually be exercised');
    expect(delivered, greaterThan(0));
    expect(result.sentences.length, delivered * 6,
        reason: 'Every surviving section must still reach the reader');
  });

  test('the prompt never asks for a rewrite shorter than the source', () async {
    String? capturedPrompt;
    final service = serviceReturning((request) {
      capturedPrompt =
          (jsonDecode(request.body)['messages'] as List).first['content']
              as String;
      return story(6, 200);
    });

    await service.simplifyTextToHsk(chineseSource, 2);

    expect(capturedPrompt, contains('at least as long as the source'));
    expect(capturedPrompt, isNot(contains('LONGER, not shorter')),
        reason: 'Asking for twice the source length blew the completion '
            'budget and the 90-second timeout');
  });
}
