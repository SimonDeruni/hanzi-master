import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OcrService {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.chinese);
  final ImagePicker _picker = ImagePicker();

  /// Prompts the user to pick an image or take a photo, then extracts Chinese text.
  Future<String?> scanImage({bool fromCamera = false}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 2000, // Optimize for performance while keeping detail
        maxHeight: 2000,
      );

      if (image == null) return null; // User canceled

      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      
      // Filter the recognized text to only keep Chinese characters
      final extracted = _extractChineseCharacters(recognizedText.text);
      if (extracted.isEmpty && recognizedText.text.isNotEmpty) {
        return recognizedText.text; // Fallback to raw text if regex filters everything out
      }
      return extracted;
    } catch (e) {
      debugPrint("OCR Error: $e");
      return null;
    }
  }

  /// Extracts Chinese text, keeping sentence structure intact.
  String _extractChineseCharacters(String text) {
    // Regex for basic Chinese characters AND basic Chinese punctuation
    final RegExp chineseRegex = RegExp(r'[\u4E00-\u9FFF]+');
    final matches = chineseRegex.allMatches(text);
    
    // Join the blocks of Chinese text, preserving words and sentences
    return matches.map((m) => m.group(0)!).join('');
  }

  void dispose() {
    _textRecognizer.close();
  }
}
