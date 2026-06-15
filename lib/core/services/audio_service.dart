import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:hanzi_master/core/services/api_key_pool.dart';

final audioServiceProvider = Provider<AudioService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  return AudioService(pool: pool);
});

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _fallbackTts = FlutterTts();
  Map<String, String> _nativeManifest = {};
  bool _isInitialized = false;
  
  // Cache directory for downloaded TTS audio
  Directory? _cacheDir;

  AudioService({required ApiKeyPool pool});

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

    // Tier 3: Fast Cloud TTS (OpenAI tts-1 or mocked Azure)
    try {
      final audioData = await _fetchStandardCloud(hanzi);
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

    // Tier 3: Premium Cloud TTS (OpenAI tts-1-hd or ElevenLabs for expressive speech)
    try {
      final audioData = await _fetchPremiumCloud(sentence);
      if (audioData != null) {
        await cacheFile.writeAsBytes(audioData);
        await _audioPlayer.play(DeviceFileSource(cacheFile.path));
        return;
      }
    } catch (e) {
      debugPrint("Premium Cloud TTS failed for sentence: $e");
    }

    await _fallbackTts.speak(sentence);
  }

  Future<Uint8List?> _fetchStandardCloud(String text) async {
    return _callOpenAiTts(text, model: 'tts-1', voice: 'alloy');
  }

  Future<Uint8List?> _fetchPremiumCloud(String text) async {
    // We use a different, more expressive voice (e.g., 'nova' or 'shimmer') and the HD model
    // for stories and Master Lin's dialog to fix the "robotic" issue.
    return _callOpenAiTts(text, model: 'tts-1-hd', voice: 'shimmer');
  }

  Future<Uint8List?> _callOpenAiTts(String text, {required String model, required String voice}) async {
    // Real implementation connecting to OpenAI's TTS API.
    // Ensure we have a valid key from the pool, even if it's the Google key (we use it as a proxy or assume the pool has an OpenAI key).
    // For this example, we assume `_pool.googleKey` or similar might be configured to accept OpenAI, or we mock the exact REST call.
    
    // As we only have OpenRouter/Google keys explicitly named, we will attempt to use an OpenAI compatible endpoint if available,
    // or return null to trigger fallback if no valid OpenAI key is present.
    final apiKey = const String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
    if (apiKey.isEmpty) return null;

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/audio/speech'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': model,
          'input': text,
          'voice': voice,
        }),
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      debugPrint('OpenAI TTS error: $e');
    }
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
