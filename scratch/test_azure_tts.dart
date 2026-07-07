import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

void main() async {
  final apiKey = 'AnZ5l470hrJMMOqPYYH085lWbpFHjRH8nZCkryg0TWFF8yaVzDdOJQQJ99CGACPV0roXJ3w3AAAYACOGk7C0';
  final region = 'germanywestcentral';
  final text = '你好';

  final safeText = text.replaceAll('&', '&').replaceAll('<', '<').replaceAll('>', '>');
  final uuid = const Uuid().v4().replaceAll('-', '');
  final uri = Uri.parse('wss://$region.tts.speech.microsoft.com/cognitiveservices/websocket/v1?X-ConnectionId=$uuid');

  print('Connecting to $uri...');
  IOWebSocketChannel? channel;
  try {
    channel = IOWebSocketChannel.connect(
      uri,
      headers: {
        'Ocp-Apim-Subscription-Key': apiKey,
      },
    );
  } catch(e) {
    print("WebSocket connect failed: $e");
    return;
  }

  final audioBuffer = <int>[];
  final boundaries = <Map<String, dynamic>>[];
  final completer = Completer<void>();

  channel.stream.listen((message) {
    if (message is String) {
      if (message.contains('Path:turn.end') || message.contains('Path: turn.end')) {
        print('Connection turn.end received.');
        completer.complete();
      } else if (message.contains('Path:audio.metadata') || message.contains('Path: audio.metadata')) {
        try {
          final parts = message.split('\r\n\r\n');
          if (parts.length > 1) {
            final data = jsonDecode(parts[1]);
            if (data['Metadata'] != null) {
              for (var meta in data['Metadata']) {
                if (meta['Type'] == 'WordBoundary') {
                  boundaries.add(meta['Data']);
                }
              }
            }
          }
        } catch(e) {
          print('Failed to parse metadata: $e');
        }
      }
    } else if (message is List<int>) {
      if (message.length > 2) {
        final headerLength = (message[0] << 8) | message[1];
        final offset = 2 + headerLength;
        if (offset < message.length) {
          // Check if it is actually audio or if the header indicates audio
          final headerText = ascii.decode(message.sublist(2, offset), allowInvalid: true);
          if (headerText.contains('Path:audio')) {
            audioBuffer.addAll(message.sublist(offset));
            print('Appended ${message.length - offset} bytes to audio buffer. Total size: ${audioBuffer.length}');
          } else {
            print('Binary message is not audio (header: ${headerText.replaceAll('\r', '\\r').replaceAll('\n', '\\n')})');
          }
        }
      }
    }
  }, onError: (e) {
    print('WebSocket error: $e');
    completer.complete();
  }, onDone: () {
    print('WebSocket closed.');
    completer.complete();
  });

  final requestId = const Uuid().v4().replaceAll('-', '');
  final timestamp = DateTime.now().toUtc().toIso8601String();

  print('Sending speech.config...');
  channel.sink.add(
    'Path: speech.config\r\n'
    'X-RequestId: $requestId\r\n'
    'X-Timestamp: $timestamp\r\n'
    'Content-Type: application/json; charset=utf-8\r\n'
    '\r\n'
    '{"context":{"synthesis":{"audio":{"metadataOptions":{"wordBoundaryEnabled":true,"sentenceBoundaryEnabled":true},"outputFormat":"audio-24khz-48kbitrate-mono-mp3"}}}}'
  );

  final ssml = '''<speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xml:lang='zh-CN'><voice name='zh-CN-XiaoxiaoNeural'>$safeText</voice></speak>''';

  print('Sending SSML: $ssml');
  channel.sink.add(
    'Path: ssml\r\n'
    'X-RequestId: $requestId\r\n'
    'X-Timestamp: $timestamp\r\n'
    'Content-Type: application/ssml+xml\r\n'
    '\r\n'
    '$ssml'
  );

  print('Waiting for turn.end...');
  await completer.future.timeout(const Duration(seconds: 15), onTimeout: () {
    print('Timed out waiting for turn.end!');
    channel?.sink.close();
  });

  print('Done. Audio buffer size: ${audioBuffer.length}. Boundaries parsed: ${boundaries.length}');
}
