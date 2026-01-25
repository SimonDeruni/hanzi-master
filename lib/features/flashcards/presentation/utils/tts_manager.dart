import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  // Singleton pattern (so we only have one voice engine running)
  static final TtsManager _instance = TtsManager._internal();
  factory TtsManager() => _instance;
  TtsManager._internal();

  final FlutterTts _flutterTts = FlutterTts();

  // Initialize the engine
  Future<void> init() async {
    // Set language to Chinese (Simplified)
    await _flutterTts.setLanguage("zh-CN");
    
    // Set speed (0.5 is slower/clearer for learning, 1.0 is normal speed)
    await _flutterTts.setSpeechRate(0.5);
    
    // Set pitch (1.0 is normal)
    await _flutterTts.setPitch(1.0);
  }

  // Speak function
  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  // Stop speaking (useful when leaving the screen)
  Future<void> stop() async {
    await _flutterTts.stop();
  }
  // NEW: Update speed on the fly
  Future<void> setRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }
}