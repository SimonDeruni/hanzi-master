import 'dart:math' as math;
import 'dart:typed_data';

import 'package:hanzi_master/core/utils/tone_templates.dart';

/// Synthetic PCM for the tests that have to go through the **real** pitch detector.
///
/// Hand-written contours test the maths; they cannot test the two links around it — the
/// analysis window, and the hand-off from the detector into the evaluator. Only audio can
/// do that, so this builds audio whose pitch we already know exactly.
///
/// Shared by `pitch_detector_service_test.dart` and `local_tone_grader_test.dart`; kept
/// here rather than duplicated so that both are measuring the same signal.

const int toneSampleRate = 16000;
const int toneWindowSize = 512;

/// One analysis window of a sine at [frequency], phase-continuous with what came before.
void _appendSine(List<int> out, double frequency, double startPhase) {
  for (int i = 0; i < toneWindowSize; i++) {
    final phase = startPhase + 2 * math.pi * frequency * (i + 1) / toneSampleRate;
    out.add((math.sin(phase) * 12000).round());
  }
}

/// A 16 kHz mono 16-bit **WAV** whose pitch follows [f0PerFrame], one frame per analysis
/// window — so exactly as many frames come back out as went in.
Uint8List toneWav(List<double> f0PerFrame) {
  final samples = <int>[];
  var phase = 0.0;
  for (final frequency in f0PerFrame) {
    _appendSine(samples, frequency, phase);
    // Keep the phase continuous between frames, or each frame starts at a discontinuity
    // and the detector sees a click rather than a pitch.
    phase += 2 * math.pi * frequency * toneWindowSize / toneSampleRate;
  }

  final dataBytes = samples.length * 2;
  final bytes = ByteData(44 + dataBytes);
  void ascii(int offset, String tag) {
    for (int i = 0; i < tag.length; i++) {
      bytes.setUint8(offset + i, tag.codeUnitAt(i));
    }
  }

  ascii(0, 'RIFF');
  bytes.setUint32(4, 36 + dataBytes, Endian.little);
  ascii(8, 'WAVE');
  ascii(12, 'fmt ');
  bytes.setUint32(16, 16, Endian.little); // PCM chunk size
  bytes.setUint16(20, 1, Endian.little); // PCM
  bytes.setUint16(22, 1, Endian.little); // mono
  bytes.setUint32(24, toneSampleRate, Endian.little);
  bytes.setUint32(28, toneSampleRate * 2, Endian.little); // byte rate
  bytes.setUint16(32, 2, Endian.little); // block align
  bytes.setUint16(34, 16, Endian.little); // bits per sample
  ascii(36, 'data');
  bytes.setUint32(40, dataBytes, Endian.little);
  for (int i = 0; i < samples.length; i++) {
    bytes.setInt16(44 + i * 2, samples[i], Endian.little);
  }
  return bytes.buffer.asUint8List();
}

/// F0 for [frames] notes following a 0–1 [shape], spanning [span] semitones from [base].
///
/// [shape] is in the same unit space as `ToneTemplates.reference`, so passing a reference
/// traces exactly that tone.
List<double> f0Frames(
  List<double> shape, {
  int frames = 9,
  double base = 150,
  double span = 8,
}) {
  final out = <double>[];
  for (int i = 0; i < frames; i++) {
    final x = frames == 1 ? 0.0 : i / (frames - 1);
    final position = x * (shape.length - 1);
    final lower = position.floor();
    final upper = math.min(lower + 1, shape.length - 1);
    final t = position - lower;
    final value = shape[lower] * (1 - t) + shape[upper] * t;
    out.add(base * math.pow(2, (value * span) / 12));
  }
  return out;
}

/// Audio whose pitch traces the reference contour for [tone].
///
/// It reads the template out of `ToneTemplates` rather than restating it here, so the
/// signal the test synthesises cannot drift away from the shape the evaluator compares
/// against.
Uint8List toneWavFor(
  int tone, {
  int frames = 12,
  double base = 150,
  double span = 9,
}) {
  final reference = ToneTemplates.reference(tone);
  if (reference == null) {
    throw ArgumentError('no reference shape for tone $tone');
  }
  return toneWav(
    f0Frames(reference, frames: frames, base: base, span: span),
  );
}
