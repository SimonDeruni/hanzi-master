import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Guards the size of a simplification reply — the thing that decided how long
/// a learner waited for a simplified article.
///
/// Reported: the browser's AI overlay sat on "AI is thinking..." for minutes.
/// The cause was the reply, not the article: every sentence was asked to carry a
/// JSON object per word (hanzi, pinyin and a translated gloss), measured in the
/// service at **~30x the source character count**. A 504-character section alone
/// finished at ~16k characters of JSON, which is minutes of generation for one
/// section.
///
/// The model is now asked for the rewritten sentence and its translation only.
/// Pinyin is generated on the phone (`PinyinHelper`, in the reader) and the word
/// list is derived from `chinese`, which also keeps every character tappable for
/// Quick Look.
class _ConfiguredKeyPool extends ApiKeyPool {
  @override
  String get nextKey => 'test-key';

  @override
  String get googleKey => 'test-key';
}

void main() {
  /// A service whose HTTP calls return [body], and which records the outgoing
  /// request so the prompt itself can be inspected.
  GeminiService serviceReturning(
    String body, {
    List<http.Request>? sent,
  }) {
    final client = MockClient((http.Request request) async {
      sent?.add(request);
      // UTF-8 explicitly: http.Response defaults to Latin-1, which cannot
      // represent the Chinese characters in these payloads.
      return http.Response.bytes(
        utf8.encode(body),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    return GeminiService(
      pool: _ConfiguredKeyPool(),
      analytics: AnalyticsService(),
      httpClient: client,
    );
  }

  /// Wraps [content] the way an OpenRouter completion returns it.
  String completion(String content) => jsonEncode({
        'choices': [
          {
            'message': {'content': content}
          }
        ]
      });

  // 84 Chinese characters: below the 100-character length guard, so these cases
  // exercise the payload shape rather than the length arithmetic.
  final String source = '这是一篇关于中文学习的短文。' * 6;
  const String sentence = '学生每天学习汉字。';

  test('the prompt no longer asks the model for a word list', () async {
    final List<http.Request> sent = <http.Request>[];
    final GeminiService service = serviceReturning(
      completion(jsonEncode({
        'sentences': [
          {'chinese': sentence, 'english': 'Students study characters.'}
        ]
      })),
      sent: sent,
    );

    await service.simplifyTextToHsk(source, 2);

    final String prompt =
        (jsonDecode(sent.single.body)['messages'] as List).first['content']
            as String;
    expect(
      prompt,
      isNot(contains('"words"')),
      reason: 'The per-word JSON object was ~30x the source and took minutes to '
          'generate; asking for it again would undo the fix',
    );
    expect(prompt, contains('"chinese"'));
    expect(prompt, contains('"english"'));
  });

  test('a sentence returned without a word list is still renderable prose',
      () async {
    final GeminiService service = serviceReturning(
      completion(jsonEncode({
        'sentences': [
          {'chinese': sentence, 'english': 'Students study characters.'}
        ]
      })),
    );

    final story = await service.simplifyTextToHsk(source, 2);

    final sentenceResult = story.sentences.single;
    expect(sentenceResult.words, isNotEmpty,
        reason: 'The reader draws the prose from the word list, so an empty one '
            'renders as a blank paragraph');
    expect(
      sentenceResult.words.map((word) => word.hanzi).join(),
      sentence,
      reason: 'The derived words must reconstruct the sentence exactly, '
          'punctuation included',
    );
  });

  test('a word list the model does supply is left alone', () async {
    final GeminiService service = serviceReturning(
      completion(jsonEncode({
        'sentences': [
          {
            'chinese': sentence,
            'english': 'Students study characters.',
            'words': [
              {'hanzi': '学生', 'pinyin': 'xué shēng', 'meaning': 'student'}
            ],
          }
        ]
      })),
    );

    final story = await service.simplifyTextToHsk(source, 2);

    expect(story.sentences.single.words.single.hanzi, '学生',
        reason: 'A real word must not be replaced by its characters: the other '
            'AI features and previously saved stories still return arrays');
  });
}
