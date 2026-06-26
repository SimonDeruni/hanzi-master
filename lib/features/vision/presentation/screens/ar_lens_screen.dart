import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

import '../providers/vision_provider.dart';
import '../widgets/ar_bounding_box_painter.dart';
import '../../../../core/services/character_lookup_service.dart';

class ARLensScreen extends ConsumerStatefulWidget {
  const ARLensScreen({super.key});

  @override
  ConsumerState<ARLensScreen> createState() => _ARLensScreenState();
}

class _ARLensScreenState extends ConsumerState<ARLensScreen> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(visionProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visionState = ref.watch(visionProvider);
    final l10n = AppLocalizations.of(context)!;
    final hasText = visionState.recognizedTextBlocks.isNotEmpty;
    final hasObjects = visionState.detectedObjects.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Camera Preview ──────────────────────────────────────────
          if (visionState.isCameraInitialized && visionState.cameraController != null)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: 1000,
                  height: 1000 / visionState.cameraController!.value.aspectRatio,
                  child: CameraPreview(visionState.cameraController!),
                ),
              ),
            ),

          // ── Object Bounding Box Overlay ──────────────────────────────
          if (visionState.isCameraInitialized && visionState.cameraController != null)
            Builder(
              builder: (context) {
                final controller = visionState.cameraController!;
                final imageSize = Size(
                  controller.value.previewSize?.width ?? 1,
                  controller.value.previewSize?.height ?? 1,
                );
                InputImageRotation rotation = InputImageRotation.rotation0deg;
                final sensorOrientation = controller.description.sensorOrientation;
                final rawRotation = InputImageRotationValue.fromRawValue(sensorOrientation);
                if (rawRotation != null) rotation = rawRotation;

                return CustomPaint(
                  painter: ARBoundingBoxPainter(
                    visionState.detectedObjects,
                    visionState.translationCache,
                    imageSize,
                    rotation,
                  ),
                );
              },
            ),

          // ── Loading / Error states ───────────────────────────────────
          if (!visionState.isCameraInitialized && visionState.error == null)
            const Center(child: CircularProgressIndicator(color: Color(0xFFFDFCF0))),

          if (visionState.error != null)
            Center(
              child: Text(visionState.error!, style: const TextStyle(color: Colors.red, fontSize: 16)),
            ),

          // ── Top bar ─────────────────────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            right: 16,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 1))]),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                // Mode indicators
                if (hasObjects)
                  _ModeBadge(icon: Icons.category_outlined, label: l10n.arLensObjects, color: Colors.blue),
                const SizedBox(width: 8),
                if (hasText)
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (_, __) => Opacity(
                      opacity: _pulseAnimation.value,
                      child: _ModeBadge(icon: Icons.text_fields, label: l10n.arLensText, color: const Color(0xFFF59E0B)),
                    ),
                  ),
              ],
            ),
          ),

          // ── Bottom: instruction OR live text panel ───────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: hasText
                  ? _LiveTextPanel(
                      key: const ValueKey('panel'),
                      blocks: visionState.recognizedTextBlocks,
                      theme: Theme.of(context),
                      l10n: l10n,
                    )
                  : Padding(
                      key: const ValueKey('hint'),
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 40),
                      child: Text(
                        l10n.pointYourCameraAt,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          shadows: [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(0, 1))],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mode badge widget ──────────────────────────────────────────────────────
class _ModeBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ModeBadge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ── Live text scrollable panel ─────────────────────────────────────────────
class _LiveTextPanel extends StatelessWidget {
  final List<RecognizedTextBlock> blocks;
  final ThemeData theme;
  final AppLocalizations l10n;

  const _LiveTextPanel({super.key, required this.blocks, required this.theme, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.85),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: const Color(0xFFF59E0B).withValues(alpha: 0.4))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle + title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.text_fields, color: Color(0xFFF59E0B), size: 18),
                const SizedBox(width: 8),
                Text(l10n.arLensDetectedText, style: const TextStyle(color: Color(0xFFF59E0B), fontWeight: FontWeight.bold, fontSize: 14)),
                const Spacer(),
                Text('${blocks.length}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          // Character list
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: blocks.length,
              itemBuilder: (context, i) {
                final block = blocks[i];
                return _TextBlockRow(block: block, theme: theme, l10n: l10n);
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }
}

// ── Single detected text block row ────────────────────────────────────────
class _TextBlockRow extends StatelessWidget {
  final RecognizedTextBlock block;
  final ThemeData theme;
  final AppLocalizations l10n;
  const _TextBlockRow({required this.block, required this.theme, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full scanned text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
            ),
            child: Text(
              block.text,
              style: const TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'NotoSansSC', fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          // Character-by-character breakdown
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: block.characters.map((info) {
                return GestureDetector(
                  onTap: () => _showCharDetail(context, info),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(info.pinyin, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                      Text(info.hanzi, style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'NotoSansSC')),
                      if (info.hskLevel > 0)
                        Text('HSK${info.hskLevel}', style: const TextStyle(color: Color(0xFFF59E0B), fontSize: 9)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showCharDetail(BuildContext context, CharacterInfo info) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF1A1A1B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(info.hanzi,
                  style: const TextStyle(fontSize: 72, fontFamily: 'NotoSansSC', color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(info.pinyin, style: const TextStyle(color: Color(0xFFF59E0B), fontSize: 20)),
              const SizedBox(height: 12),
              if (info.hskLevel > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.4)),
                  ),
                  child: Text('HSK ${info.hskLevel}',
                      style: const TextStyle(color: Color(0xFFF59E0B), fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              const SizedBox(height: 16),
              Text(info.definition,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5)),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l10n.gotIt, style: const TextStyle(color: Color(0xFFF59E0B))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
