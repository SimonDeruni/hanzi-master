import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/dtw_aligner.dart';

/// The phrase graph relies on one property of `DtwAligner.alignPitch`: after it
/// warps the learner's contour onto the target's, the result must be the **same
/// length** as the target and share its **null pattern**. That is exactly what
/// lets both lanes be mapped to the same x-axis — so a vertical slice through the
/// graph finally compares like with like, instead of "40% through your recording"
/// against "40% through the tone plan".
///
/// Before this property was relied on, the two strokes were drawn on two
/// different clocks and the overlay implied a synchrony the data never had.
void main() {
  test('the aligned contour matches the reference length and gaps', () {
    const List<double?> reference = [150, 150, null, null, 210, 200];
    const List<double?> user = [140, 150, 160, 170, 180, 190, 200, 210, 205];

    final List<double?> aligned = DtwAligner.alignPitch(reference, user);

    expect(aligned.length, reference.length);
    for (int i = 0; i < reference.length; i++) {
      expect(aligned[i] == null, reference[i] == null,
          reason: 'index $i: the aligned contour must be silent exactly where '
              'the reference is silent, or the two lanes drift out of step');
    }
    // Every surviving value comes from the learner's own contour — DTW re-times
    // what was measured, it does not invent a tone that was never said.
    for (final double? value in aligned) {
      if (value != null) expect(user.contains(value), isTrue);
    }
  });

  test('an empty learner contour aligns to silence, not a fabricated tone', () {
    const List<double?> reference = [150.0, 160.0, 170.0];
    final List<double?> aligned = DtwAligner.alignPitch(reference, const []);

    expect(aligned, hasLength(reference.length));
    expect(aligned.every((double? value) => value == null), isTrue);
  });

  test('an empty reference yields nothing to draw', () {
    expect(DtwAligner.alignPitch(const [], const [150.0, 160.0]), isEmpty);
  });
}
