import 'dart:typed_data';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitch_detector_dart/pitch_handler.dart';

class PitchDetectorService {
  late PitchDetector _detector;
  
  PitchDetectorService({int sampleRate = 16000, int bufferSize = 2048}) {
    _detector = PitchDetector(sampleRate.toDouble(), bufferSize);
  }

  /// Converts 16-bit PCM bytes to List<double> in range [-1.0, 1.0]
  List<double> _bytesToFloat(Uint8List bytes) {
    final intData = bytes.buffer.asInt16List(bytes.offsetInBytes, bytes.lengthInBytes ~/ 2);
    return intData.map((e) => e / 32768.0).toList();
  }

  /// Calculates the pitch from a PCM 16-bit buffer
  double? getPitchFromBuffer(Uint8List bytes) {
    final floats = _bytesToFloat(bytes);
    final result = _detector.getPitch(floats);
    if (result.pitched && result.probability > 0.8 && result.pitch > 50.0 && result.pitch < 800.0) {
      return result.pitch;
    }
    return null;
  }

  /// Processes an entire audio file (PCM 16-bit without header, or skip header) 
  /// and returns a list of pitch values over time.
  List<double?> extractPitchContour(Uint8List bytes, {int chunkSize = 1024, int skipHeader = 44}) {
    final contour = <double?>[];
    final floats = _bytesToFloat(Uint8List.sublistView(bytes, skipHeader));
    
    for (int i = 0; i < floats.length; i += chunkSize) {
      final end = (i + chunkSize < floats.length) ? i + chunkSize : floats.length;
      final chunk = floats.sublist(i, end);
      if (chunk.length < 512) {
        contour.add(null);
        continue;
      }
      final result = _detector.getPitch(chunk);
      if (result.pitched && result.probability > 0.7 && result.pitch > 50.0 && result.pitch < 800.0) {
        contour.add(result.pitch);
      } else {
        contour.add(null);
      }
    }
    return contour;
  }
}
