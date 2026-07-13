import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final speechServiceProvider = Provider<SpeechService>((ref) {
  return SpeechService();
});

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;

  Future<bool> init() async {
    if (_isInitialized) return true;
    _isInitialized = await _speechToText.initialize();
    return _isInitialized;
  }

  Future<void> startListening({
    required Function(String) onResult,
    Function(double)? onSoundLevel,
    String localeId = 'zh_CN',
    Duration listenFor = const Duration(seconds: 30),
    Duration pauseFor = const Duration(seconds: 1),
  }) async {
    if (!_isInitialized) await init();
    
    await _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          onResult(result.recognizedWords);
        }
      },
      onSoundLevelChange: onSoundLevel,
      localeId: localeId,
      listenOptions: SpeechListenOptions(
        partialResults: true,
      ),
      listenFor: listenFor,
      pauseFor: pauseFor,
    );
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  bool get isListening => _speechToText.isListening;
  
  void dispose() {
    _speechToText.stop();
  }
}
