import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

class AiTextBlock {
  final String text;
  final double x;
  final double y;
  final double width;
  final double height;

  AiTextBlock({required this.text, required this.x, required this.y, required this.width, required this.height});

  factory AiTextBlock.fromJson(Map<String, dynamic> json) {
    return AiTextBlock(
      text: json['text'] as String? ?? '',
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0,
    );
  }

  bool get isValid => text.isNotEmpty && width > 0 && height > 0;

  /// Clamp coordinates to stay within image bounds.
  AiTextBlock clampTo(double imageWidth, double imageHeight) {
    return AiTextBlock(
      text: text,
      x: x.clamp(0, imageWidth - 1),
      y: y.clamp(0, imageHeight - 1),
      width: width.clamp(1, imageWidth - x),
      height: height.clamp(1, imageHeight - y),
    );
  }
}

class OcrResult {
  final XFile image;
  final String text;
  final List<AiTextBlock> blocks;

  OcrResult({required this.image, required this.text, this.blocks = const []});
}

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
    final result = await processImageFileDetailed(file);
    return result?.text;
  }

  /// Prompts the user to pick an image or take a photo, then returns the image, extracted text, and text blocks.
  Future<OcrResult?> scanImageDetailed({bool fromCamera = false}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 2000,
        maxHeight: 2000,
      );
      if (image == null) return null;

      final result = await processImageFileDetailed(image);
      if (result == null) return null;

      return OcrResult(image: image, text: result.text, blocks: result.blocks);
    } catch (e) {
      debugPrint("OCR Error: $e");
      return null;
    }
  }

  /// Processes an image and returns the extracted Chinese text with bounding boxes via Gemini Vision.
  Future<({String text, List<AiTextBlock> blocks})?> processImageFileDetailed(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      final decodedImage = await decodeImageFromList(bytes);
      final imageWidth = decodedImage.width.toDouble();
      final imageHeight = decodedImage.height.toDouble();

      final result = await geminiService.extractTextFromImageDetailed(bytes);

      final blocks = result.blocks
          .map((b) => AiTextBlock.fromJson(b).clampTo(imageWidth, imageHeight))
          .where((b) => b.isValid)
          .toList();

      return (text: result.fullText, blocks: blocks);
    } catch (e) {
      debugPrint("OCR Error processing file detailed: $e");
      return null;
    }
  }
}
