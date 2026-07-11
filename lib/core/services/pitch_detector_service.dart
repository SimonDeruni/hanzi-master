import 'package:flutter/foundation.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';

class PitchDetectorService {
  late PitchDetector _detector;
  final int _bufferSize;
  
  PitchDetectorService({int sampleRate = 16000, int bufferSize = 1024}) : _bufferSize = bufferSize {
    _detector = PitchDetector(audioSampleRate: sampleRate.toDouble(), bufferSize: bufferSize);
  }

  /// Converts 16-bit PCM bytes to List<double> in range [-1.0, 1.0]
  List<double> _bytesToFloat(Uint8List bytes) {
    if (bytes.lengthInBytes < 2) return [];
    final intData = bytes.buffer.asInt16List(bytes.offsetInBytes, bytes.lengthInBytes ~/ 2);
    return intData.map((e) => e / 32768.0).toList();
  }

  /// Processes an entire audio file (PCM 16-bit without header, or skip header) 
  /// and returns a list of pitch values over time.
  Future<List<double?>> extractPitchContour(Uint8List bytes, {int chunkSize = 1024}) async {
    // Detect if the file starts with a WAV header ("RIFF")
    // If yes, skip the standard 44-byte header; otherwise read raw PCM
    final hasWavHeader = bytes.length >= 4 && bytes[0] == 82 && bytes[1] == 73 && bytes[2] == 70 && bytes[3] == 70;
    final skipHeader = hasWavHeader ? 44 : 0;

    if (bytes.lengthInBytes <= skipHeader) return [];
    final contour = <double?>[];
    final floats = _bytesToFloat(Uint8List.sublistView(bytes, skipHeader));
    
    for (int i = 0; i < floats.length; i += chunkSize) {
      final end = (i + chunkSize < floats.length) ? i + chunkSize : floats.length;
      var chunk = floats.sublist(i, end);
      
      // Skip chunks that are extremely short
      if (chunk.length < 256) {
        contour.add(null);
        continue;
      }
      
      // Pad chunk with zeros if it is shorter than the configured detector bufferSize
      if (chunk.length < _bufferSize) {
        final padded = List<double>.from(chunk);
        while (padded.length < _bufferSize) {
          padded.add(0.0);
        }
        chunk = padded;
      } else if (chunk.length > _bufferSize) {
        chunk = chunk.sublist(0, _bufferSize);
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
