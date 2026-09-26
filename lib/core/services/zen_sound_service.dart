import 'dart:io' show Platform;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final zenSoundServiceProvider = Provider<ZenSoundService>((ref) {
  return ZenSoundService.instance;
});

/// A serene, low-volume sound effects service for SinoSpark.
///
/// Implements tactile, organic acoustic moments:
/// - Soft paper flip for flashcard rotation
/// - Warm wooden Hanko seal stamp impact
/// - Whispery wet ink brush stroke sweep
/// - Resonant bronze temple chime for session / streak completion
/// - Graded-answer accents for the lesson quiz (correct / wrong)
///
/// Calibrated to gentle, low amplitudes (~0.16 to 0.26) so it never
/// competes with Mandarin spoken voice pronunciation.
///
/// This service owns its **own** [AudioPlayer] and its own audio session
/// (`ambient` on iOS so it respects the mute switch and mixes; sonification on
/// Android with no audio focus). Nothing here may ever play on the speech
/// player in `audio_service.dart`: a graded accent and a spoken word are
/// scheduled separately, and sharing one player would let either truncate the
/// other. This is also the only place the Settings "sound effects" toggle can
/// reach - see [setEnabled].
class ZenSoundService {
  ZenSoundService._internal();

  static final ZenSoundService instance = ZenSoundService._internal();

  AudioPlayer? _player;
  bool _enabled = true;
  bool _initialized = false;

  bool get isEnabled => _enabled;

  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  bool get _isTestEnv {
    if (kIsWeb) return false;
    return Platform.environment.containsKey('FLUTTER_TEST');
  }

  void _initPlayer() {
    if (_initialized || _isTestEnv) return;
    try {
      _player = AudioPlayer(playerId: 'zen_sfx');
      _player?.setReleaseMode(ReleaseMode.stop);
      _player?.setAudioContext(
        AudioContext(
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.ambient,
            options: const {
              AVAudioSessionOptions.mixWithOthers,
            },
          ),
          android: const AudioContextAndroid(
            isSpeakerphoneOn: true,
            stayAwake: false,
            contentType: AndroidContentType.sonification,
            usageType: AndroidUsageType.assistanceSonification,
            audioFocus: AndroidAudioFocus.none,
          ),
        ),
      );
      _initialized = true;
    } catch (e) {
      debugPrint('ZenSoundService: audio player initialization skipped: $e');
    }
  }

  /// Gentle paper friction sound when flipping a flashcard (140ms, soft rustle).
  Future<void> playPaperFlip() async {
    if (!_enabled) return;
    await _playAsset('audio/zen_paper_flip.wav', volume: 0.20);
  }

  /// Deep, warm wooden seal stamp impact when grading a card (180ms, 120Hz thump).
  Future<void> playSealStamp() async {
    if (!_enabled) return;
    await _playAsset('audio/zen_seal_stamp.wav', volume: 0.26);
  }

  /// Subtle wet ink brush glide when tracing a stroke (220ms, soft whisper).
  Future<void> playBrushStroke() async {
    if (!_enabled) return;
    await _playAsset('audio/zen_brush_stroke.wav', volume: 0.16);
  }

  /// Resonant bronze temple chime when completing a study session (2.0s, warm 432Hz).
  Future<void> playBellChime() async {
    if (!_enabled) return;
    await _playAsset('audio/zen_bell_chime.wav', volume: 0.22);
  }

  /// Correct-answer accent, played when the lesson quiz grades a card right.
  ///
  /// Matches the previous accent's level so the ear does not register a change
  /// in the quiz; it is simply no longer on the speech player and no longer
  /// ignores the user's sound setting.
  Future<void> playCorrect() async {
    if (!_enabled) return;
    await _playAsset('audio/sfx_correct.wav', volume: 0.22);
  }

  /// Refusal accent, played when the lesson quiz grades a card wrong.
  Future<void> playWrong() async {
    if (!_enabled) return;
    await _playAsset('audio/sfx_wrong.wav', volume: 0.20);
  }

  Future<void> _playAsset(String assetPath, {required double volume}) async {
    try {
      if (_player == null) {
        _initPlayer();
      }
      if (_player != null) {
        await _player!.stop();
        await _player!.setVolume(volume);
        await _player!.play(AssetSource(assetPath));
      }
    } catch (e) {
      // Graceful fallback on headless test environments or restricted devices
      debugPrint('ZenSoundService: playback error for $assetPath: $e');
    }
  }

  void dispose() {
    _player?.dispose();
    _player = null;
    _initialized = false;
  }
}
