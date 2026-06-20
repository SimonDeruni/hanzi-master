import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OcrService {
  final ImagePicker _picker = ImagePicker();

  /// Prompts the user to pick an image or take a photo, then extracts Chinese text using Gemini.
  Future<String?> scanImage({bool fromCamera = false}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 2000, 
        maxHeight: 2000,
      );

      if (image == null) return null; // User canceled

      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        debugPrint("OCR Error: Gemini API key is missing.");
        return null;
      }

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final imageBytes = await File(image.path).readAsBytes();
      final prompt = TextPart('Extract all Chinese characters from this image. Preserve sentences. Ignore non-Chinese text. Output ONLY the extracted Chinese text without any conversational formatting.');
      final imagePart = DataPart('image/jpeg', imageBytes);

      final response = await model.generateContent([
        Content.multi([prompt, imagePart])
      ]);

      return _extractChineseCharacters(response.text ?? "");
    } catch (e) {
      debugPrint("OCR Error (Gemini): $e");
      return null;
    }
  }

  /// Extracts Chinese text, keeping sentence structure intact.
  String _extractChineseCharacters(String text) {
    // Regex for basic Chinese characters AND basic Chinese punctuation
    final RegExp chineseRegex = RegExp(r'[\u4E00-\u9FFF\u3000-\u303F\uFF00-\uFFEF]+');
    final matches = chineseRegex.allMatches(text);
    
    // Join the blocks of Chinese text, preserving words and sentences
    return matches.map((m) => m.group(0)!).join(' ');
  }

  void dispose() {
    // No-op for Gemini
  }
}
