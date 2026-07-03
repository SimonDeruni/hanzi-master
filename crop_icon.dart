import 'dart:io';
import 'package:image/image.dart';

void main() {
  final file = File('assets/icon/icon.png');
  final bytes = file.readAsBytesSync();
  final img = decodeImage(bytes)!;

  // Find bounding box of non-transparent AND non-white pixels
  int minX = img.width;
  int minY = img.height;
  int maxX = 0;
  int maxY = 0;

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      final pixel = img.getPixel(x, y);
      // Check for transparency or solid white/near-white
      bool isTransparent = pixel.a < 10;
      bool isWhite = pixel.r > 250 && pixel.g > 250 && pixel.b > 250;
      
      if (!isTransparent && !isWhite) {
        if (x < minX) minX = x;
        if (x > maxX) maxX = x;
        if (y < minY) minY = y;
        if (y > maxY) maxY = y;
      }
    }
  }

  // Calculate size and center
  int cropWidth = maxX - minX;
  int cropHeight = maxY - minY;
  
  // Adaptive icons have a safe zone of 66px out of 108px (approx 60% of total size)
  // Let's make the content fill about 60% of the new image
  int contentSize = cropWidth > cropHeight ? cropWidth : cropHeight;
  int totalSize = (contentSize / 0.6).round();
  
  final newImg = Image(width: totalSize, height: totalSize);
  
  // Fill with transparent or white depending on needs
  // For foreground, we should use transparent
  
  int offsetX = (totalSize - cropWidth) ~/ 2 - minX;
  int offsetY = (totalSize - cropHeight) ~/ 2 - minY;

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int newX = x + offsetX;
      int newY = y + offsetY;
      if (newX >= 0 && newX < totalSize && newY >= 0 && newY < totalSize) {
        final p = img.getPixel(x, y);
        // Copy pixel but make white transparent if it's the background
        if (p.r > 250 && p.g > 250 && p.b > 250) {
           newImg.setPixel(newX, newY, ColorUint8.rgba(0, 0, 0, 0));
        } else {
           newImg.setPixel(newX, newY, p);
        }
      }
    }
  }

  File('assets/icon/icon_foreground.png').writeAsBytesSync(encodePng(newImg));
  print('Done creating icon_foreground.png');
}
