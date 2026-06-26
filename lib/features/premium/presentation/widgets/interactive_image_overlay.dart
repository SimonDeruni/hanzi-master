import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class InteractiveImageOverlay extends StatelessWidget {
  final XFile image;
  final RecognizedText recognizedText;
  final Size imageSize;
  final Function(String text) onWordTapped;

  const InteractiveImageOverlay({
    super.key,
    required this.image,
    required this.recognizedText,
    required this.imageSize,
    required this.onWordTapped,
  });

  bool _isChinese(String text) {
    return RegExp(r'[\u4E00-\u9FFF]+').hasMatch(text);
  }

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

        final interactiveWidgets = <Widget>[];

        for (final block in recognizedText.blocks) {
          for (final line in block.lines) {
            for (final element in line.elements) {
              if (_isChinese(element.text)) {
                final rect = element.boundingBox;
                interactiveWidgets.add(
                  Positioned(
                    left: rect.left * scaleX + offsetX,
                    top: rect.top * scaleY + offsetY,
                    width: rect.width * scaleX,
                    height: rect.height * scaleY,
                    child: GestureDetector(
                      onTap: () => onWordTapped(element.text),
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
                  ),
                );
              }
            }
          }
        }

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
