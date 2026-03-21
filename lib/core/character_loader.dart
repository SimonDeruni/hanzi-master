import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:path_drawing/path_drawing.dart';

/// Helper for passing parameters to the background sampling worker.
class _SampleParams {
  final Path path;
  final double interval;
  _SampleParams(this.path, this.interval);
}

/// Top-level worker for sampling points from a Path.
List<Offset> _samplePointsWorker(_SampleParams params) {
  return CharacterLoader.samplePoints(params.path, interval: params.interval);
}


/// Service responsible for parsing SVG strings into Flutter Path objects
/// and handling coordinate normalization.
class CharacterLoader {
  // Simple in-memory cache to prevent expensive SVG parsing on every frame/rebuild
  static final Map<String, Path> _pathCache = {};

  /// Mapping for radicals that are not in the HSK1 dataset as standalone characters.
  /// Format: 'Radical': ['ProxyCharacter', StrokeCount, StartIndex]
  static const Map<String, List<dynamic>> _radicalProxyMap = {
    '氵': ['汉', 3, 0],   // First 3 strokes of '汉'
    '亻': ['什', 2, 0],   // First 2 strokes of '什'
    '扌': ['打', 3, 0],   // First 3 strokes of '打'
    '讠': ['认', 2, 0],   // First 2 strokes of '认'
    '犭': ['狗', 3, 0],   // First 3 strokes of '狗'
    '饣': ['饭', 3, 0],   // First 3 strokes of '饭'
    '辶': ['这', 3, 1],   // Last 3 strokes of '这' (文 is 3, 辶 is 3) - approximate
    '阝': ['院', 2, 0],   // First 2 strokes of '院' (Left side)
    '忄': ['忙', 3, 0],   // First 3 strokes of '忙'
    '彳': ['很', 3, 0],   // First 3 strokes of '很'
    '刂': ['前', 2, 7],   // Last 2 strokes of '前' (approximate)
    '宀': ['家', 3, 0],   // First 3 strokes of '家'
    '冖': ['写', 2, 0],   // First 2 strokes of '写'
    '广': ['店', 3, 0],   // First 3 strokes of '店'
    '艹': ['茶', 3, 0],   // First 3 strokes of '茶'
    '钅': ['钱', 5, 0],   // First 5 strokes of '钱'
  };

  /// Injects proxy strokes for radicals if they are missing.
  static List<String> getProxyStrokes(String character, Map<String, dynamic> animData) {
    if (animData.containsKey(character)) {
      return List<String>.from(animData[character]['skeletons']);
    }

    if (_radicalProxyMap.containsKey(character)) {
      final proxyInfo = _radicalProxyMap[character]!;
      final proxyChar = proxyInfo[0] as String;
      final count = proxyInfo[1] as int;
      final start = proxyInfo[2] as int;

      if (animData.containsKey(proxyChar)) {
        final allStrokes = List<String>.from(animData[proxyChar]['skeletons']);
        if (allStrokes.length >= start + count) {
          return allStrokes.sublist(start, start + count);
        }
        return allStrokes; // Fallback to all strokes if indexing fails
      }
    }

    return [];
  }

  /// Parses a list of SVG path strings into a list of Flutter Paths.
  static List<Path> parseStrokes(List<String> svgPaths, {bool normalize = true, bool isFlipped = false}) {
    if (svgPaths.isEmpty) return [];

    List<Path> paths = [];
    for (final svg in svgPaths) {
      if (svg == '__CHAR_SEPARATOR__') {
        paths.add(Path());
        continue;
      }

      final cacheKey = '$svg|$normalize|$isFlipped';
      if (_pathCache.containsKey(cacheKey)) {
        paths.add(_pathCache[cacheKey]!);
        continue;
      }
      
      try {
        Path path = parseSvgPathData(svg);
        
        // Handle Y-Up source flip
        if (isFlipped) {
          path = flipY(path);
        }

        if (normalize) {
          // Standard scale from 1024 to 1000. 
          const double s = 1000.0 / 1024.0;
          final Matrix4 matrix = Matrix4.identity();
          matrix.setEntry(0, 0, s); // Scale X
          matrix.setEntry(1, 1, s); // Scale Y
          path = path.transform(matrix.storage);
        }
        
        // Performance Audit Fix: Prevent unbounded cache growth
        if (_pathCache.length > 1000) {
          _pathCache.clear();
        }

        _pathCache[cacheKey] = path;
        paths.add(path);
      } catch (e) {
        paths.add(Path());
      }
    }

    return paths;
  }

  /// Unified transformation: 1024x1024 Y-down -> 1000x1000 Y-down
  static Path transformPath(Path path) {
    const double s = 1000.0 / 1024.0;
    final Matrix4 matrix = Matrix4.identity();
    matrix.setEntry(0, 0, s);
    matrix.setEntry(1, 1, s);
    return path.transform(matrix.storage);
  }

  /// Unified transformation for points
  static Offset transformPoint(Offset p) {
    const double scale = 1000.0 / 1024.0;
    return Offset(p.dx * scale, p.dy * scale);
  }

  /// Samples points along a path at regular intervals.
  static List<Offset> samplePoints(Path path, {double interval = 5.0}) {
    final List<Offset> points = [];
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      for (double i = 0; i < metric.length; i += interval) {
        final tangent = metric.getTangentForOffset(i);
        if (tangent != null) points.add(tangent.position);
      }
      final tangent = metric.getTangentForOffset(metric.length);
      if (tangent != null) points.add(tangent.position);
    }
    return points;
  }

  /// Samples points along a path asynchronously in a background isolate.
  static Future<List<Offset>> samplePointsAsync(Path path, {double interval = 5.0}) async {
    return compute(_samplePointsWorker, _SampleParams(path, interval));
  }

  /// Parses SVG paths and samples points asynchronously in a background isolate.
  /// This is the most efficient way to load character data for matching.
  static Future<List<List<Offset>>> parseAndSampleAsync(
    List<String> svgPaths, {
    double interval = 2.0,
    bool normalize = true,
    bool isFlipped = false,
  }) async {
    return compute(
      _parseAndSampleWorker,
      _ParseAndSampleParams(
        svgPaths: svgPaths,
        interval: interval,
        normalize: normalize,
        isFlipped: isFlipped,
      ),
    );
  }

  /// Flips a path vertically (for Y-Up sources)
  static Path flipY(Path path) {
    // Manually setting entries is the most robust way to avoid deprecation warnings
    // across different vector_math versions.
    final Matrix4 matrix = Matrix4.identity();
    matrix.setEntry(1, 1, -1.0);   // Flip Y
    matrix.setEntry(1, 3, 1024.0); // Translate Y down (in 1024 space)
    
    return path.transform(matrix.storage);
  }

  /// Flips points vertically
  static List<Offset> flipPoints(List<Offset> points) {
    return points.map((p) => Offset(p.dx, 1024.0 - p.dy)).toList();
  }
}

/// Parameters for the background parsing and sampling worker.
class _ParseAndSampleParams {
  final List<String> svgPaths;
  final double interval;
  final bool normalize;
  final bool isFlipped;

  _ParseAndSampleParams({
    required this.svgPaths,
    required this.interval,
    required this.normalize,
    required this.isFlipped,
  });
}

/// Top-level worker function for parsing and sampling SVG paths.
List<List<Offset>> _parseAndSampleWorker(_ParseAndSampleParams params) {
  final List<List<Offset>> results = [];
  for (final svg in params.svgPaths) {
    if (svg == '__CHAR_SEPARATOR__') {
      results.add([]);
      continue;
    }
    try {
      Path path = parseSvgPathData(svg);
      if (params.isFlipped) {
        path = CharacterLoader.flipY(path);
      }
      if (params.normalize) {
        path = CharacterLoader.transformPath(path);
      }
      results.add(CharacterLoader.samplePoints(path, interval: params.interval));
    } catch (e) {
      results.add([]);
    }
  }
  return results;
}
