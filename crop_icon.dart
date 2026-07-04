import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final file = File('assets/icon/icon.png');
  final bytes = file.readAsBytesSync();
  final image = img.decodeImage(bytes);
  
  if (image == null) {
    print('Failed to decode image');
    return;
  }
  
  // The icon in the image is a yellow square with rounded corners.
  // The background is likely transparent (alpha=0) or white.
  // Let's find the true bounds of the non-transparent/non-white part.
  int minX = image.width;
  int minY = image.height;
  int maxX = 0;
  int maxY = 0;
  
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);
      
      // Check if it's not transparent AND not pure white
      if (pixel.a > 10 && (pixel.r < 250 || pixel.g < 250 || pixel.b < 250)) {
        if (x < minX) minX = x;
        if (x > maxX) maxX = x;
        if (y < minY) minY = y;
        if (y > maxY) maxY = y;
      }
    }
  }
  
  if (minX >= maxX || minY >= maxY) {
    print('Could not find bounds');
    return;
  }
  
  // Slightly adjust to be safe
  minX = (minX + 5).clamp(0, image.width);
  minY = (minY + 5).clamp(0, image.height);
  maxX = (maxX - 5).clamp(0, image.width);
  maxY = (maxY - 5).clamp(0, image.height);
  
  print('Cropping from ($minX, $minY) to ($maxX, $maxY)');
  
  // Make the bounding box square
  int width = maxX - minX;
  int height = maxY - minY;
  int size = width > height ? width : height;
  
  // Adjust minX and minY to center the square
  int targetMinX = minX - ((size - width) ~/ 2);
  int targetMinY = minY - ((size - height) ~/ 2);
  
  final cropped = img.copyCrop(image, x: targetMinX, y: targetMinY, width: size, height: size);
  
  // Resize back to 1024x1024 to ensure high quality
  final resized = img.copyResize(cropped, width: 1024, height: 1024, interpolation: img.Interpolation.cubic);
  
  File('assets/icon/icon.png').writeAsBytesSync(img.encodePng(resized));
  print('Success!');
}
