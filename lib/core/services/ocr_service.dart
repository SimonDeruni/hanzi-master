import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

class OcrService {
  final GeminiService geminiService;
  final ImagePicker _picker = ImagePicker();

  OcrService({required this.geminiService});

  /// Prompts the user to pick an image or take a photo, then extracts Chinese text via AI vision.
  Future<String?> scanImage({bool fromCamera = false}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 2000,
        maxHeight: 2000,
      );
      if (image == null) return null;
      return await processImageFile(image);
    } catch (e) {
      debugPrint("OCR Error: $e");
      return null;
    }
  }

  /// Extracts Chinese text from an existing XFile via AI vision.
  Future<String?> processImageFile(XFile file) async {
    return await processImageFileDetailed(file);
  }

  /// Prompts the user to pick an image or take a photo, then returns the image and extracted text.
  Future<({XFile image, String text})?> scanImageDetailed({bool fromCamera = false}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 2000,
        maxHeight: 2000,
      );
      if (image == null) return null;

      final text = await processImageFileDetailed(image);
      if (text == null) return null;

      return (image: image, text: text);
    } catch (e) {
      debugPrint("OCR Error: $e");
      return null;
    }
  }

  /// Processes an image and returns the extracted Chinese text via Gemini Vision.
  Future<String?> processImageFileDetailed(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      return await geminiService.extractTextFromImage(bytes);
    } catch (e) {
      debugPrint("OCR Error processing file detailed: $e");
      return null;
    }
  }
}
