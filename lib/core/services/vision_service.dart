import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

final visionServiceProvider = Provider<VisionService>((ref) {
  final service = VisionService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Vision Service handles local ML Kit Object Detection.
/// 
/// It acts as the "Scholar's Eye" radar, identifying physical objects
/// in the environment to connect them with Chinese flashcards.
class VisionService {
  late final ObjectDetector _objectDetector;
  bool _isInitialized = false;

  VisionService() {
    _initializeDetector();
  }

  void _initializeDetector() {
    // Mode: stream (optimized for camera feed)
    // Multiple: true (identify multiple objects at once)
    // Classification: true (identify what the object is)
    final options = ObjectDetectorOptions(
      mode: DetectionMode.stream,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);
    _isInitialized = true;
  }

  /// Processes a camera frame (InputImage) and returns detected objects.
  Future<List<DetectedObject>> processImage(InputImage inputImage) async {
    if (!_isInitialized) {
      debugPrint("VisionService: Detector not initialized.");
      return [];
    }

    try {
      final List<DetectedObject> objects = await _objectDetector.processImage(inputImage);
      return objects;
    } catch (e) {
      debugPrint("VisionService: Error processing image: $e");
      return [];
    }
  }

  /// Releases resources when the service is no longer needed.
  void dispose() {
    _objectDetector.close();
    _isInitialized = false;
  }
}
