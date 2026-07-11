import 'dart:io';
import 'package:image/image.dart' as img;

void main() async {
  final mockupPath = r'C:\Users\simon\Documents\sinospark_website\assets\mockup.png';
  final m = img.decodeImage(File(mockupPath).readAsBytesSync());
  if (m == null) return;
  
  // Center pixel color
  final cx = m.width ~/ 2;
  final cy = m.height ~/ 2;
  final centerPixel = m.getPixel(cx, cy);
  print('Center pixel: R=${centerPixel.r}, G=${centerPixel.g}, B=${centerPixel.b}');

  // Expand outwards to find bounds of this color
  int minX = cx, maxX = cx, minY = cy, maxY = cy;
  
  bool isSameColor(img.Pixel p) {
    // allow some tolerance for anti-aliasing
    return (p.r - centerPixel.r).abs() < 10 &&
           (p.g - centerPixel.g).abs() < 10 &&
           (p.b - centerPixel.b).abs() < 10;
  }

  // Left
  while (minX > 0 && isSameColor(m.getPixel(minX, cy))) minX--;
  // Right
  while (maxX < m.width - 1 && isSameColor(m.getPixel(maxX, cy))) maxX++;
  // Top
  while (minY > 0 && isSameColor(m.getPixel(cx, minY))) minY--;
  // Bottom
  while (maxY < m.height - 1 && isSameColor(m.getPixel(cx, maxY))) maxY++;

  print('Screen bounds (approx): X:$minX to $maxX, Y:$minY to $maxY');
  print('Width: ${maxX - minX}, Height: ${maxY - minY}');
}
