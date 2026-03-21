import 'dart:math';
import 'dart:ui'; // Added for Offset

/// Utility class for geometric calculations.
class GeometryUtils {
  /// Calculates the Euclidean distance between two points (x1, y1) and (x2, y2).
  static double distance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  /// Normalizes a list of Offset points to a 1000x1000 coordinate space.
  ///
  /// This method calculates the bounding box of the input points and then scales
  /// and translates them so they fit within a 0-1000 coordinate system while
  /// maintaining their aspect ratio.
  static List<Offset> normalizePoints(List<Offset> points) {
    if (points.isEmpty) {
      return [];
    }

    // Find min/max x and y to determine the bounding box
    double minX = points.first.dx;
    double maxX = points.first.dx;
    double minY = points.first.dy;
    double maxY = points.first.dy;

    for (final p in points) {
      if (p.dx < minX) minX = p.dx;
      if (p.dx > maxX) maxX = p.dx;
      if (p.dy < minY) minY = p.dy;
      if (p.dy > maxY) maxY = p.dy;
    }

    double width = maxX - minX;
    double height = maxY - minY;

    // Determine scaling factor to fit into 1000x1000, preserving aspect ratio
    // If width or height is zero, handle to prevent division by zero and maintain scale.
    double scaleX = (width == 0 || width.isNaN) ? 1.0 : 1000.0 / width;
    double scaleY = (height == 0 || height.isNaN) ? 1.0 : 1000.0 / height;
    double scale = min(scaleX, scaleY);

    // If both width and height are zero (single point), assign a default scale.
    // This case happens if the stroke is a single point.
    if ((width == 0 || width.isNaN) && (height == 0 || height.isNaN)) {
      scale = 1.0;
    } else if (width == 0 || width.isNaN) { // If only width is 0, scale based on height
      scale = scaleY;
    } else if (height == 0 || height.isNaN) { // If only height is 0, scale based on width
      scale = scaleX;
    }

    // Calculate translation to move the top-left corner to (0,0) after scaling
    double translateX = -minX * scale;
    double translateY = -minY * scale;

    // Apply scaling and translation
    return points.map((p) {
      return Offset(
        (p.dx * scale) + translateX,
        (p.dy * scale) + translateY,
      );
    }).toList();
  }

  /// Calculates the shortest distance from a point to a line segment.
  /// The line segment is defined by p1 and p2. The point is p.
  static double distanceToLineSegment(Offset p, Offset p1, Offset p2) {
    final double l2 = pow(distance(p1.dx, p1.dy, p2.dx, p2.dy), 2).toDouble();
    if (l2 == 0.0) return distance(p.dx, p.dy, p1.dx, p1.dy); // p1 and p2 are the same point

    final double t = ((p.dx - p1.dx) * (p2.dx - p1.dx) + (p.dy - p1.dy) * (p2.dy - p1.dy)) / l2;
    final double cappedT = t.clamp(0.0, 1.0); // Project point onto segment
    final Offset projection = Offset(
      p1.dx + cappedT * (p2.dx - p1.dx),
      p1.dy + cappedT * (p2.dy - p1.dy),
    );
    return distance(p.dx, p.dy, projection.dx, projection.dy);
  }
}
