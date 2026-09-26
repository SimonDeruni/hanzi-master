import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/speech_cache_service.dart';

/// Guards the one rule that keeps cached speech safe: **audio and its timings
/// travel together, or the cache is not used at all.**
///
/// Playing cached audio without timings would silently drop the word highlighting
/// a reader is following - worse than missing the cache, because the feature
/// would then look broken rather than merely slower.
void main() {
  final List<Object?> goodBoundaries = <Object?>[
    <String, dynamic>{'OffsetMs': 0, 'DurationMs': 200, 'Word': '你好'},
  ];

  /// Builds a reply. [boundaries] is **not** defaulted: an explicit `null` must
  /// reach the parser as `null`, or the "no timings" case would pass for the
  /// wrong reason.
  Map<String, dynamic> hit({Object? audio, Object? boundaries}) =>
      <String, dynamic>{
        'hit': true,
        'audioBase64':
            audio ?? base64Encode(Uint8List.fromList(<int>[1, 2, 3, 4])),
        'boundaries': boundaries,
      };

  test('reads a recording that has both audio and timings', () {
    final recording =
        recordingFromCacheResponse(hit(boundaries: goodBoundaries));
    expect(recording, isNotNull);
    expect(recording!.audio, isNotEmpty);
    expect(recording.boundaries.single['Word'], '你好');
  });

  test('refuses a recording with no timings, so highlighting cannot vanish', () {
    expect(recordingFromCacheResponse(hit(boundaries: <Object?>[])), isNull);
    expect(recordingFromCacheResponse(hit(boundaries: null)), isNull);
  });

  test('refuses a miss', () {
    expect(recordingFromCacheResponse(null), isNull);
    expect(recordingFromCacheResponse(<String, dynamic>{}), isNull);
    expect(
      recordingFromCacheResponse(<String, dynamic>{'hit': false}),
      isNull,
    );
  });

  test('refuses audio that is absent or does not decode', () {
    expect(recordingFromCacheResponse(hit(audio: '')), isNull);
    expect(recordingFromCacheResponse(hit(audio: '%%%')), isNull);
  });

  test('refuses a boundary list of the wrong shape', () {
    expect(recordingFromCacheResponse(hit(boundaries: 'not a list')), isNull);
    expect(
      recordingFromCacheResponse(hit(boundaries: <Object?>['nope'])),
      isNull,
    );
  });
}
