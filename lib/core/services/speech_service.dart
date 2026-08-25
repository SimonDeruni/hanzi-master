import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final speechServiceProvider = Provider<SpeechService>((ref) {
  return SpeechService();
});

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  Function(String)? _onStatus;
  Function(String, bool)? _onError;

  Future<bool> init() async {
    if (_isInitialized) return true;
    _isInitialized = await _speechToText.initialize(
      onStatus: (status) => _onStatus?.call(status),
      onError: (error) => _onError?.call(error.errorMsg, error.permanent),
    );
    return _isInitialized;
  }

  /// Starts a recognition session and returns whether the recognizer really
  /// entered its listening state.
  ///
  /// [onResult] remains the final-result callback for backwards compatibility.
  /// Consumers that display live captions can use [onPartialResult].
  Future<bool> startListening({
    required Function(String) onResult,
    Function(String, double)? onResultWithConfidence,
    Function(String)? onPartialResult,
    Function(double)? onSoundLevel,
    Function(String)? onStatus,
    Function(String, bool)? onError,
    String localeId = 'zh_CN',
    Duration listenFor = const Duration(seconds: 60),
    Duration pauseFor = const Duration(seconds: 3),
  }) async {
    _onStatus = onStatus;
    _onError = onError;

    if (!_isInitialized && !await init()) {
      onError?.call('speech_recognition_unavailable', true);
      return false;
    }

    try {
      await _speechToText.listen(
        onResult: (result) {
          final words = result.recognizedWords.trim();
          final double confidence = result.hasConfidenceRating && result.confidence > 0 ? result.confidence : 0.88;
          if (result.finalResult) {
            onResultWithConfidence?.call(words, confidence);
            onResult(words);
          } else {
            onPartialResult?.call(words);
          }
        },
        onSoundLevelChange: onSoundLevel,
        localeId: localeId,
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
          partialResults: true,
          cancelOnError: false,
        ),
        listenFor: listenFor,
        pauseFor: pauseFor,
      );
      return _speechToText.isListening;
    } catch (error) {
      onError?.call(error.toString(), false);
      return false;
    }
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  Future<void> cancelListening() async {
    await _speechToText.cancel();
  }

  bool get isListening => _speechToText.isListening;

  void dispose() {
    _speechToText.stop();
  }
}
