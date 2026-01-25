import 'dart:ui';
import 'package:vector_math/vector_math_64.dart';
import 'package:path_drawing/path_drawing.dart';

/// Service responsible for parsing SVG strings into Flutter Path objects
/// and handling coordinate normalization.
class CharacterLoader {
  /// Parses a list of SVG path strings into a list of Flutter Paths.
  /// 
  /// Normalizes coordinates to a 1000x1000 space (Y-down).
  static List<Path> parseStrokes(List<String> svgPaths, {bool normalize = true, bool autoCenter = false}) {
    if (svgPaths.isEmpty) return [];

    List<Path> paths = [];
    for (final svg in svgPaths) {
      if (svg == '__CHAR_SEPARATOR__') {
        paths.add(Path());
        continue;
      }
      
      try {
        Path path = parseSvgPathData(svg);
        if (normalize) {
          path = _flipAndScalePath(path);
        }
        paths.add(path);
      } catch (e) {
        paths.add(Path());
      }
    }

    // Centering is now handled by the UI layer for better touch alignment control
    return paths;
  }

  /// Initial flip and scale to 1000x1000 space (Flutter coordinate system)
  static Path _flipAndScalePath(Path path) {
    const double standardSize = 1024.0;
    const double targetSize = 1000.0;
    const double scale = targetSize / standardSize;
    
    final Matrix4 matrix = Matrix4.identity();
    // Hanzi Writer is Y-up, Flutter is Y-down.
    matrix.translate(0.0, targetSize); 
    matrix.scaleByDouble(scale, -scale, 1.0, 1.0);
    
    return path.transform(matrix.storage);
  }
}
