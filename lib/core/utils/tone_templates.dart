import 'dart:math' as math;

/// The canonical pitch shapes of Mandarin tone, written on **Chao's five-level
/// scale**.
///
/// Chao's letters (55, 35, 214, 51) are the standard way to write a tone: each
/// digit is a level from 1 — the speaker's floor — to 5, their ceiling. This class
/// turns them into a curve on a 0–1 scale, which is the same scale
/// `PitchContourMath.normaliseShape` puts a recording on, so the two are directly
/// comparable.
///
/// **Nothing here is invented.** The shapes are the standard descriptions, and the
/// half-third case is the well-known realisation of a third tone that is not
/// phrase-final. `audit/audit_40` §4.3 is why it has to exist: a matcher that
/// insists on a full dip marks 请坐 and 美国 — correct Mandarin — as wrong.
class ToneTemplates {
  /// How many points every reference curve is resampled to.
  ///
  /// 20 is comfortably more than the 5–9 frames a single syllable actually yields,
  /// so the *measurement* is resampled up to meet the template rather than the
  /// template being crushed down — resampling down would throw away the very
  /// detail the detector was tuned to capture.
  static const int resolution = 20;

  /// Control points as Chao levels, low to high tone.
  static const Map<int, List<int>> _chao = {
    // 55 — high and level. The only tone whose correct shape is flat, which is why
    // a flat measurement can never be dismissed outright as "no signal".
    1: [5, 5],
    // 35 — mid rising. Convex: it hangs near the start, then climbs.
    2: [3, 3, 3, 4, 4, 5],
    // 214 — the full dipping third, ending high.
    3: [2, 1, 1, 2, 4],
    // 51 — high falling, steep.
    4: [5, 4, 3, 1],
  };

  /// The **half-third** (半三声), 21 — low and falling with no rise at all. Used for
  /// any third tone that is not the last syllable of its phrase.
  static const List<int> _chaoHalfThird = [2, 1];

  /// Chao level 1–5 to the 0–1 scale.
  static double levelToUnit(int level) => (level - 1) / 4.0;

  /// The reference shape for [tone], or **null when that tone has no fixed shape**.
  ///
  /// Returns null for tone 5: a neutral tone takes its pitch from the syllable
  /// before it (mid after a first tone, low after a fourth), so there is no curve to
  /// match. `ToneEvaluator` reports those as "not measured" rather than inventing
  /// one — see `docs/LOCAL_TONE_PLAN.md` §7.
  static List<double>? reference(int tone, {bool phraseFinal = true}) {
    if (tone == 5 || tone == 0) return null;
    final levels = (tone == 3 && !phraseFinal) ? _chaoHalfThird : _chao[tone];
    if (levels == null) return null;
    return resample([for (final level in levels) levelToUnit(level)], resolution);
  }

  /// Linear resample of [points] (x implicitly 0–1) onto [n] evenly spaced points.
  static List<double> resample(List<double> points, int n) {
    if (points.isEmpty || n <= 0) return const [];
    if (points.length == 1) return List<double>.filled(n, points.first);
    final out = <double>[];
    for (int i = 0; i < n; i++) {
      final x = i / (n - 1);
      final position = x * (points.length - 1);
      final lower = position.floor().clamp(0, points.length - 1);
      final upper = math.min(lower + 1, points.length - 1);
      final t = position - lower;
      out.add(points[lower] * (1 - t) + points[upper] * t);
    }
    return out;
  }

  /// True when [tone] is one this class can compare against.
  static bool isGradable(int tone) => reference(tone) != null;
}
