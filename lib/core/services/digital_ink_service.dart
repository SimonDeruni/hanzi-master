import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final digitalInkServiceProvider = Provider<DigitalInkService>((ref) {
  return DigitalInkService();
});

class DigitalInkService {
  bool get isModelDownloaded => true; // Always ready

  Future<void> initialize() async {}
  Future<void> downloadModel() async {}

  Future<List<String>> recognizeStrokes(CustomInk ink) async {
    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) return [];

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      // We need to convert the ink to an image
      final imageBytes = await _inkToImage(ink);
      if (imageBytes == null) return [];

      final prompt = TextPart('Look at this handwritten Chinese character. What is it? Reply with ONLY the single Chinese character and nothing else.');
      final imagePart = DataPart('image/png', imageBytes);

      final response = await model.generateContent([
        Content.multi([prompt, imagePart])
      ]);

      final char = response.text?.trim() ?? "";
      if (char.isNotEmpty && char.length == 1) {
        return [char];
      }
      return [];
    } catch (e) {
      debugPrint("Digital Ink (Gemini) Error: $e");
      return [];
    }
  }

  Future<Uint8List?> _inkToImage(CustomInk ink) async {
    if (ink.strokes.isEmpty) return null;
    
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
      
    // Fill white background
    canvas.drawRect(const Rect.fromLTWH(0, 0, 500, 500), Paint()..color = Colors.white);
    
    for (final stroke in ink.strokes) {
      final path = Path();
      if (stroke.points.isNotEmpty) {
        path.moveTo(stroke.points.first.x, stroke.points.first.y);
        for (var i = 1; i < stroke.points.length; i++) {
          path.lineTo(stroke.points[i].x, stroke.points[i].y);
        }
      }
      canvas.drawPath(path, paint);
    }
    
    final picture = recorder.endRecording();
    final image = await picture.toImage(500, 500);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  void dispose() {}
}

class CustomStrokePoint {
  final double x;
  final double y;
  final int t;
  CustomStrokePoint({required this.x, required this.y, required this.t});
}

class CustomStroke {
  final List<CustomStrokePoint> points = [];
}

class CustomInk {
  final List<CustomStroke> strokes = [];
}
