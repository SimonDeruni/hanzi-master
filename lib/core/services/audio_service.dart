import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'dart:async';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;
import 'package:web_socket_channel/io.dart';

import 'package:hanzi_master/core/services/api_key_pool.dart';

final audioServiceProvider = Provider<AudioService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  return AudioService(pool: pool);
});

class AudioService {
  final ApiKeyPool _pool;
  AudioPlayer? _audioPlayer;
  FlutterTts? _fallbackTts;
  Map<String, String> _nativeManifest = {};
  bool _isInitialized = false;
  
  // Cache directory for downloaded TTS audio
  Directory? _cacheDir;

  final StreamController<Map<String, dynamic>> _wordBoundaryController = StreamController.broadcast();
  Stream<Map<String, dynamic>> get onWordBoundary => _wordBoundaryController.stream;
  Stream<void> get onPlayerComplete => _player.onPlayerComplete;

  List<Map<String, dynamic>> _currentBoundaries = [];
  int _currentBoundaryIndex = 0;

  double _speechRate = 0.5;

  AudioPlayer get _player {
    _audioPlayer ??= AudioPlayer();
    return _audioPlayer!;
  }

  FlutterTts get _tts {
    _fallbackTts ??= FlutterTts();
    return _fallbackTts!;
  }

  AudioService({required ApiKeyPool pool}) : _pool = pool;

  Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      final manifestString = await rootBundle.loadString('assets/data/audio_manifest.json');
      _nativeManifest = Map<String, String>.from(jsonDecode(manifestString));
    } catch (e) {
      debugPrint("Audio init failed: $e");
    }

    try {
      _cacheDir = await getApplicationDocumentsDirectory();
    } catch (e) {
      _cacheDir = Directory.systemTemp;
    }
    final audioDir = Directory('${_cacheDir!.path}/tts_cache');
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }

    _player.onPositionChanged.listen((position) {
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

    await _tts.setLanguage("zh-CN");
    
    _isInitialized = true;
  }

  Future<bool> playCharacter(String hanzi) async {
    if (!_isInitialized) await init();
    await stop();

    // tier 1: Native Asset
    final fileName = _nativeManifest[hanzi];
    if (fileName != null) {
      try {
        await _player.play(AssetSource('audio/$fileName'));
        return true;
      } catch (e) {
        debugPrint("Failed to play native audio for $hanzi: $e");
      }
    }

    // Tier 2: Local Cache
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hanzi.mp3');
    if (await cacheFile.exists()) {
      try {
        await _player.play(DeviceFileSource(cacheFile.path));
        return true;
      } catch (e) {
        debugPrint("Failed to play cached audio for $hanzi: $e");
      }
    }

    // Tier 3: Fast Cloud TTS
    try {
      final result = await _fetchCloudTTS(hanzi);
      if (result != null && result.audio.isNotEmpty) {
        await cacheFile.writeAsBytes(result.audio);
        _currentBoundaries = result.boundaries;
        _currentBoundaryIndex = 0;
        await _player.play(DeviceFileSource(cacheFile.path));
        return true;
      }
    } catch (e) {
      debugPrint("Cloud TTS failed for $hanzi: $e");
    }

    // Tier 4: Local TTS Fallback
    await _tts.setSpeechRate(_speechRate);
    final ttsResult = await _tts.speak(hanzi);
    return ttsResult != null && ttsResult == 1;
  }

  /// Stable hash for caching TTS audio files (avoids hashCode changes across runs).
  String _hashText(String text) {
    var hash = 0;
    for (var i = 0; i < text.length; i++) {
      hash = 0x1fffffff & (hash * 31) + text.codeUnitAt(i);
      hash ^= (hash >> 16) & 0xffff;
    }
    return hash.toRadixString(36);
  }

  Future<bool> playSentence(String sentence) async {
    if (!_isInitialized) await init();
    await stop();

    final hash = _hashText(sentence);
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
      await _player.setPlaybackRate(1.0);
      await _player.play(DeviceFileSource(cacheFile.path));
      return true;
    }

    // Premium Cloud TTS with streaming (Azure Neural Audio)
    try {
      final result = await _fetchCloudTTS(sentence, cacheFile: cacheFile, boundaryFile: boundaryFile);
      if (result != null && result.success) {
        return true;
      }
    } catch (e) {
      debugPrint("Cloud TTS streaming failed for sentence: $e");
    }

    // Fallback: local TTS with corrected rate (0.5 = normal speed)
    await _tts.setSpeechRate(0.5);
    final ttsResult = await _tts.speak(sentence);
    return ttsResult != null && ttsResult == 1;
  }

  Future<CloudTtsResult?> _fetchCloudTTS(String text, {File? cacheFile, File? boundaryFile}) async {
    final apiKey = _pool.azureSpeechKey;
    final region = _pool.azureSpeechRegion;
    if (apiKey.isEmpty || region.isEmpty || apiKey == 'MISSING_KEY') return null;

    final safeText = text.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');
    final uuid = const Uuid().v4().replaceAll('-', '');
    final uri = Uri.parse('wss://$region.tts.speech.microsoft.com/cognitiveservices/websocket/v1?X-ConnectionId=$uuid');

    IOWebSocketChannel? channel;
    try {
      channel = IOWebSocketChannel.connect(
        uri,
        headers: {
          'Ocp-Apim-Subscription-Key': apiKey,
        },
      );
    } catch(e) {
      debugPrint("WebSocket connect failed: $e");
      return null;
    }

    final audioBuffer = <int>[];
    final boundaries = <Map<String, dynamic>>[];
    bool playbackStarted = false;
    const int kStreamPlaybackThreshold = 50000;
    final completer = Completer<CloudTtsResult?>();

    final tmpFile = cacheFile ?? File('${_cacheDir!.path}/tts_cache/tmp_${DateTime.now().millisecondsSinceEpoch}.mp3');
    final sink = tmpFile.openWrite(mode: FileMode.write);

    channel.stream.listen((message) {
      if (message is String) {
        if (message.contains('Path:turn.end') || message.contains('Path: turn.end')) {
          if (!completer.isCompleted) {
            sink.flush().then((_) async {
              await sink.close();
              if (boundaryFile != null) {
                try { await boundaryFile.writeAsString(jsonEncode(boundaries)); } catch(_) {}
              }
              if (!playbackStarted) {
                _currentBoundaries = boundaries;
                _currentBoundaryIndex = 0;
                await _player.setPlaybackRate(1.0);
                await _player.play(DeviceFileSource(tmpFile.path));
              }
              completer.complete(CloudTtsResult(
                audio: Uint8List.fromList(audioBuffer),
                boundaries: boundaries,
                success: true,
              ));
            });
          }
        } else if (message.contains('Path:audio.metadata') || message.contains('Path: audio.metadata')) {
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
        if (message.length > 2) {
          final headerLength = (message[0] << 8) | message[1];
          final offset = 2 + headerLength;
          if (offset < message.length) {
            // Retrieve header to confirm it is indeed audio payload and not something else
            try {
              final headerText = ascii.decode(message.sublist(2, offset), allowInvalid: true);
              if (headerText.contains('Path:audio')) {
                audioBuffer.addAll(message.sublist(offset));
                if (!playbackStarted && audioBuffer.length >= kStreamPlaybackThreshold) {
                  playbackStarted = true;
                  sink.flush().then((_) {
                    _currentBoundaries = boundaries;
                    _currentBoundaryIndex = 0;
                    _player.setPlaybackRate(1.0);
                    _player.play(DeviceFileSource(tmpFile.path));
                  });
                }
              }
            } catch(e) {
              // Fallback to appending directly if header decoding fails for some reason
              audioBuffer.addAll(message.sublist(offset));
              if (!playbackStarted && audioBuffer.length >= kStreamPlaybackThreshold) {
                playbackStarted = true;
                sink.flush().then((_) {
                  _currentBoundaries = boundaries;
                  _currentBoundaryIndex = 0;
                  _player.setPlaybackRate(1.0);
                  _player.play(DeviceFileSource(tmpFile.path));
                });
              }
            }
          }
        }
      }
    }, onError: (e) {
      debugPrint('Azure TTS WS error: $e');
      if (!completer.isCompleted) { sink.close(); completer.complete(null); }
    }, onDone: () {
      sink.flush().then((_) async {
        await sink.close();
        if (boundaryFile != null) {
          try { await boundaryFile.writeAsString(jsonEncode(boundaries)); } catch(_) {}
        }
        if (!completer.isCompleted) {
        if (audioBuffer.isNotEmpty) {
          if (!playbackStarted) {
            _currentBoundaries = boundaries;
            _currentBoundaryIndex = 0;
            await _player.setPlaybackRate(1.0);
            await _player.play(DeviceFileSource(tmpFile.path));
          }
          completer.complete(CloudTtsResult(
            audio: Uint8List.fromList(audioBuffer),
            boundaries: boundaries,
            success: true,
          ));
        } else {
          completer.complete(null);
        }
      }
      });
    });

    final requestId = const Uuid().v4().replaceAll('-', '');
    final timestamp = DateTime.now().toUtc().toIso8601String();

    channel.sink.add(
      'Path: speech.config\r\n'
      'X-RequestId: $requestId\r\n'
      'X-Timestamp: $timestamp\r\n'
      'Content-Type: application/json; charset=utf-8\r\n'
      '\r\n'
      '{"context":{"synthesis":{"audio":{"metadataOptions":{"wordBoundaryEnabled":true,"sentenceBoundaryEnabled":true},"outputFormat":"audio-16khz-32kbitrate-mono-mp3"}}}}'
    );

    final ratePercent = math.max(-50, math.min(200, ((_speechRate - 0.5) * 200).round()));
    final ssml = '''<speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xml:lang='zh-CN'><voice name='zh-CN-XiaoxiaoNeural'><prosody rate='$ratePercent%'>$safeText</prosody></voice></speak>''';

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
      sink.close();
      return null;
    }).whenComplete(() => channel?.sink.close());
  }

  Future<void> stop() async {
    await _player.stop();
    await _tts.stop();
  }

  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate;
    await _tts.setSpeechRate(rate);
  }

  // SFX Methods
  Future<void> playCorrectSfx() async {
    await _player.play(AssetSource('audio/sfx_correct.wav'));
  }

  Future<void> playWrongSfx() async {
    await _player.play(AssetSource('audio/sfx_wrong.wav'));
  }

  Future<void> playCompleteSfx() async {
    await _player.play(AssetSource('audio/sfx_complete.wav'));
  }

  Future<void> playStreakSfx() async {
    await _player.play(AssetSource('audio/sfx_streak.wav'));
  }

  void dispose() {
    _player.dispose();
    _tts.stop();
    _wordBoundaryController.close();
  }
}

class CloudTtsResult {
  final Uint8List audio;
  final List<Map<String, dynamic>> boundaries;
  final bool success;

  CloudTtsResult({
    required this.audio,
    required this.boundaries,
    this.success = true,
  });
}
