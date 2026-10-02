import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/network_failure.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() {
  group('isOffline — recognises a lost connection', () {
    test('a ClientException (what package:http throws for a dead socket)', () {
      expect(
        NetworkFailure.isOffline(
          http.ClientException('Connection refused',
              Uri.parse('https://example.com/x')),
        ),
        isTrue,
      );
    });

    test('the stringified SocketException that http wraps', () {
      // `IOClient` rethrows a dead socket as a ClientException that also
      // implements SocketException; this is its toString().
      expect(
        NetworkFailure.isOffline(Exception(
            'ClientException with SocketException: Failed host lookup: '
            "'img.youtube.com' (OS Error: No address associated with hostname, "
            'errno = 7), uri=https://img.youtube.com/vi/x/maxresdefault.jpg')),
        isTrue,
      );
    });

    test('a bare SocketException rendering', () {
      expect(
        NetworkFailure.isOffline(
            Exception('SocketException: Network is unreachable (OS Error)')),
        isTrue,
      );
    });

    test('a request that never came back', () {
      final error = TimeoutException('took too long');
      expect(NetworkFailure.isOffline(error), isTrue);
      expect(NetworkFailure.isTimeout(error), isTrue);
    });

    test('Firestore going away (gRPC unavailable)', () {
      expect(
        NetworkFailure.isOffline(
          FirebaseException(plugin: 'cloud_firestore', code: 'unavailable'),
        ),
        isTrue,
      );
    });

    test('firebase_auth losing the link', () {
      expect(
        NetworkFailure.isOffline(
          FirebaseException(
              plugin: 'firebase_auth', code: 'network-request-failed'),
        ),
        isTrue,
      );
    });
  });

  group('isOffline — refuses to blame the network wrongly', () {
    test('an HTTP 500-style server error', () {
      expect(
        NetworkFailure.isOffline(Exception('Gemini API Error 500: internal')),
        isFalse,
      );
    });

    test('rate limiting — the request arrived, we were just too eager', () {
      expect(
        NetworkFailure.isOffline(
            Exception('Quota exceeded, status 429 (RESOURCE_EXHAUSTED)')),
        isFalse,
      );
    });

    test('youtube_explode_dart TransientFailureException is a 5xx, not wifi', () {
      // The trap this classifier had to avoid: youtube_explode_dart throws
      // TransientFailureException for `statusCode >= 500` and for "Channel page
      // is broken", i.e. YouTube is unwell and the network is fine.
      expect(
        NetworkFailure.isOffline(
            TransientFailureException('Channel page is broken')),
        isFalse,
      );
    });

    test('a video that no longer exists', () {
      expect(
        NetworkFailure.isOffline(
            VideoUnavailableException.unavailable(VideoId('dQw4w9WgXcQ'))),
        isFalse,
      );
    });

    test('our own closed client, which only sounds like a network error', () {
      expect(
        NetworkFailure.isOffline(http.ClientException(
            'HTTP request failed. Client is already closed.')),
        isFalse,
      );
    });

    test('a malformed URL', () {
      expect(
        NetworkFailure.isOffline(
            http.ClientException('No host specified in URI')),
        isFalse,
      );
    });

    test('an empty model response', () {
      expect(
        NetworkFailure.isOffline(Exception('Empty response from Vision model')),
        isFalse,
      );
    });

    test('another Firebase code entirely', () {
      expect(
        NetworkFailure.isOffline(
          FirebaseException(plugin: 'firebase_auth', code: 'user-not-found'),
        ),
        isFalse,
      );
    });

    test('no error at all', () {
      expect(NetworkFailure.isOffline(null), isFalse);
      expect(NetworkFailure.isTimeout(null), isFalse);
    });
  });

  group('isTimeout splits timeouts out of the offline verdict', () {
    test('a timeout-shaped message is offline and flagged as a timeout', () {
      final error = Exception('Azure grading timed out');
      expect(NetworkFailure.isOffline(error), isTrue);
      expect(NetworkFailure.isTimeout(error), isTrue);
    });

    test('a refused connection is offline but is not a timeout', () {
      final error = http.ClientException('Connection refused');
      expect(NetworkFailure.isOffline(error), isTrue);
      expect(NetworkFailure.isTimeout(error), isFalse);
    });
  });
}
