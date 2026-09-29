import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/pitch_detector_service.dart';
import 'package:hanzi_master/core/utils/tone_evaluator.dart';

/// Where the pure maths meets actual audio.
///
/// Everything else in the tone suite works on hand-written contours; this file feeds
/// the **real detector** synthetic PCM so the two links that cannot be unit-tested
/// otherwise are covered — the analysis window, and the hand-off from the detector into
/// the evaluator.
///
/// It is also the regression test for the bug `docs/LOCAL_TONE_PLAN.md` §2 found: the
/// service used to build its detector at `bufferSize: 1024` and then zero-pad every
/// 512-sample chunk up to that, so half of every window was silence. Nothing here would
/// have passed under that behaviour.

const int _sampleRate = 16000;
const int _windowSize = 512;

/// One frame of a sine at [frequency], phase-continuous with whatever came before.
void _appendSine(List<int> out, double frequency, double startPhase) {
  for (int i = 0; i < _windowSize; i++) {
    final phase = startPhase + 2 * math.pi * frequency * (i + 1) / _sampleRate;
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
    // Keep the phase continuous between frames, or each frame starts at a
    // discontinuity and the detector sees a click rather than a pitch.
    phase += 2 * math.pi * frequency * _windowSize / _sampleRate;
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
  bytes.setUint32(24, _sampleRate, Endian.little);
  bytes.setUint32(28, _sampleRate * 2, Endian.little); // byte rate
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

void main() {
  test('the detector measures the pitch it was given', () async {
    final wav = toneWav(f0Frames([0.0, 1.0], frames: 9, base: 150));
    final contour = await PitchDetectorService().extractPitchContour(wav);

    // One frame per window: no padding, no dropping.
    expect(contour.length, 9);

    final voiced = contour.whereType<double>().toList();
    expect(voiced.length, greaterThanOrEqualTo(8),
        reason: 'a clean sine must be voiced in nearly every frame');
    // Within a couple of Hz of what was synthesised — which is also what the
    // buffer/window mismatch would have destroyed.
    expect(voiced.first, closeTo(150, 3));
    expect(voiced.last, closeTo(150 * math.pow(2, 8 / 12), 4));
  });

  test('a rising tone survives the whole pipeline, start to finish', () async {
    final wav = toneWav(f0Frames([0.0, 1.0]));
    final contour = await PitchDetectorService().extractPitchContour(wav);
    final assessment = ToneEvaluator.evaluate(contour: contour, expectedTone: 2);
    expect(assessment.actualTone, 2);
    expect(assessment.matchesTarget, isTrue);
  });

  test('a falling tone is not mistaken for a rising one, from real bytes', () async {
    final wav = toneWav(f0Frames([1.0, 0.0]));
    final contour = await PitchDetectorService().extractPitchContour(wav);
    final assessment = ToneEvaluator.evaluate(contour: contour, expectedTone: 2);
    // The pair that matters: it has to *name* the fourth tone, not merely fail.
    expect(assessment.actualTone, 4);
  });

  test('a flat tone is a first tone, and a level reading is not a failure', () async {
    final wav = toneWav(f0Frames([0.5, 0.5]));
    final contour = await PitchDetectorService().extractPitchContour(wav);
    expect(ToneEvaluator.evaluate(contour: contour, expectedTone: 1).actualTone, 1);
  });

  test('silence is never graded', () async {
    final wav = toneWav(List<double>.filled(6, 150));
    // Overwrite the samples with zeroes: a header plus silence.
    for (int i = 44; i < wav.length; i++) {
      wav[i] = 0;
    }
    final contour = await PitchDetectorService().extractPitchContour(wav);
    final assessment = ToneEvaluator.evaluate(contour: contour, expectedTone: 4);
    expect(assessment.measured, isFalse);
    expect(assessment.actualTone, 0);
  });

  test('an empty or too-short buffer yields nothing voiced rather than throwing',
      () async {
    // The contract is "no voiced frames", not "an empty list": a buffer too short for
    // one window comes back as a single unvoiced frame, which is just as honest and is
    // what the evaluator expects.
    for (final bytes in [Uint8List(0), Uint8List(10)]) {
      final contour = await PitchDetectorService().extractPitchContour(bytes);
      expect(contour.whereType<double>(), isEmpty);
    }
  });
}
