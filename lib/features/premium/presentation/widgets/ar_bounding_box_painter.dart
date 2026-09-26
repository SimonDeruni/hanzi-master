import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import '../../../../features/flashcards/domain/entities/flashcard.dart';

class ARBoundingBoxPainter extends CustomPainter {
  final List<DetectedObject> detectedObjects;
  final Map<String, Flashcard> translationCache;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  ARBoundingBoxPainter(
    this.detectedObjects,
    this.translationCache,
    this.absoluteImageSize,
    this.rotation,
  );

  @override
  void paint(Canvas canvas, Size size) {
    if (absoluteImageSize == Size.zero) return;

    // Depending on orientation, swap width and height for scaling
    final bool isPortrait = rotation == InputImageRotation.rotation90deg || rotation == InputImageRotation.rotation270deg;
    
    final double imageWidth = isPortrait ? absoluteImageSize.height : absoluteImageSize.width;
    final double imageHeight = isPortrait ? absoluteImageSize.width : absoluteImageSize.height;
    
    final double scaleX = size.width / imageWidth;
    final double scaleY = size.height / imageHeight;

    final Paint boxPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = const Color(0xFFFDFCF0).withValues(alpha: 0.8);

    final Paint glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..color = const Color(0xFFFDFCF0).withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    for (final DetectedObject object in detectedObjects) {
      if (object.labels.isEmpty) continue;

      // Extract bounding box
      final rect = scaleRect(
        rect: object.boundingBox,
        imageSize: absoluteImageSize,
        widgetSize: size,
        scaleX: scaleX,
        scaleY: scaleY,
        rotation: rotation,
      );

      // Draw the box
      canvas.drawRect(rect, glowPaint);
      canvas.drawRect(rect, boxPaint);

      // Draw labels
      final String englishLabel = object.labels.first.text;
      final Flashcard? translation = translationCache[englishLabel];

      String displayTitle = englishLabel;
      String displaySubtitle = '';

      if (translation != null) {
        displayTitle = translation.hanzi;
        displaySubtitle = "${translation.pinyin}\n${translation.definition}";
        if (translation.definition == 'Loading...') {
          displaySubtitle = "Translating...";
        }
      }

      _drawTextBadge(
        canvas,
        rect,
        title: displayTitle,
        subtitle: displaySubtitle,
      );
    }
  }

  static Rect scaleRect({
    required Rect rect,
    required Size imageSize,
    required Size widgetSize,
    required double scaleX,
    required double scaleY,
    required InputImageRotation rotation,
  }) {
    // When using CameraPlugin, the raw image might be landscape but the preview is portrait.
    // The InputImage converts it based on orientation, but the bounding box is relative to the *unrotated* image.
    double left, top, right, bottom;

    switch (rotation) {
      case InputImageRotation.rotation90deg:
        left = rect.top;
        top = imageSize.height - rect.right;
        right = rect.bottom;
        bottom = imageSize.height - rect.left;
        break;
      case InputImageRotation.rotation270deg:
        left = imageSize.width - rect.bottom;
        top = rect.left;
        right = imageSize.width - rect.top;
        bottom = rect.right;
        break;
      case InputImageRotation.rotation180deg:
        left = imageSize.width - rect.right;
        top = imageSize.height - rect.bottom;
        right = imageSize.width - rect.left;
        bottom = imageSize.height - rect.top;
        break;
      default:
        left = rect.left;
        top = rect.top;
        right = rect.right;
        bottom = rect.bottom;
        break;
    }

    return Rect.fromLTRB(
      left * scaleX,
      top * scaleY,
      right * scaleX,
      bottom * scaleY,
    ).intersect(Rect.fromLTWH(0, 0, widgetSize.width, widgetSize.height));
  }

  void _drawTextBadge(Canvas canvas, Rect box, {required String title, required String subtitle}) {
    final textPainterTitle = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: Color(0xFF1A1A1B),
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'NotoSerifSC',
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    final textPainterSubtitle = TextPainter(
      text: TextSpan(
        text: subtitle,
        style: const TextStyle(
          color: Color(0xFF1A1A1B),
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainterTitle.layout();
    textPainterSubtitle.layout();

    final double badgeWidth = (textPainterTitle.width > textPainterSubtitle.width 
        ? textPainterTitle.width 
        : textPainterSubtitle.width) + 16.0;
    
    final double badgeHeight = textPainterTitle.height + (subtitle.isNotEmpty ? textPainterSubtitle.height + 4.0 : 0) + 16.0;

    final canvasBounds = canvas.getLocalClipBounds();

    // Vertical anchoring: prefer above, flip below if it would overflow top
    final double preferredTop = box.top - badgeHeight - 8.0;
    final double badgeTop = preferredTop < canvasBounds.top
        ? box.bottom + 8.0
        : preferredTop;

    // Horizontal anchoring with right-edge collision detection
    // Default: align badge left edge with box left edge
    double badgeLeft = box.left;

    // If badge overflows right screen edge, anchor from the right side of the box
    if (badgeLeft + badgeWidth > canvasBounds.width) {
      badgeLeft = box.right - badgeWidth;
    }

    // Final clamp to ensure badge stays fully within screen bounds
    badgeLeft = badgeLeft.clamp(canvasBounds.left, canvasBounds.width - badgeWidth);

    final Rect badgeRect = Rect.fromLTWH(
      badgeLeft,
      badgeTop.clamp(canvasBounds.top, canvasBounds.height - badgeHeight),
      badgeWidth,
      badgeHeight,
    );

    final RRect rBadgeRect = RRect.fromRectAndRadius(badgeRect, const Radius.circular(8.0));

    final Paint bgPaint = Paint()
      ..color = const Color(0xFFFDFCF0).withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
      
    final Paint borderPaint = Paint()
      ..color = const Color(0xFF1A1A1B).withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawRRect(rBadgeRect, bgPaint);
    canvas.drawRRect(rBadgeRect, borderPaint);

    textPainterTitle.paint(canvas, Offset(badgeRect.left + 8.0, badgeRect.top + 8.0));
    if (subtitle.isNotEmpty) {
      textPainterSubtitle.paint(canvas, Offset(badgeRect.left + 8.0, badgeRect.top + 8.0 + textPainterTitle.height + 4.0));
    }
  }

  @override
  bool shouldRepaint(covariant ARBoundingBoxPainter oldDelegate) {
    return oldDelegate.detectedObjects != detectedObjects || 
           oldDelegate.translationCache != translationCache;
  }
}
