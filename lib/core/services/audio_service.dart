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
  final ApiKeyPool _pool;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _fallbackTts = FlutterTts();
  Map<String, String> _nativeManifest = {};
  bool _isInitialized = false;
  
  // Cache directory for downloaded TTS audio
  Directory? _cacheDir;

  AudioService({required ApiKeyPool pool}) : _pool = pool;

  Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      final manifestString = await rootBundle.loadString('assets/data/audio_manifest.json');
      _nativeManifest = Map<String, String>.from(jsonDecode(manifestString));
    } catch (e) {
      debugPrint("Audio init failed: $e");
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
    await stop();

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

    // Tier 3: Fast Cloud TTS
    try {
      final audioData = await _fetchCloudTTS(hanzi, isPremium: false);
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
    await stop();

    final hash = sentence.hashCode.toString();
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hash.mp3');
    
    if (await cacheFile.exists()) {
      await _audioPlayer.play(DeviceFileSource(cacheFile.path));
      return;
    }

    // Tier 3: Premium Cloud TTS (Azure Neural Audio)
    try {
      final audioData = await _fetchCloudTTS(sentence, isPremium: true);
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

  Future<Uint8List?> _fetchCloudTTS(String text, {bool isPremium = true}) async {
    final apiKey = _pool.azureSpeechKey;
    final region = _pool.azureSpeechRegion;
    if (apiKey.isEmpty || region.isEmpty || apiKey == 'MISSING_KEY') return null;

    // Escape basic XML chars just in case
    final safeText = text.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');

    try {
      final response = await http.post(
        Uri.parse('https://$region.tts.speech.microsoft.com/cognitiveservices/v1'),
        headers: {
          'Ocp-Apim-Subscription-Key': apiKey,
          'Content-Type': 'application/ssml+xml',
          'X-Microsoft-OutputFormat': 'audio-16khz-128kbitrate-mono-mp3',
        },
        body: '''
<speak version='1.0' xml:lang='zh-CN'>
  <voice xml:lang='zh-CN' xml:gender='Female' name='zh-CN-XiaoxiaoNeural'>
    $safeText
  </voice>
</speak>
''',
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        debugPrint('Azure TTS HTTP Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('Azure TTS error: $e');
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

  // SFX Methods
  Future<void> playCorrectSfx() async {
    await _audioPlayer.play(AssetSource('audio/sfx_correct.wav'));
  }

  Future<void> playWrongSfx() async {
    await _audioPlayer.play(AssetSource('audio/sfx_wrong.wav'));
  }

  Future<void> playCompleteSfx() async {
    await _audioPlayer.play(AssetSource('audio/sfx_complete.wav'));
  }

  Future<void> playStreakSfx() async {
    await _audioPlayer.play(AssetSource('audio/sfx_streak.wav'));
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

