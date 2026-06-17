import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

final digitalInkServiceProvider = Provider<DigitalInkService>((ref) {
  return DigitalInkService();
});

class DigitalInkService {
  final String _languageCode = 'zh-Hani';
  DigitalInkRecognizer? _recognizer;
  final DigitalInkRecognizerModelManager _modelManager = DigitalInkRecognizerModelManager();

  bool _isModelDownloaded = false;

  Future<void> initialize() async {
    _isModelDownloaded = await _modelManager.isModelDownloaded(_languageCode);
    if (!_isModelDownloaded) {
      await downloadModel();
    }
    _recognizer = DigitalInkRecognizer(languageCode: _languageCode);
  }

  Future<void> downloadModel() async {
    _isModelDownloaded = await _modelManager.downloadModel(_languageCode);
    if (_isModelDownloaded) {
      _recognizer = DigitalInkRecognizer(languageCode: _languageCode);
    }
  }

  bool get isModelDownloaded => _isModelDownloaded;

  Future<List<String>> recognizeStrokes(Ink ink) async {
    if (_recognizer == null || !_isModelDownloaded) {
      await initialize();
    }
    
    if (_recognizer == null) return [];

    try {
      final List<RecognitionCandidate> candidates = await _recognizer!.recognize(ink);
      return candidates.map((c) => c.text).toList();
    } catch (e) {
      print("Digital Ink Recognition Error: $e");
      return [];
    }
  }

  void dispose() {
    _recognizer?.close();
  }
}
