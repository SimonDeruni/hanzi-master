import 'dart:io';
import 'package:image/image.dart' as img;

void main() async {
  const mockupPath = r'C:\Users\simon\Documents\sinospark_website\assets\mockup.png';
  const clipboardPath = r'C:\Users\simon\Documents\sinospark_website\assets\clipboard_image.png';
  const outPath = r'C:\Users\simon\Documents\sinospark_website\assets\mockup_updated.png';

  final mockupFile = File(mockupPath);
  final clipboardFile = File(clipboardPath);

  final mockup = img.decodeImage(mockupFile.readAsBytesSync());
  if (mockup == null) { print("Failed to decode mockup"); return; }
  
  final screenshot = img.decodeImage(clipboardFile.readAsBytesSync());
  if (screenshot == null) { print("Failed to decode screenshot"); return; }

  print('Mockup size: ${mockup.width}x${mockup.height}');
  print('Screenshot size: ${screenshot.width}x${screenshot.height}');

  // Find bounding box of transparent pixels
  int minX = mockup.width, minY = mockup.height, maxX = 0, maxY = 0;
  for (int y = 0; y < mockup.height; y++) {
    for (int x = 0; x < mockup.width; x++) {
      final pixel = mockup.getPixel(x, y);
      if (pixel.a < 255) { // Any transparency
        if (x < minX) minX = x;
        if (x > maxX) maxX = x;
        if (y < minY) minY = y;
        if (y > maxY) maxY = y;
      }
    }
  }

  print('Transparent bbox: $minX, $minY to $maxX, $maxY');
  print('Width: ${maxX - minX}, Height: ${maxY - minY}');
  
  if (maxX <= minX || maxY <= minY) {
    print('No transparent area found in mockup!');
    return;
  }

  // Scale the screenshot to fit exactly in the transparent area
  final scaledScreenshot = img.copyResize(
    screenshot, 
    width: maxX - minX + 1, 
    height: maxY - minY + 1,
    interpolation: img.Interpolation.linear
  );

  // We want the screenshot to be BEHIND the mockup.
  // The simplest way is to create a new image, draw the screenshot at the hole position,
  // and then composite the mockup over it.
  final finalImage = img.Image(width: mockup.width, height: mockup.height);
  
  // Fill with white or transparent? Let's just draw the screenshot
  img.compositeImage(finalImage, scaledScreenshot, dstX: minX, dstY: minY);
  
  // Overlay mockup
  img.compositeImage(finalImage, mockup);

  File(outPath).writeAsBytesSync(img.encodePng(finalImage));
  print('Successfully created $outPath');
}
