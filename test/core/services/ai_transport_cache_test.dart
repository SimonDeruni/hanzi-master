import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/ai_cache.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Proves the thing the cache exists for: **an identical question is not sent
/// twice.** It counts real outgoing requests, because a latency improvement is
/// not evidence and a cache hit that still hits the network is not a cache.
///
/// Hive is opened for real here (a temp directory, no cipher), because the
/// production cache lives in a Hive box and a test that skipped that would prove
/// nothing about it.
class _ConfiguredKeyPool extends ApiKeyPool {
  @override
  String get nextKey => 'test-key';

  @override
  String get googleKey => 'test-key';
}

void main() {
  late Directory hiveDir;

  setUp(() async {
    hiveDir = Directory.systemTemp.createTempSync('ai_cache_test');
    Hive.init(hiveDir.path);
    await Hive.openBox<String>(aiCacheBoxName);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    if (hiveDir.existsSync()) hiveDir.deleteSync(recursive: true);
  });

  /// A service whose transport appends every request that actually leaves the
  /// device into [sent], and replies with a body that identifies the call.
  GeminiService serviceCounting(List<http.Request> sent) {
    final MockClient client = MockClient((http.Request request) async {
      sent.add(request);
      return http.Response.bytes(
        utf8.encode(jsonEncode(<String, dynamic>{
          'choices': <dynamic>[
            <String, dynamic>{
              'message': <String, dynamic>{'content': 'answer ${sent.length}'},
            },
          ],
        })),
        200,
        headers: <String, String>{'content-type': 'application/json; charset=utf-8'},
      );
    });
    return GeminiService(
      pool: _ConfiguredKeyPool(),
      analytics: AnalyticsService(),
      httpClient: client,
    );
  }

  const List<Map<String, dynamic>> _question = <Map<String, dynamic>>[
    <String, dynamic>{'role': 'user', 'content': 'Explain 学'},
  ];

  test('an identical request is served from the cache, not the network',
      () async {
    final List<http.Request> sent = <http.Request>[];
    final GeminiService service = serviceCounting(sent);

    final String first = await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: _question,
    );
    final String second = await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: _question,
    );

    expect(sent.length, 1,
        reason: 'the second identical call must not leave the device');
    expect(second, first);
  });

  test('a different question still reaches the model', () async {
    final List<http.Request> sent = <http.Request>[];
    final GeminiService service = serviceCounting(sent);

    await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: _question,
    );
    await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: const <Map<String, dynamic>>[
        <String, dynamic>{'role': 'user', 'content': 'Explain 好'},
      ],
    );

    expect(sent.length, 2);
  });

  test('a different model is a different question', () async {
    final List<http.Request> sent = <http.Request>[];
    final GeminiService service = serviceCounting(sent);

    await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: _question,
    );
    await service.makeOpenRouterCall(
      model: 'deepseek/deepseek-chat',
      messages: _question,
    );

    expect(sent.length, 2);
  });

  test('json mode is part of the question', () async {
    final List<http.Request> sent = <http.Request>[];
    final GeminiService service = serviceCounting(sent);

    await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: _question,
    );
    await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: _question,
      jsonMode: true,
    );

    expect(sent.length, 2, reason: 'a JSON answer is not a prose answer');
  });

  test('useCache: false asks again, as a deliberate regeneration must', () async {
    final List<http.Request> sent = <http.Request>[];
    final GeminiService service = serviceCounting(sent);

    await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: _question,
    );
    await service.makeOpenRouterCall(
      model: 'google/gemini-2.5-flash',
      messages: _question,
      useCache: false,
    );

    expect(sent.length, 2);
  });
}
