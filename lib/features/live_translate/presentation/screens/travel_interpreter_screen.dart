import 'dart:ui' as ui;
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:record/record.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/shared/widgets/clickable_chinese_text.dart';
import 'package:hanzi_master/features/live_translate/domain/entities/translation_session.dart';

class InterpreterMessage {
  final String text;
  final bool isUser;

  InterpreterMessage({required this.text, required this.isUser});

  InterpreterMessage copyWith({String? text}) {
    return InterpreterMessage(
      text: text ?? this.text,
      isUser: isUser,
    );
  }
}

class TravelInterpreterScreen extends ConsumerStatefulWidget {
  const TravelInterpreterScreen({super.key});

  @override
  ConsumerState<TravelInterpreterScreen> createState() => _TravelInterpreterScreenState();
}

class _TravelInterpreterScreenState extends ConsumerState<TravelInterpreterScreen> {
  final fs.FlutterSoundPlayer _player = fs.FlutterSoundPlayer();
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  WebSocketChannel? _channel;
  StreamSubscription<Uint8List>? _audioSubscription;
  
  String _status = "Initializing...";
  bool _isLive = false;
  bool _hasError = false;
  bool _isRecording = false;

  final List<InterpreterMessage> _transcript = [];

  bool _isSessionStarted = false;

  @override
  void initState() {
    super.initState();
    // Do NOT connect automatically
  }

  Future<void> _startSession() async {
    setState(() {
      _isSessionStarted = true;
    });
    await _initAudioAndConnect();
  }

  Future<void> _initAudioAndConnect() async {
    try {
      await _player.openPlayer();
      await _player.startPlayerFromStream(
        codec: fs.Codec.pcm16,
        numChannels: 1,
        sampleRate: 24000,
        bufferSize: 8192,
        interleaved: true,
      );
      await _connectToGemini();
    } catch (e) {
      if (mounted) setState(() { _status = "Init error: $e"; _hasError = true; });
    }
  }

  Future<void> _connectToGemini() async {
    if (!mounted) return;
    setState(() => _status = "Connecting...");
    
    final apiKey = ref.read(apiKeyPoolProvider).googleKey;
    if (apiKey.isEmpty) {
      setState(() { _status = "Missing API Key"; _hasError = true; });
      return;
    }

    try {
      final uri = Uri.parse(
        'wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta.GenerativeService.BidiGenerateContent?key=$apiKey'
      );
      _channel = WebSocketChannel.connect(uri);

      final setupMessage = jsonEncode({
        "setup": {
          "model": "models/gemini-3.5-live-translate-preview",
          "generationConfig": {
             "responseModalities": ["AUDIO"],
             "speechConfig": {
               "voiceConfig": { "prebuiltVoiceConfig": { "voiceName": "Puck" } }
             }
          },
          "systemInstruction": {
            "parts": [
              {"text": "You are a Real-time Travel Interpreter. Your job is to translate spoken English to Mandarin Chinese AND spoken Mandarin Chinese to English seamlessly. If the user speaks English, output Mandarin. If they speak Mandarin, output English. Be conversational and helpful."}
            ]
          }
        }
      });

      _channel!.sink.add(setupMessage);

      _channel!.stream.listen(
        (message) async {
          if (!mounted) return;
          try {
            String textMessage;
            if (message is List<int>) {
              textMessage = utf8.decode(message);
            } else {
              textMessage = message.toString();
            }
            final data = jsonDecode(textMessage);
            
            if (data.containsKey('error')) {
              if (mounted) setState(() => _status = "Error: ${data['error']['message']}");
            }
            
            if (data.containsKey('setupComplete')) {
              setState(() => _status = "Ready to interpret...");
            }

            if (data.containsKey('serverContent')) {
              final content = data['serverContent'];
              
              if (content.containsKey('modelTurn')) {
                final modelTurn = content['modelTurn'];
                if (modelTurn['parts'] != null) {
                  for (var part in modelTurn['parts']) {
                    if (part.containsKey('inlineData')) {
                      final base64Audio = part['inlineData']['data'];
                      final audioBytes = base64Decode(base64Audio);
                      _player.feedUint8FromStream(Uint8List.fromList(audioBytes));
                    }
                    if (part.containsKey('text')) {
                      _handleAiTranscript(part['text']);
                    }
                  }
                }
              }

              if (content.containsKey('inputTranscription')) {
                final trans = content['inputTranscription'];
                _handleUserTranscript(trans['text'] ?? "", trans['finished'] ?? false);
              }
            }
          } catch (e) {}
        },
        onDone: () {
          if (mounted) setState(() { _status = "Connection closed."; _hasError = true; });
        },
        onError: (e) {
          if (mounted) setState(() { _status = "Connection Error: $e"; _hasError = true; });
        },
      );
    } catch (e) {
      if (mounted) setState(() { _status = "Fail: $e"; _hasError = true; });
    }
  }

  void _handleAiTranscript(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_transcript.isNotEmpty && !_transcript.last.isUser) {
        final last = _transcript.last;
        _transcript[_transcript.length - 1] = last.copyWith(text: last.text + text);
      } else {
        _transcript.add(InterpreterMessage(text: text, isUser: false));
      }
    });
  }

  void _handleUserTranscript(String text, bool finished) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_transcript.isNotEmpty && _transcript.last.isUser) {
        final last = _transcript.last;
        _transcript[_transcript.length - 1] = last.copyWith(text: text);
      } else {
        _transcript.add(InterpreterMessage(text: text, isUser: true));
      }
    });
  }

  Future<void> _startAudioStreaming() async {
    if (await _audioRecorder.hasPermission()) {
      setState(() {
        _isRecording = true;
        _isLive = true;
        _status = "Listening...";
      });
      final stream = await _audioRecorder.startStream(
        const RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 16000, numChannels: 1),
      );
      _audioSubscription = stream.listen((data) {
        if (data.isEmpty) return;
        if (_channel != null && _channel?.closeCode == null) {
          try {
            _channel!.sink.add(jsonEncode({
              "realtimeInput": {
                "audio": { "mimeType": "audio/pcm;rate=16000", "data": base64Encode(data) }
              }
            }));
          } catch (e) {
            debugPrint("Sink add error: $e");
          }
        }
      });
    }
  }

  Future<void> _stopAudioStreaming() async {
    await _audioSubscription?.cancel();
    await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
      _isLive = false;
      _status = "Paused";
    });
  }

  Future<void> _saveSession() async {
    if (_transcript.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No transcript to save!")));
      return;
    }
    
    final box = await Hive.openBox<TranslationSession>('translation_sessions');
    final session = TranslationSession(
      id: const Uuid().v4(),
      modeName: 'Travel Interpreter',
      date: DateTime.now(),
      messages: _transcript.map((e) => TranslationMessage(
        text: e.text,
        isUser: e.isUser,
      )).toList(),
    );
    await box.put(session.id, session);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Session saved!")));
    }
  }

  @override
  void dispose() {
    _audioSubscription?.cancel();
    _audioRecorder.dispose();
    _player.closePlayer();
    _channel?.sink.close(status.normalClosure);
    super.dispose();
  }

  Widget _buildHubUI(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Icon(Icons.translate, size: 80, color: Colors.blueAccent.withValues(alpha: 0.8)),
            const SizedBox(height: 32),
            Text(
              "Travel Interpreter",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                "Real-time bidirectional translation. Speak English or Mandarin, and it will instantly translate for you and your partner.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: GestureDetector(
                onTap: _startSession,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent.shade700, Colors.blueAccent.shade400],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Start Session",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_isSessionStarted) {
      return _buildHubUI(context, isDark);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Half (Partner - Rotated 180 degrees)
            Expanded(
              child: RotatedBox(
                quarterTurns: 2,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: _isRecording ? Colors.red.withValues(alpha: 0.1) : Colors.grey.shade900,
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Partner (中文)", style: TextStyle(color: Colors.white54, fontSize: 18, fontWeight: FontWeight.bold)),
                          if (_isRecording)
                            const Row(
                              children: [
                                Icon(Icons.circle, color: Colors.redAccent, size: 12),
                                SizedBox(width: 8),
                                Text("录音中", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: _transcript.length,
                          itemBuilder: (context, index) {
                            final msg = _transcript[_transcript.length - 1 - index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                msg.text,
                                style: TextStyle(
                                  color: msg.isUser ? Colors.blueAccent : Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Divider / Status with Toggle
            Container(
              height: 48,
              color: Colors.blueAccent.withValues(alpha: 0.2),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                        _isRecording ? "REC" : "Incognito",
                        style: TextStyle(
                          color: _isRecording ? Colors.redAccent : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: _isRecording,
                        activeColor: Colors.redAccent,
                        onChanged: (val) => setState(() => _isRecording = val),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bottom Half (User)
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: _isRecording ? Colors.red.withValues(alpha: 0.1) : Colors.black,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text("You (English)", style: TextStyle(color: Colors.white54, fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 16),
                            if (_isRecording)
                              const Row(
                                children: [
                                  Icon(Icons.circle, color: Colors.redAccent, size: 12),
                                  SizedBox(width: 8),
                                  Text("Recording", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                                ],
                              ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: _transcript.length,
                        itemBuilder: (context, index) {
                          final msg = _transcript[_transcript.length - 1 - index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: msg.isUser 
                              ? Text(
                                  msg.text,
                                  style: const TextStyle(color: Colors.white, fontSize: 24),
                                )
                              : ClickableChineseText(
                                  msg.text,
                                  style: const TextStyle(color: Colors.blueAccent, fontSize: 24),
                                ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
