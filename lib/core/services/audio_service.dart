import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'dart:async';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/audio_quota_service.dart';
import '../utils/pinyin_utils.dart';

final audioServiceProvider = Provider<AudioService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  final quota = ref.watch(audioQuotaServiceProvider);
  final service = AudioService(pool: pool, quotaService: quota);
  ref.onDispose(service.dispose);
  return service;
});

class AudioService {
  final ApiKeyPool _pool;
  final AudioQuotaService _quotaService;
  AudioPlayer? _audioPlayer;
  FlutterTts? _fallbackTts;
  Map<String, String> _nativeManifest = {};
  bool _isInitialized = false;
  Future<void>? _initializationFuture;
  Future<void> _engineOperation = Future<void>.value();
  int _playbackGeneration = 0;
  bool _isDisposed = false;
  
  // Cache directory for downloaded TTS audio
  Directory? _cacheDir;

  final StreamController<Map<String, dynamic>> _wordBoundaryController = StreamController.broadcast();
  Stream<Map<String, dynamic>> get onWordBoundary => _wordBoundaryController.stream;

  final StreamController<void> _completeController = StreamController.broadcast();
  Stream<void> get onPlayerComplete => _completeController.stream;

  final StreamController<String> _errorController = StreamController.broadcast();
  Stream<String> get onPlaybackError => _errorController.stream;

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

  AudioService({
    required ApiKeyPool pool,
    AudioQuotaService? quotaService,
  })  : _pool = pool,
        _quotaService = quotaService ?? AudioQuotaService();

  Future<void> init() async {
    if (_isInitialized) return;
    final initialization = _initializationFuture ??= _initialize();
    await initialization;
  }

  Future<void> _initialize() async {
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
    final audiobookDir = Directory('${_cacheDir!.path}/audiobook_cache');
    if (!await audiobookDir.exists()) {
      await audiobookDir.create(recursive: true);
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

    _player.onPlayerComplete.listen((_) {
      if (!_completeController.isClosed) _completeController.add(null);
    });

    _tts.setCompletionHandler(() {
      if (!_completeController.isClosed) _completeController.add(null);
    });

    _tts.setErrorHandler((message) {
      debugPrint('[AudioService] On-device TTS error: $message');
      if (!_errorController.isClosed) _errorController.add(message);
    });

    await _tts.setLanguage("zh-CN");
    
    _isInitialized = true;
  }

  Future<T> _runEngineOperation<T>(Future<T> Function() operation) {
    final completer = Completer<T>();
    _engineOperation = _engineOperation.then((_) async {
      if (_isDisposed) {
        completer.completeError(StateError('AudioService has been disposed'));
        return;
      }
      try {
        completer.complete(await operation());
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  Future<void> _stopEngines() async {
    await _player.stop();
    await _tts.stop();
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
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hanzi.wav');
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

  /// Maps scenario voice names to Azure Neural voice IDs.
  /// See: https://learn.microsoft.com/en-us/azure/ai-services/speech-service/language-support
  static const Map<String, String> _azureVoiceMap = {
    'Fenrir': 'zh-CN-YunxiNeural',       // Male, upbeat
    'Charon': 'zh-CN-YunyangNeural',     // Male, news-style
    'Kore': 'zh-CN-XiaoxiaoNeural',      // Female, warm (default)
    'Aoede': 'zh-CN-XiaoyiNeural',       // Female, cheerful
    'Puck': 'zh-CN-YunjianNeural',       // Male, older/sporty
  };

  static const String _defaultAzureVoice = 'zh-CN-XiaoxiaoNeural';

  Future<bool> playSentence(String sentence, {String voiceName = 'Kore'}) async {
    final generation = ++_playbackGeneration;
    if (!_isInitialized) await init();
    if (generation != _playbackGeneration || _isDisposed) return false;
    await _runEngineOperation(() async {
      if (generation != _playbackGeneration) return;
      await _stopEngines();
    });
    if (generation != _playbackGeneration || _isDisposed) return false;

    final azureVoice = _azureVoiceMap[voiceName] ?? _defaultAzureVoice;
    final hash = _hashText('$voiceName:$sentence');
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hash.mp3');
    final boundaryFile = File('${_cacheDir!.path}/tts_cache/$hash.json');
    
    await _player.setAudioContext(AudioContext(
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: const {
          AVAudioSessionOptions.allowBluetooth,
          AVAudioSessionOptions.mixWithOthers,
        },
      ),
      android: const AudioContextAndroid(
        isSpeakerphoneOn: false,
        stayAwake: true,
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.media,
        audioFocus: AndroidAudioFocus.gain,
      ),
    ));
    await _player.setVolume(1.0);

    if (await cacheFile.exists()) {
      _currentBoundaries = [];
      _currentBoundaryIndex = 0;
      if (await boundaryFile.exists()) {
         try {
           final jsonStr = await boundaryFile.readAsString();
           final list = jsonDecode(jsonStr) as List<dynamic>;
           _currentBoundaries = list.cast<Map<String, dynamic>>();
         } catch (_) {
           // Ignore corrupted boundary cache
         }
      }
      try {
        if (generation != _playbackGeneration) return false;
        await _runEngineOperation(() async {
          if (generation != _playbackGeneration) return;
          await _player.setPlaybackRate(1.0);
          try {
            await _player.play(DeviceFileSource(cacheFile.path));
          } catch (_) {
            final bytes = await cacheFile.readAsBytes();
            await _player.play(BytesSource(bytes));
          }
        });
        if (generation != _playbackGeneration) return false;
        debugPrint('[AudioService] Playing cached Azure audio: ${cacheFile.path}');
        return true;
      } catch (e) {
        debugPrint("[AudioService] Cached audio play failed: $e");
      }
    }

    // Premium Cloud TTS with streaming (Azure Neural Audio)
    // Only synthesize new cloud audio if user has remaining weekly quota
    if (_quotaService.hasQuotaRemaining) {
      try {
        final result = await _fetchCloudTTS(sentence, azureVoice: azureVoice, cacheFile: cacheFile, boundaryFile: boundaryFile);
        if (result != null && result.success && result.audio.isNotEmpty) {
          if (generation != _playbackGeneration) return false;
          await _quotaService.recordSpeech(sentence);
          if (generation != _playbackGeneration) return false;
          await _runEngineOperation(() async {
            if (generation != _playbackGeneration) return;
            await _player.setPlaybackRate(1.0);
            try {
              await _player.play(DeviceFileSource(cacheFile.path));
            } catch (_) {
              await _player.play(BytesSource(result.audio));
            }
          });
          if (generation != _playbackGeneration) return false;
          debugPrint("[AudioService] Playing Azure Neural Voice (${result.audio.length} bytes)");
          return true;
        }
      } catch (e) {
        debugPrint("[AudioService] Azure Neural TTS streaming failed for sentence: $e");
      }
    } else {
      debugPrint("[AudioService] Weekly 4-hour Studio Audio allowance reached. Seamlessly playing via On-Device Voice.");
    }

    // Fallback: local on-device TTS if quota is reached or Azure is offline
    if (generation != _playbackGeneration) return false;
    try {
      final ttsResult = await _runEngineOperation<dynamic>(() async {
        if (generation != _playbackGeneration) return null;
        await _tts.setLanguage('zh-CN');
        await _tts.setSpeechRate(_speechRate);
        return _tts.speak(sentence);
      });
      final started = generation == _playbackGeneration && ttsResult == 1;
      if (!started && generation == _playbackGeneration) {
        debugPrint('[AudioService] On-device TTS did not start');
      }
      return started;
    } catch (e) {
      debugPrint('[AudioService] On-device TTS failed: $e');
      return false;
    }
  }

  /// Pre-fetches the upcoming sentence in the background to ensure zero gap during continuous reading.
  Future<void> prefetchSentence(String sentence, {String voiceName = 'Kore'}) async {
    if (!_isInitialized) await init();
    if (!_quotaService.hasQuotaRemaining) return;

    final azureVoice = _azureVoiceMap[voiceName] ?? _defaultAzureVoice;
    final hash = _hashText('$voiceName:$sentence');
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hash.mp3');
    final boundaryFile = File('${_cacheDir!.path}/tts_cache/$hash.json');

    if (await cacheFile.exists()) return;

    try {
      final result = await _fetchCloudTTS(sentence, azureVoice: azureVoice, cacheFile: cacheFile, boundaryFile: boundaryFile);
      if (result != null && result.success) {
        await _quotaService.recordSpeech(sentence);
      }
    } catch (_) {
      // Background pre-fetch failure is non-blocking
    }
  }

  /// Streams remote MP3 audio or plays bundled audio assets directly.
  /// Uses rootBundle extraction to local file cache + DeviceFileSource for 100% reliable iOS/Android playback.
  Future<bool> playStreamUrl(String url) async {
    if (!_isInitialized) await init();
    await stop();

    // Ensure AudioContext is configured safely for loudspeaker playback across platforms
    try {
      await _player.setAudioContext(AudioContext(
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: const {
            AVAudioSessionOptions.allowBluetooth,
            AVAudioSessionOptions.mixWithOthers,
          },
        ),
        android: const AudioContextAndroid(
          isSpeakerphoneOn: true,
          stayAwake: true,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
          audioFocus: AndroidAudioFocus.gain,
        ),
      ));
    } catch (e) {
      debugPrint("[AudioService] Warning: could not set audio context: $e");
    }

    try {
      await _player.setVolume(1.0);
    } catch (_) {}

    try {
      // 1. Handle bundled app asset files (asset:audio/... or assets/audio/...)
      if (url.startsWith('asset:') || url.startsWith('assets/')) {
        String cleanAssetPath = url.startsWith('asset:')
            ? 'assets/${url.substring(6)}'
            : (url.startsWith('assets/') ? url : 'assets/$url');

        // Extract filename for local caching
        final filename = cleanAssetPath.split('/').last;
        final cacheFile = File('${_cacheDir!.path}/audiobook_cache/$filename');
        await cacheFile.parent.create(recursive: true);

        if (!await cacheFile.exists() || (await cacheFile.length()) < 1024) {
          try {
            debugPrint('[AudioService] Extracting bundled asset: $cleanAssetPath');
            final byteData = await rootBundle.load(cleanAssetPath);
            final buffer = byteData.buffer;
            await cacheFile.writeAsBytes(
              buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
              flush: true,
            );
            debugPrint('[AudioService] Extracted ${cacheFile.lengthSync()} bytes to ${cacheFile.path}');
          } catch (e) {
            debugPrint("[AudioService] Failed to extract asset $cleanAssetPath to cache: $e");
            // Try secondary path without leading assets/
            try {
              final altPath = cleanAssetPath.replaceFirst('assets/', '');
              final byteData = await rootBundle.load(altPath);
              final buffer = byteData.buffer;
              await cacheFile.writeAsBytes(
                buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
                flush: true,
              );
              debugPrint('[AudioService] Extracted from alt path: $altPath');
            } catch (e2) {
              debugPrint("[AudioService] Secondary asset load failed: $e2");
            }
          }
        }

        if (await cacheFile.exists() && (await cacheFile.length()) > 1024) {
          debugPrint('[AudioService] Playing DeviceFileSource: ${cacheFile.path}');
          await _player.setPlaybackRate(1.0);
          await _player.play(DeviceFileSource(cacheFile.path));
          return true;
        }

        // Fallback: direct AssetSource
        final relPath = cleanAssetPath.startsWith('assets/') ? cleanAssetPath.substring(7) : cleanAssetPath;
        debugPrint('[AudioService] Direct AssetSource fallback: $relPath');
        await _player.setPlaybackRate(1.0);
        await _player.play(AssetSource(relPath));
        return true;
      }

      // 2. Handle remote URL streaming with local caching
      final hash = _hashText(url);
      final cacheFile = File('${_cacheDir!.path}/audiobook_cache/$hash.mp3');
      await cacheFile.parent.create(recursive: true);

      if (await cacheFile.exists() && (await cacheFile.length()) > 1024) {
        await _player.setPlaybackRate(1.0);
        await _player.play(DeviceFileSource(cacheFile.path));
        return true;
      }

      // Download via HttpClient with standard browser User-Agent
      final client = HttpClient();
      try {
        final req = await client.getUrl(Uri.parse(url));
        req.headers.set('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
        req.followRedirects = true;
        req.maxRedirects = 5;
        final resp = await req.close();
        if (resp.statusCode == 200) {
          final tempFile = File('${_cacheDir!.path}/audiobook_cache/${hash}_temp.mp3');
          final sink = tempFile.openWrite();
          await resp.pipe(sink);
          if (await tempFile.exists() && (await tempFile.length()) > 1024) {
            await tempFile.rename(cacheFile.path);
            await _player.setPlaybackRate(1.0);
            await _player.play(DeviceFileSource(cacheFile.path));
            return true;
          }
        }
      } finally {
        client.close();
      }

      // Fallback: direct UrlSource
      await _player.setPlaybackRate(1.0);
      await _player.play(UrlSource(url));
      return true;
    } catch (e) {
      debugPrint("Failed to stream audio from $url: $e");
      return false;
    }
  }

  Future<Uint8List?> getSentenceAudioBytes(String sentence, {String voiceName = 'Kore'}) async {
    if (!_isInitialized) await init();
    final azureVoice = _azureVoiceMap[voiceName] ?? _defaultAzureVoice;
    final hash = _hashText('$voiceName:$sentence');
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hash.mp3');
    
    if (await cacheFile.exists()) {
      return await cacheFile.readAsBytes();
    }
    
    // Try to fetch it
    final boundaryFile = File('${_cacheDir!.path}/tts_cache/$hash.json');
    final result = await _fetchCloudTTS(sentence, azureVoice: azureVoice, cacheFile: cacheFile, boundaryFile: boundaryFile);
    if (result != null && result.success) {
      return result.audio;
    }
    return null;
  }



  /// Plays an isolated tone syllable or native Hanzi exemplar with balanced natural pitch range (+18%)
  /// and gentle pacing (-8%) with SAPI phoneme guidance for crystal-clear onset consonants and natural vowels.
  Future<bool> playToneAudition(String textToSpeak, {String? pinyin, String? cacheKey}) async {
    if (!_isInitialized) await init();
    await stop();

    // Use stable Unicode-aware hash with tone_v4 prefix for natural balanced pitch auditions
    final hash = _hashText('tone_v4:$textToSpeak:${pinyin ?? ''}:${cacheKey ?? ''}');
    final cacheFile = File('${_cacheDir!.path}/tts_cache/tone_v4_$hash.mp3');
    if (await cacheFile.exists()) {
      try {
        await _player.play(DeviceFileSource(cacheFile.path));
        return true;
      } catch (e) {
        debugPrint("Failed to play cached tone audition for $textToSpeak: $e");
      }
    }

    String? sapiPhoneme;
    if (pinyin != null && pinyin.isNotEmpty) {
      final base = PinyinUtils.removeToneMarks(pinyin).trim().toLowerCase();
      final tone = PinyinUtils.getTone(pinyin);
      if (base.isNotEmpty && tone >= 1 && tone <= 5) {
        sapiPhoneme = '$base $tone';
      }
    }

    try {
      final result = await _fetchCloudTTS(
        textToSpeak,
        pitchRange: '+18%',
        rateAdjustment: -8,
        phoneme: sapiPhoneme,
        cacheFile: cacheFile,
      );
      if (result != null && result.audio.isNotEmpty) {
        await _player.play(DeviceFileSource(cacheFile.path));
        return true;
      }
    } catch (e) {
      debugPrint("Azure tone audition failed for $textToSpeak: $e");
    }

    // Fallback to standard TTS
    await _tts.speak(textToSpeak);
    return true;
  }

  /// Fetches premium TTS audio from Azure Cognitive Services via REST API.
  /// Uses audio-16khz-128kbitrate-mono-mp3 for highest Neural fidelity and rapid transfer.
  Future<CloudTtsResult?> _fetchCloudTTS(
    String text, {
    String azureVoice = 'zh-CN-XiaoxiaoNeural',
    String pitchRange = '+15%',
    int rateAdjustment = 0,
    String? phoneme,
    File? cacheFile,
    File? boundaryFile,
  }) async {
    final apiKey = _pool.azureSpeechKey;
    final region = _pool.azureSpeechRegion;
    if (apiKey.isEmpty || region.isEmpty || apiKey == 'MISSING_KEY') {
      debugPrint('[AudioService] Azure key missing, skipping cloud TTS');
      return null;
    }

    final safeText = text.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');
    final ratePercent = math.max(-50, math.min(200, ((_speechRate - 0.5) * 200).round() + rateAdjustment));
    final innerContent = (phoneme != null && phoneme.isNotEmpty)
        ? "<phoneme alphabet='sapi' ph='$phoneme'>$safeText</phoneme>"
        : safeText;

    // Use mstts:express-as for literary storytelling role & relaxed narration cadence
    final ssml = '''<speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xmlns:mstts='https://www.w3.org/2001/mstts' xml:lang='zh-CN'><voice name='$azureVoice'><mstts:express-as style='narration-relaxed' role='Narrator'><prosody rate='$ratePercent%' range='$pitchRange'>$innerContent</prosody></mstts:express-as></voice></speak>''';

    final uri = Uri.parse('https://$region.tts.speech.microsoft.com/cognitiveservices/v1');

    debugPrint('[AudioService] Requesting Azure Neural TTS ($azureVoice, narration-relaxed) for: $text');

    try {
      final client = http.Client();
      try {
        final response = await client
            .post(
              uri,
              headers: {
                'Ocp-Apim-Subscription-Key': apiKey,
                'Content-Type': 'application/ssml+xml; charset=utf-8',
                'X-Microsoft-OutputFormat': 'audio-16khz-128kbitrate-mono-mp3',
                'User-Agent': 'SinoSpark',
              },
              body: utf8.encode(ssml),
            )
            .timeout(const Duration(seconds: 10));

        debugPrint('[AudioService] Azure TTS response: ${response.statusCode} (${response.bodyBytes.length} bytes)');

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          final audio = response.bodyBytes;

          // Save to cache file
          final tmpFile = cacheFile ?? File('${_cacheDir!.path}/tts_cache/tmp_${DateTime.now().millisecondsSinceEpoch}.mp3');
          if (!await tmpFile.parent.exists()) {
            await tmpFile.parent.create(recursive: true);
          }
          await tmpFile.writeAsBytes(audio, flush: true);

          // REST API doesn't provide word boundaries; boundaries list stays empty
          _currentBoundaries = [];
          _currentBoundaryIndex = 0;

          return CloudTtsResult(
            audio: audio,
            boundaries: [],
            success: true,
          );
        } else {
          debugPrint('[AudioService] Azure TTS failed with status ${response.statusCode}: ${response.body}');
          return null;
        }
      } finally {
        client.close();
      }
    } on TimeoutException {
      debugPrint('[AudioService] Azure TTS request timed out (10s)');
      return null;
    } catch (e) {
      debugPrint('[AudioService] Azure TTS request error: $e');
      return null;
    }
  }
  Future<void> pause() async {
    await _player.pause();
    await _tts.pause();
  }

  Future<void> resume() async {
    await _player.resume();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Stream<Duration> get onPositionChanged => _player.onPositionChanged;
  Stream<Duration> get onDurationChanged => _player.onDurationChanged;
  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;

  Future<void> stop() async {
    ++_playbackGeneration;
    if (_isDisposed) return;
    await _runEngineOperation(_stopEngines);
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
    if (_isDisposed) return;
    _isDisposed = true;
    ++_playbackGeneration;
    _audioPlayer?.dispose();
    _fallbackTts?.stop();
    _wordBoundaryController.close();
    _completeController.close();
    _errorController.close();
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
