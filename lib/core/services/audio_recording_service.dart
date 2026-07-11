import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';

final audioRecordingServiceProvider = Provider<AudioRecordingService>((ref) {
  return AudioRecordingService();
});

class AudioRecordingService {
  final AudioRecorder _audioRecorder = AudioRecorder();

  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  Future<bool> hasPermission() async {
    return await _audioRecorder.hasPermission();
  }

  Stream<Amplitude> get onAmplitudeChanged => _audioRecorder.onAmplitudeChanged(const Duration(milliseconds: 50));

  Future<void> startRecording(String fileName) async {
    if (await hasPermission()) {
      final dir = await getTemporaryDirectory();
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      final path = '${dir.path}/$fileName.wav';
      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: path,
      );
    } else {
      throw Exception('Microphone permission denied');
    }
  }

  Future<String?> stopRecording() async {
    try {
      if (await _audioRecorder.isRecording()) {
        return await _audioRecorder.stop();
      }
    } catch (e) {
      // Recorder may be in an invalid state — return null gracefully
    }
    return null;
  }

  Future<void> dispose() async {
    await _audioRecorder.dispose();
  }
}
