import 'package:flutter/foundation.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';

class PitchDetectorService {
  /// One analysis window, in samples — and therefore also the hop between frames,
  /// so consecutive windows do not overlap.
  ///
  /// **512 (32 ms at 16 kHz) is the point of this class.** A Mandarin syllable runs
  /// 150–300 ms, so the 1024 default it used to carry gave only 3–5 points per
  /// syllable and could not show a tone-3 dip at all. Going lower is worse rather
  /// than better: at 256 samples (16 ms) a low male voice at 75 Hz has a 13 ms
  /// period, so the detector cannot see two cycles and reports nothing.
  ///
  /// This is also the bug `docs/LOCAL_TONE_PLAN.md` §2 turned up: the detector was
  /// built with `bufferSize: 1024` while `extractPitchContour` accepted its own
  /// `chunkSize` and then **zero-padded every chunk up to 1024**, so asking for a
  /// 512-sample hop analysed half silence. Window and buffer are now the same
  /// number, by construction.
  final int windowSize;

  final PitchDetector _detector;

  PitchDetectorService({int sampleRate = 16000, this.windowSize = 512})
      : assert(
          windowSize >= 256 && windowSize <= 4096,
          'windowSize must be 256-4096 samples: shorter cannot hold two periods of '
          'a low male voice (75 Hz = 13 ms = 213 samples), and longer blurs a '
          '150 ms syllable into a single frame.',
        ),
        _detector = PitchDetector(
          audioSampleRate: sampleRate.toDouble(),
          bufferSize: windowSize,
        );

  /// Converts 16-bit PCM bytes to List<double> in range [-1.0, 1.0]
  List<double> _bytesToFloat(Uint8List bytes) {
    if (bytes.lengthInBytes < 2) return [];
    final intData = bytes.buffer.asInt16List(bytes.offsetInBytes, bytes.lengthInBytes ~/ 2);
    return intData.map((e) => e / 32768.0).toList();
  }

  /// Processes an entire audio file (PCM 16-bit without header, or skip header)
  /// and returns a list of pitch values over time.
  ///
  /// One value per [windowSize] samples, so the list is already a hop of
  /// `windowSize / sampleRate` seconds — 32 ms for the defaults. `null` means the
  /// frame was unvoiced, below the confidence gate, or out of the human range;
  /// callers must treat it as "nothing measured here", never as a pitch of zero.
  Future<List<double?>> extractPitchContour(Uint8List bytes) async {
    // Detect if the file starts with a WAV header ("RIFF")
    // If yes, skip the standard 44-byte header; otherwise read raw PCM
    final hasWavHeader = bytes.length >= 4 && bytes[0] == 82 && bytes[1] == 73 && bytes[2] == 70 && bytes[3] == 70;
    final skipHeader = hasWavHeader ? 44 : 0;

    if (bytes.lengthInBytes <= skipHeader) return [];
    final contour = <double?>[];
    final floats = _bytesToFloat(Uint8List.sublistView(bytes, skipHeader));

    for (int i = 0; i < floats.length; i += windowSize) {
      final end = (i + windowSize < floats.length) ? i + windowSize : floats.length;
      var chunk = floats.sublist(i, end);

      // Skip chunks that are extremely short
      if (chunk.length < 256) {
        contour.add(null);
        continue;
      }

      // Only the final partial window lands here, and padding it to a full window
      // is correct — the alternative is <2 periods of signal. A chunk *larger* than
      // the window is now impossible, which is what the old `chunkSize` argument
      // used to cause.
      if (chunk.length < windowSize) {
        final padded = List<double>.from(chunk);
        while (padded.length < windowSize) {
          padded.add(0.0);
        }
        chunk = padded;
      }
      
      try {
        final result = await _detector.getPitchFromFloatBuffer(chunk);
        if (result.pitched && result.probability > 0.7 && result.pitch > 50.0 && result.pitch < 800.0) {
          contour.add(result.pitch);
        } else {
          contour.add(null);
        }
      } catch (e) {
        debugPrint("[PitchDetector] Warning processing chunk at $i: $e");
        contour.add(null);
      }
    }
    return contour;
  }
}
