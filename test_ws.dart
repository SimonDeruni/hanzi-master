import 'dart:io';
import 'dart:convert';

void main() async {
  final apiKey = 'AQ.Ab8RN6Jw1wne4dkK1GceZmxu25nsh_a30BbXoWa6tDBo9Zt4Hw';
  final uri = Uri.parse(
      'wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta.GenerativeService.BidiGenerateContent?key=$apiKey');

  try {
    print("Connecting...");
    final ws = await WebSocket.connect(uri.toString());
    print("Connected!");

    final setupMessage = jsonEncode({
      "setup": {
        "model": "models/gemini-2.5-flash-live",
        "generationConfig": {
          "responseModalities": ["AUDIO"],
          "speechConfig": {
            "voiceConfig": {
              "prebuiltVoiceConfig": {"voiceName": "Puck"}
            }
          }
        },
        "systemInstruction": {
          "parts": [
            {"text": "You are a professional Mandarin tutor named Master Lin."}
          ]
        }
      }
    });

    ws.listen(
      (data) {
        print("Received: $data");
      },
      onDone: () {
        print("Connection closed. Code: ${ws.closeCode}, Reason: ${ws.closeReason}");
        exit(0);
      },
      onError: (err) {
        print("Error: $err");
        exit(1);
      },
    );

    print("Sending setup message...");
    ws.add(setupMessage);

    // Keep alive
    await Future.delayed(Duration(seconds: 10));
    ws.close();
  } catch (e) {
    print("Failed: $e");
  }
}

