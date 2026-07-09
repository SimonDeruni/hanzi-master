import 'dart:ui' as ui;
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:record/record.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/features/live_translate/domain/entities/translation_session.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:hanzi_master/shared/widgets/info_bulb.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TravelInterpreterScreen extends ConsumerStatefulWidget {
  const TravelInterpreterScreen({super.key});

  @override
  ConsumerState<TravelInterpreterScreen> createState() => _TravelInterpreterScreenState();
}

class _TravelInterpreterScreenState extends ConsumerState<TravelInterpreterScreen> with SingleTickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();

  WebSocketChannel? _channel;
  StreamSubscription<Uint8List>? _audioSubscription;

  String _status = "Initializing...";
  bool _hasError = false;
  bool _isRecording = false;

  // Side language state (decoupled from global provider)
  String _sideALanguage = 'English';
  String _sideBLanguage = 'Mandarin';

  // Input modes per side
  bool _isSideAKeyboardMode = false;

  final TextEditingController _sideATextController = TextEditingController();
  bool _isTranslatingText = false;

  final List<TranslationMessage> _messages = [];
  final List<int> _audioBuffer = [];

  // Message filtering by sideId
  List<TranslationMessage> get _sideAMessages =>
      _messages.where((msg) => msg.sideId == 'a').toList();

  List<TranslationMessage> get _sideBMessages =>
      _messages.where((msg) => msg.sideId == 'b').toList();

  bool _isSessionStarted = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenHub = prefs.getBool('has_seen_travel_hub') ?? false;
    if (hasSeenHub) {
      if (mounted) {
        setState(() => _isSessionStarted = true);
        _initAudioAndConnect();
      }
    }
  }

  void _startSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_travel_hub', true);

    if (!mounted) return;
    setState(() => _isSessionStarted = true);
    _initAudioAndConnect();
  }

  Future<void> _initAudioAndConnect() async {
    try {
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
          "model": "models/gemini-2.0-flash-exp",
          "generationConfig": {
             "responseModalities": ["TEXT"]
          },
          "systemInstruction": {
            "parts": [
              {"text": "You are a Real-time Travel Interpreter. Your job is to translate spoken $_sideALanguage to $_sideBLanguage AND spoken $_sideBLanguage to $_sideALanguage seamlessly. If the user speaks $_sideALanguage, output $_sideBLanguage. If they speak $_sideBLanguage, output $_sideALanguage. Be conversational and helpful. Output text ONLY."}
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
          } catch (e) {
            // Ignore malformed messages from the WebSocket stream
          }
        },
        onDone: () {
          final code = _channel?.closeCode;
          final reason = _channel?.closeReason;
          debugPrint("TravelInterpreter: Connection closed. Code: $code, Reason: $reason");
          if (mounted && _isSessionStarted) {
            setState(() { _status = "Reconnecting..."; _hasError = false; });
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted && _isSessionStarted) {
                _initAudioAndConnect();
              }
            });
          } else {
            if (mounted) setState(() { _status = "Connection closed ($code): ${reason ?? 'unknown'}"; _hasError = true; });
          }
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
      if (_messages.isNotEmpty && _messages.last.sideId == 'b') {
        final last = _messages.last;
        _messages[_messages.length - 1] = TranslationMessage(
          text: last.text + text,
          isUser: false,
          timestamp: last.timestamp,
          sideId: 'b',
          language: _sideBLanguage,
        );
      } else {
        _messages.add(TranslationMessage(
          text: text,
          isUser: false,
          sideId: 'b',
          language: _sideBLanguage,
        ));
      }
    });
  }

  void _handleUserTranscript(String text, bool finished) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_messages.isNotEmpty && _messages.last.sideId == 'a') {
        final last = _messages.last;
        _messages[_messages.length - 1] = TranslationMessage(
          text: text,
          isUser: true,
          timestamp: last.timestamp,
          sideId: 'a',
          language: _sideALanguage,
        );
      } else {
        _messages.add(TranslationMessage(
          text: text,
          isUser: true,
          sideId: 'a',
          language: _sideALanguage,
        ));
      }
    });
  }

  Future<void> _startAudioStreaming() async {
    if (await _audioRecorder.hasPermission()) {
      setState(() {
        _isRecording = true;
        _status = "Listening...";
      });
      final stream = await _audioRecorder.startStream(
        const RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 16000, numChannels: 1),
      );
      _audioSubscription = stream.listen((data) {
        if (data.isEmpty) return;
        _audioBuffer.addAll(data);

        if (_audioBuffer.length >= 16000) {
          if (_channel != null && _channel?.closeCode == null) {
            try {
              _channel!.sink.add(jsonEncode({
                "realtimeInput": {
                  "audio": {
                    "mimeType": "audio/pcm;rate=16000",
                    "data": base64Encode(_audioBuffer)
                  }
                }
              }));
              _audioBuffer.clear();
            } catch (e) {
              debugPrint("Sink add error: $e");
            }
          }
        }
      });
    }
  }

  Future<void> _stopAudioStreaming() async {
    await _audioSubscription?.cancel();
    await _audioRecorder.stop();

    if (_audioBuffer.isNotEmpty && _channel != null && _channel?.closeCode == null) {
      try {
        _channel!.sink.add(jsonEncode({
          "realtimeInput": {
            "audio": {
              "mimeType": "audio/pcm;rate=16000",
              "data": base64Encode(_audioBuffer)
            }
          }
        }));
      } catch (_) {}
      _audioBuffer.clear();
    }

    if (_channel != null && _channel?.closeCode == null) {
      try {
        _channel!.sink.add(jsonEncode({
          "clientContent": {
            "turnComplete": true
          }
        }));
      } catch (_) {}
    }

    setState(() {
      _isRecording = false;
      _status = "Paused";
    });
  }

  /// Send a text translation with explicit source→target routing.
  /// [sideId] determines source language: 'a' → _sideALanguage→_sideBLanguage, 'b' → _sideBLanguage→_sideALanguage.
  Future<void> _sendTextTranslation(String text, {required String sideId}) async {
    if (text.trim().isEmpty) return;

    final sourceLang = sideId == 'a' ? _sideALanguage : _sideBLanguage;
    final targetLang = sideId == 'a' ? _sideBLanguage : _sideALanguage;

    // Add sender's text immediately
    setState(() {
      _messages.add(TranslationMessage(
        text: text,
        isUser: sideId == 'a',
        sideId: sideId,
        language: sourceLang,
      ));
      _isTranslatingText = true;
      _status = "Translating...";
    });

    try {
      final geminiService = ref.read(geminiServiceProvider);
      final response = await geminiService.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {
            "role": "system",
            "content": "You are a Real-time Travel Interpreter. Translate the following text from $sourceLang to $targetLang. Be conversational and helpful. Output text ONLY. Do not include pinyin in the main response."
          },
          {
            "role": "user",
            "content": text
          }
        ]
      );

      if (mounted) {
        setState(() {
          _messages.add(TranslationMessage(
            text: response,
            isUser: sideId != 'a',
            sideId: sideId == 'a' ? 'b' : 'a',
            language: targetLang,
          ));
          _isTranslatingText = false;
          _status = _isRecording ? "Listening..." : "Paused";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isTranslatingText = false;
          _status = "Translation failed";
        });
      }
    }
  }

  /// Shows a full-screen overlay for Side B (partner) to type using the system keyboard.
  void _showPartnerKeyboard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final controller = TextEditingController();
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(ctx).size.height * 0.5,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1313),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text(
                    "Type in $_sideBLanguage",
                    style: const TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                // Text field
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Type your message in $_sideBLanguage...",
                        hintStyle: const TextStyle(color: Colors.white24),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.08),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                // Send button
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        final text = controller.text.trim();
                        if (text.isNotEmpty) {
                          _sendTextTranslation(text, sideId: 'b');
                        }
                        Navigator.pop(ctx);
                      },
                      child: const Text("Send", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveSession() async {
    if (_messages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No transcript to save!")));
      return;
    }

    final box = await Hive.openBox<TranslationSession>('translation_sessions');
    final session = TranslationSession(
      id: const Uuid().v4(),
      modeName: 'Travel Interpreter',
      date: DateTime.now(),
      messages: _messages.toList(),
      sideALanguage: _sideALanguage,
      sideBLanguage: _sideBLanguage,
    );
    await box.put(session.id, session);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Session saved!")));
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _audioSubscription?.cancel();
    _audioRecorder.dispose();
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
                  const Spacer(),
                  const InfoBulb(id: "travel_interpreter", title: "Travel Interpreter", message: "Translate speech in real time. Speak in English and hear the Chinese translation instantly, or vice versa."),
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              // Top Half (Side B - Partner, Rotated 180 degrees)
              Expanded(
                child: RotatedBox(
                  quarterTurns: 2,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    color: _isRecording ? const Color(0xFF3E1F1F) : const Color(0xFF1E1313),
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Side B language dropdown
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _sideBLanguage,
                                    icon: const Icon(Icons.language, color: Colors.white70),
                                    dropdownColor: Colors.grey[900],
                                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                    items: supportedTranslationLanguages.map((lang) => DropdownMenuItem(value: lang, child: Text("Partner ($lang)"))).toList(),
                                    onChanged: (val) {
                                      if (val != null) setState(() => _sideBLanguage = val);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Side B keyboard button → triggers Pass the Phone overlay
                                IconButton(
                                  icon: Icon(
                                    Icons.keyboard,
                                    color: Colors.white54,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    if (_isRecording) _stopAudioStreaming();
                                    _showPartnerKeyboard();
                                  },
                                ),
                              ],
                            ),
                            if (_isRecording)
                              const Row(
                                children: [
                                  Icon(Icons.mic, color: Colors.redAccent, size: 16),
                                  SizedBox(width: 8),
                                  Text("录音中", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            itemCount: _sideBMessages.length,
                            itemBuilder: (context, index) {
                              final msg = _sideBMessages[_sideBMessages.length - 1 - index];
                              final isFromSideB = msg.sideId == 'b';
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                  decoration: BoxDecoration(
                                    color: isFromSideB ? Colors.blue.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(24),
                                      topRight: const Radius.circular(24),
                                      bottomLeft: Radius.circular(isFromSideB ? 24 : 4),
                                      bottomRight: Radius.circular(isFromSideB ? 4 : 24),
                                    ),
                                    border: Border.all(color: isFromSideB ? Colors.blue.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.2)),
                                  ),
                                  child: Text(
                                    msg.text,
                                    style: TextStyle(
                                      color: isFromSideB ? Colors.blue.shade200 : Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
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

              // Bottom Half (Side A - User)
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: _isRecording ? const Color(0xFF152A3B) : const Color(0xFF121A20),
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Side A language dropdown
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _sideALanguage,
                                  icon: const Icon(Icons.language, color: Colors.white70),
                                  dropdownColor: Colors.grey[900],
                                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  items: supportedTranslationLanguages.map((lang) => DropdownMenuItem(value: lang, child: Text("You ($lang)"))).toList(),
                                  onChanged: (val) {
                                    if (val != null) setState(() => _sideALanguage = val);
                                  },
                                ),
                              ),
                              // Side A keyboard toggle
                              IconButton(
                                icon: Icon(
                                  Icons.keyboard,
                                  color: _isSideAKeyboardMode ? Colors.blueAccent : Colors.white54,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isSideAKeyboardMode = !_isSideAKeyboardMode;
                                    if (_isSideAKeyboardMode && _isRecording) {
                                      _stopAudioStreaming();
                                    }
                                  });
                                },
                              ),
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
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.camera_alt, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const UniversalScannerScreen(intent: CameraIntent.travelAR)),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.white),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: _sideAMessages.length,
                          itemBuilder: (context, index) {
                            final msg = _sideAMessages[_sideAMessages.length - 1 - index];
                            final isFromSideA = msg.sideId == 'a';
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                decoration: BoxDecoration(
                                  color: isFromSideA ? Colors.blue.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(24),
                                    topRight: const Radius.circular(24),
                                    bottomLeft: Radius.circular(isFromSideA ? 24 : 4),
                                    bottomRight: Radius.circular(isFromSideA ? 4 : 24),
                                  ),
                                  border: Border.all(color: isFromSideA ? Colors.blue.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.2)),
                                ),
                                child: isFromSideA
                                  ? Text(
                                      msg.text,
                                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                                    )
                                  : TappableMarkdownHanziText(
                                      msg.text,
                                      style: const TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.w500),
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (_isSideAKeyboardMode)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextField(
                            controller: _sideATextController,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                            decoration: InputDecoration(
                              hintText: "Type in $_sideALanguage...",
                              hintStyle: const TextStyle(color: Colors.white38),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send, color: Colors.blueAccent),
                                onPressed: _isTranslatingText ? null : () {
                                  _sendTextTranslation(_sideATextController.text, sideId: 'a');
                                  _sideATextController.clear();
                                },
                              ),
                            ),
                            onSubmitted: _isTranslatingText ? null : (val) {
                              _sendTextTranslation(val, sideId: 'a');
                              _sideATextController.clear();
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // The Floating Center Control Bar
          _buildCenterControlBar(),
        ],
      ),
    );
  }

  Widget _buildCenterControlBar() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final blur = _isRecording ? (_pulseController.value * 20.0 + 10.0) : 0.0;
        final spread = _isRecording ? (_pulseController.value * 5.0) : 0.0;
        return Positioned(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                if (_isRecording)
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.3),
                    blurRadius: blur,
                    spreadRadius: spread,
                  )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Language Icon
                      const Icon(Icons.translate, color: Colors.white70, size: 24),
                      const SizedBox(width: 8),
                      // Mic Button
                      GestureDetector(
                        onTap: () {
                          if (_isRecording) {
                            _stopAudioStreaming();
                          } else {
                            _startAudioStreaming();
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _isRecording ? Colors.redAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _isRecording ? Colors.redAccent : Colors.white24,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            _isRecording ? Icons.mic : Icons.mic_none,
                            color: _isRecording ? Colors.redAccent : Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Status Text
                      Expanded(
                        child: Text(
                          _status,
                          style: TextStyle(
                            color: _hasError ? Colors.redAccent : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Save button
                      IconButton(
                        icon: const Icon(Icons.save_alt, color: Colors.white70, size: 22),
                        onPressed: _saveSession,
                        tooltip: "Save session",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}