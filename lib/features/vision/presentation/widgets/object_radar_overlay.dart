import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

/// Zen-style radar overlay for detected objects.
///
/// Draws floating labels and ink-style bounding boxes around detected objects
/// using the project's signature Xuan Paper (#FDFCF0) and Carbon Ink (#1A1A1B) aesthetic.
class ObjectRadarOverlay extends StatelessWidget {
  final List<DetectedObject> objects;
  final Size previewSize;
  final Size screenSize;
  final Function(DetectedObject) onTap;

  const ObjectRadarOverlay({
    super.key,
    required this.objects,
    required this.previewSize,
    required this.screenSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate scaling factors
    final double scaleX = screenSize.width / previewSize.width;
    final double scaleY = screenSize.height / previewSize.height;

    return Stack(
      children: objects.map((object) {
        final rect = _scaleRect(object.boundingBox, scaleX, scaleY);
        final label = object.labels.isNotEmpty ? object.labels.first.text : "Object";

        return Positioned(
          left: rect.left,
          top: rect.top,
          child: GestureDetector(
            onTap: () => onTap(object),
            child: _ZenObjectMarker(
              rect: rect,
              label: label,
            ),
          ),
        );
      }).toList(),
    );
  }

  Rect _scaleRect(Rect rect, double scaleX, double scaleY) {
    return Rect.fromLTRB(
      rect.left * scaleX,
      rect.top * scaleY,
      rect.right * scaleX,
      rect.bottom * scaleY,
    );
  }
}

class _ZenObjectMarker extends StatelessWidget {
  final Rect rect;
  final String label;

  const _ZenObjectMarker({
    required this.rect,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    const Color xuanPaper = Color(0xFFFDFCF0);
    const Color carbonInk = Color(0xFF1A1A1B);

    return SizedBox(
      width: rect.width,
      height: rect.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ink-style bounding box (thin, slightly transparent)
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: carbonInk.withValues(alpha: 0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          
          // Floating label
          Positioned(
            top: -30,
            left: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutQuart,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: xuanPaper,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: carbonInk.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: carbonInk.withValues(alpha: 0.1),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: carbonInk,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label.toUpperCase(),
                    style: const TextStyle(
                      color: carbonInk,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Connector line
          Positioned(
            top: -10,
            left: 10,
            child: Container(
              width: 1,
              height: 10,
              color: carbonInk.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
