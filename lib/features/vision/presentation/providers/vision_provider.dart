import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/vision_service.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../features/progression/providers/progression_service.dart';

/// State for the Vision feature.
class VisionState extends Equatable {
  final List<String> detectedObjects;
  final Set<String> capturedLabels;
  final bool isDeepScanning;
  final CameraController? cameraController;
  final bool isCameraInitialized;
  final String? error;

  const VisionState({
    this.detectedObjects = const [],
    this.capturedLabels = const {},
    this.isDeepScanning = false,
    this.cameraController,
    this.isCameraInitialized = false,
    this.error,
  });

  VisionState copyWith({
    List<String>? detectedObjects,
    Set<String>? capturedLabels,
    bool? isDeepScanning,
    CameraController? cameraController,
    bool? isCameraInitialized,
    String? error,
  }) {
    return VisionState(
      detectedObjects: detectedObjects ?? this.detectedObjects,
      capturedLabels: capturedLabels ?? this.capturedLabels,
      isDeepScanning: isDeepScanning ?? this.isDeepScanning,
      cameraController: cameraController ?? this.cameraController,
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        detectedObjects,
        capturedLabels,
        isDeepScanning,
        cameraController,
        isCameraInitialized,
        error,
      ];
}

/// Notifier to manage vision state and camera logic.
class VisionNotifier extends StateNotifier<VisionState> {
  final VisionService _visionService;
  final GeminiService _geminiService;
  final Ref _ref;
  bool _isProcessing = false;

  VisionNotifier({
    required VisionService visionService,
    required GeminiService geminiService,
    required Ref ref,
  })  : _visionService = visionService,
        _geminiService = geminiService,
        _ref = ref,
        super(const VisionState());

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
        imageFormatGroup: ImageFormatGroup.yuv420,
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
    // Realtime object detection stream is disabled because ML Kit is removed.
    // We only use Deep Scan (triggerDeepScan) with Gemini now.
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
    state.cameraController?.dispose();
    super.dispose();
  }
}

/// Provider for VisionState.
final visionProvider = StateNotifierProvider<VisionNotifier, VisionState>((ref) {
  final visionService = ref.watch(visionServiceProvider);
  final geminiService = ref.watch(geminiServiceProvider);
  return VisionNotifier(
    visionService: visionService,
    geminiService: geminiService,
    ref: ref,
  );
});
