import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  const key = 'MISSING_KEY_SEE_ISSUES';
  const region = 'germanywestcentral';
  
  final Map<String, dynamic> params = {
    "ReferenceText": "我今年八岁了",
    "GradingSystem": "HundredMark",
    "Granularity": "Phoneme",
    "Dimension": "Comprehensive"
  };

  final String base64Params = base64Encode(utf8.encode(jsonEncode(params)));
  const String endpoint = 'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=zh-CN';

  // Read a real test wav file if available, otherwise just use dummy bytes
  // Actually, sending dummy bytes causes InitialSilenceTimeout. Let's assume the user sent real audio.
  print('Endpoint: $endpoint');
  
  // Create a real PCM audio with some noise so it doesn't trigger InitialSilenceTimeout
  // Actually, we can't easily generate spoken Chinese. Let's just create random noise.
  const byteCount = 16000 * 2;
  final wavHeader = <int>[
    82, 73, 70, 70, 
    (36 + byteCount) & 0xff, ((36 + byteCount) >> 8) & 0xff, ((36 + byteCount) >> 16) & 0xff, ((36 + byteCount) >> 24) & 0xff,
    87, 65, 86, 69, 
    102, 109, 116, 32, 
    16, 0, 0, 0, 
    1, 0, 
    1, 0, 
    128, 62, 0, 0, 
    0, 125, 0, 0, 
    2, 0, 
    16, 0, 
    100, 97, 116, 97, 
    byteCount & 0xff, (byteCount >> 8) & 0xff, (byteCount >> 16) & 0xff, (byteCount >> 24) & 0xff,
  ];
  final audioBytes = List<int>.from(wavHeader);
  for(int i=0; i<byteCount; i++) {
    audioBytes.add(i % 256); // fake noise
  }

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
  print("Response: $responseBody");
}
