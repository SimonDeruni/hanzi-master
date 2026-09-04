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
    // 1. Trigger native iOS AVAudioSession.requestRecordPermission via record package
    try {
      final hasPerm = await _audioRecorder.hasPermission();
      if (hasPerm) return true;
    } catch (_) {}

    // 2. Fallback check via permission_handler
    try {
      final status = await Permission.microphone.request();
      if (status == PermissionStatus.granted) return true;
    } catch (_) {}

    return false;
  }

  Future<bool> hasPermission() async {
    try {
      return await _audioRecorder.hasPermission();
    } catch (_) {
      return false;
    }
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
