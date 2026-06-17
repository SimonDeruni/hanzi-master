import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:record/record.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import '../../domain/entities/scenario.dart';
import '../../../chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import '../widgets/live_call_summary_screen.dart';

class LiveCallMessage {
  final String text;
  final ChatRole role;
  final Map<String, dynamic>? grade; 
  final DateTime timestamp;

  LiveCallMessage({
    required this.text,
    required this.role,
    this.grade,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  LiveCallMessage copyWith({Map<String, dynamic>? grade, String? text}) {
    return LiveCallMessage(
      text: text ?? this.text,
      role: role,
      grade: grade ?? this.grade,
      timestamp: timestamp,
    );
  }
}

class LiveCallScreen extends ConsumerStatefulWidget {
  final ConversationScenario scenario;

  const LiveCallScreen({super.key, required this.scenario});

  @override
  ConsumerState<LiveCallScreen> createState() => _LiveCallScreenState();
}

class _LiveCallScreenState extends ConsumerState<LiveCallScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isMuted = false;
  bool _isSpeaker = true;
  bool _isEndingCall = false;
  
  WebSocketChannel? _channel;
  String _callStatus = "Initializing...";
  bool _hasError = false;

  final AudioRecorder _audioRecorder = AudioRecorder();
  final fs.FlutterSoundPlayer _player = fs.FlutterSoundPlayer();
  StreamSubscription<Uint8List>? _audioSubscription;
  bool _isLive = false;

  // Transcript & Grading State
  final List<LiveCallMessage> _transcript = [];
  final BytesBuilder _userAudioBuffer = BytesBuilder();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _initAudioAndConnect();
  }

  Future<void> _initAudioAndConnect() async {
    try {
      await _player.openPlayer();
      // Required for stream playback:
      await _player.startPlayerFromStream(
        codec: fs.Codec.pcm16,
        numChannels: 1,
        sampleRate: 24000,
        bufferSize: 8192,
        interleaved: true,
      );
      await _connectToGemini();
    } catch (e) {
      debugPrint("LiveCall: Init failed: $e");
      if (mounted) {
        setState(() {
          _callStatus = "Initialization error. Check permissions.";
          _hasError = true;
        });
      }
    }
  }

  Future<void> _connectToGemini() async {
    if (!mounted) return;
    setState(() {
      _callStatus = "Connecting to Scholar...";
      _hasError = false;
    });
    
    final apiKey = ref.read(apiKeyPoolProvider).googleKey;
    if (apiKey.isEmpty) {
      setState(() {
        _callStatus = "Error: Missing Google API Key";
        _hasError = true;
      });
      return;
    }

    try {
      // Endpoint for Gemini Multimodal Live API
      final uri = Uri.parse(
        'wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta.GenerativeService.BidiGenerateContent?key=$apiKey'
      );
      
      _channel = WebSocketChannel.connect(uri);

      // 1. Setup Phase - Updated for June 2026 stable models
      final setupMessage = jsonEncode({
        "setup": {
          "model": "models/gemini-3.1-flash-live-preview",
          "generationConfig": {
             "responseModalities": ["AUDIO"],
             "speechConfig": {
               "voiceConfig": { "prebuiltVoiceConfig": { "voiceName": "Puck" } }
             }
          },
          "systemInstruction": {
            "parts": [
              {"text": "You are a professional Mandarin tutor named Master Lin. You are patient, wise, and encouraging. Respond naturally in spoken Mandarin. Keep your responses short (under 3 sentences). Your current scenario: ${widget.scenario.description}"}
            ]
          }
        }
      });

      _channel!.sink.add(setupMessage);

      _channel!.stream.listen(
        (message) async {
          debugPrint("GEMINI LIVE RAW: $message");
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
              debugPrint("LiveCall: Server returned error: ${data['error']}");
              if (mounted) setState(() => _callStatus = "Server Error: ${data['error']['message']}");
            }
            
            if (data.containsKey('setupComplete')) {
              setState(() => _callStatus = "Connected! Speak now.");
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
                      _handleAiTranscript(part['text']);
                    }
                  }
                }
              }

              if (content.containsKey('inputTranscription')) {
                final trans = content['inputTranscription'];
                _handleUserInputTranscription(trans['text'] ?? "", trans['finished'] ?? false);
              }

              if (content['interrupted'] == true) {
                 _player.stopPlayer();
                 _userAudioBuffer.clear();
              }
            }
          } catch (e) {
            debugPrint("LiveCall: Parse error: $e");
          }
        },
        onDone: () {
          if (_isEndingCall) return;
          final closeCode = _channel?.closeCode;
          final closeReason = _channel?.closeReason;
          debugPrint("LiveCall: Closed. Code: $closeCode, Reason: $closeReason");
          if (mounted) {
            setState(() {
              if (closeCode == 4403 || closeCode == 403) {
                _callStatus = "Access Denied (403). Your API Key lacks 'Live' permissions or region is unsupported.";
              } else {
                _callStatus = "Connection closed ($closeCode): ${closeReason ?? 'Unknown reason'}";
              }
              _hasError = true;
            });
          }
        },
        onError: (error) {
          debugPrint("LiveCall: Stream error: $error");
          if (mounted) {
            setState(() {
              _callStatus = "Connection Error: $error";
              _hasError = true;
            });
          }
        },
      );

    } catch (e) {
      debugPrint("LiveCall: Connection fail: $e");
      if (mounted) {
        setState(() {
          _callStatus = "Failed to reach server: $e";
          _hasError = true;
        });
      }
    }
  }

  void _handleAiTranscript(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_transcript.isNotEmpty && _transcript.last.role == ChatRole.scholar) {
        final last = _transcript.removeLast();
        _transcript.add(last.copyWith(text: last.text + text));
      } else {
        _transcript.add(LiveCallMessage(text: text, role: ChatRole.scholar));
      }
    });
    _scrollToBottom();
  }

  void _handleUserInputTranscription(String text, bool finished) {
    if (text.trim().isEmpty) return;
    setState(() {
      int lastUserIdx = _transcript.lastIndexWhere((m) => m.role == ChatRole.user);
      if (lastUserIdx != -1 && _transcript[lastUserIdx].grade == null) {
        _transcript[lastUserIdx] = _transcript[lastUserIdx].copyWith(text: text);
      } else {
        _transcript.add(LiveCallMessage(text: text, role: ChatRole.user));
      }
    });

    if (finished) {
      _triggerGradingForLastUserTurn();
    }
    _scrollToBottom();
  }

  Future<void> _triggerGradingForLastUserTurn() async {
    final lastUserIdx = _transcript.lastIndexWhere((m) => m.role == ChatRole.user);
    if (lastUserIdx == -1) return;
    
    final message = _transcript[lastUserIdx];
    final audioData = _userAudioBuffer.takeBytes();
    if (audioData.isEmpty) return;

    try {
      final result = await ref.read(geminiServiceProvider).gradeAudio(audioData, message.text, "");
      if (mounted) {
        setState(() {
          _transcript[lastUserIdx] = message.copyWith(grade: result);
        });
      }
    } catch (e) {
      debugPrint("Live grading error: $e");
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _startAudioStreaming() async {
    if (await _audioRecorder.hasPermission()) {
      final stream = await _audioRecorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
      );

      _audioSubscription = stream.listen((data) {
        if (data.isEmpty) return;
        if (!_isMuted && _channel != null) {
          _channel!.sink.add(jsonEncode({
            "realtimeInput": {
              "audio": { "mimeType": "audio/pcm;rate=16000", "data": base64Encode(data) }
            }
          }));
          _userAudioBuffer.add(data);
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
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _endCall() async {
    _isEndingCall = true;
    HapticsManager.heavy();
    _channel?.sink.close(status.normalClosure);

    if (_transcript.isEmpty) {
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white)),
    );

    final verdict = await _generateFinalVerdict();
    
    if (mounted) {
      Navigator.pop(context); // Close loading
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LiveCallSummaryScreen(
            transcript: _transcript,
            scholarVerdict: verdict,
          ),
        ),
      );
    }
  }

  Future<String> _generateFinalVerdict() async {
    try {
      final gemini = ref.read(geminiServiceProvider);
      final transcriptStr = _transcript.map((m) => "${m.role.name.toUpperCase()}: ${m.text}").join("\n");
      
      final prompt = 'Analyze this transcript and student\'s pronunciation patterns. Identify top 2 struggle areas. Encouraging, scholarly, <80 words.\n\n$transcriptStr';

      return await gemini.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
      );
    } catch (e) {
      return "Excellent effort. Continue daily practice to refine tones.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.scenario.avatarAssetPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.black87),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(color: Colors.black.withValues(alpha: 0.7)),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text("GEMINI LIVE CALL", style: theme.textTheme.labelMedium?.copyWith(color: Colors.white54, letterSpacing: 2.0)),
                      const SizedBox(height: 8),
                      Text(widget.scenario.title, style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(_callStatus, style: TextStyle(color: _hasError ? Colors.redAccent : Colors.white70, fontSize: 16)),
                      if (_hasError)
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Return to menu", style: TextStyle(color: Colors.white)),
                        ),
                    ],
                  ),
                ),

                const Spacer(),

                // Transcript Overlay
                Container(
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
                        stops: [0.0, 0.1, 0.9, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: _transcript.length,
                      itemBuilder: (context, index) {
                        final msg = _transcript[index];
                        return _LiveTranscriptBubble(message: msg, theme: theme);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    final scale = _isLive && !_isMuted && !_hasError ? _pulseAnimation.value : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 140, height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            if (_isLive && !_isMuted && !_hasError)
                              BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.4), blurRadius: 40, spreadRadius: 5),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            widget.scenario.avatarAssetPath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(color: Colors.indigo.shade900),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 48),

                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CallControlButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        label: _isMuted ? "Muted" : "Mute",
                        isActive: _isMuted,
                        onTap: () => setState(() => _isMuted = !_isMuted),
                      ),
                      GestureDetector(
                        onTap: _endCall,
                        child: Container(
                          width: 72, height: 72,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.redAccent, blurRadius: 20, offset: Offset(0, 4))]
                          ),
                          child: const Icon(Icons.call_end, color: Colors.white, size: 36),
                        ),
                      ),
                      _CallControlButton(
                        icon: _isSpeaker ? Icons.volume_up : Icons.volume_down,
                        label: "Speaker",
                        isActive: _isSpeaker,
                        onTap: () => setState(() => _isSpeaker = !_isSpeaker),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveTranscriptBubble extends StatelessWidget {
  final LiveCallMessage message;
  final ThemeData theme;
  const _LiveTranscriptBubble({required this.message, required this.theme});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (isUser && message.grade != null)
             _buildGradedText(message.grade!['words'] ?? [], theme)
          else
            Text(
              message.text,
              textAlign: isUser ? TextAlign.right : TextAlign.left,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isUser ? Colors.white70 : theme.colorScheme.primary.withValues(alpha: 0.9),
                fontWeight: isUser ? FontWeight.normal : FontWeight.bold,
                height: 1.4,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGradedText(List<dynamic> words, ThemeData theme) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 4,
      children: words.map((w) {
        final bool correct = w['isCorrect'] ?? true;
        return Text(
          w['word'] ?? "",
          style: theme.textTheme.bodyLarge?.copyWith(
            color: correct ? Colors.greenAccent : Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        );
      }).toList(),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _CallControlButton({required this.icon, required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isActive ? Colors.black : Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
