import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/ocr_service.dart';

class InteractiveImageOverlay extends StatelessWidget {
  final XFile image;
  final List<AiTextBlock> blocks;
  final Size imageSize;
  final Function(String text) onWordTapped;

  const InteractiveImageOverlay({
    super.key,
    required this.image,
    required this.blocks,
    required this.imageSize,
    required this.onWordTapped,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fittedSizes = applyBoxFit(BoxFit.contain, imageSize, constraints.biggest);
        final renderedSize = fittedSizes.destination;

        final scaleX = renderedSize.width / imageSize.width;
        final scaleY = renderedSize.height / imageSize.height;

        final offsetX = (constraints.maxWidth - renderedSize.width) / 2;
        final offsetY = (constraints.maxHeight - renderedSize.height) / 2;

        final interactiveWidgets = blocks.map((block) {
          return Positioned(
            left: block.x * scaleX + offsetX,
            top: block.y * scaleY + offsetY,
            width: block.width * scaleX,
            height: block.height * scaleY,
            child: GestureDetector(
              onTap: () => onWordTapped(block.text),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          );
        }).toList();

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(image.path),
              fit: BoxFit.contain,
            ),
            ...interactiveWidgets,
          ],
        );
      },
    );
  }
}
