import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Guards *how much* of a long article is rewritten at once.
///
/// Reported: the browser's AI overlay sat on "AI is thinking..." for minutes on
/// a long page. Nothing was broken — `simplifyTextToHsk` rewrites an article in
/// **sequential batches**, so the wait is `batches x one-section latency`, and
/// with a window of three a twelve-section article waited through four rounds
/// back to back.
///
/// This test holds every mocked response open briefly and counts how many
/// requests are in flight together, because that peak is the number that decides
/// the wait. It is also the only thing that distinguishes "six sections at a
/// time" from "three": a request count alone cannot see the difference.
class _ConfiguredKeyPool extends ApiKeyPool {
  @override
  String get nextKey => 'test-key';

  @override
  String get googleKey => 'test-key';
}

void main() {
  /// How long a mocked response is held open, so overlapping requests overlap.
  const Duration responseHold = Duration(milliseconds: 30);

  /// Enough Chinese per section to clear the 90% length guard on the largest
  /// section (700 characters), so no response is retried and the request count
  /// equals the section count.
  const int sentencesPerSection = 5;
  final String chinesePerSection = '汉' * 200;

  int requests = 0;
  int inFlight = 0;
  int peakInFlight = 0;

  setUp(() {
    requests = 0;
    inFlight = 0;
    peakInFlight = 0;
  });

  GeminiService serviceTrackingOverlap() {
    final client = MockClient((http.Request request) async {
      requests++;
      inFlight++;
      peakInFlight = math.max(peakInFlight, inFlight);
      await Future<void>.delayed(responseHold);
      inFlight--;

      final payload = jsonEncode({
        'sentences': [
          for (var i = 0; i < sentencesPerSection; i++)
            {
              'chinese': chinesePerSection,
              'english': 'Section sentence $i',
              'words': [
                {'hanzi': '汉', 'pinyin': 'han4', 'meaning': 'Han'}
              ],
            }
        ]
      });
      return http.Response.bytes(
        utf8.encode(jsonEncode({
          'choices': [
            {
              'message': {'content': payload}
            }
          ]
        })),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    return GeminiService(
      // No real network happens: the injected client is a mock and the key is a
      // literal that exists only inside this test process.
      pool: _ConfiguredKeyPool(),
      analytics: AnalyticsService(),
      httpClient: client,
    );
  }

  test('a long article is rewritten more than one section at a time', () async {
    // ~8,000 Chinese characters of continuous prose, so the section splitter
    // produces well over one window and the batching loop must run repeatedly.
    final String source = List.filled(8, '汉字学习' * 250).join('\n\n');
    final GeminiService service = serviceTrackingOverlap();

    final story = await service.simplifyTextToHsk(source, 3);

    expect(requests, greaterThan(6),
        reason: 'The fixture must span more than one window to exercise it');
    expect(
      peakInFlight,
      6,
      reason: 'Six sections are rewritten at once. A narrower window makes a '
          'long article wait through extra sequential batches, which is what '
          'the reader saw as a stuck "AI is thinking" overlay',
    );
    expect(
      story.sentences.length,
      requests * sentencesPerSection,
      reason: 'Every section must still reach the reader, and no section may be '
          'retried at these lengths',
    );
  });
}
