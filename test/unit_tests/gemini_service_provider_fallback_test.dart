import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('character context cache keys are scoped by output language', () {
    final englishKey = GeminiService.contextCacheKey(
      targetLanguage: 'English',
      hanzi: '人',
      hskLevel: 1,
    );
    final frenchKey = GeminiService.contextCacheKey(
      targetLanguage: 'French',
      hanzi: '人',
      hskLevel: 1,
    );

    expect(englishKey, 'context_v2:english:人:1');
    expect(frenchKey, 'context_v2:french:人:1');
    expect(englishKey, isNot(frenchKey));
    expect(englishKey, isNot('人_1'));
  });

  test('uses Gemini directly when the OpenRouter key is missing', () async {
    late http.Request capturedRequest;
    final service = GeminiService(
      pool: _FakeApiKeyPool(googleKey: 'google-test-key'),
      analytics: AnalyticsService(),
      httpClient: MockClient((request) async {
        capturedRequest = request;
        return http.Response(
          jsonEncode({
            'candidates': [
              {
                'content': {
                  'parts': [
                    {'text': '{"cards": []}'}
                  ]
                }
              }
            ]
          }),
          200,
        );
      }),
    );

    final result = await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: const [
        {'role': 'user', 'content': 'Generate cards'}
      ],
      jsonMode: true,
    );

    expect(capturedRequest.url.host, 'generativelanguage.googleapis.com');
    expect(capturedRequest.url.queryParameters['key'], 'google-test-key');
    expect(capturedRequest.url.path,
        '/v1beta/models/gemini-3.6-flash:generateContent');
    expect(
        jsonDecode(capturedRequest.body)['generationConfig']
            ['responseMimeType'],
        'application/json');
    expect(result, '{"cards": []}');
  });

  test('prefers OpenRouter when its key is configured', () async {
    late http.Request capturedRequest;
    final service = GeminiService(
      pool: _FakeApiKeyPool(
        openRouterKey: 'openrouter-test-key',
        googleKey: 'google-test-key',
      ),
      analytics: AnalyticsService(),
      httpClient: MockClient((request) async {
        capturedRequest = request;
        return http.Response(
          jsonEncode({
            'choices': [
              {
                'message': {'content': 'ok'}
              }
            ]
          }),
          200,
        );
      }),
    );

    expect(
      await service.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: const [
          {'role': 'user', 'content': 'Generate cards'}
        ],
      ),
      'ok',
    );
    expect(capturedRequest.url.host, 'openrouter.ai');
    expect(
        capturedRequest.headers['Authorization'], 'Bearer openrouter-test-key');
  });

  test('reports missing AI configuration without making a request', () async {
    var requestMade = false;
    final service = GeminiService(
      pool: _FakeApiKeyPool(),
      analytics: AnalyticsService(),
      httpClient: MockClient((request) async {
        requestMade = true;
        return http.Response('', 500);
      }),
    );

    await expectLater(
      service.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: const [
          {'role': 'user', 'content': 'Generate cards'}
        ],
      ),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          contains('OPENROUTER_API_KEY or GEMINI_API_KEY'),
        ),
      ),
    );
    expect(requestMade, isFalse);
  });

  test('streamOpenRouterText streams from Google Gemini SSE when OpenRouter key is missing', () async {
    late http.Request capturedRequest;
    final service = GeminiService(
      pool: _FakeApiKeyPool(googleKey: 'google-test-key'),
      analytics: AnalyticsService(),
      httpClient: MockClient((request) async {
        capturedRequest = request;
        const ssePayload = 'data: {"candidates":[{"content":{"parts":[{"text":"Hello "}]}}]}\n\n'
            'data: {"candidates":[{"content":{"parts":[{"text":"world!"}]}}]}\n\n';
        return http.Response(ssePayload, 200, headers: {'content-type': 'text/event-stream'});
      }),
    );

    final chunks = await service.streamOpenRouterText('Hello').toList();
    expect(chunks, ['Hello ', 'world!']);
    expect(capturedRequest.url.host, 'generativelanguage.googleapis.com');
    expect(capturedRequest.url.path, '/v1beta/models/gemini-3.6-flash:streamGenerateContent');
    expect(capturedRequest.url.queryParameters['alt'], 'sse');
    expect(capturedRequest.url.queryParameters['key'], 'google-test-key');
  });

  test('streamOpenRouterText streams from OpenRouter when key is configured', () async {
    late http.Request capturedRequest;
    final service = GeminiService(
      pool: _FakeApiKeyPool(
        openRouterKey: 'openrouter-test-key',
        googleKey: 'google-test-key',
      ),
      analytics: AnalyticsService(),
      httpClient: MockClient((request) async {
        capturedRequest = request;
        const ssePayload = 'data: {"choices":[{"delta":{"content":"Hi"漫}}]}\n\n'
            'data: {"choices":[{"delta":{"content":" there"漫}}]}\n\n'
            'data: [DONE]\n\n';
        // replace character
        final cleanPayload = ssePayload.replaceAll('漫', '');
        return http.Response(cleanPayload, 200, headers: {'content-type': 'text/event-stream'});
      }),
    );

    final chunks = await service.streamOpenRouterText('Hi').toList();
    expect(chunks, ['Hi', ' there']);
    expect(capturedRequest.url.host, 'openrouter.ai');
    expect(capturedRequest.headers['Authorization'], 'Bearer openrouter-test-key');
  });
}

class _FakeApiKeyPool extends ApiKeyPool {
  _FakeApiKeyPool({
    this.openRouterKey = 'MISSING_KEY',
    this.googleKey = 'MISSING_KEY',
  });

  final String openRouterKey;

  @override
  final String googleKey;

  @override
  String get nextKey => openRouterKey;
}
