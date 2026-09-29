import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final speechCacheServiceProvider =
    Provider<SpeechCacheService>((ref) => SpeechCacheService());

/// A recording read back from the shared speech cache.
///
/// The timings travel with the audio on purpose: they drive the word highlighting
/// that follows the spoken words, and timings from a different take would appear
/// to slide against the voice.
@immutable
class CachedRecording {
  const CachedRecording({required this.audio, required this.boundaries});

  final Uint8List audio;
  final List<Map<String, dynamic>> boundaries;
}

/// Read one recording out of a `getTtsAudioV2` reply, or `null` if it is unusable.
///
/// Pure, so it can be tested without Firebase - and deliberately strict:
/// **audio and timings together, or nothing.** Playing cached audio without its
/// timings would silently drop the highlighting a reader is following, which is
/// worse than missing the cache and streaming as usual.
///
/// @param data the callable's payload
CachedRecording? recordingFromCacheResponse(Map<String, dynamic>? data) {
  if (data == null || data['hit'] != true) return null;
  final Object? audioBase64 = data['audioBase64'];
  if (audioBase64 is! String || audioBase64.isEmpty) return null;

  final Object? rawBoundaries = data['boundaries'];
  if (rawBoundaries is! List || rawBoundaries.isEmpty) return null;
  final List<Map<String, dynamic>> boundaries = <Map<String, dynamic>>[];
  for (final Object? entry in rawBoundaries) {
    if (entry is! Map) return null;
    boundaries.add(Map<String, dynamic>.from(entry));
  }

  try {
    final Uint8List audio = base64Decode(audioBase64);
    if (audio.isEmpty) return null;
    return CachedRecording(audio: audio, boundaries: boundaries);
  } catch (_) {
    // A payload that does not decode is a miss, not an exception: the caller
    // then does what it always did.
    return null;
  }
}

/// Reads and fills the server-side speech cache.
///
/// One recording per (sentence, voice, rate) is shared by every user, so the
/// second listener of a sentence hears it instantly and costs nothing. See
/// `getTtsAudioV2` and `warmTtsAudioV2` in `functions/index.js`.
///
/// Every method here is *silent about failure*, by design: a cache that is
/// unreachable, undeployed or empty must be indistinguishable from a miss, so
/// that speech can never break because of it.
class SpeechCacheService {
  SpeechCacheService({FirebaseFunctions? functions, FirebaseAuth? auth})
      : _customFunctions = functions,
        _customAuth = auth;

  final FirebaseFunctions? _customFunctions;
  final FirebaseAuth? _customAuth;

  FirebaseFunctions? get _functions {
    if (_customFunctions != null) return _customFunctions;
    try {
      return FirebaseFunctions.instance;
    } catch (_) {
      return null;
    }
  }

  FirebaseAuth? get _auth {
    if (_customAuth != null) return _customAuth;
    try {
      return FirebaseAuth.instance;
    } catch (_) {
      return null;
    }
  }

  /// A recording another user already made, or `null` when there is none usable.
  ///
  /// [voice] and [rate] must be **the same values the synthesis call uses**.
  /// They are part of the recording's identity; passing a different voice or rate
  /// than the one that produced the audio would hand a listener the wrong take.
  Future<CachedRecording?> lookup({
    required String text,
    required String voice,
    required double rate,
  }) async {
    try {
      final functions = _functions;
      if (functions == null) return null;
      final HttpsCallableResult<Map<String, dynamic>> response =
          await functions.httpsCallable('getTtsAudioV2').call<Map<String, dynamic>>(
        <String, Object?>{'text': text, 'voice': voice, 'rate': rate},
      );
      return recordingFromCacheResponse(response.data);
    } catch (error) {
      debugPrint('Speech cache lookup unavailable: $error');
      return null;
    }
  }

  /// Offer a recording for everyone who comes after.
  ///
  /// Requires a signed-in user, because this is the half that writes to shared
  /// storage; signed-out listeners still *read* the cache happily. Failures are
  /// swallowed - this is an optimisation, never something to interrupt a learner
  /// with.
  Future<void> offer({
    required String text,
    required String voice,
    required double rate,
    required Uint8List audio,
    required List<Map<String, dynamic>> boundaries,
  }) async {
    try {
      final auth = _auth;
      final functions = _functions;
      if (auth == null || functions == null || auth.currentUser == null) return;
      if (audio.isEmpty || boundaries.isEmpty) return;
      await functions.httpsCallable('warmTtsAudioV2').call<void>(
        <String, Object?>{
          'text': text,
          'voice': voice,
          'rate': rate,
          'audioBase64': base64Encode(audio),
          'boundaries': boundaries,
        },
      );
    } catch (error) {
      debugPrint('Speech cache warm skipped: $error');
    }
  }
}
