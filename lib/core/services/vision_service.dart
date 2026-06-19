import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final visionServiceProvider = Provider<VisionService>((ref) {
  final service = VisionService();
  ref.onDispose(() => service.dispose());
  return service;
});

class VisionService {
  bool _isInitialized = true;

  /// Processes a camera frame (XFile) and returns detected object names as Strings.
  /// Replaced InputImage with XFile since ML Kit is removed.
  Future<List<String>> processImage(XFile imageFile) async {
    if (!_isInitialized) {
      debugPrint("VisionService: Detector not initialized.");
      return [];
    }

    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) return [];

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final imageBytes = await File(imageFile.path).readAsBytes();
      final prompt = TextPart('Identify the single main object in this image. Reply with ONLY the English noun.');
      final imagePart = DataPart('image/jpeg', imageBytes);

      final response = await model.generateContent([
        Content.multi([prompt, imagePart])
      ]);

      final label = response.text?.trim() ?? "";
      if (label.isNotEmpty) {
        return [label];
      }
      return [];
    } catch (e) {
      debugPrint("VisionService (Gemini) Error: $e");
      return [];
    }
  }

  void dispose() {
    _isInitialized = false;
  }
}
