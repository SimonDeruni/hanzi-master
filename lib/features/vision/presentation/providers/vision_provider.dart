import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../../../core/services/vision_service.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../features/progression/providers/progression_service.dart';
import '../../../../features/flashcards/domain/entities/flashcard.dart';
import '../../../../core/services/character_lookup_service.dart';

/// A recognized Chinese text block from the live camera.
class RecognizedTextBlock {
  final String text;
  final List<CharacterInfo> characters;
  const RecognizedTextBlock({required this.text, required this.characters});
}

/// State for the Vision feature.
class VisionState extends Equatable {
  final List<DetectedObject> detectedObjects;
  final Set<String> capturedLabels;
  final Map<String, Flashcard> translationCache;
  final bool isDeepScanning;
  final CameraController? cameraController;
  final bool isCameraInitialized;
  final String? error;
  final List<RecognizedTextBlock> recognizedTextBlocks;

  const VisionState({
    this.detectedObjects = const [],
    this.capturedLabels = const {},
    this.translationCache = const {},
    this.isDeepScanning = false,
    this.cameraController,
    this.isCameraInitialized = false,
    this.error,
    this.recognizedTextBlocks = const [],
  });

  VisionState copyWith({
    List<DetectedObject>? detectedObjects,
    Set<String>? capturedLabels,
    Map<String, Flashcard>? translationCache,
    bool? isDeepScanning,
    CameraController? cameraController,
    bool? isCameraInitialized,
    String? error,
    List<RecognizedTextBlock>? recognizedTextBlocks,
  }) {
    return VisionState(
      detectedObjects: detectedObjects ?? this.detectedObjects,
      capturedLabels: capturedLabels ?? this.capturedLabels,
      translationCache: translationCache ?? this.translationCache,
      isDeepScanning: isDeepScanning ?? this.isDeepScanning,
      cameraController: cameraController ?? this.cameraController,
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
      error: error ?? this.error,
      recognizedTextBlocks: recognizedTextBlocks ?? this.recognizedTextBlocks,
    );
  }

  @override
  List<Object?> get props => [
        detectedObjects,
        capturedLabels,
        translationCache,
        isDeepScanning,
        cameraController,
        isCameraInitialized,
        error,
        recognizedTextBlocks,
      ];
}

/// Notifier to manage vision state and camera logic.
class VisionNotifier extends StateNotifier<VisionState> {
  final VisionService _visionService;
  final GeminiService _geminiService;
  final CharacterLookupService _lookupService;
  final Ref _ref;
  bool _isProcessing = false;
  // Throttle text recognition: run at most once per second
  DateTime _lastTextRecognition = DateTime(0);
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.chinese);

  VisionNotifier({
    required VisionService visionService,
    required GeminiService geminiService,
    required CharacterLookupService lookupService,
    required Ref ref,
  })  : _visionService = visionService,
        _geminiService = geminiService,
        _lookupService = lookupService,
        _ref = ref,
        super(const VisionState()) {
    // Initialize the lookup service in the background
    lookupService.init();
  }

  /// Records an object as "captured" and awards Ink Points if it's the first time.
  Future<bool> captureObject(String label) async {
    if (state.capturedLabels.contains(label)) return false;

    final newCaptured = Set<String>.from(state.capturedLabels)..add(label);
    state = state.copyWith(capturedLabels: newCaptured);

    // Award +5 Ink Points for the Scholar's Collection
    await _ref.read(progressionProvider.notifier).addInkPoints(5);
    return true;
  }

  /// Initializes the camera and starts the object detection stream.
  Future<void> initialize() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        state = state.copyWith(error: 'No cameras found');
        return;
      }

      // Use the back camera if available
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: defaultTargetPlatform == TargetPlatform.android 
            ? ImageFormatGroup.yuv420 
            : ImageFormatGroup.bgra8888,
      );

      await controller.initialize();
      
      state = state.copyWith(
        cameraController: controller,
        isCameraInitialized: true,
      );

      // Start image stream for real-time radar
      await controller.startImageStream(_processCameraImage);
    } catch (e) {
      state = state.copyWith(error: 'Camera initialization failed: $e');
    }
  }

  /// Processes frames from the camera stream.
  Future<void> _processCameraImage(CameraImage image) async {
    if (_isProcessing || state.isDeepScanning) return;
    _isProcessing = true;

    try {
      final inputImage = _convertCameraImage(image);
      if (inputImage == null) return;

      // Run object detection and (throttled) text recognition in parallel
      final now = DateTime.now();
      final shouldRunOcr = now.difference(_lastTextRecognition).inMilliseconds > 1000;

      final futures = <Future>[
        _visionService.processImage(inputImage),
        if (shouldRunOcr) _runTextRecognition(inputImage),
      ];
      final results = await Future.wait(futures);
      if (shouldRunOcr) _lastTextRecognition = now;

      final objects = results[0] as List<DetectedObject>;

      final currentCache = Map<String, Flashcard>.from(state.translationCache);
      bool cacheUpdated = false;

      for (final obj in objects) {
        for (final label in obj.labels) {
          final text = label.text;
          if (!currentCache.containsKey(text)) {
            currentCache[text] = Flashcard(hanzi: '...', pinyin: '...', definition: 'Loading...', id: 'temp_$text', hskLevel: 0, strokePaths: const [], modeStats: const {});
            cacheUpdated = true;
            _fetchTranslation(text);
          }
        }
      }

      state = state.copyWith(
        detectedObjects: objects,
        translationCache: cacheUpdated ? currentCache : null,
      );
    } catch (e) {
      debugPrint('Error processing camera image: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// Runs Chinese text recognition on a single frame and updates state.
  Future<void> _runTextRecognition(InputImage inputImage) async {
    try {
      final recognized = await _textRecognizer.processImage(inputImage);
      // Extract unique Chinese character blocks
      final chineseRegex = RegExp(r'[\u4E00-\u9FFF]{1,}');
      final blocks = <RecognizedTextBlock>[];
      final seen = <String>{};

      for (final block in recognized.blocks) {
        final matches = chineseRegex.allMatches(block.text);
        for (final match in matches) {
          final text = match.group(0)!;
          if (seen.contains(text) || text.length < 1) continue;
          seen.add(text);
          // Look up each character in the block
          final chars = await _lookupService.lookupAll(
            text.split('').where((c) => chineseRegex.hasMatch(c)),
          );
          if (chars.isNotEmpty) {
            blocks.add(RecognizedTextBlock(text: text, characters: chars));
          }
        }
      }

      if (mounted) {
        state = state.copyWith(recognizedTextBlocks: blocks);
      }
    } catch (e) {
      debugPrint('Text recognition error: $e');
    }
  }

  Future<void> _fetchTranslation(String label) async {
    try {
      final flashcard = await _geminiService.translateObject(label);
      final newCache = Map<String, Flashcard>.from(state.translationCache);
      newCache[label] = flashcard;
      state = state.copyWith(translationCache: newCache);
    } catch (e) {
      debugPrint('Error fetching translation for $label: $e');
      // On error, remove the placeholder so it can retry later
      final newCache = Map<String, Flashcard>.from(state.translationCache);
      newCache.remove(label);
      state = state.copyWith(translationCache: newCache);
    }
  }

  /// Converts CameraImage to InputImage for ML Kit.
  InputImage? _convertCameraImage(CameraImage image) {
    final camera = state.cameraController?.description;
    if (camera == null) return null;

    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (defaultTargetPlatform == TargetPlatform.android) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    }

    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (defaultTargetPlatform == TargetPlatform.android &&
            format != InputImageFormat.nv21 &&
            format != InputImageFormat.yuv420 &&
            format.name != 'yuv_420_888') ||
        (defaultTargetPlatform == TargetPlatform.iOS &&
            format != InputImageFormat.bgra8888)) {
      return null;
    }

    if (image.planes.isEmpty) return null;

    final BytesBuilder allBytes = BytesBuilder();
    for (final Plane plane in image.planes) {
      allBytes.add(plane.bytes);
    }
    final bytes = allBytes.takeBytes();

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
  }

  /// Triggers a Deep Scan using Gemini Pro Vision.
  Future<GeminiContext?> triggerDeepScan() async {
    final controller = state.cameraController;
    if (controller == null || !controller.value.isInitialized) return null;

    state = state.copyWith(isDeepScanning: true);
    
    try {
      // Pause detection during deep scan
      await controller.stopImageStream();
      
      final XFile photo = await controller.takePicture();
      final bytes = await photo.readAsBytes();
      
      final result = await _geminiService.analyzeImage(bytes);
      
      // Resume detection
      await controller.startImageStream(_processCameraImage);
      
      return result;
    } catch (e) {
      state = state.copyWith(error: 'Deep scan failed: $e');
      // Try to resume even if it failed
      try {
        await controller.startImageStream(_processCameraImage);
      } catch (_) {}
      return null;
    } finally {
      state = state.copyWith(isDeepScanning: false);
    }
  }

  @override
  void dispose() {
    _textRecognizer.close();
    state.cameraController?.dispose();
    super.dispose();
  }
}

/// Provider for VisionState.
final visionProvider = StateNotifierProvider.autoDispose<VisionNotifier, VisionState>((ref) {
  final visionService = ref.watch(visionServiceProvider);
  final geminiService = ref.watch(geminiServiceProvider);
  final lookupService = ref.watch(characterLookupServiceProvider);
  return VisionNotifier(
    visionService: visionService,
    geminiService: geminiService,
    lookupService: lookupService,
    ref: ref,
  );
});
