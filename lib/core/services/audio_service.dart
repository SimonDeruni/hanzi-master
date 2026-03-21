import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioService();
});

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _fallbackTts = FlutterTts();
  Map<String, String> _nativeManifest = {};
  bool _isInitialized = false;
  
  // Cache directory for downloaded TTS audio
  Directory? _cacheDir;

  Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      final manifestString = await rootBundle.loadString('assets/data/audio_manifest.json');
      _nativeManifest = Map<String, String>.from(jsonDecode(manifestString));
    } catch (e) {
      debugPrint("Audio init failed: $e"); // Changed from print
    }

    _cacheDir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${_cacheDir!.path}/tts_cache');
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }

    await _fallbackTts.setLanguage("zh-CN");
    await _fallbackTts.setSpeechRate(0.5);
    
    _isInitialized = true;
  }

  Future<void> playCharacter(String hanzi) async {
    if (!_isInitialized) await init();

    // tier 1: Native Asset
    final fileName = _nativeManifest[hanzi];
    if (fileName != null) {
      try {
        await _audioPlayer.play(AssetSource('audio/$fileName'));
        return;
      } catch (e) {
        debugPrint("Failed to play native audio for $hanzi: $e");
      }
    }

    // Tier 2: Local Cache
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hanzi.mp3');
    if (await cacheFile.exists()) {
      try {
        await _audioPlayer.play(DeviceFileSource(cacheFile.path));
        return;
      } catch (e) {
        debugPrint("Failed to play cached audio for $hanzi: $e");
      }
    }

    // Tier 3: Cloud TTS
    try {
      final audioData = await _fetchFromCloud(hanzi);
      if (audioData != null) {
        await cacheFile.writeAsBytes(audioData);
        await _audioPlayer.play(DeviceFileSource(cacheFile.path));
        return;
      }
    } catch (e) {
      debugPrint("Cloud TTS failed for $hanzi: $e");
    }

    // Tier 4: Local TTS Fallback
    await _fallbackTts.speak(hanzi);
  }

  Future<void> playSentence(String sentence) async {
    if (!_isInitialized) await init();

    final hash = sentence.hashCode.toString();
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hash.mp3');
    
    if (await cacheFile.exists()) {
      await _audioPlayer.play(DeviceFileSource(cacheFile.path));
      return;
    }

    // Tier 3: Cloud TTS
    try {
      final audioData = await _fetchFromCloud(sentence);
      if (audioData != null) {
        await cacheFile.writeAsBytes(audioData);
        await _audioPlayer.play(DeviceFileSource(cacheFile.path));
        return;
      }
    } catch (e) {
      debugPrint("Cloud TTS failed for sentence: $e");
    }

    await _fallbackTts.speak(sentence);
  }

  /// Tier 3: Cloud TTS Fetcher (Currently MOCKED for security/MVP)
  Future<Uint8List?> _fetchFromCloud(String text) async {
    // In a real scenario, this would be an authenticated POST to Azure/ElevenLabs.
    // For this implementation, we return null to force the Tier 4 fallback 
    // until a valid API key and endpoint are configured by the user.
    // TODO: Integrate Azure Speech SDK or ElevenLabs REST API.
    return null;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    await _fallbackTts.stop();
  }

  Future<void> setSpeechRate(double rate) async {
    await _fallbackTts.setSpeechRate(rate);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
