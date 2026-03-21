import 'dart:ui';
import 'package:vector_math/vector_math_64.dart';
import 'package:path_drawing/path_drawing.dart';

/// Service responsible for parsing SVG strings into Flutter Path objects
/// and handling coordinate normalization.
class CharacterLoader {
  /// Parses a list of SVG path strings into a list of Flutter Paths.
  /// 
  /// Normalizes coordinates to a 1000x1000 space and optionally centers the character.
  static List<Path> parseStrokes(List<String> svgPaths, {bool normalize = true, bool autoCenter = false}) {
    if (svgPaths.isEmpty) return [];

    // 1. Parse all strokes into raw paths and apply the Y-flip/Scale
    List<Path> paths = [];
    for (final svg in svgPaths) {
      if (svg == '__CHAR_SEPARATOR__') {
        paths.add(Path()); // Keep separator placeholder
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

    if (!normalize || !autoCenter) return paths;

    // 2. Perform Auto-Centering for each character group
    return _centerPathGroups(paths);
  }

  /// Initial flip and scale to 1000x1000 space
  static Path _flipAndScalePath(Path path) {
    const double standardSize = 1024.0;
    const double targetSize = 1000.0;
    const double scale = targetSize / standardSize;
    
    final Matrix4 matrix = Matrix4.identity();
    matrix.translate(0.0, targetSize); 
    matrix.scaleByDouble(scale, -scale, 1.0, 1.0);
    
    return path.transform(matrix.storage);
  }

  /// Centers groups of paths (characters) independently within the 1000x1000 space
  static List<Path> _centerPathGroups(List<Path> allPaths) {
    List<Path> centeredPaths = List.from(allPaths);
    int startIndex = 0;

    for (int i = 0; i <= allPaths.length; i++) {
      // If we hit a separator or the end, center the previous group
      if (i == allPaths.length || _isSeparator(allPaths[i])) {
        if (startIndex < i) {
          _centerRange(centeredPaths, startIndex, i);
        }
        startIndex = i + 1;
      }
    }
    return centeredPaths;
  }

  static bool _isSeparator(Path path) {
    // In our logic, separators are empty paths. 
    // But since valid dots might be small, we check if the bounds are absolutely zero.
    return path.getBounds().isEmpty;
  }

  static void _centerRange(List<Path> paths, int start, int end) {
    // 1. Calculate bounding box of the whole character
    Rect totalBounds = Rect.zero;
    bool first = true;
    for (int i = start; i < end; i++) {
      final b = paths[i].getBounds();
      if (b.isEmpty) continue;
      if (first) {
        totalBounds = b;
        first = false;
      } else {
        totalBounds = totalBounds.expandToInclude(b);
      }
    }

    if (totalBounds.isEmpty) return;

    // 2. Calculate shift to center it at (500, 400) - biased UPWARDS
    final double offsetX = 500.0 - totalBounds.center.dx;
    final double offsetY = 400.0 - totalBounds.center.dy;

    // 3. Apply shift to all strokes in this character
    final Matrix4 shiftMatrix = Matrix4.identity()..translate(offsetX, offsetY);
    for (int i = start; i < end; i++) {
      if (!paths[i].getBounds().isEmpty) {
        paths[i] = paths[i].transform(shiftMatrix.storage);
      }
    }
  }
}