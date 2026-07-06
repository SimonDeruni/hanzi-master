import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final key = 'AnZ5l470hrJMMOqPYYH085lWbpFHjRH8nZCkryg0TWFF8yaVzDdOJQQJ99CGACPV0roXJ3w3AAAYACOGk7C0';
  final region = 'germanywestcentral';
  
  final Map<String, dynamic> params = {
    "ReferenceText": "我今年八岁了",
    "GradingSystem": "HundredMark",
    "Granularity": "Phoneme",
    "Dimension": "Comprehensive"
  };

  final String base64Params = base64Encode(utf8.encode(jsonEncode(params)));
  final String endpoint = 'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=zh-CN';

  // Create a 1-second silent WAV file (16000Hz, 1 channel, 16-bit PCM)
  final byteCount = 16000 * 2;
  final wavHeader = <int>[
    82, 73, 70, 70, // "RIFF"
    (36 + byteCount) & 0xff, ((36 + byteCount) >> 8) & 0xff, ((36 + byteCount) >> 16) & 0xff, ((36 + byteCount) >> 24) & 0xff,
    87, 65, 86, 69, // "WAVE"
    102, 109, 116, 32, // "fmt "
    16, 0, 0, 0, // Subchunk1Size (16 for PCM)
    1, 0, // AudioFormat (1 for PCM)
    1, 0, // NumChannels (1)
    128, 62, 0, 0, // SampleRate (16000)
    0, 125, 0, 0, // ByteRate (16000 * 1 * 2 = 32000)
    2, 0, // BlockAlign (1 * 2)
    16, 0, // BitsPerSample (16)
    100, 97, 116, 97, // "data"
    byteCount & 0xff, (byteCount >> 8) & 0xff, (byteCount >> 16) & 0xff, (byteCount >> 24) & 0xff,
  ];
  final audioBytes = List<int>.from(wavHeader)..addAll(List<int>.filled(byteCount, 0));

  final request = http.Request('POST', Uri.parse(endpoint));
  request.headers.addAll({
    'Ocp-Apim-Subscription-Key': key,
    'Content-Type': 'audio/wav; codecs=audio/pcm; samplerate=16000',
    'Accept': 'application/json',
    'Pronunciation-Assessment': base64Params,
  });
  request.bodyBytes = audioBytes;

  final response = await http.Client().send(request);
  final responseBody = await response.stream.bytesToString();
  print(responseBody);
}
