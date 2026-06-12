import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vision_provider.dart';
import '../widgets/object_radar_overlay.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import '../../../../shared/widgets/quick_look_sheet.dart';

/// The "Scholar's Eye" Vision Screen.
/// 
/// Provides a real-time camera view with an interactive ML radar overlay.
/// Users can tap detected objects to see their Chinese translation or
/// perform a "Deep Scan" using Gemini Pro Vision.
class VisionScreen extends ConsumerStatefulWidget {
  const VisionScreen({super.key});

  @override
  ConsumerState<VisionScreen> createState() => _VisionScreenState();
}

class _VisionScreenState extends ConsumerState<VisionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _brushController;

  @override
  void initState() {
    super.initState();
    _brushController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    // Initialize camera and vision services
    Future.microtask(() => ref.read(visionProvider.notifier).initialize());
  }

  @override
  void dispose() {
    _brushController.dispose();
    super.dispose();
  }

  void _handleDeepScan() async {
    if (_brushController.isAnimating) return;
    
    _brushController.repeat();
    
    final result = await ref.read(visionProvider.notifier).triggerDeepScan();
    
    _brushController.stop();
    _brushController.reset();

    if (result != null && mounted) {
      // Show result using QuickLookSheet if it provides enough context
      // For now, we just show a snackbar or log it, as Task 6 handles full integration
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Deep Scan Complete: Analysis received."),
          backgroundColor: Color(0xFF1A1A1B),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(visionProvider);
    const Color xuanPaper = Color(0xFFFDFCF0);
    const Color carbonInk = Color(0xFF1A1A1B);

    return Scaffold(
      backgroundColor: Colors.black, // Camera background
      body: Stack(
        children: [
          // 1. Camera Preview
          if (state.isCameraInitialized && state.cameraController != null)
            Center(
              child: CameraPreview(state.cameraController!),
            )
          else
            const Center(
              child: CircularProgressIndicator(color: xuanPaper),
            ),

          // 2. Xuan Texture Overlay (Subtle)
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Container(
                color: xuanPaper,
              ),
            ),
          ),

          // 3. Radar Overlay
          if (state.isCameraInitialized && state.cameraController != null)
            LayoutBuilder(
              builder: (context, constraints) {
                final previewSize = state.cameraController!.value.previewSize!;
                // ML Kit coordinates are often swapped on Android/iOS depending on orientation
                // For simplicity in this step, we assume standard portrait
                return ObjectRadarOverlay(
                  objects: state.detectedObjects,
                  previewSize: Size(previewSize.height, previewSize.width),
                  screenSize: Size(constraints.maxWidth, constraints.maxHeight),
                  onTap: (object) async {
                    final label = object.labels.isNotEmpty ? object.labels.first.text : "Object";
                    
                    // 1. Capture and Award Points
                    final isNew = await ref.read(visionProvider.notifier).captureObject(label);
                    
                    if (isNew && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Captured $label! +5 Ink Points"),
                          duration: const Duration(seconds: 2),
                          backgroundColor: carbonInk,
                        ),
                      );
                    }

                    // 2. Translate and Show Quick Look
                    if (mounted) {
                      try {
                        final flashcard = await ref.read(geminiServiceProvider).translateObject(label);
                        if (mounted) {
                          showQuickLook(context, flashcard.hanzi);
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Could not translate object.")),
                          );
                        }
                      }
                    }
                  },
                );
              },
            ),

          // 4. Interface Overlays
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: xuanPaper),
                        style: IconButton.styleFrom(
                          backgroundColor: carbonInk.withValues(alpha: 0.5),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: carbonInk.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.remove_red_eye, color: xuanPaper, size: 16),
                            SizedBox(width: 8),
                            Text(
                              "SCHOLAR'S EYE",
                              style: TextStyle(
                                color: xuanPaper,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Deep Scan Brush FAB
                  Center(
                    child: GestureDetector(
                      onTap: _handleDeepScan,
                      child: RotationTransition(
                        turns: _brushController,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: xuanPaper,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: carbonInk.withValues(alpha: 0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                            border: Border.all(
                              color: carbonInk,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.brush,
                                color: carbonInk,
                                size: 40,
                              ),
                              if (state.isDeepScanning)
                                const SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: CircularProgressIndicator(
                                    color: carbonInk,
                                    strokeWidth: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.isDeepScanning ? "INKING REALITY..." : "TAP TO DEEP SCAN",
                    style: const TextStyle(
                      color: xuanPaper,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(color: carbonInk, blurRadius: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          
          if (state.error != null)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
