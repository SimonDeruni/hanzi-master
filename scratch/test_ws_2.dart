import 'dart:io';
import 'dart:convert';

void main() async {
  const apiKey = 'AQ.Ab8RN6IY_hG6QpIjnjAxCAo-dAbIMS-egNT9cH_vpJgpujXxKA';
  final uri = Uri.parse(
      'wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1alpha.GenerativeService.BidiGenerateContent?key=$apiKey');

  try {
    print("Connecting...");
    final ws = await WebSocket.connect(uri.toString());
    print("Connected!");

    final setupMessage = jsonEncode({
      "setup": {
        "model": "models/gemini-2.0-flash-exp",
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
        String message;
        if (data is List<int>) {
          message = utf8.decode(data);
        } else {
          message = data.toString();
        }
        print("Received: $message");
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
    await Future.delayed(const Duration(seconds: 5));
    ws.close();
  } catch (e) {
    print("Failed: $e");
  }
}
