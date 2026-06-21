import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

void main() async {
  final dir = Directory('assets/audio');
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }

  await _generateWav('assets/audio/whoosh.wav', 0.4, _whoosh);
  await _generateWav('assets/audio/thud.wav', 0.3, _thud);
  await _generateWav('assets/audio/wet_ink.wav', 1.0, _wetInk);
  print('Audio generated!');
}

Future<void> _generateWav(String filename, double duration, double Function(double, int) generator) async {
  final sampleRate = 44100;
  final numSamples = (duration * sampleRate).toInt();
  final data = ByteData(numSamples * 2);
  
  for (int i = 0; i < numSamples; i++) {
    final t = i / sampleRate;
    double sample = generator(t, i);
    sample = max(-1.0, min(1.0, sample));
    data.setInt16(i * 2, (sample * 32767).toInt(), Endian.little);
  }

  final byteList = data.buffer.asUint8List();
  final file = File(filename);
  
  // WAV header
  final header = BytesBuilder();
  header.add('RIFF'.codeUnits);
  header.add(_int32ToBytes(36 + byteList.length));
  header.add('WAVE'.codeUnits);
  header.add('fmt '.codeUnits);
  header.add(_int32ToBytes(16)); // Subchunk1Size
  header.add(_int16ToBytes(1));  // AudioFormat (PCM)
  header.add(_int16ToBytes(1));  // NumChannels
  header.add(_int32ToBytes(sampleRate)); // SampleRate
  header.add(_int32ToBytes(sampleRate * 2)); // ByteRate
  header.add(_int16ToBytes(2));  // BlockAlign
  header.add(_int16ToBytes(16)); // BitsPerSample
  header.add('data'.codeUnits);
  header.add(_int32ToBytes(byteList.length));
  
  final out = BytesBuilder();
  out.add(header.takeBytes());
  out.add(byteList);
  
  await file.writeAsBytes(out.takeBytes());
}

List<int> _int32ToBytes(int value) {
  final b = ByteData(4);
  b.setInt32(0, value, Endian.little);
  return b.buffer.asUint8List();
}

List<int> _int16ToBytes(int value) {
  final b = ByteData(2);
  b.setInt16(0, value, Endian.little);
  return b.buffer.asUint8List();
}

final _rand = Random();

double _whoosh(double t, int i) {
  final noise = _rand.nextDouble() * 2 - 1;
  double env = 0;
  if (t < 0.1) env = t / 0.1;
  else env = max(0.0, 1.0 - (t - 0.1) / 0.3);
  return noise * env * 0.5;
}

double _thud(double t, int i) {
  double freq = 60 - t * 100;
  if (freq < 20) freq = 20;
  final env = exp(-t * 20);
  return sin(2 * pi * freq * t) * env;
}

double _wetInk(double t, int i) {
  final noise = _rand.nextDouble() * 2 - 1;
  final env = 0.5 + 0.5 * sin(2 * pi * 5 * t);
  return noise * env * 0.1;
}
