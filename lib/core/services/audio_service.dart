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
import '../utils/pinyin_utils.dart';

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

  final StreamController<void> _completeController = StreamController.broadcast();
  Stream<void> get onPlayerComplete => _completeController.stream;

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
    if (!_isInitialized) await init();
    await stop();

    final azureVoice = _azureVoiceMap[voiceName] ?? _defaultAzureVoice;
    final hash = _hashText('$voiceName:$sentence');
    final cacheFile = File('${_cacheDir!.path}/tts_cache/$hash.mp3');
    final boundaryFile = File('${_cacheDir!.path}/tts_cache/$hash.json');
    
    await _player.setAudioContext(AudioContext(
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playAndRecord,
        options: const {
          AVAudioSessionOptions.defaultToSpeaker,
          AVAudioSessionOptions.allowBluetooth,
          AVAudioSessionOptions.mixWithOthers,
        },
      ),
      android: const AudioContextAndroid(
        isSpeakerphoneOn: true,
        stayAwake: true,
        contentType: AndroidContentType.speech,
        usageType: AndroidUsageType.voiceCommunication,
        audioFocus: AndroidAudioFocus.gainTransient,
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
      await _player.setPlaybackRate(1.0);
      await _player.play(DeviceFileSource(cacheFile.path));
      return true;
    }

    // Premium Cloud TTS with streaming (Azure Neural Audio)
    try {
      final result = await _fetchCloudTTS(sentence, azureVoice: azureVoice, cacheFile: cacheFile, boundaryFile: boundaryFile);
      if (result != null && result.success) {
        await _player.setPlaybackRate(1.0);
        await _player.play(DeviceFileSource(cacheFile.path));
        return true;
      }
    } catch (e) {
      debugPrint("Azure Neural TTS streaming failed for sentence: $e");
    }

    // Fallback: local TTS if Azure fails
    await _tts.setSpeechRate(0.5);
    final ttsResult = await _tts.speak(sentence);
    return ttsResult != null && ttsResult == 1;
  }

  /// Streams remote MP3 audio or plays bundled audio assets directly.
  /// Uses rootBundle extraction to local file cache + DeviceFileSource for 100% reliable iOS/Android playback.
  Future<bool> playStreamUrl(String url) async {
    if (!_isInitialized) await init();
    await stop();

    // Ensure AudioContext is configured for loudspeaker playback across platforms
    await _player.setAudioContext(AudioContext(
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: const {
          AVAudioSessionOptions.defaultToSpeaker,
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
    await _player.setVolume(1.0);

    try {
      // 1. Handle bundled app asset files (asset:audio/... or assets/audio/...)
      if (url.startsWith('asset:') || url.startsWith('assets/')) {
        String cleanAssetPath = url.startsWith('asset:')
            ? 'assets/${url.substring(6)}'
            : (url.startsWith('assets/') ? url : 'assets/$url');

        // Extract filename for local caching
        final filename = cleanAssetPath.split('/').last;
        final cacheFile = File('${_cacheDir!.path}/audiobook_cache/$filename');

        if (!await cacheFile.exists() || (await cacheFile.length()) < 1024) {
          try {
            final byteData = await rootBundle.load(cleanAssetPath);
            final buffer = byteData.buffer;
            await cacheFile.writeAsBytes(
              buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
              flush: true,
            );
          } catch (e) {
            debugPrint("Failed to extract asset $cleanAssetPath to cache: $e");
            // Try secondary path without leading assets/
            try {
              final altPath = cleanAssetPath.replaceFirst('assets/', '');
              final byteData = await rootBundle.load(altPath);
              final buffer = byteData.buffer;
              await cacheFile.writeAsBytes(
                buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
                flush: true,
              );
            } catch (e2) {
              debugPrint("Secondary asset load failed: $e2");
            }
          }
        }

        if (await cacheFile.exists() && (await cacheFile.length()) > 1024) {
          await _player.setPlaybackRate(1.0);
          await _player.play(DeviceFileSource(cacheFile.path));
          return true;
        }
      }

      // 2. Handle remote URL streaming with local caching
      final hash = _hashText(url);
      final cacheFile = File('${_cacheDir!.path}/audiobook_cache/$hash.mp3');

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
    final ssml = '''<speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xml:lang='zh-CN'><voice name='$azureVoice'><prosody rate='$ratePercent%' range='$pitchRange'>$innerContent</prosody></voice></speak>''';

    final uri = Uri.parse('https://$region.tts.speech.microsoft.com/cognitiveservices/v1');

    debugPrint('[AudioService] Requesting Azure Neural TTS ($azureVoice) for: $text');

    try {
      final client = http.Client();
      try {
        final response = await client
            .post(
              uri,
              headers: {
                'Ocp-Apim-Subscription-Key': apiKey,
                'Content-Type': 'application/ssml+xml',
                'X-Microsoft-OutputFormat': 'audio-16khz-128kbitrate-mono-mp3',
                'User-Agent': 'SinoSpark',
              },
              body: ssml,
            )
            .timeout(const Duration(seconds: 10));

        debugPrint('[AudioService] Azure TTS response: ${response.statusCode} (${response.bodyBytes.length} bytes)');

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          final audio = response.bodyBytes;

          // Save to cache file
          final tmpFile = cacheFile ?? File('${_cacheDir!.path}/tts_cache/tmp_${DateTime.now().millisecondsSinceEpoch}.mp3');
          await tmpFile.writeAsBytes(audio);

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
    _completeController.close();
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
