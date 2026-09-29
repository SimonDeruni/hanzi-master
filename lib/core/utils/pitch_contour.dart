import 'dart:math' as math;

import 'tone_templates.dart';

/// The arithmetic between a raw pitch contour and a tone verdict.
///
/// Pure and static, like `DtwAligner` — every function here is testable with a
/// hand-written contour and no audio at all, which is deliberate: this is the part
/// that decides whether the feature is honest, so it should be verifiable without a
/// microphone.
///
/// **Everything happens in log-pitch, not Hz.** Pitch is perceived logarithmically —
/// an octave is a doubling — so comparing Hz makes a high voice look "more wrong"
/// for the same relative error. It also matters mechanically: a woman at 220 Hz and
/// a man at 110 Hz saying a *perfect* first tone differ by 110 Hz, so a raw-Hz
/// comparison would be dominated by who is speaking rather than by the tone.
/// `DtwAligner.alignPitch` still subtracts raw Hz; it is kept for the *display*
/// alignment, where `ToneGraphPainter` normalises the drawing anyway.
class PitchContourMath {
  /// Below this span a contour is treated as **level** rather than stretched to fill
  /// the 0–1 range.
  ///
  /// This exists because of a failing test, and the failure was instructive: a *correct*
  /// first tone is a steady note with a little natural jitter, and min–max normalisation
  /// amplified that jitter into a full-scale random shape — which could then match
  /// anything. 1.5 semitones is about the smallest movement a listener would call a tone
  /// rather than a wobble, so anything under it is a level reading and is normalised to a
  /// level line.
  static const double flatSpanSemitones = 1.5;

  /// [flatSpanSemitones] expressed in log₂ units, which is the scale [normaliseShape]
  /// works on.
  static const double _flatSpanLog2 = flatSpanSemitones / 12;

  /// A frame jumping this many semitones from its neighbour is the detector locking
  /// onto a harmonic, not a tone. A real fourth tone falls ~7 semitones over 200 ms,
  /// which is about 1 per 32 ms frame.
  static const double octaveJumpSemitones = 6.0;

  /// Frames that carried a usable pitch — the rest were unvoiced or failed the
  /// detector's own confidence gate.
  static int voicedCount(List<double?> contour) =>
      contour.where((value) => value != null && value > 0).length;

  /// The pitch values that survived, in order.
  static List<double> voicedValues(List<double?> contour) => [
        for (final value in contour)
          if (value != null && value > 0) value,
      ];

  /// Interpolates across dropouts so a creaky third tone does not read as two
  /// separate shapes.
  ///
  /// **This exists because of the single biggest risk in the design:** a third
  /// tone's dip descends into creaky voice for many speakers, and YIN drops out
  /// exactly there — so the detector fails on the tone that is hardest to see.
  /// Leading and trailing gaps take the nearest voiced value rather than
  /// extrapolating a trend that was never observed.
  static List<double?> fillGaps(List<double?> contour) {
    final out = List<double?>.from(contour);
    final voiced = <int>[
      for (int i = 0; i < out.length; i++)
        if (out[i] != null && out[i]! > 0) i,
    ];
    if (voiced.isEmpty) return out;

    for (int i = 0; i < out.length; i++) {
      if (out[i] != null && out[i]! > 0) continue;
      int? before;
      int? after;
      for (final index in voiced) {
        if (index < i) before = index;
      }
      for (final index in voiced) {
        if (index > i) {
          after = index;
          break;
        }
      }
      if (before != null && after != null) {
        final t = (i - before) / (after - before);
        out[i] = out[before]! * (1 - t) + out[after]! * t;
      } else {
        out[i] = out[(before ?? after)!];
      }
    }
    return out;
  }

  /// log₂ of each frame, `null` where nothing was voiced. log₂ rather than natural
  /// log only because semitones then fall out as a ×12.
  static List<double?> toLog2(List<double?> contour) => [
        for (final value in contour)
          (value != null && value > 0) ? (math.log(value) / math.ln2) : null,
      ];

  /// The contour's **span**, in semitones.
  ///
  /// This is the *magnitude* signal, and it is deliberately separate from the shape:
  /// min–max normalisation makes the shape invariant to how far the voice moved, so
  /// without this a murmur could pass as a fine fourth tone.
  static double spanSemitones(List<double?> contour) {
    final values = voicedValues(contour);
    if (values.length < 2) return 0;
    final low = values.reduce(math.min);
    final high = values.reduce(math.max);
    if (low <= 0) return 0;
    return 12 * (math.log(high / low) / math.ln2);
  }

  /// The shape alone, on a 0–1 scale: min–max over log-pitch.
  ///
  /// Shift- and scale-invariant by construction, which is what "shape" means — the
  /// speaker's absolute pitch is discarded here and carried by [spanSemitones]
  /// instead.
  ///
  /// A **level** contour returns a level line at 0.5 — see [flatSpanSemitones] for why
  /// that is not an error case: a correct first tone *is* level, and 0.5 can masquerade
  /// as neither a rise nor a fall, so it matches the first-tone template and nothing
  /// else. Normalising a level reading to the full 0–1 range would instead turn its
  /// natural jitter into a random shape. Rejecting levelness here would reject correct
  /// Mandarin.
  ///
  /// Returns null only when there is nothing voiced to normalise.
  static List<double?>? normaliseShape(List<double?> logContour) {
    final values = [for (final value in logContour) if (value != null) value];
    if (values.isEmpty) return null;
    final low = values.reduce(math.min);
    final high = values.reduce(math.max);
    final range = high - low;
    if (range < _flatSpanLog2) return List<double>.filled(logContour.length, 0.5);
    return [
      for (final value in logContour)
        value == null ? null : (value - low) / range,
    ];
  }

  /// True when any two adjacent voiced frames are further apart than
  /// [octaveJumpSemitones] — the signature of the detector locking onto a harmonic.
  ///
  /// A contour that does this is a **measurement failure, not a wrong tone**, so the
  /// caller must report "not measured" rather than blame the learner.
  static bool hasOctaveJump(List<double?> logContour) {
    for (int i = 1; i < logContour.length; i++) {
      final previous = logContour[i - 1];
      final current = logContour[i];
      if (previous == null || current == null) continue;
      if ((current - previous).abs() * 12 > octaveJumpSemitones) return true;
    }
    return false;
  }

  /// Mean absolute difference between two same-length curves on a 0–1 scale.
  ///
  /// Plain per-point distance rather than DTW: on a 5–9 frame measurement, warping
  /// adds noise instead of removing it. DTW is kept for the *display* alignment,
  /// which is what it is genuinely good at.
  static double distance(List<double> a, List<double> b) {
    if (a.isEmpty || a.length != b.length) return double.infinity;
    var total = 0.0;
    for (int i = 0; i < a.length; i++) {
      total += (a[i] - b[i]).abs();
    }
    return total / a.length;
  }

  /// The shape [tones] should make, in Hz, laid out in equal slots for display.
  ///
  /// **This is a schematic, not a time-aligned target.** Azure does not return
  /// per-syllable offsets, so there is no way to know where a character begins inside
  /// a recording; every tone therefore gets an equal share of the width. It says what
  /// each tone should *look like* and nothing about *when* — which is why the surface
  /// that draws it says so in as many words rather than letting the two strokes appear
  /// aligned.
  ///
  /// It returns **Hz**, not a 0–1 shape, because it shares a coordinate space with a
  /// real contour: `ToneGraphPainter` scales every series by the shared min/max of both,
  /// so a unit-scale target drawn against a 150 Hz trace would collapse to a flat line
  /// along the bottom of the graph. [baseHz] is where the middle of the shape sits and
  /// [spanSemitones] how far it reaches either side — the same mapping the audio tests
  /// use to synthesise a known pitch, so a target and a measured trace are directly
  /// comparable.
  ///
  /// A tone with no fixed shape (the neutral tone) contributes `null`s rather than a
  /// guess: the slot keeps its width, so the syllables after it stay in place, and the
  /// graph does not imply a shape that is not there.
  static List<double?> idealForTones(
    List<int> tones, {
    int resolution = 12,
    double baseHz = 150,
    double spanSemitones = 8,
  }) {
    if (tones.isEmpty || resolution < 2) return const [];

    final out = <double?>[];
    for (int i = 0; i < tones.length; i++) {
      // Only the last syllable of a phrase is phrase-final: a non-final third tone is a
      // half-third — a low fall — and not the full dip. `ToneTemplates` already knows
      // the difference, so the target stroke shows the shape that was actually asked
      // for rather than a dip the phrase never contained.
      final reference = ToneTemplates.reference(
        tones[i],
        phraseFinal: i == tones.length - 1,
      );
      if (reference == null) {
        out.addAll(List<double?>.filled(resolution, null));
        continue;
      }
      for (final unit in ToneTemplates.resample(reference, resolution)) {
        // unit 0.5 sits at [baseHz]; the shape reaches ±span/2 semitones around it.
        out.add(baseHz * math.pow(2, (unit - 0.5) * spanSemitones / 12).toDouble());
      }
    }
    return out;
  }
}
