import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' show ClientException;

/// Tells a **lost connection** apart from every other kind of failure.
///
/// The app leans on this to decide whether to say *"No internet connection —
/// please check your network"* instead of leaking a raw exception string, so
/// the classifier has to be right in **both** directions: a false positive
/// blames the user's wifi for a server-side bug, and a false negative shows
/// `ClientException: Failed host lookup…` to someone who just needs to turn
/// wifi back on.
///
/// ## Why types *and* message markers
///
/// Type checks are authoritative and come first:
///
/// * `http.ClientException` — `package:http` only throws this for
///   connection-level problems (HTTP 4xx/5xx arrive as ordinary responses, not
///   exceptions). Its `IOClient` rethrows a dead socket as
///   `_ClientSocketException extends ClientException implements SocketException`,
///   so this single check covers the radio, the DNS lookup and the socket.
/// * `TimeoutException` — the request never completed.
/// * `FirebaseException` — Firestore/Auth/Functions report a lost link as the
///   gRPC `unavailable` / `network-request-failed` codes.
///
/// Everything else falls back to markers in the message, because several
/// transports wrap or stringify the original error before it reaches us:
/// `youtube_explode_dart` lets the socket error surface through a chain of
/// rethrows, and `google_generative_ai`'s chat stream does
/// `controller.addError(e, s)` — the original object, but from *inside* an SDK
/// that we do not control. Markers are the only thing that survives that.
///
/// ## What is deliberately *not* offline
///
/// * **HTTP 5xx / `TransientFailureException`.** `youtube_explode_dart` uses
///   `TransientFailureException` for *"Channel page is broken"* and for
///   `statusCode >= 500` — the network is fine, YouTube is unwell. Advice to
///   check your wifi would be actively misleading, so it is left alone.
/// * **429 / quota.** Rate limiting means the request *arrived*.
/// * **`ClientException('Client is already closed.')`** — that one is *us*,
///   not the network.
///
/// Deliberately imports neither `dart:io` nor any transport package: this file
/// is reached from screens that are otherwise web-compatible, and `dart:io`
/// alone would make every one of those importers unbuildable for web. A raw
/// `SocketException` is still caught, by marker.
class NetworkFailure {
  NetworkFailure._();

  /// `FirebaseException.code` values that mean "the device is not online".
  ///
  /// `unavailable` is the gRPC code the Firebase SDKs surface for a dropped
  /// connection; `network-request-failed` is `firebase_auth`'s.
  static const Set<String> firebaseOfflineCodes = <String>{
    'unavailable',
    'network-request-failed',
    'deadline-exceeded',
  };

  /// `ClientException`s that are *not* the network's fault, so a connection
  /// verdict would be a lie.
  static const List<String> _benignClientExceptions = <String>[
    'client is already closed',
    'no host specified',
  ];

  /// Fragments that appear in a genuine connectivity failure, lowercased.
  ///
  /// `socketexception` and `failed host lookup` are doing most of the work:
  /// they are how `dart:io`'s `SocketException` and `http`'s wrapping of it
  /// both render themselves.
  static const List<String> _offlineMarkers = <String>[
    'socketexception',
    'failed host lookup',
    'no address associated with hostname',
    'network is unreachable',
    'networkrequestfailed',
    'network-request-failed',
    'connection refused',
    'connection closed',
    'connection reset',
    'connection terminated',
    'connection aborted',
    'connection failed',
    'software caused connection abort',
    'unable to resolve host',
    'could not resolve host',
    'no internet',
    'xmlhttprequest error',
  ];

  /// Fragments that mean the request ran out of time, lowercased.
  static const List<String> _timeoutMarkers = <String>[
    'timed out',
    'timeout',
    'deadline exceeded',
  ];

  /// Whether [error] is best explained to the user as a lost connection.
  ///
  /// Timeouts count as offline: the app already advises "check your
  /// connection" for them (see `azureGradingTimedOutCheckYourIntern`), and from
  /// the user's chair an unanswered request is indistinguishable from a radio
  /// that is off. Use [isTimeout] to tell the two apart when the wording
  /// matters.
  static bool isOffline(Object? error) {
    if (error == null) return false;

    if (error is TimeoutException) return true;
    if (_isFirebaseOffline(error)) return true;

    final String text = _text(error);

    if (error is ClientException) {
      return !_matchesAny(text, _benignClientExceptions);
    }

    return _matchesAny(text, _offlineMarkers) ||
        _matchesAny(text, _timeoutMarkers);
  }

  /// Whether the failure was specifically a request that never came back.
  static bool isTimeout(Object? error) {
    if (error == null) return false;
    if (error is TimeoutException) return true;
    return _matchesAny(_text(error), _timeoutMarkers);
  }

  static bool _isFirebaseOffline(Object error) =>
      error is FirebaseException && firebaseOfflineCodes.contains(error.code);

  /// `toString()` lowercased, so markers are compared once, in one place.
  static String _text(Object error) => error.toString().toLowerCase();

  static bool _matchesAny(String text, List<String> markers) =>
      markers.any(text.contains);
}
