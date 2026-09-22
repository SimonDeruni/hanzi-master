import 'dart:io' show Platform;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SoundscapeTrack {
  off,
  courtyardRain,
  guqinWind,
  midnightZen;

  String get assetPath {
    switch (this) {
      case SoundscapeTrack.courtyardRain:
        return 'audio/ambient_courtyard_rain.wav';
      case SoundscapeTrack.guqinWind:
        return 'audio/ambient_guqin_wind.wav';
      case SoundscapeTrack.midnightZen:
        return 'audio/ambient_midnight_zen.wav';
      case SoundscapeTrack.off:
        return '';
    }
  }

  static SoundscapeTrack fromString(String? value) {
    switch (value) {
      case 'courtyardRain':
        return SoundscapeTrack.courtyardRain;
      case 'guqinWind':
        return SoundscapeTrack.guqinWind;
      case 'midnightZen':
        return SoundscapeTrack.midnightZen;
      default:
        return SoundscapeTrack.off;
    }
  }
}

class ZenAmbientState {
  final SoundscapeTrack track;
  final bool isPlaying;
  final double volume;

  const ZenAmbientState({
    this.track = SoundscapeTrack.off,
    this.isPlaying = false,
    this.volume = 0.15,
  });

  ZenAmbientState copyWith({
    SoundscapeTrack? track,
    bool? isPlaying,
    double? volume,
  }) {
    return ZenAmbientState(
      track: track ?? this.track,
      isPlaying: isPlaying ?? this.isPlaying,
      volume: volume ?? this.volume,
    );
  }
}

final zenAmbientServiceProvider =
    StateNotifierProvider<ZenAmbientService, ZenAmbientState>((ref) {
  return ZenAmbientService.instance;
});

class ZenAmbientService extends StateNotifier<ZenAmbientState> {
  ZenAmbientService._internal() : super(const ZenAmbientState());

  static final ZenAmbientService instance = ZenAmbientService._internal();

  static const String _keySoundscapeTrack = 'zen_soundscape_track';
  static const String _keySoundscapeVolume = 'zen_soundscape_volume';

  AudioPlayer? _player;
  bool _initialized = false;
  SharedPreferences? _prefs;

  bool get _isTestEnv {
    if (kIsWeb) return false;
    return Platform.environment.containsKey('FLUTTER_TEST');
  }

  Future<void> init({SharedPreferences? prefs}) async {
    if (prefs != null) {
      _prefs = prefs;
      _initialized = false;
    } else if (_initialized) {
      return;
    }
    try {
      _prefs = prefs ?? await SharedPreferences.getInstance();
      final savedTrackStr = _prefs?.getString(_keySoundscapeTrack);
      final savedTrack = SoundscapeTrack.fromString(savedTrackStr);
      final savedVolume = _prefs?.getDouble(_keySoundscapeVolume) ?? 0.15;

      state = state.copyWith(
        track: savedTrack,
        volume: savedVolume,
        isPlaying: false,
      );

      _initAudioPlayer();
      _initialized = true;
    } catch (e) {
      debugPrint('ZenAmbientService: init error: $e');
    }
  }

  void _initAudioPlayer() {
    if (_player != null || _isTestEnv) return;
    try {
      _player = AudioPlayer(playerId: 'zen_ambient');
      _player?.setReleaseMode(ReleaseMode.loop);
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
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.media,
            audioFocus: AndroidAudioFocus.none,
          ),
        ),
      );
    } catch (e) {
      debugPrint('ZenAmbientService: player creation skipped: $e');
    }
  }

  Future<void> setTrack(SoundscapeTrack track) async {
    if (state.track == track && state.isPlaying) return;

    state = state.copyWith(track: track);
    await _prefs?.setString(_keySoundscapeTrack, track.name);

    if (track == SoundscapeTrack.off) {
      await stop();
    } else {
      await _playTrack(track);
    }
  }

  Future<void> togglePlayPause() async {
    if (state.track == SoundscapeTrack.off) {
      // Default to Courtyard Rain when toggled on from off
      await setTrack(SoundscapeTrack.courtyardRain);
      return;
    }

    if (state.isPlaying) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<void> setVolume(double volume) async {
    final clamped = volume.clamp(0.0, 1.0);
    state = state.copyWith(volume: clamped);
    await _prefs?.setDouble(_keySoundscapeVolume, clamped);

    if (_player != null && state.isPlaying && !_isTestEnv) {
      try {
        await _player!.setVolume(clamped);
      } catch (e) {
        debugPrint('ZenAmbientService: setVolume error: $e');
      }
    }
  }

  Future<void> pause() async {
    if (!state.isPlaying) return;
    state = state.copyWith(isPlaying: false);

    if (_player != null && !_isTestEnv) {
      try {
        await _player!.pause();
      } catch (e) {
        debugPrint('ZenAmbientService: pause error: $e');
      }
    }
  }

  Future<void> resume() async {
    if (state.track == SoundscapeTrack.off) return;
    if (state.isPlaying) return;

    await _playTrack(state.track);
  }

  Future<void> stop() async {
    state = state.copyWith(isPlaying: false);

    if (_player != null && !_isTestEnv) {
      try {
        await _player!.stop();
      } catch (e) {
        debugPrint('ZenAmbientService: stop error: $e');
      }
    }
  }

  Future<void> _playTrack(SoundscapeTrack track) async {
    if (track == SoundscapeTrack.off) {
      await stop();
      return;
    }

    _initAudioPlayer();
    state = state.copyWith(track: track, isPlaying: true);

    if (_player != null && !_isTestEnv) {
      try {
        await _player!.stop();
        await _player!.setVolume(state.volume);
        await _player!.setReleaseMode(ReleaseMode.loop);
        await _player!.play(AssetSource(track.assetPath));
      } catch (e) {
        debugPrint('ZenAmbientService: playback error for ${track.name}: $e');
      }
    }
  }

  @override
  void dispose() {
    _player?.dispose();
    _player = null;
    super.dispose();
  }
}
