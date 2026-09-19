import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class _FakeApiKeyPool extends Fake implements ApiKeyPool {
  @override
  final String nextKey;
  @override
  final String googleKey;

  _FakeApiKeyPool({
    this.nextKey = 'test-openrouter-key',
    this.googleKey = 'test-google-key',
  });
}

void main() {
  group('GeminiService.simplifyTextToHsk', () {
    test('succeeds when simplification is shorter than source text without throwing', () async {
      // Source text has ~120 Chinese characters
      const sourceText =
          '从北京与白宫的斡旋来看，台湾依然是北京口中不容触碰的“红线”，但操作手法确实变得更加交易化。'
          '据共同社报道，特朗普急于在11月中期选举前交出一份外交成绩单，因此极为重视这场峰会。'
          '中国正是抓住这一点，把事情变得更加容易协商。';

      // Mock AI response has ~50 Chinese characters (~40% of source), typical of HSK 2 rewriting
      final mockStoryJson = jsonEncode({
        'sentences': [
          {
            'chinese': '北京和美国政府在谈话。',
            'english': 'Beijing and the US government are talking.',
            'words': [
              {'hanzi': '北京', 'pinyin': 'Běijīng', 'meaning': 'Beijing'},
              {'hanzi': '和', 'pinyin': 'hé', 'meaning': 'and'},
              {'hanzi': '美国政府', 'pinyin': 'Měiguó zhèngfǔ', 'meaning': 'US government'},
              {'hanzi': '在', 'pinyin': 'zài', 'meaning': 'in the process of'},
              {'hanzi': '谈话', 'pinyin': 'tánhuà', 'meaning': 'talking'},
            ]
          },
          {
            'chinese': '台湾对中国很重要，但是现在双方的交流方式改变了。',
            'english': 'Taiwan is very important to China, but now communication has changed.',
            'words': [
              {'hanzi': '台湾', 'pinyin': 'Táiwān', 'meaning': 'Taiwan'},
              {'hanzi': '对', 'pinyin': 'duì', 'meaning': 'towards'},
              {'hanzi': '中国', 'pinyin': 'Zhōngguó', 'meaning': 'China'},
              {'hanzi': '很', 'pinyin': 'hěn', 'meaning': 'very'},
              {'hanzi': '重要', 'pinyin': 'zhòngyào', 'meaning': 'important'},
              {'hanzi': '但是', 'pinyin': 'dànshì', 'meaning': 'but'},
              {'hanzi': '改变', 'pinyin': 'gǎibiàn', 'meaning': 'changed'},
            ]
          }
        ]
      });

      final service = GeminiService(
        pool: _FakeApiKeyPool(),
        analytics: AnalyticsService(),
        httpClient: MockClient((request) async {
          final payload = jsonEncode({
            'choices': [
              {
                'message': {'content': '```json\n$mockStoryJson\n```'}
              }
            ]
          });
          return http.Response.bytes(
            utf8.encode(payload),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        }),
      );

      final result = await service.simplifyTextToHsk(sourceText, 2);

      expect(result.sentences.length, 2);
      expect(result.sentences[0].chinese, '北京和美国政府在谈话。');
      expect(result.sentences[1].chinese, contains('台湾对中国很重要'));
    });

    test('recovers safely from markdown preamble around json payload', () async {
      const sourceText = '这是一篇关于中文学习的短文。学生们每天都在努力学习汉字和语法。';

      final mockStoryJson = jsonEncode({
        'sentences': [
          {
            'chinese': '学生每天学习汉字。',
            'english': 'Students study characters every day.',
            'words': [
              {'hanzi': '学生', 'pinyin': 'xuéshēng', 'meaning': 'student'},
              {'hanzi': '每天', 'pinyin': 'měitiān', 'meaning': 'every day'},
              {'hanzi': '学习', 'pinyin': 'xuéxí', 'meaning': 'study'},
              {'hanzi': '汉字', 'pinyin': 'hànzì', 'meaning': 'Chinese characters'},
            ]
          }
        ]
      });

      final wrappedContent =
          'Here is the simplified article formatted in JSON:\n\n```json\n$mockStoryJson\n```\nHope this helps!';

      final service = GeminiService(
        pool: _FakeApiKeyPool(),
        analytics: AnalyticsService(),
        httpClient: MockClient((request) async {
          final payload = jsonEncode({
            'choices': [
              {
                'message': {'content': wrappedContent}
              }
            ]
          });
          return http.Response.bytes(
            utf8.encode(payload),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        }),
      );

      final result = await service.simplifyTextToHsk(sourceText, 1);
      expect(result.sentences.length, 1);
      expect(result.sentences[0].chinese, '学生每天学习汉字。');
    });

    test('failover from deepseek model targets gemini-3.6-flash on Google API', () async {
      late http.Request capturedRequest;
      final service = GeminiService(
        pool: _FakeApiKeyPool(nextKey: 'MISSING_KEY', googleKey: 'test-google-key'),
        analytics: AnalyticsService(),
        httpClient: MockClient((request) async {
          capturedRequest = request;
          return http.Response(
            jsonEncode({
              'candidates': [
                {
                  'content': {
                    'parts': [
                      {'text': jsonEncode({'sentences': []})}
                    ]
                  }
                }
              ]
            }),
            200,
          );
        }),
      );

      await service.makeOpenRouterCall(
        model: 'deepseek/deepseek-chat',
        messages: const [
          {'role': 'user', 'content': 'test'}
        ],
        jsonMode: true,
      );

      expect(capturedRequest.url.host, 'generativelanguage.googleapis.com');
      expect(capturedRequest.url.path, '/v1beta/models/gemini-3.6-flash:generateContent');
    });
  });
}
