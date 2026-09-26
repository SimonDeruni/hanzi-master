import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  const key = "MISSING_KEY_SEE_ISSUES";
  const region = "germanywestcentral";
  
  // We need a short wav file. We can just generate a valid empty/silent wav file or read one from the project if available.
  // I will generate a 1-second silent WAV file.
  const sampleRate = 16000;
  const numSamples = sampleRate * 1;
  const byteCount = numSamples * 2;
  
  final wavHeader = <int>[
    82, 73, 70, 70, // "RIFF"
    (36 + byteCount) & 0xff, ((36 + byteCount) >> 8) & 0xff, ((36 + byteCount) >> 16) & 0xff, ((36 + byteCount) >> 24) & 0xff,
    87, 65, 86, 69, // "WAVE"
    102, 109, 116, 32, // "fmt "
    16, 0, 0, 0, 
    1, 0, 
    1, 0, 
    128, 62, 0, 0, 
    0, 125, 0, 0, 
    2, 0, 
    16, 0, 
    100, 97, 116, 97, // "data"
    byteCount & 0xff, (byteCount >> 8) & 0xff, (byteCount >> 16) & 0xff, (byteCount >> 24) & 0xff,
  ];
  
  final audioBytes = List<int>.from(wavHeader)..addAll(List.filled(byteCount, 0));

  final Map<String, dynamic> params = {
    "ReferenceText": "你好",
    "GradingSystem": "HundredMark",
    "Granularity": "Phoneme",
    "Dimension": "Comprehensive"
  };

  final String jsonParams = jsonEncode(params);
  final String base64Params = base64Encode(utf8.encode(jsonParams));

  const String endpoint = 'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=zh-CN&format=detailed';

  final request = http.Request('POST', Uri.parse(endpoint));
  request.headers.addAll({
    'Ocp-Apim-Subscription-Key': key,
    'Content-Type': 'audio/wav; codecs=audio/pcm; samplerate=16000',
    'Accept': 'application/json',
    'Pronunciation-Assessment': base64Params,
  });
  
  request.bodyBytes = audioBytes;
  
  print("Sending scripted...");
  final response = await http.Client().send(request);
  final responseBody = await response.stream.bytesToString();
  print("Scripted Response:");
  print(responseBody);
  
  final Map<String, dynamic> paramsUnscripted = {
    "ReferenceText": "",
    "GradingSystem": "HundredMark",
    "Granularity": "Phoneme",
    "Dimension": "Comprehensive"
  };

  final String jsonParamsU = jsonEncode(paramsUnscripted);
  final String base64ParamsU = base64Encode(utf8.encode(jsonParamsU));

  const String endpointU = 'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=zh-CN';

  final requestU = http.Request('POST', Uri.parse(endpointU));
  requestU.headers.addAll({
    'Ocp-Apim-Subscription-Key': key,
    'Content-Type': 'audio/wav; codecs=audio/pcm; samplerate=16000',
    'Accept': 'application/json',
    'Pronunciation-Assessment': base64ParamsU,
  });
  
  requestU.bodyBytes = audioBytes;
  
  print("Sending unscripted...");
  final responseU = await http.Client().send(requestU);
  final responseBodyU = await responseU.stream.bytesToString();
  print("Unscripted Response:");
  print(responseBodyU);
}
