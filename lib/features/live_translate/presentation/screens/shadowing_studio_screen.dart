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
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';

class ShadowingMessage {
  final String englishText;
  final String mandarinTranslation;
  final Map<String, dynamic>? pronunciationGrade;

  ShadowingMessage({required this.englishText, required this.mandarinTranslation, this.pronunciationGrade});

  ShadowingMessage copyWith({String? englishText, String? mandarinTranslation, Map<String, dynamic>? pronunciationGrade}) {
    return ShadowingMessage(
      englishText: englishText ?? this.englishText,
      mandarinTranslation: mandarinTranslation ?? this.mandarinTranslation,
      pronunciationGrade: pronunciationGrade ?? this.pronunciationGrade,
    );
  }
}

class ShadowingStudioScreen extends ConsumerStatefulWidget {
  const ShadowingStudioScreen({super.key});

  @override
  ConsumerState<ShadowingStudioScreen> createState() => _ShadowingStudioScreenState();
}

class _ShadowingStudioScreenState extends ConsumerState<ShadowingStudioScreen> {
  final fs.FlutterSoundPlayer _player = fs.FlutterSoundPlayer();
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  WebSocketChannel? _channel;
  StreamSubscription<Uint8List>? _audioSubscription;
  
  String _status = "Initializing...";
  bool _isLive = false;
  bool _hasError = false;

  final List<ShadowingMessage> _transcript = [];

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
              {"text": "You are a Shadowing Practice Studio. The user will speak English. You must instantly translate the English phrase into Mandarin Chinese and speak the Mandarin Chinese back to them so they can shadow your pronunciation."}
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
              setState(() => _status = "Speak English to get started...");
              _startAudioStreaming();
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
                      _handleTranslatedText(part['text']);
                    }
                  }
                }
              }

              if (content.containsKey('inputTranscription')) {
                final trans = content['inputTranscription'];
                _handleOriginalAudioText(trans['text'] ?? "", trans['finished'] ?? false);
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

  void _handleTranslatedText(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_transcript.isNotEmpty) {
        final last = _transcript.last;
        _transcript[_transcript.length - 1] = last.copyWith(mandarinTranslation: last.mandarinTranslation + text);
      } else {
        _transcript.add(ShadowingMessage(englishText: "...", mandarinTranslation: text));
      }
    });
  }

  void _handleOriginalAudioText(String text, bool finished) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_transcript.isEmpty || finished) {
        _transcript.add(ShadowingMessage(englishText: text, mandarinTranslation: ""));
      } else {
        final last = _transcript.last;
        _transcript[_transcript.length - 1] = last.copyWith(englishText: text);
      }
    });
  }

  Future<void> _startAudioStreaming() async {
    if (await _audioRecorder.hasPermission()) {
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
      setState(() => _isLive = true);
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
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              // Hero Section
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.orange.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.record_voice_over,
                          size: 80,
                          color: isDark ? Colors.orange.shade300 : Colors.orange.shade600,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Shadowing Studio",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Master your Mandarin pronunciation by mimicking native speech in real-time.",
                        style: TextStyle(
                          fontSize: 18,
                          color: isDark ? Colors.white70 : Colors.black54,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Instructions
                      _buildInstructionRow(
                        Icons.mic_none,
                        "Speak in English",
                        "Say any phrase you want to learn.",
                        isDark,
                      ),
                      const SizedBox(height: 24),
                      _buildInstructionRow(
                        Icons.translate,
                        "Instant Translation",
                        "AI instantly translates it to Mandarin.",
                        isDark,
                      ),
                      const SizedBox(height: 24),
                      _buildInstructionRow(
                        Icons.hearing,
                        "Listen & Shadow",
                        "Listen to the native voice and repeat after it.",
                        isDark,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Start Button Area
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      (isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)).withValues(alpha: 0.0),
                      isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
                    ],
                  ),
                ),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _startSession,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mic, size: 28, color: Colors.white),
                        SizedBox(width: 12),
                        Text(
                          "START SESSION",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionRow(IconData icon, String title, String subtitle, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: isDark ? Colors.orange.shade300 : Colors.orange.shade600, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white54 : Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (!_isSessionStarted) {
      return _buildHubUI(context, isDark);
    }

    return Scaffold(
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Shadowing Studio",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: _isLive ? Colors.orange.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _isLive ? Colors.orange.shade200 : Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isLive ? Icons.mic : Icons.mic_off,
                      color: _isLive ? Colors.orange.shade700 : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _status,
                      style: TextStyle(
                        color: _isLive ? Colors.orange.shade900 : Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  itemCount: _transcript.length,
                  itemBuilder: (context, index) {
                    final msg = _transcript[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: isDark ? Colors.white54 : Colors.black54),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  msg.englishText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDark ? Colors.white54 : Colors.black54,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            children: [
                              const Icon(Icons.record_voice_over, size: 16, color: Colors.orange),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  msg.mandarinTranslation,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: isDark ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
