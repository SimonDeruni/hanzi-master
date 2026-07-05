import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

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

  final StreamController<Map<String, dynamic>> _wordBoundaryController = StreamController.broadcast();
  Stream<Map<String, dynamic>> get onWordBoundary => _wordBoundaryController.stream;
  Stream<void> get onPlayerComplete => _audioPlayer.onPlayerComplete;

  List<Map<String, dynamic>> _currentBoundaries = [];
  int _currentBoundaryIndex = 0;

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

    _audioPlayer.onPositionChanged.listen((position) {
      if (_currentBoundaries.isEmpty || _currentBoundaryIndex >= _currentBoundaries.length) return;
      
      final currentMs = position.inMilliseconds;
      // Azure offset is in 100-ns ticks. 1 ms = 10000 ticks.
      final nextBoundary = _currentBoundaries[_currentBoundaryIndex];
      final offsetTicks = nextBoundary['Offset'];
      if (offsetTicks == null) return;
      
      final boundaryMs = (offsetTicks is int ? offsetTicks : int.tryParse(offsetTicks.toString()) ?? 0) / 10000;
      
      if (currentMs >= boundaryMs) {
        _wordBoundaryController.add(nextBoundary);
        _currentBoundaryIndex++;
      }
    });

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
      final result = await _fetchCloudTTS(hanzi, isPremium: false);
      if (result != null && result.audio.isNotEmpty) {
        await cacheFile.writeAsBytes(result.audio);
        _currentBoundaries = result.boundaries;
        _currentBoundaryIndex = 0;
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
    final boundaryFile = File('${_cacheDir!.path}/tts_cache/$hash.json');
    
    if (await cacheFile.exists()) {
      _currentBoundaries = [];
      _currentBoundaryIndex = 0;
      if (await boundaryFile.exists()) {
         try {
           final jsonStr = await boundaryFile.readAsString();
           final list = jsonDecode(jsonStr) as List<dynamic>;
           _currentBoundaries = list.cast<Map<String, dynamic>>();
         } catch(e) {}
      }
      await _audioPlayer.play(DeviceFileSource(cacheFile.path));
      return;
    }

    // Tier 3: Premium Cloud TTS (Azure Neural Audio)
    try {
      final result = await _fetchCloudTTS(sentence, isPremium: true);
      if (result != null && result.audio.isNotEmpty) {
        await cacheFile.writeAsBytes(result.audio);
        await boundaryFile.writeAsString(jsonEncode(result.boundaries));
        _currentBoundaries = result.boundaries;
        _currentBoundaryIndex = 0;
        await _audioPlayer.play(DeviceFileSource(cacheFile.path));
        return;
      }
    } catch (e) {
      debugPrint("Premium Cloud TTS failed for sentence: $e");
    }

    await _fallbackTts.speak(sentence);
  }

  Future<CloudTtsResult?> _fetchCloudTTS(String text, {bool isPremium = true}) async {
    final apiKey = _pool.azureSpeechKey;
    final region = _pool.azureSpeechRegion;
    if (apiKey.isEmpty || region.isEmpty || apiKey == 'MISSING_KEY') return null;

    final safeText = text.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');
    final uri = Uri.parse('wss://$region.tts.speech.microsoft.com/cognitiveservices/websocket/v1');
    final uuid = const Uuid().v4().replaceAll('-', '');

    IOWebSocketChannel? channel;
    try {
      channel = IOWebSocketChannel.connect(
        uri,
        headers: {
          'Ocp-Apim-Subscription-Key': apiKey,
          'X-ConnectionId': uuid,
        },
      );
    } catch(e) {
      debugPrint("WebSocket connect failed: $e");
      return null;
    }

    final audioBuffer = <int>[];
    final boundaries = <Map<String, dynamic>>[];
    final completer = Completer<CloudTtsResult?>();

    channel.stream.listen((message) {
      if (message is String) {
        if (message.contains('Path: turn.end')) {
          if (!completer.isCompleted) {
            completer.complete(CloudTtsResult(
              audio: Uint8List.fromList(audioBuffer),
              boundaries: boundaries,
            ));
          }
        } else if (message.contains('Path: audio.metadata')) {
          try {
            final parts = message.split('\r\n\r\n');
            if (parts.length > 1) {
              final data = jsonDecode(parts[1]);
              if (data['Metadata'] != null) {
                for (var meta in data['Metadata']) {
                  if (meta['Type'] == 'WordBoundary') {
                    boundaries.add(meta['Data']);
                  }
                }
              }
            }
          } catch(e) {
            debugPrint('Failed to parse metadata: $e');
          }
        }
      } else if (message is List<int>) {
        int offset = -1;
        for (int i = 0; i < message.length - 3; i++) {
          if (message[i] == 13 && message[i+1] == 10 && message[i+2] == 13 && message[i+3] == 10) {
            offset = i + 4;
            break;
          }
        }
        if (offset != -1 && offset < message.length) {
          audioBuffer.addAll(message.sublist(offset));
        }
      }
    }, onError: (e) {
      debugPrint('Azure TTS WS error: $e');
      if (!completer.isCompleted) completer.complete(null);
    }, onDone: () {
      if (!completer.isCompleted) {
        if (audioBuffer.isNotEmpty) {
          completer.complete(CloudTtsResult(
            audio: Uint8List.fromList(audioBuffer),
            boundaries: boundaries,
          ));
        } else {
          completer.complete(null);
        }
      }
    });

    final requestId = const Uuid().v4().replaceAll('-', '');
    final timestamp = DateTime.now().toUtc().toIso8601String();

    channel.sink.add(
      'Path: speech.config\r\n'
      'Content-Type: application/json; charset=utf-8\r\n'
      '\r\n'
      '{"context":{"system":{"name":"SpeechSDK"}}}'
    );

    final ssml = '''<speak version='1.0' xml:lang='zh-CN'><voice name='zh-CN-XiaoxiaoNeural'>$safeText</voice></speak>''';

    channel.sink.add(
      'Path: ssml\r\n'
      'X-RequestId: $requestId\r\n'
      'X-Timestamp: $timestamp\r\n'
      'Content-Type: application/ssml+xml\r\n'
      '\r\n'
      '$ssml'
    );

    return completer.future.timeout(const Duration(seconds: 15), onTimeout: () {
      channel?.sink.close();
      return null;
    }).whenComplete(() => channel?.sink.close());
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
    _fallbackTts.stop();
    _wordBoundaryController.close();
  }
}

class CloudTtsResult {
  final Uint8List audio;
  final List<Map<String, dynamic>> boundaries;

  CloudTtsResult({
    required this.audio,
    required this.boundaries,
  });
}
